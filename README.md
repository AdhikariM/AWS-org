# AWS multi-account org (Terraform)

Bootstraps **AWS Organizations** from the management (payer) account, then creates tooling + workload accounts.

```
.
├── live/
│   └── org/                 # root stack you apply (state lives here)
├── modules/
│   └── organization/        # org, OUs, member accounts
├── .gitignore
└── README.md
```

| Account | OU |
|---------|-----|
| tooling | Infrastructure |
| dev / staging / prod | Workloads |

## Prerequisites

1. AWS CLI configured for the **management** account: `aws sts get-caller-identity`
2. Payment method on file
3. Four unique root emails in `live/org/terraform.tfvars`

## Usage

```bash
cd live/org
cp terraform.tfvars.example terraform.tfvars
# edit emails

terraform init
terraform plan
terraform apply
```

## After apply

- Cross-account role in each member account: `OrganizationAccountAccessRole`
- Switch role from management into e.g. dev account ID from `terraform output account_ids`

## Layout notes

- Apply only from `live/org` (that directory owns state).
- Reusable logic stays in `modules/organization`.
- Later stacks (e.g. `live/tooling`, networking) can live next to `live/org`.

## Out of scope (for now)

Remote state, GitHub Actions, SCPs, IAM Identity Center, networking.
