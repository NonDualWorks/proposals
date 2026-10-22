# Concepts and tool mapping

The platform model is defined in tool-neutral terms. Jira, Linear and GitHub are ways to run it, not the model itself. This page defines each concept once, then shows how each tool expresses it.

*Diátaxis type: Reference.*

## Concepts

| Concept | Definition |
|---|---|
| **Offering** | Something customers ask for by name, with one owner, its own docs, and (usually) its own releases. The unit everything maps to. |
| **Category** | A slot from the [offerings menu](offerings-menu.md) that groups offerings, such as Runtime or IAM & Governance |
| **Kind** | What sort of offering it is: **journey**, **building block**, **product** or **support** (see [offerings-menu.md](offerings-menu.md#journeys-and-building-blocks)) |
| **Flavor** | A variant of one offering that customers choose between (trunk-based vs. feature-branch environments). Recorded on requests, not a separate component. |
| **Substrate** | The offering another offering runs on (Developer Environments run on EKS Clusters). Changes to the substrate are released there. |
| **Ring** | One stage of a change rolling through environments (dev → perf → prod), released and dated separately when customers need to know |
| **Plane** | Where the offering lives in the platform's architecture. One home plane, optionally others it touches. |
| **Concern** | Why the work exists: `security-compliance`, `governance`, `finops`, `reliability` |
| **Owner** | The one person accountable for an offering, and the default assignee for its requests |
| **Request** | A customer using an offering as it is: add a secret, onboard a joiner. Fulfilled and closed. **Never part of a release.** |
| **Change** | Work that changes how an offering behaves or is fulfilled for everyone |
| **Release** | A dated group of changes to one offering. Releases make the calendar. |
| **Journey link** | A journey request linked to the building-block requests it needs, so the backstory and the per-block noise are both kept |
| **Noise** | Request volume and lead time per offering over time. Picks the next improvement. |
| **Channel** | Where customers talk to the team. One per category to start, split per offering when volume justifies it. |
| **Docs tree** | Diátaxis docs per offering, grouped under its category |
| **Maturity level** | L1 Ticket Ops → L2 Paved Road → L3 Self-Service → L4 Outcome-Driven, per offering |
| **Project** | Time-bound committed work that changes one or more offerings, then is archived. Named after its primary offering and outcome. |
| **Launch** | The date a project's outcome becomes available; one calendar entry, usually several releases |
| **Notice** | A standard announcement: release, maintenance window, disruption, plan change (and deployment, for shared environments) |
| **Proposal** | An RFC, Lite Proposal or ADR, through the [proposal process](../flow.md). A proposal's offering is the one it affects. |

## How each tool expresses the concepts

| Concept | Jira | Linear | GitHub |
|---|---|---|---|
| Offering | **Component** | A label in an *Offering* label group (or a Team, for a large offering with its own workflow) | A label `offering:<slug>`, plus repo topics |
| Category | Component description, or name prefix (`Runtime · EKS Clusters`) | Parent label group, or a custom view | Label prefix or project field |
| Owner | Component lead + default assignee | Team triage owner, or a label-based auto-assign rule | Label-based auto-assignment; CODEOWNERS for the repos |
| Request | **Service Request** issue type, or label `request` | **Asks** (Slack, email or form) into the team's **Triage** | Issue form with label `request` |
| Change | Normal issue with a fix version | Issue in a project | Issue in a milestone |
| Release | **Fix version** with a release date (project-scoped, so prefix with the offering) | A **project** (or project milestone) per release, with a target date | A **milestone** with a due date, plus a GitHub **Release** for code |
| Calendar | Releases page and timeline | Projects timeline and roadmap | Projects roadmap view by milestone date |
| Journey link | Issue links | Sub-issues or related issues | Sub-issues |
| Project (outcome) | Epic, due date = launch | Project, target date = launch | Milestone or project, due date = launch |
| Noise | JQL filter + dashboard gadget by component | Insights by label | Issue search by label; Insights in Projects |
| Proposal intake and votes | Label `proposal`, Vote button | Triage, or Linear's customer requests | Discussions (Ideas) with upvotes |
| Phase of a proposal | `prop-*` label (workflow is often locked) | Project status, or a custom workflow state | Project field |
| Channel | Teams channel per category | Slack channel per category (Asks can be raised from it) | Discussions category, or a chat channel |
| Docs tree | Confluence page tree | Linear Docs, or an external docs site | Repo `docs/`, or a docs site |

## What's tool-specific and what isn't

The **concepts** are stable. These parts of the [Atlassian setup](atlassian-setup.md) are **Jira mechanics**, not the model:

| Jira mechanic | Generic concept it stands in for |
|---|---|
| Component | Offering |
| Fix version, prefixed with the offering name | Release |
| `prop-*` labels for phases | Proposal phase (needed only because the workflow is locked) |
| JQL swimlanes and quick filters | Views of the proposal phases and request noise |
| Service Request type or `request` label | Request versus change |

When the model is applied in another tool, map the concepts, not the Jira mechanics. Two examples of where other tools fit better:

- **Requests:** Linear's Asks, with Triage, is close to the request concept out of the box: intake from chat, email or a form, landing in one place for the owner to sort.
- **Releases:** Linear has no fix-version equivalent. A release maps to a project or milestone with a target date, which also gives you a release update and a timeline.

Sources: [Linear: Making the most of Linear](https://linear.app/docs/making-the-most-of-linear), [Linear Asks](https://linear.app/docs/linear-asks), [Linear customer requests](https://linear.app/docs/customer-requests.md).
