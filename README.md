Telescopic Engineering: restoring project viability in the AI era
=================================================================

A structured documentation method to solve several issues with AI assistance: they drift/wander/hallucinate, they shift some costs from creating to reviewing, they break the traditional effort loop and workflow from ideas to a sustainable project leading to various negative consequences.

Telescopic engineering offers a structured solution to keep your project on track, minimizes the reviewing cost, restore some sanity and manageable control while still allowing some acceleration made possible by AI.

What's this?
------------

This project defines a methodology for organizing software systems as a **stack of progressively detailed documents**, starting from a concise entry point (`README.md`) and ending in executable code.

Each layer refines the previous one without altering its meaning. The result is a system where:

- high-level intent remains stable,
- mid-level design decisions stay explicit,
- low-level implementation can be rewritten safely.

Why this?
---------

Modern AI-assisted development changes the bottleneck: generating code and text is cheap, but ensuring **consistency, correctness, and intent alignment** is not.

Without structure:

- generated code drifts from intent,
- specifications silently diverge,
- local edits break global assumptions,
- rebuilding systems becomes fragile and expensive.

This methodology exists to enforce a disciplined separation of concerns across abstraction levels so that:

- upstream intent acts as a stable source of truth,
- downstream artifacts become replaceable derivations,
- AI and humans can iterate safely without losing coherence.

How it works
------------

The system is a directed chain of refinement:

``` default
README.md -> capability spec -> functional spec -> architecture -> implementation -> code
```

Each stage:

- is minimal and focused,
- expands only what its level requires,
- must remain consistent with upstream definitions,
- can be discarded and rebuilt while upstream stages retain their value.

Name origin
-----------

Like a pocket telescope extends in nested segments, the method extends a project as a chain of documents, each segment revealing more detail without disturbing the alignment of the whole.
