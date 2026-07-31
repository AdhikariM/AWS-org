variable "account_name_prefix" {
  description = "Prefix for member account names, e.g. 'aj' -> aj-tooling, aj-dev."
  type        = string
}

variable "account_emails" {
  description = "Unique root email for each member account."
  type = object({
    tooling = string
    dev     = string
    staging = string
    prod    = string
  })
}

variable "aws_service_access_principals" {
  description = "AWS service principals to enable for the organization."
  type        = list(string)
  default = [
    "sso.amazonaws.com",
    "cloudtrail.amazonaws.com",
  ]
}
