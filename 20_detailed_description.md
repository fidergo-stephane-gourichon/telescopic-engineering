How telescopic engineering works
================================

See [motivation](10_motivation.md) for the argument behind the approach. Below is the stage-by-stage breakdown.

Core principles
---------------

The system is a chain of stages, from upstream (concise, high-level) to downstream (detailed, low-level).

Because each document is minimal, it is easy and quick to review or even read in depth, yet it is the solid foundation on which all downstream documents rest.

Each document covers only what its stage describes and no more: any further detail appears only at the next stage. At the end, the code is the last ground truth (since it is what actually runs).

Yet all documents are authoritative: downstream documents make some decisions explicit and provide more details, yet must not deviate from what is stated in upstream documents.

As a consequence, the introduction of any stage document is extremely short: rather than repeating the upstream content, it is ideally one or two sentences. The intro summarises what the previous stage established and what this stage adds -- enough for a reader who lands on the document by chance to orient themselves without reading the whole chain.

Below is an archetype of the stages that together serve the purpose, from the most upstream to the most downstream.

The stages
----------

### README.md

README.md is the entry point for everyone and targets the random visitor who lands on the repository. It is the only document in the chain with this audience -- all other documents are working documents, increasingly technical and maintainer-oriented as one moves downstream.

It must pitch the project and provide minimal entry points to any area where the visitor wants to know more or experiment. Every section stays concise (a few sentences); each may link to deeper documents.

See [readme_writing.md](readme_writing.md) for a catalog of sections worth considering and the rationale behind each.

### Capability specification

The capability specification provides a *high-level description* of *all* the capabilities of the system.

No detail about how the user will interact or how features are implemented. In particular, do not name any commands, CLI flags, subcommand names, or UI elements -- those belong in the functional specification.

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

Inline prose links to related documents, functions, and sections should be abundant: they let a reviewer jump directly to relevant context without searching.

Observations
------------

- The documents are interdependent and overlap in their content, if only because each document goes into more details about what the upstream one explained.

- Yet the relation is asymmetrical: from any stage, it and all downstream stages could be completely cut off and the remaining upstream stages would still make a standalone and consistent document set. A typical scenario is eliminating technical debt: a prototype was coded in a language and as the project evolves a complete rewrite is due.

Practical concerns
------------------

**Format.** Markdown is the natural choice for stage documents: readable as plain text, widely rendered, and version-control-friendly.

**Document structure.** Each stage document follows this layout:

1.  The title heading.
2.  The intro (one or two sentences as described in Core principles).
3.  A top navigation bar -- immediately after the intro, before any content section.
4.  The content sections.
5.  A `Navigation` section at the bottom.

**Navigation bars.** Both bars use a three-part line: previous stage, current document label, next stage. The markers make direction visible in the markdown source:

Top bar (plain center -- you are already at the top):

`[< README <](link) || capability specification || [> functional specification >](link)`

Bottom bar (linked center -- jump back to top after reading):

`[< README <](link) || [^ capability specification ^](#capability-specification) || [> functional specification >](link)`

The `<` markers bracket the upstream link; plain text or `^`-bracketed text identifies the current document; the `>` markers bracket the downstream link.

Keep document title headings in plain ASCII. The heading-to-anchor mapping (`# Some Title` -> `#some-title`) is a widely-followed convention, not a standard: renderers agree on plain ASCII but diverge on accents, Unicode, and special characters.

Navigation
----------

For common questions, see the [FAQ](30_faq.md). Back to [README](README.md).
