# `.github` repository — managed via OpenTofu.
#
# This module manages the `aletheia-works/.github` repository itself
# (repo settings, branch protection, CODEOWNERS). It is intentionally
# separate from `infra/github-org/` so that organization-level state
# (org settings, security manager team, Actions permissions) and
# repository-level state evolve independently and reviewers can tell
# at a glance which surface a change touches.
#
# Convention: keep this module small; everything fits in main.tf until
# it grows past a few hundred lines, then split by feature.

# ─── Repository ──────────────────────────────────────────────────────
#
# Adopts the existing `.github` repository on first apply via the
# declarative `import` block (OpenTofu 1.6+). Idempotent once state
# contains the resource; the import block can be removed in a follow-up
# cleanup PR after the first successful apply.

resource "github_repository" "this" {
  name        = ".github"
  description = "Org-wide defaults for aletheia-works: Code of Conduct, Security Policy, and templates"
  visibility  = "public"

  # Topics — surface this repo as the org's infrastructure / template hub
  # and resolve the ghqr `repo-meta-002` finding ("no topics").
  topics = [
    "github",
    "github-actions",
    "infrastructure-as-code",
    "opentofu",
    "org-management",
  ]

  # Feature toggles — match current live state.
  has_issues      = true
  has_discussions = false
  has_projects    = true
  has_wiki        = true

  # Merge strategy — current settings preserved; tightening is a separate
  # decision once contributor flow stabilises.
  allow_merge_commit = true
  allow_squash_merge = true
  allow_rebase_merge = true
  allow_auto_merge   = false

  # Resolve ghqr `repo-feat-002` ("auto-delete branches not enabled").
  delete_branch_on_merge = true

  # Inherit web commit signoff from the org-level setting.
  web_commit_signoff_required = true

  archived = false

  lifecycle {
    prevent_destroy = true
  }
}

import {
  to = github_repository.this
  id = ".github"
}

# ─── Branch protection ───────────────────────────────────────────────
#
# Phase 1 baseline. Mirrors vivarium/infra/github/branch_protection.tf
# so contributor expectations are uniform across repos. `enforce_admins`
# stays off so the sole maintainer can self-merge while solo; flip to
# true once a second reviewer is available.

resource "github_branch_protection" "main" {
  repository_id = github_repository.this.node_id
  pattern       = "main"

  required_pull_request_reviews {
    required_approving_review_count = 1
    dismiss_stale_reviews           = true
    require_code_owner_reviews      = true
    require_last_push_approval      = false
  }

  # `Commitlint` runs on every pull_request via this repo's own
  # .github/workflows/commitlint.yml (executed directly, not via a
  # caller), so the context name is the bare job display name.
  required_status_checks {
    strict = true
    contexts = [
      "Commitlint",
    ]
  }

  enforce_admins = false

  required_linear_history         = true
  allows_force_pushes             = false
  allows_deletions                = false
  require_conversation_resolution = true
  require_signed_commits          = true
}

# CODEOWNERS lives at .github/CODEOWNERS as a regular committed file
# (not managed via tofu's github_repository_file). Plain repo content
# stays out of state and contributors can edit it through normal PRs
# without needing the tofu apply pipeline. See `.github/CODEOWNERS`.
