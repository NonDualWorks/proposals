# Nondual Works — Proposals

Design proposals, decision records and measured outcomes for the Nondual Works suite.

> **Thesis:** make delivery truth **legible**, **trustworthy**, and **answerable**.

This repository is where features of the suite are argued for before they are built, and where they are held to account after they ship. It is run as if many people contribute, even when few do: every capability passes through the same phases, the same gates, and the same written reasoning.

## How it works in one picture

```
Idea ──▶ Discovery ──▶ Draft ──▶ FCP ──▶ Accepted ──▶ Alpha ──▶ Beta ──▶ GA ──▶ Measured
 │           │           │        │        │                                      │
 Discussion  Brief +     RFC PR   ≥72h     merged          gates per phase        before/after
 + votes     baseline    opened   window   by decider      (templates/gate-*)     vs. baseline
                                    │
                                    └──▶ Declined / Withdrawn (merged, with reasons)
```

**See it from each person's point of view:** [docs/flow.md](docs/flow.md), with an [interactive version](https://nondualworks.github.io/proposals/flow/) that switches between GitHub and Atlassian + Teams.

The full process is itself a proposal: **[RFC-0000: The Proposal Process](rfcs/0000-proposal-process.md)**.

## What lives where

| Path | What it is |
|---|---|
| [`rfcs/`](rfcs/) | Full RFCs, numbered. Accepted, declined and withdrawn RFCs all stay. |
| [`lite/`](lite/) | Lite Proposals: one-page changes that don't need the full ceremony. |
| [`discovery/`](discovery/) | Discovery Briefs: the problem and its baseline numbers, before a solution. |
| [`reports/`](reports/) | Measured Reports: what actually happened against the baseline. |
| [`templates/`](templates/) | The six templates. Copy, don't edit in place. |
| [`MAP.md`](MAP.md) | Every proposal on the plane × pillar grid, and the maturity heatmap. |
| [`GOVERNANCE.md`](GOVERNANCE.md) | Roles, decision rules, and how a solo maintainer keeps itself honest. |
| [`HANDOFF.md`](HANDOFF.md) | Current state and the next steps. Start here if you're picking up work. |
| [`CONTRIBUTING.md`](CONTRIBUTING.md) | How to raise an idea, write a proposal, and review one. |

Architecture Decision Records (ADRs) live next to the code they constrain, in each product repo under `docs/adr/`.

## Which tier do I need?

| If the change… | Use |
|---|---|
| Is an internal decision with no user-facing change | **ADR** in the product repo |
| Is small, reversible, and needs no migration | **Lite Proposal** |
| Adds a capability, changes a golden path, or forces anyone to migrate | **Full RFC** |

When in doubt, start a [Discussion](../../discussions/categories/ideas). Someone will tell you which tier fits.

## Status at a glance

The live board is the **Proposals** GitHub Project. Every proposal's front matter carries `phase`, `plane`, `pillar`, `maturity-aspect` and `level`, so the board and [`MAP.md`](MAP.md) can be rebuilt from the files alone.
