variable "root_ou_id" {}
variable "sandbox_ou_id" {}

resource "aws_organizations_policy" "deny_root" {
  name        = "DenyRootAccountUsage"
  description = "Prevents root account usage"
  type        = "SERVICE_CONTROL_POLICY"
  content = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Sid      = "DenyRootUser"
      Effect   = "Deny"
      Action   = "*"
      Resource = "*"
      Condition = {
        StringLike = {
          "aws:PrincipalArn" = "arn:aws:iam::*:root"
        }
      }
    }]
  })
}

resource "aws_organizations_policy_attachment" "deny_root" {
  policy_id = aws_organizations_policy.deny_root.id
  target_id = var.root_ou_id
}

resource "aws_organizations_policy" "deny_expensive" {
  name = "DenyExpensivePurchases"
  type = "SERVICE_CONTROL_POLICY"
  content = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Sid    = "DenyReservedInstances"
      Effect = "Deny"
      Action = [
        "ec2:PurchaseReservedInstancesOffering",
        "savingsplans:CreateSavingsPlan",
        "rds:PurchaseReservedDBInstancesOffering"
      ]
      Resource = "*"
    }]
  })
}

resource "aws_organizations_policy_attachment" "deny_expensive" {
  policy_id = aws_organizations_policy.deny_expensive.id
  target_id = var.sandbox_ou_id
}
