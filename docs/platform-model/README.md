# The platform model

How a platform engineering team describes what it offers, so customers, tools, docs and metrics all line up. Use it when starting with a new customer, adding an offering, or untangling ad-hoc work.

*Diátaxis type: Explanation. The other files in this folder are reference, how-to and a template.*

## Files in this folder

| File | Type | Use it to |
|---|---|---|
| [README.md](README.md) | Explanation | Understand the model and why it's shaped this way |
| [concepts.md](concepts.md) | Reference | The tool-neutral vocabulary, and how Jira, Linear and GitHub express it |
| [offerings-menu.md](offerings-menu.md) | Reference | The generic menu, journeys and building blocks, requests versus releases, the component test, a 15-component starter set, naming |
| [maturity-paths.md](maturity-paths.md) | Explanation | Evolve an ad-hoc (L1) offering to self-service, with a worked example |
| [communication.md](communication.md) | Reference | Channel kinds and naming, shared channels, the standard notices, partner and UAT channels |
| [projects-and-releases.md](projects-and-releases.md) | Explanation | Project naming, landing pages and closing; projects spanning offerings; the two-layer calendar; code-to-offering rules |
| [atlassian-setup.md](atlassian-setup.md) | How-to | Set the model up in Jira, Teams, Confluence and Bitbucket, including the proposals board |
| [new-customer-playbook.md](new-customer-playbook.md) | How-to | Apply all of this when approaching a new customer |
| [offering-template.md](offering-template.md) | Template | Create a catalog entry and docs skeleton for one offering |

## The model in one picture

```
Plane          Resource                    a tag: where it lives in the platform's architecture
 └ Category    Runtime                     a slot from the generic menu, for grouping
    └ Offering EKS Clusters                what customers ask for by name
        ├ Jira component (lead = owner, default assignee)
        ├ Fix versions → release dates → the published calendar
        ├ Chat channel (per category to start, per offering when busy)
        ├ Docs tree in Diátaxis form (tutorial, how-to, reference, explanation)
        └ Repos, mapped many-to-one in the catalog
```

**The offering is the unit.** It has one name everywhere: the component customers file against, the docs they read, the releases on the calendar, and eventually its own channel. Two things map many-to-one on purpose: **channels** start one per category (busy offerings get their own later), and **repos** map to offerings in the catalog, because real code doesn't line up neatly.

**Concepts first, tools second.** The model is defined in tool-neutral terms in [concepts.md](concepts.md). Jira components and fix versions are one way to run it; Linear and GitHub are others.

## Principles

