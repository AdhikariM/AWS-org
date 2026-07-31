output "organization_id" {
  description = "AWS Organizations ID."
  value       = aws_organizations_organization.this.id
}

output "organization_arn" {
  description = "AWS Organizations ARN."
  value       = aws_organizations_organization.this.arn
}

output "organization_root_id" {
  description = "Root ID of the organization."
  value       = aws_organizations_organization.this.roots[0].id
}

output "ou_ids" {
  description = "Organizational Unit IDs."
  value = {
    infrastructure = aws_organizations_organizational_unit.infrastructure.id
    workloads      = aws_organizations_organizational_unit.workloads.id
  }
}

output "account_ids" {
  description = "Member account IDs keyed by short name."
  value = {
    for key, account in aws_organizations_account.this : key => account.id
  }
}

output "account_arns" {
  description = "Member account ARNs keyed by short name."
  value = {
    for key, account in aws_organizations_account.this : key => account.arn
  }
}
