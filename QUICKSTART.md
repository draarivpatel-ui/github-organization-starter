# Quickstart: a configured GitHub organization in 10 minutes

You need a GitHub account. Nothing else is installed until step 3.

## Checklist

- [ ] 1. **Create the organization** (2 min). github.com, profile picture, **Your organizations**, **New organization**, **Free** plan. Name: short, lowercase.
- [ ] 2. **Turn on two-factor requirement** (1 min). Organization, **Settings**, **Authentication security**, **Require two-factor authentication**.
- [ ] 3. **Install and sign in to `gh`** (2 min).

  ```bash
  gh auth login --scopes repo,admin:org
  ```

- [ ] 4. **Check your setup** (1 min).

  ```bash
  ./scripts/check-prerequisites.sh YOUR_ORG
  ```

   ![Output of check-prerequisites.sh](docs/images/09-check-prerequisites.png)

- [ ] 5. **Create the org-wide `.github` repository and a first repo** (2 min).

  ```bash
  ./scripts/bootstrap-repositories.sh YOUR_ORG
  ```

  This publishes the community files in `templates/community/` and the profile README, so every repository inherits a code of conduct, security policy and support page.

- [ ] 6. **Protect the default branch** (1 min).

  ```bash
  ./scripts/configure-branch-protection.sh YOUR_ORG first-repo
  ```

- [ ] 7. **Set base permissions to Read.** **Settings**, **Member privileges**, **Base permissions**: Read. Grant more through teams ([guide](docs/teams-and-permissions.md)).
- [ ] 8. **Edit the profile README** in `YOUR_ORG/.github/profile/README.md` so your org page says what you build.

Done. Next: [security](docs/organization-security.md) and [teams](docs/teams-and-permissions.md).

Try everything first with `DRY_RUN=1 ./scripts/bootstrap-repositories.sh YOUR_ORG`.
