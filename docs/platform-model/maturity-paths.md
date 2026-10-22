# Maturity paths for offerings

How an offering moves from ad-hoc tickets to self-service, and how to choose which offering to improve next.

*Diátaxis type: Explanation, with one worked example.*

## Levels, in plain words

From the [CNCF Platform Engineering Maturity Model](https://tag-app-delivery.cncf.io/whitepapers/platform-eng-maturity-model/), applied to a single offering:

| Level | CNCF name | For one offering, it means |
|---|---|---|
| **L1** | Provisional | *Ticket Ops.* Done by hand on request; no standard, no owner, no docs |
| **L2** | Operational | *Paved Road.* A standard request and a standard way of delivering it; still done by the platform team |
| **L3** | Scalable | *Self-Service.* Customers do it themselves; the platform team owns the system, not each request |
| **L4** | Optimizing | *Outcome-Driven.* The need shrinks or disappears; measured against outcomes; customers contribute |

The main aspect that moves is usually **Interfaces** (tickets → self-service), with **Operations** alongside it. The team's overall level is the heatmap in [MAP.md](../../MAP.md); an offering's level is a field in its catalog entry.

## The general path

Every ad-hoc dependency on the platform team (secrets, DNS records, IAM roles, new environments, cluster access) can follow the same path:

```
Name it → route it → measure the noise → standardize → self-serve → design the need away
  L1        L1          baseline          L2 (Lite)     L3 (RFC)      L4 (RFC)
```

1. **Name it.** Create the component, channel and docs root, even at L1.
2. **Route it.** Send every related request to that component.
3. **Measure the noise.** Tickets per month, lead time per request, manual steps. This becomes the Discovery baseline.
4. **Standardize** with a Lite Proposal: a request form, a convention, one delivery mechanism. Reversible, no migration.
5. **Self-serve** with a Full RFC: customers act directly, with a pioneer team and gates.
6. **Design the need away** with a later RFC, once self-service is normal.

**Choosing what to improve next:** rank components by ticket volume. The noisiest L1 offering is usually the best next RFC.

## Worked example: Workload Secrets

**The situation today.** An application team introduces a new secret. The platform team creates it in the vault, writes glue to deliver it, and creates a Kubernetes secret for the workload, by hand, on request. The secret rarely comes alone: it's usually one step in a new integration (often with a firewall or security-group change and approvals) or a new service. Track it as a building-block request linked to that journey.

**The offering.** Start from the customer's job: *my app needs a credential at runtime, safely.*

| | |
|---|---|
| Offering / component | **Workload Secrets** |
| Category | IAM & Governance |
| Kind | Building block, usually requested as part of a System Integrations or Service Onboarding journey |
| Home plane | Security |
| Also touches | Resource (Kubernetes secrets), Integration & Delivery (deploy manifests) |
| Concerns | security-compliance |
| Channel | IAM & Governance (shared with the other journeys and building blocks in the category) |

**What each level looks like:**

| Level | Developer experience | What the platform team owns | Evidence |
|---|---|---|---|
| **L1** (today) | Files an ad-hoc ticket or sends a message, then waits | Every secret, by hand: create, glue, deliver | Tickets per month, days waiting, secret values passing through tickets or chat (a real risk) |
| **L2** | Fills in a standard request (app, environment, name, owner, rotation) | Still creates each secret, but delivery is standard: a naming convention such as `/<team>/<app>/<env>/<name>` and one sync mechanism into the cluster (e.g. External Secrets Operator). Glue retired. | Lead time down, glue scripts removed, zero secrets in chat |
| **L3** | Declares the need in their own repo and writes the value into their team's own vault path | The system: vault, per-team access policies, sync operator, conventions | Tickets near zero; need-to-available in minutes |
| **L4** | Often needs no secret at all: workload identity (e.g. EKS Pod Identity or IRSA) and short-lived dynamic credentials replace long-lived keys | Rotation, sprawl detection, a policy blocking plaintext secrets | Static secrets per service falling; rotation coverage; teams contributing policies |

At L4 the aim is to remove most secrets, not to deliver them faster.

**Getting started:**

1. Create the **Workload Secrets** component and lead. Route every secrets request there, linked to its journey issue where there is one. The noise becomes measurable on its own.
2. Write honest **L1 docs**: *How-to: request a secret* (today's process) and *Reference: naming convention* (the target). Documenting L1 truthfully makes the move to L2 visible.
3. **L2** as a Lite Proposal: request form, naming convention, one sync mechanism.
4. **L3** as a Full RFC with a pioneer team: self-service paths and per-team policies. Its Measured Report proves Interfaces L1 → L3.
5. **L4** as a later RFC: workload identity and dynamic credentials.

## Impact versus effort

A quick triage lens for which improvement to propose, kept coarse on purpose:

| | Effort S | Effort M / L |
|---|---|---|
| **Impact high** | Quick win: do next, often a Lite Proposal | Big bet: Full RFC with Discovery |
| **Impact low** | Filler: Lite or ADR when there's slack | Money pit: decline, and record why |

- Score at triage, **re-score at Discovery** with baseline numbers, and **compare at Measured** to calibrate future guesses.
- Impact: how many people feel it, how often, which maturity aspect it moves. Effort: include migration, docs and on-call cost, not just build time.
- It informs the decider; it doesn't replace them. Security fixes and enabling work often score badly and still matter. Overrides get a written reason.
