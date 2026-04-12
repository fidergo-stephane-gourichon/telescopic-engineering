Telescopic Engineering
======================

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

More
----

1.  `doc/10_capability_specification/` — defines system capabilities (what must be possible)
2.  `doc/20_functional_specification/` — defines external behavior (what the system does)
3.  `doc/30_architecture/` — defines structural decomposition strategy
4.  `doc/40_implementation/` — defines technology mapping rules
5.  `src/` — executable system (ground truth)

Name origin
-----------

“Telescopic” refers to the idea of nested structures that extend outward in controlled stages, where each segment reveals more detail without altering the alignment of the whole.
