# Offerings menu

A generic menu of what platform engineering teams offer, how to decide which items become Jira components, and how to name them.

*Diátaxis type: Reference.*

## Capabilities versus offerings

The [CNCF Platforms White Paper](https://tag-app-delivery.cncf.io/whitepapers/platforms/) lists 13 **capabilities** most platforms provide. An **offering** is how a team packages capabilities for its customers, named by what the customer gets. The menu below is built from those capabilities, plus two offerings nearly every product-minded platform team runs.

## The menu

| Category | What the customer gets | Home plane | CNCF capability |
|---|---|---|---|
| **Software Catalog** | What exists, who owns it, how it connects | Developer Control | Web portals |
| **Docs Hub** | One place for how-tos and references | Developer Control | Golden path docs |
| **Golden Paths & Templates** | A new service or pipeline that starts out right | Developer Control | Golden path templates |
| **Developer Environments** | Local, ephemeral or preview environments | Developer Control | Development environments |
| **Infrastructure Self-Service** | Databases, buckets, queues on request, via IaC modules or APIs | Integration & Delivery | APIs and CLIs |
| **CI Pipelines** | Build and test without owning the tooling | Integration & Delivery | Build and test automation |
| **CD & Release Management** | Safe, visible deploys and promotions | Integration & Delivery | Delivery and verification automation |
| **Artifacts & Images** | Registries, golden images, package caches | Integration & Delivery | Artifact storage |
| **Runtime** | Somewhere to run, patched and upgraded for you | Resource | Infrastructure services |
| **Data & Messaging** | Managed databases, queues, event streams | Resource | Data services; messaging and events |
| **Networking & Ingress** | DNS, certificates, ingress, service-to-service traffic | Resource | Infrastructure services |
| **Observability** | Logs, metrics, traces, dashboards, alerts | Monitoring & Logging | Application observability |
| **Cost Visibility** | Showback per team, cost guardrails | Monitoring & Logging | Application observability (OpenCost) |
| **Identity & Secrets** | Credentials and workload identity, handled safely | Security | Identity and secrets |
| **Policy & Compliance** | Guardrails, scanning, supply chain checks, audit evidence | Security | Security services |

### The two extras

Not in the CNCF list, but almost universal once a team runs its platform as a product:

| Category | What the customer gets | Home plane |
|---|---|---|
| **Platform Support & Enablement** | A support channel, office hours, onboarding, training | Cross-cutting |
| **Roadmap & Proposals** | A published roadmap and calendar, and a way to ask for things | Cross-cutting |

### How to read the menu

- **It's a menu, not a checklist.** Most teams start with five to eight. Nearly universal: Software Catalog, Docs Hub, Golden Paths, CI, CD, Runtime, Observability, Identity & Secrets, Platform Support. The rest depend on the organization (data services often belong to a DBA team, for example).
- **Specialties fit inside generic slots.** Fleet AMI patching lives in Runtime (and Artifacts & Images if you build golden images). A release-management tool is CD & Release Management.
- **Two attributes from the white paper make good rules:** offerings are *optional and composable* (teams use what they need), and *secure by default* (compliance is built into each offering, not a separate one people must remember).

## Category versus component

A **category** is a menu slot. A **component** is the concrete offering inside it. When a slot holds one offering, they can share a name; as soon as it holds two (EKS and Lambda under Runtime), they split.

```
Plane → Category → Component
Resource → Runtime → EKS Clusters
```

## Is it a component?

A component is the smallest thing that has all four:

1. **Customers ask for it by name.** "My EKS cluster", not "the runtime".
2. **One owner.** The Jira component lead, also the default assignee.
3. **Its own release stream.** Fix versions on the calendar.
4. **Its own support channel and docs.**

Applied to the menu:

| Category | Component? |
|---|---|
| Runtime, CI, CD & Release, Artifacts & Images, Infrastructure Self-Service, Observability, Identity & Secrets, Data & Messaging, Networking | **Yes**, one per concrete offering |
| Software Catalog, Docs Hub, Golden Paths, Developer Environments | **Yes**, once you run them (templates and schemas release too) |
| Platform Support | **Yes, without releases.** The inbox for "I don't know which offering this is"; triage moves issues to the right component. |
| Policy & Compliance, Cost Visibility | **Depends.** A component if shipped as products (policy bundles, cost dashboards); otherwise a **concern tag** on other components. |
| Roadmap & Proposals | **No.** That's the `proposal` label and the proposal process. |

Aim for **8 to 15 components**. Fewer and they're too vague to route; many more and customers can't choose from the dropdown. If the list gets long, prefix names with the category (`Runtime · EKS Clusters`) so the dropdown groups itself.

## Illustrative mapping

For a team running EKS fleets, Concourse or Jenkins pipelines and a release-management tool. Replace with your own.

| Category | Component | Home plane | Concerns | Fix version example |
|---|---|---|---|---|
| Runtime | EKS Clusters | Resource | security-compliance, finops | `EKS 2026.11 – node AMI patch` |
| Artifacts & Images | Golden Images | Integration & Delivery | security-compliance | `AMI 2026.11` |
| CI Pipelines | CI Pipelines | Integration & Delivery | — | `CI 2026.11` |
| CD & Release Management | Release Desk | Integration & Delivery | reliability | `Release Desk 1.2` |
| Infrastructure Self-Service | Terraform Modules | Integration & Delivery | finops | `Terraform Modules 3.4.0` |
| Observability | Observability | Monitoring & Logging | reliability | `Observability 2026.Q4` |
| Identity & Secrets | Workload Secrets | Security | security-compliance | `Workload Secrets 2026.11` |
| Docs Hub | Docs Hub | Developer Control | — | — |
| Platform Support | Platform Support | Cross-cutting | — | — |

## Naming conventions

One name per offering, used everywhere:

| Thing | Pattern | Example |
|---|---|---|
| Offering and Jira component | Outcome noun phrase, Title Case, no tool names | Workload Secrets |
| Teams channel | Exactly the component name | Workload Secrets |
| Confluence tree root | Exactly the component name | Workload Secrets |
| Fix version | `<Component> <YYYY.MM>` for cadenced work, `<Component> <semver>` for products | `Workload Secrets 2026.11` |
| Short slug (repos, labels, URLs) | lowercase-hyphenated | `workload-secrets` |

Names to avoid: tool names ("Vault Requests", "Jenkins"), state names ("Secrets Tickets"), and team-internal jargon customers wouldn't search for.

## Catalog fields

Every offering's catalog entry carries these. The [offering template](offering-template.md) has them ready to copy.

| Field | Example |
|---|---|
| Offering / component | Workload Secrets |
| Category | Identity & Secrets |
| Home plane | Security |
| Also touches | Resource, Integration & Delivery |
| Concerns | security-compliance |
| Owner (component lead) | @name |
| Teams channel | Workload Secrets |
| Docs | Confluence: Workload Secrets |
| Release cadence | Monthly, or on change |
| Fix version pattern | `Workload Secrets <YYYY.MM>` |
| Repos | `workload-secrets-policies`, `platform-eso-config` |
| Backed by | Vault, External Secrets Operator |
| Current maturity level | L1 Ticket Ops |
