Frequently asked questions
==========================

### That makes many documents? Is this overkill, bureaucracy?

Maintaining consistency across several documents is real work -- but significantly less than the alternative, and the cost drops sharply with AI assistance. An AI can check consistency between stages, propagate a change from an upstream document into downstream ones, and flag drift. The human reviewer then only needs to validate concise upstream documents and verify that downstream propagation is correct.

Without this structure, the equivalent effort goes into untangling confusion, reworking feature drift, and answering questions that a clear upstream document would have prevented. The structure does not eliminate work; it redirects effort from reactive firefighting to proactive review of short, focused documents.

In practice, the first documents are very short. Each stage is not much longer than the previous. From one stage to the next the gap is manageable.

### Who reads all those documents?

Different persons or the same person, both are fine.

The telescopic structure guarantees that having things clear at any upstream stage ensures consistency with downstream stages.

### Where to put all this?

If at all possible (and obviously for simple projects) everything will live in the same repository as the code. Rationale: they evolve with it. Same repo is a simple solution.

A suggested layout:

``` default
README.md
doc/
  10_capability_specification/
  20_functional_specification/
  30_architecture/
  40_implementation/
src/
```

The numeric prefixes enforce sort order in directory listings so the chain reads top-to-bottom. The gaps (10, 20, 30, 40) leave room for inserting a stage without renumbering. Each stage is a directory (not a file) from the start, so companion artifacts (acceptance tests, decision records) have a natural home without renaming.

README.md lives at the repository root (stage 0, implicitly) since that is where repository visitors expect it. Code lives outside `doc/` in its own tree.

Each directory contains at least a main document. The naming convention for the main document is a project-level decision (e.g. always `spec.md`, or matching the directory name).

Notice that if the functional specification is not in the same repository as the code, then the acceptance tests are stored with the functional specification, not with the code. In other words, position in the chain, not file style or tools, determines what is stored with what.

### What about cross-cutting concerns?

Example: security model, operational runbook.

They should be handled at the appropriate stages.

Take security for example:

- README.md: one sentence about the security stance, threat model and how it's handled

- capability specification: details the security approach, the *what* not the *how*

- functional specification: details the specifics about security, including acceptance tests like "check that port 443 responds with a valid certificate", "check that feeding a valid signed certificate for another domain yields the server rejecting the connection"

- etc, apply the rules of each stage to this specific aspect

For example, at each stage have a subsection about each relevant concern. This only adds volume when the project actually has that concern -- a project with no security requirements gets no security subsections.

When a cross-cutting concern grows large enough that its subsections dominate the stage documents, project staff may decide to give it its own parallel document chain at the relevant stages (e.g. a dedicated security capability specification, security functional specification, etc.). This is a project-level decision, not a rule of this system.

Decision records are historical artifacts whose goal is to record what was evaluated, the reasons, and the decision, for future reference. They are to be done at whatever stage is relevant for the topic. There may be decision records at the capability specification stage, at the functional specification stage, at the architecture stage, at the implementation stage. They live in a `decisions/` directory co-located with the stage they affect.

Changelogs are a different beast, they document product history, they are off this track.

### What happens when documents get out of sync?

Documents will drift. The question is not whether, but how to recover.

When a human changed an upstream document, that change is most likely correct and downstream documents should be updated to match. But surprises do happen in the other direction: a bug, a failing test, or an unexpected behavior sometimes reveals a gap or an error in an upstream document that was never noticed. In those cases the upstream document needs correction, not the code.

There is no universal rule for which direction wins -- it must be judged each time based on the evidence.

In practice, the AI is periodically asked to check consistency across all stages, report discrepancies or gaps, and produce a summary for a human reviewer who decides what to fix and where. The telescopic structure makes this tractable: because each stage is short and focused, inconsistencies stand out. The overall effect is that things naturally tend toward order rather than drifting apart.

### Can stages be skipped or merged for small projects?

Yes. The full five-stage chain is the general case, not a minimum requirement. Two approaches:

**Start full, leave stages empty.** Create all stages from the start. Some will be a single sentence ("No architecture decisions beyond what the functional spec implies."). This is lightweight and preserves the structure for when the project grows. The empty stage is a conscious acknowledgment that there is nothing to say at that altitude, not a gap.

**Start minimal, split when needed.** Begin with just README + one specification document + code. As the project grows, split the single spec into capability and functional when it starts serving two distinct purposes, then split further when architecture decisions become non-trivial. The trigger for splitting: a single document starts addressing two clearly different audiences or two different levels of abstraction.

The minimum viable set is: README (what this is) + a specification (what it does and how) + code.

### Any other resources or similar endeavor?

Yes.

[Harness engineering: Structured workflows for AI-assisted development | Red Hat Developer](https://developers.redhat.com/articles/2026/04/07/harness-engineering-structured-workflows-ai-assisted-development#why_this_works)
