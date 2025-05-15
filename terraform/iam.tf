data "aws_iam_policy" "SecurityAudit" {
  arn = "arn:aws:iam::aws:policy/SecurityAudit"
}
data "aws_caller_identity" "current" {
}
data "aws_region" "current" {
}


resource "aws_iam_role" "prowler_role" {
  name = "cto-scanner-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRoleWithWebIdentity"
        Effect = "Allow"
        Principal = {
          Federated = "${var.eks_oidc_provider_arn}"
        }
        Condition = {
          StringLike = {
            "${var.eks_oidc_provider}:sub" = "system:serviceaccount:*:prowler-api-sa"
            "${var.eks_oidc_provider}:aud" = "sts.amazonaws.com"
          }
        }
      }
    ]
  })

  tags = {
    Application = "${local.name_prefix}"
    Terraform   = "true"
  }
}

resource "aws_iam_policy" "prowler_api_policy" {
  name        = "prowler_api_policy"
  description = "Policy for prowler API to access AWS resources"

  policy = jsonencode(
            {
            "Version": "2012-10-17",
            "Statement": [
                {
                    "Sid": "secretsmanager",
                    "Effect": "Allow",
                    "Action": [
                        "secretsmanager:*"
                    ],
                    "Resource": [
                        "${aws_secretsmanager_secret.prowler_secret.id}",
                        "${aws_secretsmanager_secret.prowler_ui_secret.id}"
                    ]
                },
                {
                    Action =  [
                        "logs:PutLogEvents"
                        ],
                    Effect   = "Allow"
                    Resource =  "arn:aws:logs:*:${data.aws_caller_identity.current.account_id}:log-group:*:log-stream:*"
                },
                {
                    Action =  [
                        "logs:CreateLogStream",
                        "logs:CreateLogGroup"
                        ],
                    Effect   = "Allow"
                    Resource =  "arn:aws:logs:*:${data.aws_caller_identity.current.account_id}:log-group:*"
                },
                {
                    Action =  ["sts:AssumeRole"],
                    Effect   = "Allow"
                    Resource =  "*"
                },
                {
                    "Effect": "Allow",
                    "Action": [
                        "s3:*"
                    ],
                    "Resource": [
                        "arn:aws:s3:::ascending-jarvis-cto-scanner",
                        "arn:aws:s3:::ascending-jarvis-cto-scanner/*"
                    ]
                },
                {
                    "Sid": "s3",
                    "Effect": "Allow",
                    "Action": [
                        "s3:ListAllMyBuckets"
                    ],
                    "Resource": [
                        "*"
                    ]
                },
            ]
        })
}

resource "aws_iam_role_policy_attachment" "prowler_attachment" {
  role       = aws_iam_role.prowler_role.name
  policy_arn = aws_iam_policy.prowler_api_policy.arn
}