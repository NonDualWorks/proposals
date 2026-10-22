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

## Journeys and building blocks

Customers rarely ask for a building block on its own. A new secret almost always arrives with a backstory: a new integration, a new service, a new joiner. So offerings come in four **kinds**:

| Kind | What it is | Examples |
|---|---|---|
| **Journey** | A job a customer comes with, which usually needs several building blocks | People Access, Service Onboarding, System Integrations |
| **Building block** | A capability journeys are made of; also requested directly for existing setups | Workload Secrets, Network Access |
| **Product** | Something customers use continuously | EKS Clusters, CI Pipelines, Observability |
| **Support** | The catch-all inbox | Platform Support |

**The journey link.** A journey request is one issue, linked to one issue per building block it needs:

```
DEVOPS-501  [System Integrations]  Payments → BU-Billing API
  ├ DEVOPS-502  [Workload Secrets]     billing-api client secret for payments
  ├ DEVOPS-503  [Network Access]       SG rule payments → billing (443)
  └ DEVOPS-504  [System Integrations]  BU-Billing owner approval
```

The **story** (why, who approved) stays on the journey issue. The **noise** is counted per building block, so "40 Workload Secrets requests this quarter, most from System Integrations" tells you exactly where to invest.

**Journeys mature by composing building blocks.** Service Onboarding at L3 is a golden-path template that creates the repo, pipeline, namespace, catalog entry and secret path in one go. System Integrations at L3 is an integration declared as code (source, target, port, credential type) with approvals built in, from which the secret and network change follow.

## Requests versus releases

| | Request | Change and release |
|---|---|---|
| What it is | A customer using the offering as it is | A change to how the offering behaves or is fulfilled, for everyone |
| Example | Add a secret for the payments service | Upgrade the secrets operator; enforce the naming convention; launch the request form |
| Gets a release? | **Never** | Yes, grouped into a dated release of that offering |
| Shows up in | Noise and lead-time metrics | The calendar |

Three services each asking for a secret on a busy day are three requests and no release. If the team bundles their delivery into one config rollout, that rollout is an operational change linked to the three requests, still not a release. Keeping requests out of releases keeps the calendar meaningful.

So an offering's component does three jobs even in months with no release: **routing** (requests land with the owner), **measurement** (noise per offering), and **anchoring** (the channel and docs share its name).

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
| Journeys and building blocks | **Yes, both.** Journeys hold the story; building blocks give per-capability noise. Link them. |
| Policy & Compliance, Cost Visibility | **Depends.** A component if shipped as products (policy bundles, cost dashboards); otherwise a **concern tag** (`security-compliance`, `governance`, `finops`) on other components. |
| Roadmap & Proposals | **No.** That's the `proposal` label and the proposal process. |

Aim for **8 to 15 components**. Fewer and they're too vague to route; many more and customers can't choose from the dropdown. If the list gets long, prefix names with the category (`Runtime · EKS Clusters`) so the dropdown groups itself.

## Starter component set

A comprehensive set for a platform team that runs EKS fleets, CI/CD pipelines, a release-management tool and IAM and governance work. Use it as is, or delete rows you don't run. Fifteen components, within the 8 to 15 guideline.

