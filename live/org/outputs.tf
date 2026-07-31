output "organization_id" {
  description = "AWS Organizations ID."
  value       = module.organization.organization_id
}

output "organization_arn" {
  description = "AWS Organizations ARN."
  value       = module.organization.organization_arn
}

output "organization_root_id" {
  description = "Root ID of the organization."
  value       = module.organization.organization_root_id
}

output "ou_ids" {
  description = "Organizational Unit IDs."
  value       = module.organization.ou_ids
}

output "account_ids" {
  description = "Member account IDs keyed by short name (tooling, dev, staging, prod)."
  value       = module.organization.account_ids
}

output "account_arns" {
  description = "Member account ARNs keyed by short name."
  value       = module.organization.account_arns
}
