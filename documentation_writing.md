Telescopic engineering for viable and durable projects in the AI era
====================================================================

The situation and issue
-----------------------

- Generative AIs and vibe-coding make it easy to get lots of text and code. The cost shifts from creating them to ensuring they fit the intended purpose.

- Without **proper steering**, code generation yields hallucinations, drift and overall wasted time.

- Just riding on the AI acceleration breaks the traditional effort loop and workflow from ideas to a sustainable project, leading to various negative consequences (rhythm and attention disruption, burnout, loss of control).

Adapt proven approaches to the new context
------------------------------------------

- Documentation is an external memory, allowing humans to work on projects **too big to fit at once in a person's mind**.
- Drift and disorder can be dealt with proper structure and discipline.
- AI is good at some things (spotting and reporting inconsistencies in bigger contexts), while humans remain better at keeping in mind the big picture and controlling at some levels of details.

What if adjusting well-known old good practice in a new specific combination can:

- leverage AI on what it's good at,
- let humans do what they are good at,
- create a new more suitable equilibrium (better than just relinquishing control),
- restore some of the broken loops?

Telescopic engineering sets your project on tracks
--------------------------------------------------

Telescopic engineering **structures** a project as a **chain of stages** with **progressively detailed documents**, from a narrow upstream end (the `README.md`) to a wide downstream end (the code), with stages in between that are maintained consistent with one another.

At any time you only have to focus on part of any stage, evaluate and correct it, and the overall structure will help other actors (humans or AI) to propagate whatever you express into full-fledged working implementation.

A key benefit: because upstream documents are self-contained, any downstream stage can be discarded and rebuilt without losing the project's foundation. This applies at every scale -- rewriting code from unchanged implementation docs, re-architecting from an unchanged functional spec, or pivoting the entire technology stack while preserving the capability specification. The upstream documents act as a stable checkpoint from which downstream work can always be regenerated.

In other words, it's mainly reusing the old working recipes, but tuned to a software project where human(s) and AI(s) work together, allowing the human to maintain proper steering and high velocity.

How telescopic engineering works
--------------------------------

The system is a chain of stages, from upstream (concise, high-level) to downstream (detailed, low-level).

Because each document is minimal, it is easy and quick to review or even read in depth, yet it is the solid foundation on which all downstream documents rest.

Each document covers only what its stage describes and no more: any further detail appears only at the next stage. At the end, the code is the last ground truth (since it is what actually runs).

Yet all documents are authoritative: downstream documents make some decisions explicit and provide more details, yet must not deviate from what is stated in upstream documents.

As a consequence, the introduction of any stage document is extremely short: where its traditional content would just look like the upstream document, it is mostly an introduction sentence and a link to that.

Below is an archetype of the stages that together serve the purpose, from the most upstream to the most downstream.

### README.md

README.md is the entry point for everyone and targets the random visitor who lands on the repository. It is the only document in the chain with this audience -- all other documents are working documents, increasingly technical and maintainer-oriented as one moves downstream.

It must pitch the project and provide minimal entry points to any area where the visitor wants to know more or experiment. Every section stays concise (a few sentences); each may link to deeper documents.

See [[readme_writing.md|]] for a catalog of sections worth considering and the rationale behind each.

### Capability specification

The capability specification provides a *high-level description* of *all* the capabilities of the system.

No detail about how the user will interact or how features are implemented.

This stage is important because it details the *properties* that are needed ("a user must be able to...") but not the *how* ("a window with title FOO, content BAR and ok/cancel buttons").

### Functional specification

The functional specification provides a comprehensive description of what the product does, every feature in detail, how the user can interact with it, how it interacts with its surroundings.

Anything that's part of the contract with the outside world belongs here, even down to the bits and bytes if important.

- configuration files (the specification may leave options open like "whatever is natural with the chosen downstream implementation")
- network protocol (typical example where bits and bytes are fundamental here)

It's okay here to mention common computer science concepts (like a tree, queue, dictionary, callback, event loop) if that serves clarity and conciseness, yet reference to a specific technology, brand, or programming language is forbidden.

Anything that's internal, not observable from the outside, does not belong at this stage. Example: no mention of internal architecture, or implementation language.

Acceptance tests belong here: they are a machine-readable, machine-verifiable part of the functional specification. They ideally live in the same repository, to ensure consistency.

### Architecture document

The architecture document describes the solution strategy.

Whatever is needed to structure a working solution irrespective of a specific implementation language belongs at this stage.

Examples:

- breaking down a problem into sub-problems
- introducing algorithms and explanations on how to use them, that will solve the underlying issue

In very simple projects, it may not make sense to have an architecture stage.

### Implementation documentation

The implementation document describes the technology stack and how the solution strategy maps to it.

It is a project-wide document. It introduces and justifies impactful project-wide choices: language, dependencies, overall data structures that are consequences of the language choices.

Any element, decision, etc. that makes sense only once these choices are made but before writing code belongs here.

Unit tests belong here and are considered a machine-readable, machine-verifiable part of the implementation documentation.

Notice the closer proximity between "implementation documentation" and "source code", yet these are still distinct.

For example: once Python and library foo are chosen for implementation, a specific way of writing software naturally derives, with specific interfaces and classes, and still is not the code.

Throwing away part or even all of the code, e.g. because it grew more complicated than needed, then rewriting it based on the same implementation documentation is an option.

### Actual code

The last "document" is the actual code.

It makes sense to separate code from "implementation documentation".

Except for very small projects it lives in its own source tree and is generally split over a number of folders and many source files.

Notice that code-local documents should exist in the source tree:

- per-directory `README.md`, introduce and justify choices specific to the subsystem in this directory
- in some specific cases, extra documents, either with the same name as a specific source code file, but with `.md` extension, focusing on specific aspects
- structured code comments that allow automatic extraction into documentation

Care must be taken to have abundance of cross-references for the reviewer's convenience (clarity, navigation).

Observations
------------

- The documents are interdependent and overlap in their content, if only because each document goes into more details about what the upstream one explained.
- Yet the relation is asymmetrical: from any stage, it and all downstream stages could be completely cut off and the remaining upstream stages would make an incomplete but standalone and consistent document set, allowing to rebuild all downstream documents. A typical scenario is eliminating technical debt: a prototype was coded in a language and as the project evolves a complete rewrite is due.

FAQ
---

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
