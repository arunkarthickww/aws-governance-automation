terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

module "scp_policies" {
  source        = "../../modules/scp-policies"
  root_ou_id    = var.root_ou_id
  sandbox_ou_id = var.sandbox_ou_id
}

module "budget_alerts" {
  source      = "../../modules/budget-alerts"
  alert_email = var.alert_email
}

module "guardduty" {
  source = "../../modules/guardduty"
}
