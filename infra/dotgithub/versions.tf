terraform {
  # Require OpenTofu 1.6+ (also Terraform 1.6+ compatible).
  # 1.6+ is required for the declarative `import` block in main.tf.
  required_version = ">= 1.6.0"

  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.12"
    }
  }

  # State is stored as a GitHub Actions artifact (`terraform-state-dotgithub`),
  # distinct from `infra/github-org/`'s `terraform-state` artifact, so the
  # two modules in this repo never overwrite each other's state.
  backend "local" {
    path = "terraform.tfstate"
  }
}
