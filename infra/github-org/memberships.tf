# Organization membership.
#
# Only owners (admins) are pinned in code; regular members can be added
# via the UI without requiring a Tofu round-trip. If/when the project
# grows past solo development, convert the members list into its own
# variable and add a `github_membership` per member with role="member".
#
# Import with:
#   tofu import github_membership.owners[\"JamBalaya56562\"] aletheia-works:JamBalaya56562

resource "github_membership" "owners" {
  for_each = toset(var.org_owners)

  username = each.key
  role     = "admin"
}
