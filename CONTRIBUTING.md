# Contributing to aletheia-works

Thank you for considering a contribution.

## Before you start

Each repository has its own `CONTRIBUTING.md` with project-specific guidance. Consult the per-repo file first. This org-wide file captures shared expectations across every aletheia-works project.

## Shared expectations

- **Open an issue before a large PR.** Drive-by large changes tend to collide with in-progress work.
- **Verify before filing.** This project exists to counter unverified AI-generated output. Please confirm a bug personally (or in a reproducible environment) before reporting it.
- **Sign off your web commits.** The org enforces `web_commit_signoff_required`.

## Commit messages

All commits must follow the [Conventional Commits specification](https://www.conventionalcommits.org/en/v1.0.0/). This is enforced by a shared CI workflow ([`commitlint.yml`](./.github/workflows/commitlint.yml)) that runs on every push and pull request across aletheia-works repos.

Format:

```
<type>(<scope>)?: <subject>

[optional body]

[optional footer(s)]
```

Accepted types (from `@commitlint/config-conventional`):

| Type | Use for |
|---|---|
| `feat` | A new user-visible feature |
| `fix` | A bug fix |
| `docs` | Documentation-only changes |
| `refactor` | Code restructuring that changes no behavior |
| `perf` | Performance improvements |
| `test` | Adding or fixing tests |
| `build` | Build system / dependency changes |
| `ci` | CI configuration changes |
| `chore` | Maintenance, tooling, bootstrap |
| `revert` | Reverts a previous commit |
| `style` | Whitespace / formatting only |

Examples:

```
feat(wasm): add Pyodide sandbox initialization
fix(ci): correct download-artifact run-id fallback
docs: explain the verified-reproduction workflow
chore: initial bootstrap of vivarium
```

### Squashing and rewriting history

During the early bootstrap phase of a new repository (before the first PR lands), history can be rewritten — use `sl amend`, `sl fold`, or a nuclear reset to squash everything into the initial commit, then force-push to `main`. Once PR-based review begins, switch to normal per-commit granularity and do not rewrite shared history.

## Labeling policy

**Labels are applied mechanically — never by humans or AI as ad-hoc judgment.**

Each aletheia-works repo uses a shared label taxonomy (`type: *`, `scope: *`, `priority: *`, `status: *`, `ai: *`). Labels are applied through automation:

- [`actions/labeler`](https://github.com/actions/labeler) applies `scope: *` / `type: docs` based on changed file paths (configured in each repo's `.github/labeler.yml`).
- Release-note categorization is driven by the same labels via `.github/release.yml`.
- Contributors do not apply or rename labels in issue/PR UIs for workflow purposes. If a label is needed, add the corresponding automation rule instead.

When changing the label set, update the repo's `infra/github/labels.tf` (Terraform-managed) and re-run the plan/apply workflow — never click-edit labels in the GitHub UI.

## Communication

- Technical discussion: GitHub Discussions on the affected repository
- Cross-project / strategic: Discussions on `aletheia-works/.github` (enabled when needed)

## Conduct

All contributors are expected to uphold the [Code of Conduct](./CODE_OF_CONDUCT.md).
