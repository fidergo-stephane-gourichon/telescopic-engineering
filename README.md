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

The system is a **directed chain of refinement**:

    README.md
       ↓
    Capability Specification
       ↓
    Functional Specification
       ↓
    Architecture
       ↓
    Implementation Documentation
       ↓
    Code

Each stage:

- is minimal and focused,
- expands only what its level requires,
- must remain consistent with upstream definitions,
- can be discarded and rebuilt while upstream stages retain their value.

Key properties
--------------

- **Upstream stability**: intent is captured early and remains constant.
- **Localized reasoning**: each document is small enough to audit independently.
- **Bidirectional correction**: inconsistencies can be resolved either upward or downward depending on evidence.
- **AI-friendly structure**: each stage is a bounded context for generation and verification.

What problem it solves
----------------------

- Prevents specification drift in long-lived projects.
- Makes AI-generated code auditable against explicit intent layers.
- Reduces cognitive load by isolating concerns by abstraction level.
- Enables partial rewrites (code, architecture, or full system) without losing correctness guarantees.

Quick start
-----------

### 1. Create the structure

``` shell
$ mkdir -p doc/10_capability_specification \
           doc/20_functional_specification \
           doc/30_architecture \
           doc/40_implementation \
           src
```

### 2. Initialize minimal chain

``` shell
$ echo "Project intent goes here." > README.md
$ echo "Capability spec placeholder." > doc/10_capability_specification/spec.md
$ echo "Functional spec placeholder." > doc/20_functional_specification/spec.md
$ echo "Architecture placeholder." > doc/30_architecture/spec.md
$ echo "Implementation placeholder." > doc/40_implementation/spec.md
```

### 3. Enforce consistency loop

At each change:

- update the highest relevant upstream document first,
- propagate changes downstream,
- verify that no downstream artifact deviates from its upstream

Architecture overview
---------------------

    [Intent Layer]
        README.md
            ↓
    [Capability Layer]
        What must be possible
            ↓
    [Functional Layer]
        External behavior definition
            ↓
    [Architecture Layer]
        System decomposition strategy
            ↓
    [Implementation Layer]
        Technology mapping rules
            ↓
    [Execution Layer]
        Source code (runtime truth)

Scope rules
-----------

This system explicitly enforces:

- **No hidden design decisions in code**
- **No behavior not traceable to functional specification**
- **No architectural choices not justified in architecture layer**
- **No capability introduced without upstream declaration**

Conversely:

- implementation details must not leak upward,
- upstream documents remain free of technical specificity unless required.

Philosophy
----------

- Simplicity at each layer is more important than completeness.
- Clarity is achieved by separation, not aggregation.
- Every layer should be small enough to be fully reviewed.
- The system optimizes for *regeneration*, not permanence of artifacts.

Status
------

Experimental methodology. Stable concept, evolving best practices.

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
