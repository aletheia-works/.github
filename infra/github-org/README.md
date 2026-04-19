# `infra/github-org/` — Org settings as code

OpenTofu configuration that manages the **organization-level** settings of
`aletheia-works` declaratively.

For per-repository settings (labels, branch protection, milestones) see each
repo's own `infra/github/` — e.g.
[vivarium/infra/github/](https://github.com/aletheia-works/vivarium/tree/main/infra/github).

## Managed resources

| Resource | File | Notes |
|---|---|---|
| `github_organization_settings` | `main.tf` | Profile, permissions, security defaults |
| `github_actions_organization_permissions` | `actions.tf` | Allowed actions policy |
| `github_membership` (admin role) | `memberships.tf` | Org owners |

A short list of org attributes that the provider does **not** cover yet
(2FA enforcement, SHA pinning, default workflow permissions, …) is
documented in `main.tf` — those are managed via the GitHub UI until the
provider catches up.

## CI workflows

Shared plan/apply logic lives in `.github/workflows/terraform-plan.yml` and
`.github/workflows/terraform-apply.yml` as **reusable workflows** (`on:
workflow_call`). Each consumer repo calls them through a thin wrapper.

| File | Purpose |
|---|---|
| `.github/workflows/terraform-plan.yml` | Reusable — `tofu plan` + PR comment |
| `.github/workflows/terraform-apply.yml` | Reusable — `tofu apply` + auto-filed failure issue |
| `.github/workflows/org-terraform-plan.yml` | Thin caller for this repo's `infra/github-org/` |
| `.github/workflows/org-terraform-apply.yml` | Thin caller for this repo's `infra/github-org/` |
| `.github/workflows/seed-state.yml` | One-off state bootstrap / recovery |
| `.github/workflows/terraform-state-backup.yml` | Weekly + post-apply backup to Release assets |

### Why reusable workflows, and does OpenTofu care?

**Short answer:** OpenTofu doesn't care — the reusable workflow just
orchestrates the `tofu` binary — and sharing the workflow logic removes
~300 duplicated lines from every new repo that needs an `infra/` directory.

**Isolation guarantees that matter for state:**

- **State artifact** (`terraform-state`) and **repo variable**
  (`LATEST_APPLY_RUN_ID`) are evaluated in the *caller's* repo context,
  so the org's state and vivarium's state never intersect.
- **Concurrency group** (`terraform-state`) is scoped to the caller
  workflow run, so a plan in the org repo cannot serialize behind a plan
  in vivarium.
- **Secrets** flow via `secrets: inherit` — `TF_TOKEN_GITHUB` is resolved
  in the caller repo. Reusable workflows never see each other's secrets
  store.
- **`workflow_run` listeners** (e.g. `terraform-state-backup.yml`) stay
  per-repo because `workflow_run` fires in the repo where the completed
  workflow ran, not in the reusable workflow's home repo.

The only coupling is the shared `.github` repo commit the caller pins —
updating `terraform-plan.yml@main` immediately affects every caller.
Pin to a SHA in production-critical repos if that's undesirable.

## Running locally

### 1. Create a Fine-grained PAT

Create a [Fine-grained personal access token](https://github.com/settings/personal-access-tokens/new) with:

- **Resource owner**: `aletheia-works`
- **Repository access**: Public Repositories (Read-only) — or `aletheia-works/.github` specifically
- **Organization permissions**:
  - Administration: **Read and write**
  - Members: **Read and write**
  - Custom organization roles: Read-only (if available)
  - Plan: Read-only
  - Secrets: **Read and write** (only if you plan to manage org secrets)

### 2. Prepare local files

```bash
cd infra/github-org
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars and set billing_email

export GITHUB_TOKEN=github_pat_xxxxxxxxxxxx
```

### 3. Fetch the latest state

```bash
gh run download --repo aletheia-works/.github --name terraform-state --dir .
```

### 4. Run tofu

```bash
tofu init
tofu plan
tofu apply
```

### 5. First-time bootstrap (import existing org)

```bash
tofu import github_organization_settings.this aletheia-works
tofu import github_actions_organization_permissions.this aletheia-works
tofu import 'github_membership.owners["JamBalaya56562"]' aletheia-works:JamBalaya56562
```

Then `tofu plan` to verify no drift, and push the state via
`seed-state.yml` so CI picks it up.

## State management

State lives as a GitHub Actions artifact in this repo (90-day retention) and
is mirrored to Release Assets weekly for long-term retention. A
`concurrency` group serializes plan/apply runs; there is no true distributed
lock, so don't run `apply` locally while CI is running.

## File layout

```
infra/github-org/
├── versions.tf                 # OpenTofu and provider versions
├── providers.tf                # GitHub provider config
├── variables.tf                # Input variables
├── main.tf                     # github_organization_settings
├── actions.tf                  # github_actions_organization_permissions
├── memberships.tf              # github_membership (admins)
├── terraform.tfvars.example    # Template for terraform.tfvars
├── .gitignore                  # Excludes state and secrets
├── .terraform.lock.hcl         # Provider version lock (committed after `tofu init`)
└── README.md
```
