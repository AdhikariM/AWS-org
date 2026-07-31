terraform {
  backend "s3" {
    bucket         = "aj-tfstate-122866988098"
    key            = "org/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "aj-terraform-locks"
    encrypt        = true
  }
}
