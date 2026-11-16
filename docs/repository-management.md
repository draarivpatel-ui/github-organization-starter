# Repository management

## Naming

Lowercase, hyphenated, noun-first: `billing-api`, `web-app`, `infra-terraform`. Reserve `.github` for shared files and `docs` for documentation.

## Every new repository should have

- A README that says what it is and how to run it.
- A LICENSE (public repos) or an internal-use notice (private).
- `CONTRIBUTING.md` unless inherited from the org `.github` repository.
- Branch protection on the default branch.
- A topic list and description, so search finds it.

Templates: [templates/repository/](../templates/repository).

## Template repositories

Mark a repository as a template (Settings, **Template repository**) and create new ones from it with:

```bash
gh repo create YOUR_ORG/new-service --template YOUR_ORG/service-template --private
```

## Archive, do not delete

Archive abandoned repositories (Settings, **Archive this repository**). They stay readable and links keep working.

## Automation

`scripts/bootstrap-repositories.sh` creates the shared `.github` repository and a first repository from a list you control.
