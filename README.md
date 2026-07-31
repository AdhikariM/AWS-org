# AWS multi-account org (Terraform)

Bootstraps **AWS Organizations** from the management (payer) account, then creates tooling + workload accounts.

```
.
├── .github/workflows/     # CI plan / apply
├── live/
│   └── org/               # root stack (remote state in S3)
├── modules/
│   └── organization/      # org, OUs, member accounts
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
3. Four unique root emails in `live/org/terraform.tfvars` (local only; never commit)

## Local usage

```bash
cd live/org
cp terraform.tfvars.example terraform.tfvars
# edit emails

terraform init
terraform plan
terraform apply
```

State is stored in S3 (`aj-tfstate-122866988098`) with DynamoDB locking (`aj-terraform-locks`).

## GitHub Actions

| Event | Behavior |
|-------|----------|
| Pull request | `terraform plan` + PR comment with the plan |
| Push to `develop` / `main` | `terraform apply -auto-approve` |
| `workflow_dispatch` | plan only (Actions → Run workflow) |

### Required repository secrets

Repo → **Settings → Secrets and variables → Actions**:

| Secret | Value |
|--------|--------|
| `AWS_ACCESS_KEY_ID` | IAM access key (management account) |
| `AWS_SECRET_ACCESS_KEY` | matching secret |
| `TF_VARS` | full contents of your local `live/org/terraform.tfvars` |

Keep the repo **private** while using long-lived AWS keys.

### Cost

- GitHub Actions: uses free-tier minutes (this workflow is short; typically fine on Free)
- S3 state + DynamoDB lock: cents/month at this scale
- Empty AWS accounts: ~$0

## After apply

- Cross-account role: `OrganizationAccountAccessRole`
- Switch role from management using IDs from `terraform output account_ids`
