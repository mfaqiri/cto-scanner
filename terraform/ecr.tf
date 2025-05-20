resource "aws_ecr_repository" "librechat" {
  name                 = "prowler-api"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "prowler_ui" {
  name                 = "prowler-ui-image"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}