module "organization" {
  source = "../../modules/organization"

  account_name_prefix = var.account_name_prefix
  account_emails      = var.account_emails
}
