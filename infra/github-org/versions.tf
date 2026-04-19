terraform {
  # Require OpenTofu 1.6+ (also Terraform 1.6+ compatible).
  required_version = ">= 1.6.0"

  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }

  # State is stored as a GitHub Actions artifact (same pseudo-remote pattern
  # used by the vivarium repository). Workflows download/upload the artifact
  # on every run.
  backend "local" {
    path = "terraform.tfstate"
  }
}
