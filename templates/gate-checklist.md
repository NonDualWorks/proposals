# Gate Checklist: RFC-0000 → <Alpha | Beta | GA>

<!--
Paste into the RFC's tracking issue (or a PR that updates the RFC's phase) when asking to move it.
The decider ticks or rejects each line. Unticked lines need a written reason to be waived.
-->

**RFC:** · **From phase:** · **To phase:** · **Requested by:** @ · **Date:**

## Entering Alpha

*Works end-to-end, non-production, for one real user. Scrappy is fine.*

- [ ] RFC is merged with `phase: accepted`
- [ ] Pioneer named in front matter is a real person with the problem
- [ ] End-to-end path works in a non-production environment
- [ ] Baseline measures from Discovery can be collected the same way again
- [ ] Known gaps (security, scale, edge cases) are listed in the tracking issue
- [ ] Rollback is possible, even if manual

## Entering Beta

*Ready for a few more adopters. Measurement is wired up.*

- [ ] Pioneer has used it without hand-holding at least once
- [ ] Pioneer feedback recorded in the tracking issue and answered
- [ ] Security review done (persona review at minimum; external for anything touching credentials or production)
- [ ] Docs: **Tutorial** and **How-to** published
- [ ] Leading metric is being collected automatically or on a fixed schedule
- [ ] At least 2 adopters lined up
- [ ] Failure modes from the RFC's *Operability* section are observable

## Entering GA

*The default path. Owned, supported, and replacing something.*

- [ ] At least 2 adopters using it for real work
- [ ] SLOs defined in the RFC have been met for 2 consecutive weeks
- [ ] Docs: **Reference** and **Explanation** published (all four Diátaxis quadrants)
- [ ] Bypass rate known (how many eligible users go around it)
- [ ] The path it replaces has a deprecation date and migration guide
- [ ] Owner and support channel named
- [ ] Measured Report scheduled (date written down)

## Decision

- [ ] Approved · [ ] Sent back · [ ] Waived lines with reasons:

**Decider:** @ · **Date:**
