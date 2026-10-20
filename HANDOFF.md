# Handoff

Context and next steps for anyone (human or AI) picking up work in this repo. Read this first, then [RFC-0000](rfcs/0000-proposal-process.md) and [GOVERNANCE.md](GOVERNANCE.md).

*Last updated: 2026-10-19.*

## Why this repo exists

Nondual Works is a suite of developer tooling built in public by one maintainer ([@PhanidharX](https://github.com/PhanidharX)), run as if many people contribute. The thesis across every product: **make delivery truth legible, trustworthy, and answerable.** This repo is where features are proposed, decided, and later measured. Features won't all fit together neatly at first; the point is to lay foundations toward an Internal Developer Platform and to practise the rigour, which pays off wherever it's applied.

The same process maps onto an Atlassian stack at work (Bitbucket PRs for proposals, Jira labels and swimlanes for phases, Teams polls for FCP, Confluence as the published read layer). This repo is the public reference implementation.

## Where things stand

| | State |
|---|---|
| RFC-0000 process, governance, templates, labels | ✅ Merged on `main` |
| Repo visibility | ✅ Public |
| Discussions | ✅ Enabled. Categories: Announcements, General, **Ideas**, **Poll**, Q&A, Show and Tell |
| Ideas form (`.github/DISCUSSION_TEMPLATE/ideas.yml`) | ✅ Active (matches the `ideas` category slug) |
| FCP form (`.github/DISCUSSION_TEMPLATE/fcp.yml`) | ⚠️ Inactive. No `fcp` category exists, and GitHub doesn't support forms on Poll-format categories. Fixed by step 1 below. |
| "Proposals" GitHub Project | ⬜ Not created yet |
| Flow diagram (`docs/flow.md`, Mermaid) | ✅ Merged (PR #1) |
| Interactive flow page | ✅ Live at <https://nondualworks.github.io/proposals/flow/> (GitHub Pages from `main` `/docs`). `#atlassian` opens the work view. |
| First real proposal | ⬜ Not started |

## Conventions (quick reference)

Full definitions are in RFC-0000. These are the values the front matter and labels use.

| Field | Values |
|---|---|
| `phase` | `idea` `discovery` `draft` `fcp` `accepted` `declined` `withdrawn` `alpha` `beta` `ga` `measured` `sunset` |
| `plane` | `developer-control` `integration-delivery` `resource` `monitoring-logging` `security` `cross-cutting` |
| `pillar` | `legible` `trustworthy` `answerable` |
| `maturity-aspect` | `investment` `adoption` `interfaces` `operations` `measurement` |
| `level` | `L1` Ticket Ops → `L2` Paved Roads → `L3` Platform as Product → `L4` Outcome-Driven, written `L1→L2` |

- **Numbering:** the file number is the PR number of the first draft, four digits. RFCs and Lite Proposals have separate sequences.
- **Venues:** a Discussion until Draft, the PR from Draft onwards. One venue per stage.
- **ADRs** live in the product repo under `docs/adr/`, not here.
- **Commits:** imperative subject, prefixed with the proposal it belongs to when there is one (`RFC-0001: …`, `Lite-0002: …`).

## Next steps, in order

Each step is a real use of the process, so the process gets tested as it's used.

### 1. Lite Proposal: run FCP polls in a Poll-format category

The first thing the process meets is a flaw in itself: RFC-0000 assumes an FCP Discussion with a form *and* a poll, and GitHub can't do both in one category. Per GOVERNANCE.md, process changes go through the process, so this is the first Lite Proposal.

- **Problem:** `fcp.yml` can't attach to any category that also supports polls.
- **Likely change:** create an **FCP** category in **Poll** format; delete `fcp.yml`; move its fields (PR link, close date, decider, who was asked) into a short required header in the poll's body, documented in CONTRIBUTING.md; update RFC-0000's *Where each thing lives* table and add a *Revisions* entry.
- **Path:** copy `templates/lite-proposal.md` → `lite/0000-fcp-poll-category.md`, open a PR, rename to the PR number, wait the 48h FCP, merge with a *Decision* note.
- **Why start here:** it's small, it exercises the whole Lite path end to end, and a process that fixes itself in public is a good first post.

### 2. Create the Proposals Project

GitHub → NonDualWorks → Projects → New, board layout, linked to this repo. Single-select fields:

| Field | Options |
|---|---|
| Phase | the 12 `phase` values |
| Plane | the 6 `plane` values |
| Pillar | the 3 `pillar` values |
| Maturity | the 5 `maturity-aspect` values |
| Level | `L1→L2`, `L2→L3`, `L3→L4` |
| Decider | text |

Group by Phase. Front matter stays the source of truth; the board mirrors it.

### 3. Discovery Brief for Release Desk (the first real feature)

The worked example is the release-management tool designed in earlier sessions (working names: Release Desk / Tower; naming is still open). It earns the first RFC because it spans several planes, has real baselines available, and already has settled decisions and open questions.

- Open an **Ideas** Discussion first: the problem, who feels it (a release manager promoting between environments), and evidence.
- Then `discovery/d<discussion#>-environment-promotion.md` from the template. Baselines to capture (sanitized, from the day job, where the pioneer is the maintainer):
  - time from "decide to promote" to pipeline submit
  - share of promotions needing manual YAML edits
  - wrong-version or stale-promotion incidents per quarter
  - test minutes per deploy (for the test-selection win)
- Tags: `plane: [developer-control, integration-delivery]`, `pillar: [legible, trustworthy]`, `maturity-aspect: interfaces`, `current-level: L1`.

### 4. RFC-0001: Environment promotion with preview

Write it from `templates/rfc.md`. The design context below is what's already settled; it goes in *Answered questions* and *Reference-level explanation*. Each settled decision becomes an **ADR in the product repo** once that repo exists (at Alpha), linked from the RFC's `adrs:` field.

Run the five persona reviews (see GOVERNANCE.md) before asking for FCP, then take it through a real 72-hour FCP.

### 5. A second, deliberately small example

`helm_overrides` re-deploy mode as a Lite Proposal, once RFC-0001 is accepted. It shows that not everything needs the full ceremony.

### Queued process refinements

Raised while explaining the process; not yet proposed. Each is a Lite Proposal under the governance rules. Batch them into one *process refinements from first use* Lite if they're small enough.

- **Maturity impact table.** Keep `maturity-aspect` and `level` as the one aspect a proposal bets on and will measure, but add a table to the RFC's *Maturity* section rating all five aspects as *neutral*, *supports*, *moves* or *regresses*. The *regresses* rows surface costs (for example, a new tool adding on-call load is an Operations regression). The Measured Report then checks the primary claim and whether any regression was worse than expected. Touches `templates/rfc.md`, `templates/measured-report.md` and RFC-0000's tag section.
- **Who runs triage.** `docs/flow.md` shows the Decider running weekly triage, which is true only because the maintainer is also the decider today. Decide whether triage belongs to the maintainer or the decider as a rule.

### Work adaptation notes

For when this process is proposed at work (Atlassian + Teams; Jira workflows are locked enterprise-wide). The venue mapping is in [`docs/flow.md`](docs/flow.md).

- **Teams** for conversation and the comment-period poll (built-in Polls). Copy the tally into the PR's *Decision* section; chat threads are hard to find later. Bitbucket → Teams notifications go through the Teams Workflows app, if the tenant allows it.
- **Confluence** for Discovery Briefs (co-editing and inline comments suit non-engineers) and as the generated read layer. A Page Properties table on each proposal page plus a Page Properties Report on the parent gives a live index. Never let a document be edited in both Bitbucket and Confluence: the pandoc publish would overwrite Confluence edits.
- **Keep the proposal itself in a Bitbucket PR.** Confluence has no equivalent of line-level review, a merge decision, or "every Block answered before merge", and no built-in polls.
- **Jira** Vote button for idea demand; phase as labels with JQL swimlanes. Jira Product Discovery fits ideas and voting better if the org licenses it.

### After that

Monthly: rank top-voted Ideas, pick the next Discovery. Quarterly: rebuild MAP.md and retro the process. Candidates already in the suite's backlog include the software catalog (naadi), conforge, and docspine; each should arrive as an Idea, not jump straight to an RFC.

## Release Desk: design context so far

From earlier design sessions. Treat this as input to the Discovery Brief and RFC-0001, not as a spec.

**The job.** A release manager picks a **source** environment (e.g. staging) and a **destination** (e.g. production), sees a typed **preview** of what would change, selects what to take, and **submits** the destination's desired state to an existing deploy pipeline (Concourse or Jenkins) through an adapter. Episode 1 ends at submit. Approvals and governance (including infra cases like monthly AMI patching across many clusters) come later.

**Industry framing.** Sync-centric tools (Argo CD, Flux) organise around apps; promotion-centric tools (Kargo's Freight and Stages, GitOps Promoter) around moving artifacts; release orchestration (Harness) around phases and approvals; Octopus around an environment grid. The chosen approach is **Terraform-plan-like**: compute a typed Preview against a destination fingerprint, diff the parsed model rather than raw YAML, and reject a stale submission if the destination changed after preview.

**Data shape (sanitized).** Per environment: a flat `services` list (`name`, `uri`, `version`, `helm_chart_version`) and a `test_suites` list of the same shape. A separate `helm_overrides` file (replicas etc.) goes straight to the deploy job and is not part of the promotion diff. A separate test mapping file maps service → test suite names.

**Settled decisions** (candidate ADRs):

1. **The manifest is always the full state.** The desired manifest after applying a selection contains every service and suite, never a partial. Any file stands alone as ground truth and supports hotfix prep from a known-good source.
2. **Three states per environment.** *Desired* (written on submit), *Deployed* (written by the pipeline only after deploy and tests succeed, and the source for future promotions, which avoids promoting from an environment mid-rollout), and *Observed* (from a future drift watcher, out of scope).
3. **One file contract for every deploy mode.** `diff`, `selected` and `all` all produce `manifest` (complete), `deploy` (services to roll out) and `testSuites` (distinct, with versions). The pipeline reads only `deploy` and `testSuites` and never branches on mode; in `all` mode the CLI fills `deploy` with every service.
4. **Test selection rules.** An unmapped changed service runs all suites (which rewards keeping the mapping current). Removed services' suites are skipped. Mapping is direct only, not transitive. A changed test suite always runs.

Also settled: *Evidence* is one security-scan record per service with links, distinct from test suites. The UX direction is a hybrid: an environment matrix as home, lanes for the promotion view, and triage cards only for risky changes.

**Open questions** (keep in the RFC):

- Whether a `deployed-unverified` status is needed when tests fail after a successful deploy. Depends on whether the pipeline auto-rolls-back.
- Product naming.
- Which version formats can be reliably ordered, so downgrades can be flagged.

**Architecture intent.** Diff and business logic first, as a module (CLI or API), released incrementally; UI layered on later. Built on the suite's foundations so it can later use the open-source catalog without hacks. Published with generic nomenclature.

## A working loop for local sessions

1. `git pull`. Read this file's *Where things stand* and the open PRs.
2. Pick the single next step above. Respect the WIP limits in GOVERNANCE.md.
3. Branch as `lite/<slug>`, `rfc/<slug>`, `discovery/<slug>` or `report/<slug>`.
4. Write as **Author**. Open the PR early; drafts are fine.
5. On a different day, review as **Decider** with the PR template checklist.
6. When a phase changes: update front matter, labels, the Project card, MAP.md, and *Where things stand* here.
7. Post the phase change publicly if it's worth a sentence (Discovery finding, RFC opened, decision, Alpha demo, Measured report).

### Prompt for AI persona reviews

> You are reviewing an RFC for an open-source developer-tooling project as the **{persona}** described in GOVERNANCE.md. Read the RFC in full. Leave no more than five comments, each tied to a specific section, each phrased as a question the author must answer. Prioritise what would cause real harm or confusion over style. End with one line: *Support*, *Support with concerns*, or *Block* (with the reason).

Post each review as a PR review comment prefixed with the persona name, and answer every one before FCP.
