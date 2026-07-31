variable "aws_region" {
  description = "AWS region for the provider (Organizations is global; region is still required by the provider)."
  type        = string
  default     = "us-east-1"
}

variable "account_name_prefix" {
  description = "Prefix for member account names, e.g. 'aj' -> aj-tooling, aj-dev."
  type        = string
  default     = "aj"
}

variable "account_emails" {
  description = "Unique root email for each member account. Must never have been used for another AWS account."
  type = object({
    tooling = string
    dev     = string
    staging = string
    prod    = string
  })
}
