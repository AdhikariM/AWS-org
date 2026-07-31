locals {
  accounts = {
    tooling = {
      email     = var.account_emails.tooling
      parent_id = aws_organizations_organizational_unit.infrastructure.id
    }
    dev = {
      email     = var.account_emails.dev
      parent_id = aws_organizations_organizational_unit.workloads.id
    }
    staging = {
      email     = var.account_emails.staging
      parent_id = aws_organizations_organizational_unit.workloads.id
    }
    prod = {
      email     = var.account_emails.prod
      parent_id = aws_organizations_organizational_unit.workloads.id
    }
  }
}

resource "aws_organizations_account" "this" {
  for_each = local.accounts

  name      = "${var.account_name_prefix}-${each.key}"
  email     = each.value.email
  parent_id = each.value.parent_id

  role_name = "OrganizationAccountAccessRole"

  close_on_deletion = false

  lifecycle {
    ignore_changes = [
      role_name,
    ]
  }
}