| Category (starter channel) | Component | Kind | Home plane | Concerns | Releases? | Fix version pattern |
|---|---|---|---|---|---|---|
| **IAM & Governance** | People Access | Journey | Security | governance, security-compliance | When the access process changes | `People Access <YYYY.MM>` |
| | Service Onboarding | Journey | Developer Control | governance | When the onboarding template or steps change | `Service Onboarding <semver>` |
| | System Integrations | Journey | Security | governance, security-compliance | When the integration process changes | `System Integrations <YYYY.MM>` |
| | Vendor Licenses | Journey | Cross-cutting | governance, finops | Rarely; when the licence process changes | `Vendor Licenses <YYYY.MM>` |
| | Workload Secrets | Building block | Security | security-compliance | When how secrets are supplied changes | `Workload Secrets <YYYY.MM>` |
| | Network Access | Building block | Resource | security-compliance | When how firewall or security-group changes are made changes | `Network Access <YYYY.MM>` |
| **Runtime & Images** | EKS Clusters | Product | Resource | security-compliance, finops, reliability | Monthly patching, version upgrades | `EKS Clusters <YYYY.MM> – <what>` |
| | Golden Images | Product | Integration & Delivery | security-compliance | Monthly image builds | `Golden Images <YYYY.MM>` |
| **Delivery** | CI Pipelines | Product | Integration & Delivery | reliability | Pipeline template changes | `CI Pipelines <YYYY.MM>` |
| | Deployments & Releases | Product | Integration & Delivery | reliability | Tool and process changes | `Deployments & Releases <semver>` |
| | Infrastructure Modules | Product | Integration & Delivery | finops | Module versions | `Infrastructure Modules <semver>` |
| **Observability** | Observability | Product | Monitoring & Logging | reliability, finops | Stack and dashboard changes | `Observability <YYYY.MM>` |
| **Developer Portal** | Software Catalog | Product | Developer Control | — | Schema and portal changes | `Software Catalog <semver>` |
| | Docs Hub | Product | Developer Control | — | Structure and template changes | `Docs Hub <YYYY.MM>` |
| **Platform Support** | Platform Support | Support | Cross-cutting | — | Never | — |

Plus one channel that isn't an offering: **Platform Proposals**, for the proposal process.

Notes:
- **Deployments & Releases** and **Infrastructure Modules** are named for outcomes. The tools behind them (a release-management tool such as Release Desk; Terraform) go in the catalog's *backed by* field.
- **Fix versions are for changes only.** Requests on any of these components never get one (see [requests versus releases](#requests-versus-releases)).
- **Not included, add if you run them:** Developer Environments, Golden Paths & Templates (if separate from Service Onboarding), Data & Messaging, Networking & Ingress (if separate from Network Access), Policy & Compliance and Cost Visibility as products.

## Naming conventions

One name per offering, used everywhere. Channels and docs trees start at the **category** level and split per offering when volume or audience justifies it (for example, People Access often has a different audience: managers and HR rather than developers).

In a shared channel, start each post with the component name (`[System Integrations] Payments → BU-Billing API`) so people can scan and triage can pick the right component.


| Thing | Pattern | Example |
|---|---|---|
| Offering and Jira component | Outcome noun phrase, Title Case, no tool names | Workload Secrets |
| Chat channel | The **category** name to start (`IAM & Governance`); the component name once it gets its own | IAM & Governance |
| Docs tree | Category root, with one section per offering named exactly as the component | IAM & Governance / Workload Secrets |
| Fix version | `<Component> <YYYY.MM>` for cadenced work, `<Component> <semver>` for products | `Workload Secrets 2026.11` |
| Short slug (repos, labels, URLs) | lowercase-hyphenated | `workload-secrets` |

Names to avoid: tool names ("Vault Requests", "Jenkins"), state names ("Secrets Tickets"), and team-internal jargon customers wouldn't search for.

## Catalog fields

Every offering's catalog entry carries these. The [offering template](offering-template.md) has them ready to copy.

| Field | Example |
|---|---|
| Offering / component | Workload Secrets |
| Category | IAM & Governance |
| Kind | Building block |
| Home plane | Security |
| Also touches | Resource, Integration & Delivery |
| Concerns | security-compliance |
| Usually requested via | System Integrations, Service Onboarding |
| Owner (component lead) | @name |
| Channel | IAM & Governance |
| Docs | Confluence: Workload Secrets |
| Release cadence | Monthly, or on change |
| Fix version pattern | `Workload Secrets <YYYY.MM>` |
| Repos | `workload-secrets-policies`, `platform-eso-config` |
| Backed by | Vault, External Secrets Operator |
| Current maturity level | L1 Ticket Ops |
