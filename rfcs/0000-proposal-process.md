---
rfc: 0000
title: The Proposal Process
phase: accepted
author: "@PhanidharX"
decider: "@PhanidharX"
created: 2026-10-18
updated: 2026-10-18
discussion: ""
tracking: ""
plane: cross-cutting
pillar: [legible, answerable]
maturity-aspect: measurement
level: L1→L2
supersedes: ""
---

# RFC-0000: The Proposal Process

## Summary

Every meaningful capability in the Nondual Works suite is proposed in writing, discussed in the open, decided by a named person, built in phases with explicit exit gates, and closed only when its effect has been measured against a baseline taken before work began. This RFC defines that process, the three proposal tiers, the lifecycle, the tags every proposal carries, and the tools that hold each piece.

This RFC is accepted by its own author on creation, as the bootstrap exception. Every later change to the process goes through the process.

## Developer story

**Today**, an idea for the suite lives in a chat log, a notebook, or a head. It gets built because it was interesting that week. Six months later nobody can say why it exists, whether it helped, or what was considered and rejected.

**After this**, the idea is a Discussion with a problem statement and votes. If it's worth pursuing, it gets a Discovery Brief with numbers that describe the problem today. The proposal is a pull request you can comment on line by line. A named decider merges or declines it after a fixed comment window. The feature moves through Alpha, Beta and GA with checklists. When it's done, a short report says whether the numbers moved. All of it is searchable, linkable, and public.

## Motivation

The suite is built by a very small team, in public. Small teams skip process because it feels like overhead with no audience. That is exactly when it is most useful:

- **Reasoning decays faster than code.** The *why* behind a design is the first thing lost. Written proposals keep it.
- **Without a baseline, every feature "worked."** Measuring before building is the only honest way to know.
- **Cohesion is earned, not assumed.** Tagging every proposal by plane and thesis pillar shows where the suite is coherent and where it is a collection of interesting parts.
- **The rigour transfers.** The same process, mapped to Atlassian or any other stack, works for a platform team at work. This repo is the reference implementation.

## Guide-level explanation

### Three tiers

| Tier | When | Where | Review |
|---|---|---|---|
| **ADR** | An internal decision with no user-facing change, or a decision already made inside an accepted RFC | `docs/adr/NNNN-*.md` in the product repo | PR review, no FCP |
| **Lite Proposal** | Small, reversible, no migration, one page | `lite/NNNN-*.md` here | PR, 48h FCP |
| **Full RFC** | New capability, golden-path change, anything that forces migration, anything spanning repos | `rfcs/NNNN-*.md` here | PR, ≥72h FCP |

A Lite Proposal that grows past one page, or turns out to need a migration, is promoted to a Full RFC. That is normal, not a failure.

### Lifecycle

| Phase | What happens | Exit gate | Artifact |
|---|---|---|---|
| **Idea** | A Discussion in *Ideas* states the problem, who feels it, and evidence. People vote. | Triaged; owner named; tier chosen | Discussion |
| **Discovery** | Understand the problem before proposing a solution. Capture today's numbers. | Baseline recorded; pioneer user named; tags set | [Discovery Brief](../templates/discovery-brief.md) |
| **Draft** | The proposal is written and opened as a PR. Discussion happens on the PR. | Author marks it ready for FCP | [RFC](../templates/rfc.md) or [Lite](../templates/lite-proposal.md) |
| **FCP** | Final Comment Period. A poll in the PR's linked Discussion. No new scope. | Window elapsed; every *Block* answered | PR + poll |
| **Accepted / Declined / Withdrawn** | The decider merges the PR with the outcome in front matter. All outcomes are merged. | — | Merged PR |
| **Alpha** | Works end-to-end, non-production, for one pioneer user. Scrappy is fine. | Pioneer uses it without hand-holding | [Gate Checklist](../templates/gate-checklist.md) |
| **Beta** | Security review, docs, a few adopters, measurement wired up. | Security sign-off; docs in Tutorial + How-to; ≥2 adopters | Gate Checklist |
| **GA** | Default path. SLOs, support, deprecation plan for what it replaces. | SLOs met for 2 weeks; old path has a sunset date | Gate Checklist |
| **Measured** | Before/after report against the Discovery baseline. Decide: expand, iterate, or sunset. | Report merged | [Measured Report](../templates/measured-report.md) |
| **Sunset** | Removal, via a deprecation RFC with a migration path. | Last user migrated | RFC |

