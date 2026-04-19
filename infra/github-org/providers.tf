# GitHub provider configuration.
#
# Authentication:
# - Reads a Personal Access Token from GITHUB_TOKEN.
# - In GitHub Actions, secrets.TF_TOKEN_GITHUB is injected as GITHUB_TOKEN.
# - Locally, export GITHUB_TOKEN=github_pat_xxx before running tofu.

provider "github" {
  owner = var.github_owner
}
