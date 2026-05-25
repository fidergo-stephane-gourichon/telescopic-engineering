The filesystem structuration pattern
====================================

Part of [telescopic engineering](../README.md). This file is itself an application of the pattern it describes: the pattern started as one section of [how it works](../20_detailed_description.md) and spilled into this file -- placed in `20_detailed_description/`, the spill directory of its origin document -- once it deserved room to breathe.

The pattern
-----------

A body of documentation is organised by a single recurring unit: a file `foo.md` paired with an optional sibling directory `foo/`.

- `foo.md` is the entry point. It carries the content while the content is small.
- `foo/` holds the overflow. It exists only once `foo.md` has grown enough to need it.

The pairing is the whole pattern. Everything below is a consequence of it.

Spilling
--------

When a section of `foo.md` grows too large to sit comfortably among its peers, it **spills**: the section's body moves into a new file `foo/<name>.md`, and a link to that file is left in its place.

`foo.md` stays readable: a reader scanning it sees every section, in order, and follows a link only for the sections they care about.

Taken to its limit, every section has spilled, and `foo.md` holds nothing but its title, its intro, and an ordered list of links to the files in `foo/`. That is a valid and common end state, not a degenerate one: `foo.md` has become a pure index.

Collapsing
----------

The operation is reversible. When the files in `foo/` shrink -- content removed, topics merged -- they **collapse** back: a small `foo/<name>.md` becomes a section inside `foo.md` again, and `foo/` is removed once empty.

Spilling and collapsing are the same pattern run in opposite directions. A document is never locked to one shape; it moves between shapes as its content grows and shrinks.

Ordering prefixes
-----------------

The presentation order of the files inside `foo/` is the order they are listed in `foo.md`. A filename prefix is added so that a plain directory listing sorts the same way:

- **Numeric** (`10_`, `20_`, `30_`) when the files form a sequence -- a reading order, a pipeline, stages that build on each other. Leave gaps so a file can be inserted without renumbering its neighbours.
- **Alphabetical** when the order is merely a stable, predictable sort and no sequence is implied.

The prefix is a deliberate choice between these two intents, not decoration. When neither applies, no prefix is needed.

Recursion: the pattern applies at every level
---------------------------------------------

`foo/<name>.md` is itself a `foo.md` for a `foo/` of its own. The pattern nests without limit.

It also reaches the top. The documentation root is just another instance: a populated `doc-telescopic/` directory implies a `doc-telescopic.md` beside it.

``` default
README.md
doc-telescopic.md          <- the root index
doc-telescopic/
  10_capability_specification/
  20_functional_specification/
  30_architecture/
  40_implementation/
src/
```

`doc-telescopic.md` briefly introduces the telescopic engineering method, links to <https://github.com/fidergo-stephane-gourichon/telescopic-engineering>, and enumerates the stage directories in order. It is the index of `doc-telescopic/`, exactly as any `foo.md` is the index of its `foo/`.

Empty stages
------------

An empty stage needs no stub directory and no placeholder file. Mention it in `doc-telescopic.md` as deliberately empty, or omit it entirely. A missing directory is not a gap to fill; it is the absence of overflow, which is the normal state of a small project.

Why this is foundational
------------------------

The pattern is not a filing tidiness rule. It is the structural backbone that makes the rest of telescopic engineering work on a filesystem.

- **Navigation becomes near-trivial.** The path of a file states where it sits in the chain and what it contains. A reader orients themselves from the URL alone.
- **Order has a single source of truth.** The order in which `foo.md` lists its sections and links *is* the presentation order for `foo/`. The filename prefixes should match that order, and normally do, but the match is best-effort: when `foo.md` and the prefixes disagree, `foo.md` wins, and the mismatch is an incident to resolve by renaming the files -- worth doing, though rarely urgent.
- **Tooling can derive structure.** Because each `foo.md` lists its `foo/` files in order and the directory tree encodes nesting, a renderer or a navigation generator can build a table of contents and inter-document links mechanically, with no separate hand-maintained index to drift out of sync.
- **Growth never forces reorganisation.** A document that outgrows one file spills; one that shrinks collapses. The shape follows the content, and no rename cascade is needed when a project grows.

Navigation
----------

Back to [README](../README.md), or see [how it works](../20_detailed_description.md) for the stage-by-stage breakdown and the [FAQ](../30_faq.md) for common questions.
