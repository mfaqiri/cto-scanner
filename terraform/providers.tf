provider "aws" {
  region = "us-east-1"
}

data "aws_ecr_authorization_token" "token" {
  registry_id = "897729109735"
}

data "aws_eks_cluster" "s-api" {
  name = "ascending-s-api-cluster"
}


provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.s-api.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.s-api.certificate_authority[0].data)

    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "aws"
      args        = ["eks", "get-token", "--cluster-name", "ascending-s-api-cluster"]
    }
  }

  registry {
    url      = "oci://897729109735.dkr.ecr.us-east-1.amazonaws.com"
    username = data.aws_ecr_authorization_token.token.user_name
    password = data.aws_ecr_authorization_token.token.password
  }
}