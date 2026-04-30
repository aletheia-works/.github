# Security Policy

This is the **org-wide default** policy. Each repository can override it by shipping its own `SECURITY.md` — see [vivarium/SECURITY.md](https://github.com/aletheia-works/vivarium/blob/main/SECURITY.md) for the canonical, more detailed example.

## Reporting a vulnerability

Please do **not** open public issues for security problems.

Use **GitHub's [Private Vulnerability Reporting](https://docs.github.com/en/code-security/security-advisories/guidance-on-reporting-and-writing-information-about-vulnerabilities/privately-reporting-a-security-vulnerability)** on the affected repository:

1. Navigate to the repository's **Security** tab.
2. Click **Report a vulnerability**.
3. Fill in the advisory draft.

If you cannot use GitHub's flow, email `jambalaya.pyoncafe@gmail.com` with:

- The affected repository and version (or commit SHA).
- Reproduction steps.
- Your assessment of impact.

## Response expectations

aletheia-works projects are open-source, not managed services with an SLA. Response is **best-effort**:

- We will acknowledge private reports when we see them.
- We do not commit to a fixed triage or patch timeline.
- We will coordinate disclosure timing with you before making an advisory public.

## Supported versions

Each repository publishes its own supported-versions table. The default policy across the org is that only the `main` branch of each active repository is supported until that repository tags a release.

## A note on AI-generated reports

aletheia-works exists in part *because* AI-generated bug reports have become a signal-to-noise problem for open-source maintainers. We ask that any security report — AI-assisted or otherwise — include a human-verified reproduction. Reports that cannot be reproduced will be closed.

[Vivarium](https://github.com/aletheia-works/vivarium) is precisely the tool for building that reproduction before you file. See [vivarium/docs/docs/vision.md](https://github.com/aletheia-works/vivarium/blob/main/docs/docs/vision.md) for the broader context (cURL, Ghostty, tldraw, GitHub's February 2026 acknowledgement).

## No bug-bounty programme

There is no bug-bounty programme across aletheia-works. The cURL precedent (95% AI slop by January 2026) argues against bounties at this scale: they attract volume, and volume without quality creates more work than it resolves.

## Licence

aletheia-works projects are licensed under [Apache-2.0](LICENSE), which includes an explicit patent grant and a patent-retaliation clause. There is no separate contributor licence agreement.
