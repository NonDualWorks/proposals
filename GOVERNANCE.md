# Governance

How decisions get made in Nondual Works, and how a project with one active maintainer keeps that honest.

## Roles

| Role | Responsibility | Today |
|---|---|---|
| **Author** | Writes the proposal, answers review, keeps *Answered Questions* current | Anyone |
| **Decider** | Accepts, declines, or sends back after FCP. One per proposal, named in front matter. | Maintainer |
| **Reviewer** | Challenges the proposal on the PR. May vote *Block* with a reason. | Anyone, plus the personas below |
| **Pioneer** | The first real user in Alpha. Must be a person with the problem, not a hypothetical. | Named per proposal |
| **Maintainer** | Owns the process itself, triages Ideas, keeps `MAP.md` current | @PhanidharX |

The decider is never chosen by vote. Votes inform the decision; they do not make it.

## Decision rules

1. **Lazy consensus inside a fixed window.** If FCP closes with no unanswered *Block*, the decider may accept.
2. **Blocks need reasons.** A *Block* without a written reason on the PR is treated as a comment.
3. **The decider writes the decision down.** Every merged proposal ends with a *Decision* note: outcome, the main reasons, and what would change the decision.
4. **Declines are merged.** A declined proposal is part of the record. It stops the same idea from returning without new evidence.
5. **Process changes go through the process.** Edits to RFC-0000, this file, or the templates are Lite Proposals at minimum.

## Keeping a solo maintainer honest

When the author and the decider are the same person, these practices stand in for the missing second reviewer.

### Separate hats, separate days

Write as **Author**. Review as **Decider** on a different day, using the checklist in the PR template. Never open and approve a proposal in the same sitting.

### Real comment periods

| Tier | Minimum FCP |
|---|---|
| Lite Proposal | 48 hours |
| Full RFC | 72 hours |

The window starts when the FCP Discussion is posted, not when the PR is opened. Cooling off catches most of what a second reader would.

### Reviewer personas

Before FCP, every Full RFC gets a structured review from each of these fixed personas. Reviews may be written by the maintainer or produced with an AI assistant; either way they are posted as PR review comments prefixed with the persona name, and the author responds to each.

| Persona | Asks |
|---|---|
| **Skeptical SRE** | What breaks at 3 a.m.? What's the rollback? Who gets paged? |
| **First-time developer** | Could I use this from the docs alone? What's the first confusing step? |
| **Security reviewer** | What new trust does this create? What does it log, store, or expose? |
| **Release manager** | Does this make releases safer or just faster? What's the audit trail? |
| **Future maintainer** | In two years, will the *why* still be clear? What's hardest to change later? |

### A pioneer who isn't hypothetical

Alpha requires a named person who has the problem. For work-inspired features, that's the maintainer in their day job, using sanitized data. If no real pioneer exists, the proposal stays in Discovery.

### WIP limits

| | Limit |
|---|---|
| Full RFCs in Draft or FCP | 1 |
| Features in Alpha | 1 |
| Features in Beta | 2 |

A new proposal can't enter Draft while another sits in FCP. Process without limits becomes process theatre.

## Cadence

| When | What |
|---|---|
| Weekly | Triage Ideas; check FCP deadlines; move phases on the board |
| Monthly | Rank top-voted Ideas; pick the next Discovery |
| Quarterly | Rebuild `MAP.md`; publish a maturity heatmap from **Measured** reports; retro on the process itself |

## Building in public

Each phase change is a natural public update: a Discovery finding, an RFC opening for comment, a decision, an Alpha demo, a Measured report. Declined proposals are often the most useful to write about.

## Changing this document

Open a Lite Proposal. The maintainer is the decider for governance changes until there are other regular contributors, at which point this section is the first thing to revisit.
