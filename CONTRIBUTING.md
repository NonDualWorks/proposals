# Contributing

Thanks for wanting to shape Nondual Works. This page covers the three things people usually want to do here.

## 1. Raise an idea

Start a Discussion in the **Ideas** category. The form asks for:

- **The problem**, in terms of what someone is trying to do and what gets in the way.
- **Who feels it.** A role, a team type, or yourself.
- **Evidence.** Anything concrete: a support thread, a number, a story, a screenshot.

Don't propose a solution yet. Ideas that start with a solution tend to get argued about as solutions, and the problem never gets examined.

Upvote ideas you also feel. Votes are a demand signal the maintainer looks at during weekly triage.

## 2. Write a proposal

Once an idea is triaged and a tier is chosen:

1. **Discovery first** (Full RFCs). Copy [`templates/discovery-brief.md`](templates/discovery-brief.md) to `discovery/`, fill in the baseline, and open a PR. It can merge before the RFC exists.
2. **Copy the right template.** [`templates/rfc.md`](templates/rfc.md) to `rfcs/0000-your-title.md`, or [`templates/lite-proposal.md`](templates/lite-proposal.md) to `lite/0000-your-title.md`.
3. **Open a PR** with `phase: draft`. Once the PR exists, rename the file to use the PR number.
4. **Respond to review on the PR.** When a question is settled, move it from *Open questions* to *Answered questions* with the answer.
5. **Ask for FCP** by commenting `/fcp` on the PR when you think it's ready. The maintainer opens the FCP Discussion with a poll and the window starts.

### Writing style

This repo follows the style of the Concourse RFCs.

- **Write in first person.** "I want to…", "We'd change…". Proposals are arguments made by people.
- **Show before you tell.** Put the command, the config, or the screen before the abstraction it illustrates.
- **Start from the user.** The *Developer story* section comes before the design for a reason.
- **Be honest about costs.** *Drawbacks* and *Developer cost* are where reviewers decide whether to trust the rest.
- **Keep the history.** Don't delete resolved questions; answer them.

## 3. Review a proposal

Comment on the PR, ideally on specific lines. In an FCP poll you can vote:

| Vote | Means |
|---|---|
| **Support** | I'd like this to go ahead as written. |
| **Support with concerns** | Go ahead; I've left concerns on the PR that should be addressed or acknowledged. |
| **Block** | This shouldn't go ahead as written. **Must** be accompanied by a reason on the PR. |

A Block without a reason is counted as a comment.

## Labels

| Label | Meaning |
|---|---|
| `tier:rfc` · `tier:lite` · `tier:adr` | Proposal tier |
| `phase:*` | Mirrors the `phase` field in front matter |
| `plane:*` | IDP plane |
| `pillar:*` | Thesis pillar |
| `needs:baseline` | Can't leave Discovery until numbers are recorded |
| `needs:pioneer` | Can't enter Alpha until a real user is named |

## Code of conduct

Be kind, be specific, argue with ideas rather than people. Disagreement is welcome and expected; it is how designs improve.
