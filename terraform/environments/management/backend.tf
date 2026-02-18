terraform {
  backend "s3" {
    bucket         = "myorg-terraform-state-250466514350"
    key            = "management/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}
