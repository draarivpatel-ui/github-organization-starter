# Enterprise organization

One organization per business unit, under a GitHub Enterprise account with SAML SSO.

```
.github                    shared policies and workflow templates
platform-*                 internal platform repositories (private)
service-<domain>-<name>    one repository per service (private)
```

Teams mirror the org chart and sync from the identity provider. Access is granted to teams only; Admin is limited to the platform team. Rulesets are set at the organization level, with required status checks and CODEOWNERS review. Audit log streams to the security team's SIEM.
