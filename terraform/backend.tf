terraform {
  backend "s3" {
    bucket         = "ascending-s-api-terraform-states"
    key            = "prowler/tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
  }
}