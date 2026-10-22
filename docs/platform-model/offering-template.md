# Offering template

Copy this for each new offering. The first part is the **catalog entry** (a Page Properties table on the offering's Confluence root page, or front matter in a repo). The second is the **docs skeleton**, the same for every offering so people and AI tools find things in the same place.

*Diátaxis type: Template. Fields are explained in [offerings-menu.md](offerings-menu.md#catalog-fields).*

---

## Catalog entry

```yaml
offering: Workload Secrets            # also the Jira component, Teams channel and Confluence root
slug: workload-secrets
category: Identity & Secrets          # slot from the offerings menu
home-plane: security                  # developer-control | integration-delivery | resource | monitoring-logging | security | cross-cutting
also-touches: [resource, integration-delivery]
concerns: [security-compliance]       # security-compliance | finops | reliability | …
owner: "@name"                        # Jira component lead and default assignee
teams-channel: Workload Secrets
docs: "Confluence: Platform / Workload Secrets"
release-cadence: on change            # monthly | quarterly | on change | none
fix-version-pattern: "Workload Secrets <YYYY.MM>"
repos: [workload-secrets-policies, platform-eso-config]
backed-by: [Vault, External Secrets Operator]
current-level: L1                     # L1 Ticket Ops | L2 Paved Road | L3 Self-Service | L4 Outcome-Driven
target-level: L3
baseline:                             # from routing requests to the component
  requests-per-month:
  median-lead-time:
  manual-steps:
proposals: []                         # RFCs and Lite Proposals affecting this offering
```

## One-line summary

> *What the customer gets, in one sentence, from their side.*
> Example: "Your workload gets the credentials it needs at runtime, without secrets passing through tickets or chat."

## Docs skeleton

```
<Offering name>
├── Tutorials
│   └── Your first <thing> with <offering>          learning by doing, start to finish
├── How-to guides
│   ├── Request / create a <thing>                   matches the current level honestly
│   ├── Change or rotate a <thing>
│   └── Get help                                     the Teams channel, Jira component, response times
├── Reference
│   ├── Naming and conventions
│   ├── Limits, quotas and SLOs
│   ├── Release calendar                             fix versions and dates
│   └── Changelog
└── Explanation
    ├── How <offering> works                         architecture, planes it touches
    ├── Why it's shaped this way                     links to the RFCs and ADRs
    └── Where it's heading                           current level, target level, open proposals
```

At L1, the how-to describes today's manual process truthfully. Updating it as the offering moves to L2 and L3 is part of each Beta gate (docs live in Tutorial and How-to) and GA gate (all four quadrants).

## Setup checklist

- [ ] Jira component created; lead and default assignee set; description filled in
- [ ] Teams channel created with the same name; docs link and Jira filter pinned
- [ ] Confluence root created with the same name, this skeleton and the catalog table
- [ ] Listed on the *Offerings catalog* page (automatic via Page Properties Report)
- [ ] First fix version created, if it has a cadence
- [ ] Requests are being routed here; baseline collection started
