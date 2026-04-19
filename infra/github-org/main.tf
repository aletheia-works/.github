# Organization-level settings.
#
# To bring the existing org settings under management, import first:
#   tofu import github_organization_settings.this aletheia-works
#
# Values here must match what's currently set in the GitHub UI at import
# time; otherwise the first apply will drift the live settings. If you
# change a value intentionally, `tofu plan` will show the diff.

resource "github_organization_settings" "this" {
  billing_email = var.billing_email
  email         = var.billing_email
  description   = var.org_description

  # ─── Member permissions ──────────────────────────────────────
  # Only admins (organization owners) can create repositories. Members
  # cannot create repos of any visibility and cannot fork private repos.
  # Phase 0 is solo development so the practical blast radius is zero,
  # but these defaults are the right ones to hand off to a future team
  # and avoid accidental public creation.
  default_repository_permission            = "read"
  members_can_create_repositories          = false
  members_can_create_public_repositories   = false
  members_can_create_private_repositories  = false
  members_can_create_internal_repositories = false
  members_can_fork_private_repositories    = false

  # ─── GitHub Pages ────────────────────────────────────────────
  # Enable public Pages so repositories (vivarium, future sub-projects)
  # can publish docs sites. This is an *organization-level* gate: even
  # org owners cannot enable Pages on a repo while the org toggle is off.
  #
  # NOTE: GitHub couples `members_can_create_private_pages` to the
  # parent `members_can_create_pages` toggle — enabling the parent flips
  # private_pages to true on the API side even if the API request set it
  # to false. Keeping all three aligned at `true` to avoid infinite
  # drift. Private Pages are unreachable in practice on the Free plan
  # (private repos can't host Pages), so this is cosmetic.
  members_can_create_pages         = true
  members_can_create_public_pages  = true
  members_can_create_private_pages = true

  # ─── Projects (classic) / Project boards ─────────────────────
  # Org-level Projects classic board is enabled so the "vivarium roadmap"
  # GitHub Projects v2 board surfaces under the org. Repository-level
  # classic Projects stay on as well — `vivarium` uses them for some
  # views.
  has_organization_projects = true
  has_repository_projects   = true

  # ─── Commit integrity ────────────────────────────────────────
  # Enforce sign-off for every commit across every repo in the org. Repos
  # inherit this and cannot turn it off (which is why vivarium's repo
  # resource uses lifecycle.ignore_changes — the provider's PATCH always
  # ships web_commit_signoff_required=false in the body and triggers a 422).
  web_commit_signoff_required = true

  # ─── Default security hardening for new repos ────────────────
  # These only affect repositories created *after* the setting flips. For
  # existing repos, enable at the repo level. GitHub Advanced Security is
  # a paid add-on and stays off.
  advanced_security_enabled_for_new_repositories               = false
  dependabot_alerts_enabled_for_new_repositories               = true
  dependabot_security_updates_enabled_for_new_repositories     = true
  dependency_graph_enabled_for_new_repositories                = true
  secret_scanning_enabled_for_new_repositories                 = true
  secret_scanning_push_protection_enabled_for_new_repositories = true
}

# ── Settings that are NOT managed here ──────────────────────────────────
#
# The integrations/github provider (as of v6.11) does not expose the
# following org attributes. They are set via the GitHub UI / REST and
# documented here so the source of truth is still discoverable:
#
# • two_factor_requirement_enabled = true
#     Org-level 2FA enforcement. Set at /organizations/<org>/settings/security.
#
# • sha_pinning_required = true  (Actions → General → Policies)
#     Forces third-party actions to be pinned by commit SHA.
#
# • default_workflow_permissions = "read"                  (Actions → General)
#   can_approve_pull_request_reviews = false
#     Least-privilege GITHUB_TOKEN for all workflows.
#
# • members_can_delete_repositories = true                 (Repo policies)
# • members_can_change_repo_visibility = true
# • members_can_invite_outside_collaborators = true
# • members_can_delete_issues = false
# • display_commenter_full_name_setting_enabled = false
# • readers_can_create_discussions = true
# • members_can_create_teams = true
# • members_can_view_dependency_insights = true
# • deploy_keys_enabled_for_repositories = false
# • members_allowed_repository_creation_type = "none"
#     (Legacy aggregate field; practically covered by the per-visibility
#     members_can_create_*_repositories booleans set above.)
#
# Team / Enterprise-plan-only and therefore out of scope on Free:
# • Organization Rulesets
# • Custom repository roles
#
# When the provider adds coverage for any of the above, migrate it into
# this file and drop the corresponding line from this block.
