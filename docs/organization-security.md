# GitHub organization security checklist

- [ ] **Require two-factor authentication** (Settings, Authentication security). Members without 2FA are removed from the organization, so announce it first.
- [ ] **At least two owners**, everyone else a member.
- [ ] **Base permission: Read.**
- [ ] **Dependabot alerts and security updates** on for all repositories.
- [ ] **Secret scanning and push protection** on for all repositories (free on public repos).
- [ ] **Code scanning** (CodeQL) on public repositories.
- [ ] **Rulesets or branch protection** on default branches: pull request required, status checks required, force pushes blocked. `scripts/configure-branch-protection.sh` sets this up.
- [ ] **Restrict third-party app access**: Settings, Third-party access, require approval for OAuth apps.
- [ ] **Pin GitHub Actions to commit SHAs** and set the default workflow token to read-only (Settings, Actions, General).
- [ ] **A `SECURITY.md`** telling people how to report vulnerabilities privately ([template](../templates/community/SECURITY.md)). Enable private vulnerability reporting.
- [ ] **Review the audit log** monthly (Settings, Audit log).
- [ ] **Offboarding**: remove departed members the same day and rotate any secrets they could read.

## Common mistakes

- Giving everyone Admin "temporarily".
- Personal access tokens with broad scopes in CI. Prefer GitHub Apps or fine-grained tokens.
- Branch protection only on `main` while releases come from other branches.
