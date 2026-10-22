# Projects and releases

How time-bound projects fit the offering model, how a project that spans several offerings is released and shown on the calendar, and how code maps to offerings.

*Diátaxis type: Explanation, with how-to guidance.*

## A project borrows from an offering and gives back

A **project** is a time-bound piece of committed work, usually the delivery (Alpha → GA) of an accepted [proposal](../flow.md). It exists to change one or more offerings, and it disappears into them when it's done:

```
Proposal accepted → Project opens → releases land in offerings → docs harvested → project archived → Measured (in the offering)
```

## Naming

`Project · <Offering> – <outcome>`, with the **primary offering** (where the outcome lands) first:

- `Project · Workload Secrets – Self-Service`
- `Project · EKS Clusters – 1.32 Upgrade`
- `Project · Docs Sites – Auto-Publish`

Use the same name for the chat channel, the landing page and the delivery epic. Leave dates and ticket keys out of the name (dates slip, and keys mean nothing to partners); put the proposal number, epic and target date in the channel description and pinned post.

## The landing page

Under **Projects → In flight**, one page per project with a fixed shape, so nobody needs a status meeting:

1. **Goal:** one paragraph; links to the proposal, the epic, the channel and the calendar.
2. **Status:** a dated update on a fixed day (for example every Friday):
   - Overall: on track / at risk / off track
   - Done since last update
   - Next
   - Risks and blockers
   - **Decisions needed, and from whom**
3. **Decision log:** short entries, each linking to an ADR when one is written.
4. **Working notes:** runbooks, configs and open items as they emerge.

Post a one-line link to each status update in the project channel, so the page stays the record and the channel stays the nudge.

## Closing a project: harvest, then archive

| From the project | Goes to |
|---|---|
| Runbooks written along the way | The offering's **How-to** guides |
| Settings, limits, conventions | The offering's **Reference** |
| Why it was built this way | The offering's **Explanation**, linking the proposal |
| Decisions | **ADRs** next to the code |
| Open items | Work items on the **offering's component** |
| Status updates | Stay with the archived page |

1. **At GA,** the harvest is part of the GA gate: the offering's docs cover all four Diátaxis quadrants, and the project page links to them.
2. **Two to four weeks after GA,** once things settle: move the page to **Projects → Archive**, mark it archived at the top, and archive the chat channel. Both stay searchable.
3. **The Measured report** comes 30–90 days after GA and happens in the **offering's** channel, because the project no longer exists.

## Projects that span several offerings

Most projects touch more than one offering. Two groupings, each with one job:

| | Groups work by | Answers | Seen by |
|---|---|---|---|
| **Epic** (one per project) | **Outcome**: what customers can do afterwards, in their words | "Is the project done?" | The team and stakeholders |
| **Releases** (one per affected offering) | **Offering** | "What changed in this offering, and when?" | Owners, maintainers, each offering's changelog |

**Epics group by outcome; releases group by offering.** A single release shared across offerings is possible in Jira (versions are project-wide), but it leaves each offering's history incomplete.

Offerings changed only internally (nothing customer-visible) get no release; their work items sit in the epic.

## The calendar

The calendar has two layers:

1. **Launches:** one entry per project, on the date the outcome becomes available (the epic's target date).
2. **Releases that affect someone on their own:** they cause disruption or need customers to act. Everything else is folded into the launch entry.

Plus recurring releases with their own audience, such as monthly patch rings.

### Worked example: self-service workload secrets

Outcome: *developers create workload secrets themselves, without a ticket.*

| Date | Calendar entry | Releases that day | Why it's on the calendar |
|---|---|---|---|
| Nov 26 | *EKS Clusters: secrets operator installed* | `EKS Clusters 2026.12 – secrets operator` | Changes every cluster, and self-service depends on it. Cluster users get a maintenance notice. |
| Dec 3 | **Launch: self-service workload secrets** | `Workload Secrets 2.0`, `Service Onboarding 1.4` | The outcome. Both ship together; the launch notice lists them. |

- **Releases ship together on launch day** unless a **dependency forces an order**. Neither Workload Secrets 2.0 nor Service Onboarding 1.4 is useful alone, so they share a date; the operator must exist first, so it goes a week earlier.
- **Separate releases on the same date** keep each offering's history accurate: the Service Onboarding changelog reads *"1.4: new services get a secrets path automatically (part of the self-service secrets launch)"*.
- **In Jira:** the epic's due date is the launch (epics on the timeline give the launch layer); fix versions with release dates give the release layer; each version's description names the outcome it belongs to.

## Code and repos

Map code to offerings before moving any of it. These rules work for a monorepo or many repos:

1. **Every piece of code has exactly one owning offering,** even if others use it. Many paths or repos to one offering is fine; code owned by several offerings is the smell to watch.
2. **In a monorepo, map directories to offerings** with CODEOWNERS (`/workload-secrets/ @secrets-owner`). With many repos, prefix repo names with the offering slug (`workload-secrets-policies`).
3. **Group by category:** top-level directories, Bitbucket projects, or GitHub topics.
4. **Add machine-readable metadata,** such as a `catalog-info.yaml` per offering directory or repo with `offering: workload-secrets`, in the style of Backstage. It makes the map readable by a catalog later.
5. **Tag releases per offering** (`workload-secrets/v2.0`), so each offering releases independently even from one repo.
6. **Shared code has one owner and is consumed by version.** Pipeline templates belong to CI Pipelines; others consume a released version rather than copying.
7. **An offering must be able to release without coordinating another offering's code.** When that fails, you have the evidence for a restructuring proposal, and only then.
8. **Put the work item key in branch names and commits,** so code links back to the component and epic automatically.

Rules 1–5 cost little and give you the code-to-offering map; per-offering delivery metrics (lead time, PR throughput) then roll up automatically. Rules 6–7 matter once a release is actually blocked.