A proposal is not closed at GA. It is closed at **Measured**.

### Tags every proposal carries

**Plane** — where it lives in an Internal Developer Platform (after the PlatformEngineering.org reference architecture):

| Value | Plane |
|---|---|
| `developer-control` | Developer Control Plane — the interfaces developers configure and use |
| `integration-delivery` | Integration & Delivery Plane — build, store, configure, deploy |
| `resource` | Resource Plane — clusters, databases, storage, DNS |
| `monitoring-logging` | Monitoring & Logging Plane — metrics, logs, traces |
| `security` | Security Plane — secrets, policy, identity, supply chain |
| `cross-cutting` | Process, foundations, or schema shared by all planes |

**Pillar** — which part of the suite's thesis it serves. One or more:

| Value | Question it answers |
|---|---|
| `legible` | Can someone *see* the truth of delivery without asking? |
| `trustworthy` | Can they *rely* on what they see? |
| `answerable` | Can they *ask* it a question and get a grounded answer? |

A proposal that cannot name a pillar is a signal worth discussing, not an automatic rejection.

**Maturity** — which aspect of the CNCF Platform Engineering Maturity Model it moves, and between which levels:

| `maturity-aspect` | `investment` · `adoption` · `interfaces` · `operations` · `measurement` |
|---|---|

| Level | CNCF name | In our words |
|---|---|---|
| **L1** | Provisional | *Ticket Ops* — work arrives as requests; bespoke scripts; success means "done" |
| **L2** | Operational | *Paved Roads* — standard pipelines and templates; some self-service; outputs measured |
| **L3** | Scalable | *Platform as Product* — owned golden paths; adoption and DX measured; evidence-driven proposals |
| **L4** | Optimizing | *Outcome-Driven* — tied to delivery and DX outcomes; continuous discovery; data-led deprecation |

Written as `level: L1→L2`. Uneven profiles are expected; L4 everywhere is not the goal.

### Metrics by phase

| Phase | Typical measures |
|---|---|
| Discovery | Time-to-first-change, requests or tickets per month, manual steps in the workflow, toil inventory |
| Alpha / Beta | Pioneer task success, time-to-value, bypass rate (people going around the new path) |
| GA / Measured | Adoption among eligible users, DORA at the service level, DX survey or NPS |

Every Full RFC names **one leading** and **one lagging** metric, each with a baseline from its Discovery Brief.

## Reference-level explanation

### Numbering and files

- RFCs: `rfcs/NNNN-kebab-title.md`. Lite: `lite/NNNN-kebab-title.md`. Separate number sequences.
- The number is the PR number of the first draft, zero-padded to four digits. This avoids collisions without a registry.
- Discovery Briefs share the number of the proposal they lead to: `discovery/NNNN-kebab-title.md`. If a brief is written before a PR exists, use the Discussion number with a `d` prefix (`d0042`) and rename on PR.
- Measured Reports: `reports/NNNN-kebab-title.md`, same number as the RFC.

### Front matter

All proposals carry YAML front matter. The fields are listed in each template. `phase` is the single source of truth for status; the GitHub Project mirrors it, never the other way round.

Allowed `phase` values: `idea`, `discovery`, `draft`, `fcp`, `accepted`, `declined`, `withdrawn`, `alpha`, `beta`, `ga`, `measured`, `sunset`.

### Where each thing lives

