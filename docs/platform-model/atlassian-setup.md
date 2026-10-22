# Atlassian and Teams setup

How to run the platform model and the proposal process on Jira, Bitbucket, Confluence, Microsoft Teams and Mural, inside **one team project** (called `DEVOPS` here), where you can't create new Jira projects or Confluence spaces and Jira workflows are locked enterprise-wide.

*Diátaxis type: How-to.*

## The one-to-one chain

| Offering is… | In |
|---|---|
| A **component** (lead = owner and default assignee) | Jira |
| A series of **fix versions** with release dates, which make the calendar | Jira |
| A **channel**, named exactly like the component | Teams |
| A **page tree** in Diátaxis form, named exactly like the component | Confluence |
| One or more **repos**, mapped in the catalog | Bitbucket |

## 1. Jira: offerings

### Components

Create one component per offering (see [the component test](offerings-menu.md#is-it-a-component)). For each:

- **Component lead:** the offering owner. Set **default assignee** to the component lead, so issues route themselves.
- **Description:** category, home plane, concerns, Teams channel link, docs link. Jira then carries a light version of the catalog.

### Fix versions and the calendar

- Fix versions belong to the **project**, not to a component, so prefix every version with the component name: `EKS Clusters 2026.11 – node AMI patch`, `Workload Secrets 2026.11`.
- Tag each issue with both its **component** and its **fix version**.
- Set a **release date** on every version. The Releases page and timeline views then become the published calendar.
- **Cadenced work** (monthly patching): create the quarter's versions at quarterly planning, or use a scheduled Jira Automation rule to create next month's version, if your admins allow automation.

### Delivery board

Keep proposals off the board your team plans sprints from:

```sql
project = DEVOPS AND (labels IS EMPTY OR labels NOT IN (proposal)) ORDER BY Rank ASC
```

The `labels IS EMPTY` clause matters: `labels NOT IN (…)` alone silently drops every issue with no labels.

## 2. Jira: proposals

Proposals use the **`proposal` label** as the umbrella. On a proposal issue, the **component** is the offering it affects. A new offering is a Full RFC that adds a component; retiring one is a sunset RFC that archives it.

Voting must be available (look for the **Vote** button on an issue).

### Labels

Jira labels are site-wide, so everything except the umbrella has a `prop-` prefix.

| Purpose | Labels |
|---|---|
| Umbrella | `proposal` |
| Phase (exactly one) | `prop-idea` `prop-discovery` `prop-draft` `prop-fcp` `prop-accepted` `prop-declined` `prop-withdrawn` `prop-alpha` `prop-beta` `prop-ga` `prop-measured` `prop-sunset` |
| Tier | `prop-tier-rfc` `prop-tier-lite` |
| Plane | `prop-plane-devctl` `prop-plane-delivery` `prop-plane-resource` `prop-plane-monitoring` `prop-plane-security` `prop-plane-cross` |
| Maturity aspect | `prop-aspect-investment` `prop-aspect-adoption` `prop-aspect-interfaces` `prop-aspect-operations` `prop-aspect-measurement` |
| Impact / effort | `prop-impact-high` `prop-impact-med` `prop-impact-low` · `prop-effort-s` `prop-effort-m` `prop-effort-l` |
| Blockers | `prop-needs-baseline` `prop-needs-pioneer` |

### Field conventions

| Field | Means |
|---|---|
| Status | To Do = waiting · In Progress = being worked · In Review = comment period or awaiting a gate · Done = closed (measured, declined, withdrawn, sunset). The phase is in the label, so the locked workflow doesn't matter. |
| Component | The offering the proposal affects |
| Assignee | Whoever acts next |
| Due date | The current phase's deadline |
| Summary | `[Idea] …`, renamed `[RFC-0012] …` once the Bitbucket PR exists |
| Branch | `rfc/DEVOPS-1234-slug`, so the PR appears on the issue |
| Delivery | When accepted, create a delivery epic and link it to the proposal issue. The epic goes into sprints; the proposal issue never does. |

### Proposals board

Save the filter **Proposals – all**, shared with your team:

```sql
project = DEVOPS AND labels = proposal ORDER BY Rank ASC
```

**Create board → Kanban → from existing saved filter.** Map columns to your statuses. Card layout: Labels, Votes, Due date.

**Swimlanes → Queries** (first match wins):

| Lane | JQL |
|---|---|
| Comment period | `labels = prop-fcp` |
| Draft | `labels = prop-draft` |
| Discovery | `labels = prop-discovery` |
| Ideas | `labels = prop-idea` |
| Accepted | `labels = prop-accepted` |
| Delivering | `labels in (prop-alpha, prop-beta, prop-ga)` |
| Measured | `labels = prop-measured` |
| Closed | `labels in (prop-declined, prop-withdrawn, prop-sunset)` |

**Quick filters:**

| Filter | JQL |
|---|---|
| Waiting on me | `assignee = currentUser()` |
| Untriaged | `labels = prop-idea AND assignee is EMPTY` |
| Popular | `labels = prop-idea AND votes >= 3` |
| Quick wins | `labels = prop-impact-high AND labels = prop-effort-s` |
| Due in 2 days | `duedate <= 2d AND statusCategory != Done` |
| Overdue | `duedate < now() AND statusCategory != Done` |
| Full RFCs | `labels = prop-tier-rfc` |
| Blocked | `labels in (prop-needs-baseline, prop-needs-pioneer)` |

### Saved filters for the rhythm

```sql
-- Weekly triage
project = DEVOPS AND labels = prop-idea ORDER BY votes DESC, created ASC

-- Open comment periods
project = DEVOPS AND labels = prop-fcp ORDER BY duedate ASC

-- Shipped, never measured
project = DEVOPS AND labels = prop-ga AND updated <= -30d

-- Measured this quarter
project = DEVOPS AND labels = prop-measured AND updated >= startOfQuarter()

-- Ideas from outside the platform team (Adoption evidence)
project = DEVOPS AND labels = proposal AND reporter not in membersOf("platform-team")

-- Accepted but no delivery epic linked
project = DEVOPS AND labels = prop-accepted AND issueLinkType is EMPTY

-- All proposals touching one offering
project = DEVOPS AND labels = proposal AND component = "Workload Secrets"

-- Noise per offering, to pick the next improvement (group by component in a dashboard gadget)
project = DEVOPS AND (labels IS EMPTY OR labels NOT IN (proposal)) AND created >= -90d
```

Replace `platform-team` with your Jira group's name.

### Raising an idea

Pin a **pre-filled create link** in the Teams channel: project DEVOPS, your issue type, label `prop-idea` plus `proposal`, and a description skeleton (*Problem / Who feels it / Evidence*). Test that it works on your site.

### Jira Product Discovery

If it's provisioned (the Free plan covers 3 creators; anyone with Jira access contributes), it handles the Idea and Shape phases better: ideas, votes, custom fields for plane and aspect, and an impact-versus-effort matrix. It doesn't replace the proposal PR, the comment-period poll or the decision. Adopting it is a good first Lite Proposal.

## 3. Bitbucket

- A **`proposals` repo**: RFCs, Lite Proposals, Discovery Briefs (if not in Confluence), Measured Reports, templates, PR template.
- **Branch permissions:** only deciders merge.
- **Pipelines:** on merge, pandoc publishes changed proposals to Confluence under *Published proposals*.
- **Metrics:** Bitbucket gives lead time and PR throughput per repo. Roll them up per offering using the repo → offering mapping in the catalog.
- **ADRs:** `docs/adr/` in each product repo.

## 4. Microsoft Teams

One Teams team for the platform, customer-facing:

| Channel | Purpose |
|---|---|
| **One per offering**, named exactly as the component | Support and discussion for that offering. Pin the docs link and a Jira filter for its open issues. |
| **Platform Support** | Anything that doesn't fit an offering yet; triage moves it on |
| **Platform Proposals** | One post per idea; the comment-period **poll** goes in that post's thread |

Rules:
- **One venue per stage.** Talk in the idea's thread until there's a PR, then only on the PR.
- **Copy outcomes into the record.** Poll tallies and decisions go into the PR's *Decision* section; chat is hard to find later.
- **Polls:** Support / Support with concerns / Block, not anonymous, close date in the question. A Block needs a reason on the PR.
- **Notifications:** Bitbucket and Jira events can post into channels through the Teams **Workflows** app, if your tenant allows it.
- Add the **Proposals board** as a channel tab (Jira Cloud app for Teams).

## 5. Confluence

In your team's existing space:

```
Platform
├── Offerings catalog              ← Page Properties Report over every offering page
├── EKS Clusters                   ← one tree per offering, named exactly as the component
│   ├── Tutorials
│   ├── How-to guides
│   ├── Reference
│   └── Explanation
├── Workload Secrets
│   └── …
└── Platform Proposals
    ├── How we propose             ← links the flow (#atlassian) and this setup
    ├── Discovery briefs           ← edited here, from a template
    └── Published proposals        ← generated by pandoc; "discuss on the PR" banner
```

- **Every offering root page** carries a Page Properties table with the [catalog fields](offerings-menu.md#catalog-fields). The *Offerings catalog* page's Page Properties Report turns them into a live index.
- **Same skeleton for every offering.** Consistent Diátaxis structure and the same properties table are what make the docs reliable to feed to an AI assistant (for example, first-line answers in each offering's channel). The *current maturity level* field tells it whether to point people to self-service or to the request form.
- **Never edit a document in both places.** Pages generated from Bitbucket are read-only in practice; editing them in Confluence means the next publish overwrites the change.

## 6. Mural

A reusable template for the monthly ranking: place the top-voted ideas on an **impact × effort** 2×2, then dot-vote within the quadrants.

## 7. Cadence

| When | What | Uses |
|---|---|---|
| Weekly, 30 min | Triage ideas, check comment-period deadlines, move phases | Weekly triage and open comment-period filters |
| Monthly | Rank top ideas, pick the next Discovery | Mural 2×2, popular and quick-win filters |
| Quarterly | Maturity review, calendar for next quarter, process retro | Measured-this-quarter filter, noise per offering, fix versions |

## 8. Bootstrap

1. Create the components for the offerings you run today (including L1 ones such as Workload Secrets), with leads, channels and Confluence roots.
2. Set up the proposals labels, board and filters.
3. Take an **RFC-0000 adapted for work** through the process with the team: same flow, real reviewers instead of personas, named deciders. The team agrees to the process by using it.
4. Check the dry run: the RFC appears on the Proposals board and **not** on the delivery board.
