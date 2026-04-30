<!--
Thanks for opening a PR on aletheia-works. A few notes so CI and reviewers
can move quickly:

- Title MUST follow Conventional Commits:
    <type>(<scope>)?: <subject>
  Types: feat, fix, docs, refactor, test, chore, build, ci, perf.
  The org-wide commitlint workflow will fail the check otherwise.

- The `scope: *` label is applied automatically by `.github/labeler.yml`
  from file paths. Do not hand-add it.

- Labels are mechanical only — they come from path rules, the
  Conventional-Commit prefix, or CI, never from judgement. If you are
  about to apply a label by judgement, stop and ask.
-->

## Summary

<!-- 1–3 bullets on what this PR changes and why. -->

Closes #<issue-number>.

## Verification

- [ ] I ran the relevant test suite locally where applicable.
- [ ] I added or updated tests for changed behaviour.
- [ ] I updated documentation where user-visible behaviour changes.
- [ ] If this affects a Vivarium-runnable reproduction, I verified the repro still works.

## Process notes

<!-- Delete the bullets that do not apply. -->
- AI-authored? If yes, the `ai: generated` label must be set on this PR.
- Scope-creep check: the diff still matches the title and linked Issue.
- Claude's automated review agrees, or you have pushed back with a specific
  justification on each disagreement (silent capitulation corrupts the
  review signal).
