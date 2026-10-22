# Communication

Which chat channels exist, what they're called, who can join them, and how the team announces change.

*Diátaxis type: Reference, with how-to guidance. Examples use Microsoft Teams; the same rules apply to Slack or any chat tool.*

## Four kinds of channel

| Kind | Named after | Pattern | Example | Lifetime |
|---|---|---|---|---|
| **Offering** | What you offer | The offering or category name, no prefix | `IAM & Governance`, `Workload Secrets`, `UAT Environments` | Permanent |
| **Customer** | A specialist team you serve across several offerings | `Customer · <team>` | `Customer · Performance Engineering` | As long as the relationship |
| **Partner** | A business unit you collaborate with | `Partner · <BU>` | `Partner · Billing` | As long as the collaboration |
| **Project** | A time-bound piece of committed work | `Project · <Offering> – <outcome>` | `Project · Workload Secrets – Self-Service` | Until delivered, then archived |

Plus **Platform Support** (the catch-all) and **Platform Proposals** (the [proposal process](../flow.md)).

The prefixes group each kind together in the channel list and keep relationship and project channels apart from offering channels.

## Rules for offering channels

- **Start with one channel per category** (IAM & Governance, Runtime & Compute, Delivery, Developer Experience, Observability). Split an offering into its own channel when it carries most of the traffic or has a distinct audience.
- **A distinct audience gets its own channel from the start,** even at low volume: performance engineers using Performance Environments, DB engineers using Admin Workstations, business testers using UAT Environments. The test is *who asks*, not how often.
- **Name the channel after the offering, never the team that uses it.** Teams get reorganized and other users appear; `Performance Environments` stays correct where "Perf Team Support" doesn't. The audience is the reason for a separate channel; it doesn't decide the name.
- **In a shared category channel, start each post with the component name:** `[System Integrations] Payments → BU-Billing API`.
- **Pin** the docs link, a filter of the offering's open requests, and the release calendar.

Add a **customer channel** only when a specialist team regularly needs several offerings at once and wants one place for roadmap asks and cross-cutting issues. Offering channels answer *"help with this thing"*; customer channels answer *"how is our partnership going"*.

## People outside the team

Use **shared channels** for anyone who isn't a member of the platform team: partner BUs, business testers, specialist teams. In Microsoft Teams, a shared channel can include individuals, or a whole other team, without adding them to your team. Sharing with people in *another organization's* tenant also needs cross-tenant access (B2B direct connect) enabled by your admins.

## Notices

Four standard post types, used the same way in every channel:

| Notice | When | Must include |
|---|---|---|
| **Release** | When a release that affects the channel's audience is scheduled | What changes, the date, impact, action needed (if any), link to the release |
| **Maintenance window** | At least 5 business days ahead; a reminder 24 hours before; *started* and *complete* posts in the same thread | Start and end with time zone, affected systems, expected impact, rollback plan, contact |
| **Disruption** | Unplanned impact | What's affected, since when, workaround, time of next update |
| **Plan change** | A date moves or something is cancelled | What moved, the new date, why |

Rules:
- **One thread per event.** Updates are replies, so the history of a window or release stays together.
- **Use the tool's announcement style** for notices (Teams' Announcement post), so they stand out from conversation.
- **The calendar is the source of truth.** Notices come from releases and their dates (see [projects-and-releases.md](projects-and-releases.md#the-calendar)). Automate the release notice where the tool allows (Teams Workflows, Slack workflows); otherwise post from a template.
- **Decisions get copied out.** If someone agrees to a window or raises a blocker in a thread, record it on the work item.

## Partner channels

`Partner · <BU>` channels are **announcement-first**: partners mostly need to know what's changing and when. Use the four notice types; keep discussion in threads under them; pin the release calendar and the partner's contact list.

## Environments shared with outsiders: the UAT example

**UAT Environments** is an offering whose users are mostly outside the team (business testers, QA). It gets a shared channel named `UAT Environments`, and a clearly stated shared responsibility, pinned in the channel:

- **The platform team owns the environment:** availability, data refreshes, access, maintenance windows.
- **App teams own what's deployed there and their test data.**
- **Testers report app bugs to the app team and environment problems to the platform team.**

Add a fifth notice type for environments like this: **Deployment** (service, version, deployed at, release it belongs to), posted whenever the environment changes. Testers' most common question is *"what's in UAT right now?"*; a release-management tool's *Deployed* state for that environment can feed this notice automatically.
