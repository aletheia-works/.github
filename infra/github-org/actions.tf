# Org-level GitHub Actions policy.
#
# Import with:
#   tofu import github_actions_organization_permissions.this aletheia-works

resource "github_actions_organization_permissions" "this" {
  # Actions run in every repo in the org. (The only alternative value is
  # "selected", which would require enumerating repos; unnecessary here.)
  enabled_repositories = "all"

  # "selected" means third-party actions are restricted to the explicit
  # allowlist in allowed_actions_config. GitHub-owned and verified-creator
  # actions remain automatically allowed via the booleans below.
  allowed_actions = "selected"

  allowed_actions_config {
    github_owned_allowed = true
    verified_allowed     = true
    patterns_allowed     = var.allowed_action_patterns
  }
}