1. **Name the offering after the outcome, not the tool.** "Workload Secrets", not "Vault". Backstage isn't an offering; it's a tool that delivers three (Software Catalog, Docs Hub, Golden Paths). If the tool changes, the offering, its component and its channel stay.
2. **Planes say where; concerns say why.** A plane is part of the platform's architecture. Security compliance, FinOps and reliability are reasons work exists, and they cut across planes. Record them as **concern** tags, not as planes.
3. **Every offering has one home plane** (where the thing it owns or changes lives) and can **also touch** others. Spanning planes is normal.
4. **A component passes four tests:** customers ask for it by name, it has one owner, it has its own release stream, and it deserves its own channel and docs. See [the component test](offerings-menu.md#is-it-a-component).
5. **Map code to offerings; don't restructure first.** Works for monorepos (by directory) and many repos alike. Restructure only when an offering can't be released on its own, and make that its own RFC with evidence. See [code and repos](projects-and-releases.md#code-and-repos).
6. **Name ad-hoc work before improving it.** Something done by ticket today is already an offering at Level 1. Naming it makes its noise measurable, which is the baseline for improving it. See [maturity-paths.md](maturity-paths.md).
7. **Requests are not releases.** A customer using an offering as it is (adding a secret) is a request: fulfilled, measured, never released. Only changes to how the offering works go into a release and onto the calendar. See [requests versus releases](offerings-menu.md#requests-versus-releases).
8. **Journeys hold the story; building blocks hold the noise.** Customers arrive with jobs (a new integration, a new service, a new joiner) that need several building blocks (a secret, a firewall change). Link one journey request to its building-block requests. See [journeys and building blocks](offerings-menu.md#journeys-and-building-blocks).
9. **Epics group by outcome; releases group by offering.** A project spanning several offerings has one epic and one release per affected offering, mostly on the same launch date. See [projects-and-releases.md](projects-and-releases.md).

## Planes

From the PlatformEngineering.org reference architecture:

| Plane | Holds |
|---|---|
| **Developer Control** | The interfaces developers use: portal, templates, version control for app and platform source |
| **Integration & Delivery** | Build, store, configure and deploy: CI, registries, orchestrators, CD, **and running IaC** |
| **Resource** | What runs the apps: clusters, compute, databases, networking, DNS |
| **Monitoring & Logging** | Metrics, logs, traces, dashboards, alerts, cost visibility |
| **Security** | Secrets, identity, policy engines, scanning |

### IaC touches three planes

| Part | Plane |
|---|---|
| The Terraform code, in version control | Developer Control |
| Running it: pipelines, plan and apply, orchestration | **Integration & Delivery** (infrastructure delivery belongs here, not only app CI/CD) |
| What it creates | Resource |

## Offerings that span planes

Give each offering three tags:

| Tag | Values | Rule |
|---|---|---|
| **Home plane** | One plane | Where the thing it owns or changes lives |
| **Also touches** | Zero or more planes | What it relies on |
| **Concerns** | `security-compliance`, `governance`, `finops`, `reliability`, … | Why it exists |

The concern tag lets you ask "everything we do for compliance" across the catalog, which is useful for audits.

### Worked example: monthly AMI patching for ~50 EKS clusters

| Question | Answer | Plane |
|---|---|---|
| What changes? | Node AMIs across the cluster fleet | **Resource** (home) |
| How? | Pipelines rolling node groups | Integration & Delivery |
| What counts as compliant? | Patch and vulnerability policy | Security |
| How is it proven? | Patch level and drift reports | Monitoring & Logging |
| Why? | Compliance | Concern: `security-compliance` |

"AMI patching" is an activity, so it isn't the component. Two good shapes:

- **Option A, patching is only for EKS:** one component, **EKS Clusters**. Patching is its monthly fix version (`EKS 2026.11 – node AMI patch`) beside other cluster work (`EKS 1.32 upgrade`).
- **Option B, hardened AMIs are used by EKS and others:** split producing from consuming. **Golden Images** (Integration & Delivery) releases `AMI 2026.11`; **EKS Clusters** (Resource) releases `EKS 2026.11 – node AMI rollout` a few days later. Both are independently releasable, and the calendar shows the sequence.

### Worked example: FinOps instance-type rules

"Use FinOps-approved instance types" is a **rule** (policy as code, Security plane machinery) that **applies to** the Resource plane, with cost **visibility** in Monitoring & Logging. Treat it as the `finops` concern on the offerings it affects. If it grows into its own offering (cost dashboards, showback per team), its home plane is Monitoring & Logging, because what it owns is the visibility.

## How this connects to the proposal process

- An accepted RFC that creates an offering adds a **component**. A sunset RFC archives one.
- On a proposal issue, the **component** means *the offering it affects*. Proposals as a group are marked with the `proposal` label, never a component.
- Offerings carry a **current maturity level**. Moving an offering up a level is the bet a proposal makes in its `maturity-aspect` and `level` fields.
- The Atlassian version of all this is in [atlassian-setup.md](atlassian-setup.md). The process itself is in [RFC-0000](../../rfcs/0000-proposal-process.md) and [the flow](../flow.md).

## Sources

- [CNCF TAG App Delivery: Platforms White Paper](https://tag-app-delivery.cncf.io/whitepapers/platforms/): the 13 platform capabilities and attributes of successful platforms
- [CNCF Platform Engineering Maturity Model](https://tag-app-delivery.cncf.io/whitepapers/platform-eng-maturity-model/): aspects and levels
- [PlatformEngineering.org: reference architectures](https://platformengineering.org/blog/create-your-own-platform-engineering-reference-architectures) and [The New Stack summary](https://thenewstack.io/build-your-idp-at-light-speed-with-a-platform-reference-architecture/): the five planes
