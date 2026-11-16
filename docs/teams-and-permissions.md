# Teams and permissions

## Organization roles

| Role | Can |
| --- | --- |
| Owner | Everything, including billing and deleting the organization |
| Member | Whatever base permissions and team grants allow |
| Billing manager | Manage billing only |
| Outside collaborator | Access to specific repositories only, not a member |

## Repository roles, least to most

Read, Triage, Write, Maintain, Admin. Grant the lowest that lets the person do their job.

## A sensible team layout

```
engineering           Write on code repositories
  engineering-leads   Maintain
docs                  Write on docs repositories
security              Read everywhere, Admin on security tooling
```

Grant access to **teams**, not individuals, so offboarding is one removal.

## With `gh`

```bash
# create a team
gh api orgs/YOUR_ORG/teams -f name=engineering -f privacy=closed

# add a member
gh api -X PUT orgs/YOUR_ORG/teams/engineering/memberships/USERNAME -f role=member

# give the team Write on a repository
gh api -X PUT orgs/YOUR_ORG/teams/engineering/repos/YOUR_ORG/REPO -f permission=push
```

Use `CODEOWNERS` to route reviews to the right team.
