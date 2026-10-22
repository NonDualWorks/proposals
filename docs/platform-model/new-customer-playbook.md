# New customer playbook

How to apply the platform model when you start with a new customer: an organization, a business unit, or a team you'll be running a platform for.

*Diátaxis type: How-to.*

## Before you start

You need: read access to their ticket history and repos, a few hours with two or three of their developers, and someone who can say yes to creating components and channels.

## 1. Inventory what they already ask for

Pull the last 90 days of requests to the platform or ops team, from tickets, chat and email. Group them by **what the requester needed**, not by who did the work.

Each group is an offering that already exists at Level 1, even if nobody has named it. Typical groups: new joiners' access, new services, integrations with other systems, new secrets, DNS records, cluster access, new environments, pipeline fixes, "why did my deploy fail".

Separate **journeys** (the job: a new integration) from **building blocks** (the steps: a secret, a firewall change). Requests that look simple usually belong to a journey.

## 2. Match the groups to the menu

Place each group into a slot on the [offerings menu](offerings-menu.md). Most fit; a few will be the customer's specialties, which sit inside a generic slot (fleet AMI patching inside Runtime).

Note what's **missing**. Gaps in the nearly universal set (Catalog, Docs, Golden Paths, CI, CD, Runtime, Observability, Secrets, Support) are usually where developers lose the most time.

## 3. Pick the first five to eight offerings

Choose the ones that pass [the component test](offerings-menu.md#is-it-a-component) and carry the most requests, starting from the [starter component set](offerings-menu.md#starter-component-set). Always include **Platform Support** as the catch-all.

Name each one using the [naming conventions](offerings-menu.md#naming-conventions): an outcome, not a tool.

## 4. Build the chain for each offering

For every chosen offering, using [offering-template.md](offering-template.md):

- [ ] Jira component, with lead and default assignee
- [ ] Its category channel (one per category to start)
- [ ] A section with the same name in its category's docs tree, with the Diátaxis skeleton
- [ ] Catalog entry: home plane, also touches, concerns, repos, current level
- [ ] First fix version, if it has a release cadence

Details in [atlassian-setup.md](atlassian-setup.md).

## 5. Route and measure

Point all new requests at the right component. After four to six weeks you have, per offering:

- requests per month,
- lead time per request,
- the manual steps behind each one.

That's the **Discovery baseline** for every improvement that follows.

## 6. Pick the first improvement

Rank offerings by noise and score the top few on **impact × effort** ([maturity-paths.md](maturity-paths.md#impact-versus-effort)). The noisiest L1 offering with a credible L2 is usually the best start, and it's typically a **Lite Proposal** (a standard request and one delivery mechanism), not a big RFC.

## 7. Introduce the proposal process

Run an **RFC-0000 adapted for the customer** through its own process, with their developers as reviewers. Share [the flow](../flow.md) (the interactive version with `#atlassian` for Atlassian shops) as the one-page explanation.

## 8. Publish the first calendar

From fix versions and release dates: recurring work (patching cycles), planned releases, and comment periods closing. This is usually the first thing the customer *sees* change, and it starts building trust in the platform as a product.

## What to avoid

- **Restructuring repos up front.** Map them to offerings; restructure only where an offering can't release on its own, and do it as an RFC.
- **Naming offerings after tools.** The customer's team will outlast the tool choice.
- **Too many components early.** Start with five to eight; split later when routing or releases demand it.
- **Skipping the baseline.** Without step 5, no later improvement can be shown to have worked.