| Concern | Tool |
|---|---|
| Ideas, votes, polls, FCP poll | GitHub **Discussions** (categories: *Ideas*, *FCP*, *Announcements*) |
| Proposal text and line-level review | **Pull request** in this repo |
| Lifecycle board | GitHub **Project** "Proposals", fields: Phase, Plane, Pillar, Maturity, Level, Decider |
| Implementation work | Issues and milestones in the product repo, each linking back to the RFC |
| Small decisions | ADRs in the product repo, `docs/adr/` |
| Published read layer | `README.md` and `MAP.md` here; later, a docs site |

### Discussion rules

- **One venue per stage.** Before Draft: the Discussion. From Draft on: the PR. The Discussion gets a pinned comment linking the PR and is locked for new top-level comments.
- **Votes are advisory.** The decider decides. A poll with many *Supports* does not override an unanswered *Block*.
- **A Block must come with a reason** on the PR. A Block without a reason is a comment.
- **An FCP with no comments is not consensus.** The decider must record who was asked.
- **Answered Questions are kept.** When an open question is resolved, it moves to *Answered Questions* with the answer and a link. The history of the design stays readable.

### Amending an accepted RFC

Small clarifications: a PR that edits the RFC and notes the change in a *Revisions* list at the end. Changes in scope or direction: a new RFC that `supersedes` the old one.

## Drawbacks

- **Overhead.** Writing a Discovery Brief before building is slower than building. That cost is the point, but it must stay proportionate; the Lite tier and ADRs exist so that most changes skip it.
- **Theatre risk.** A solo maintainer reviewing their own proposals can go through the motions. [GOVERNANCE.md](../GOVERNANCE.md) sets out the specific practices that guard against this.
- **Baselines can be fake-precise.** Early numbers will be rough. Rough and honest beats absent.

## Alternatives and prior art

- **No process; build and blog.** Fastest, and loses the reasoning. Rejected.
- **Issues only.** Issues are good for tracking, poor for long-form argument and line-level review.
- **[Concourse RFCs](https://github.com/concourse/rfcs)** — the writing style this process imitates most closely: first person, concrete examples before abstractions, a living *Answered Questions* section.
- **[Rust RFCs](https://github.com/rust-lang/rfcs)** — guide-level and reference-level split; FCP; explicit drawbacks and prior art.
- **[Kubernetes KEPs](https://github.com/kubernetes/enhancements)** — graduation criteria from Alpha to GA; production readiness review.
- **[Oxide RFDs](https://rfd.shared.oxide.computer/)** — states that give half-formed ideas a legitimate home.
- **Amazon PR/FAQ** — start from the user's experience; here, the *Developer story* section.
- **[ADRs (Nygard)](https://cognitect.com/blog/2011/11/15/documenting-architecture-decisions)** — small decisions, recorded close to the code.
- **CNCF Platform Engineering Maturity Model** and **PlatformEngineering.org** reference architecture and Minimum Viable Platform phases — the source of the tags and the lifecycle shape.

## Success metrics

| | Metric | Baseline | Target (2 quarters) |
|---|---|---|---|
| Leading | Share of accepted RFCs with a Discovery baseline before Draft | 0% (none exist) | 100% |
| Lagging | Share of accepted RFCs that reach **Measured** | 0% | ≥ 60% of those past GA |
| Health | Median days from Draft to decision | — | ≤ 14 |
| Health | Share of proposals originating from user evidence rather than maintainer ideas | — | rising quarter over quarter |

## Open questions

- Should the GitHub Project be rebuilt from front matter by a workflow, or kept by hand until there are enough proposals to justify automation?
- When outside contributors appear, does the decider role stay with the maintainer, or rotate per plane?

## Answered questions

- **Where do ADRs live?** In the product repo next to the code, not here. A proposal links to them; they don't need a central index until there are dozens.
- **Is the Discussion or the PR the place to argue?** The Discussion until Draft, the PR after. One venue per stage.

## Revisions

- 2026-10-18 — Initial version.
