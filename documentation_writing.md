# Documentation for viable and durable projects

## Why this?

Any project (from the biggest to even very small, beyond, say, 100 lines of code) need some documents to keep things on track. Without them, everything wanders, with them things converge much more easily.

This document elaborates a set of documenation-focused guidelines for project success.

## The structuring fan-out documentation system

Below is an archetype of the documents that together serve the purpose, from the most high-level concise to the detailed.

Each document is minimal in the sense that it covers what is described here but no more: any more detail appears only in the next document. At the end, the code is the last ground truth (since it is what actually runs in the end).


### README.md

README.md is the entry point for everyone and targets the random github visitor.

README.md must pitch the project:

- all section very concise (few sentences)
- first a "what's this?" section about what the project is (one sentence, maybe two or three)
- then in a project-dependent order chosen to maximize clarity
- each section may have links to more details

Possible sections:

- "Why this?" what's the problem this project solves,
- "Who it is for?" the target audience
- what you get,
- "Getting started" with practical steps,
- dependencies,
- "more" with an ordered list of other documentations in the project (including all links that were in previous sections)

Whatever serves the purpose is welcome e.g. an overall diagram given the constraints of conciseness.

### Product requirements

Product requirements provides a high-level description of all the features.

No detail about how the user will interact or how features are implemented.

### Functional specification

Functional specification provides a comprehensive description of what the product does, every feature in detail, how the user can interact with it, how it interacts with its surroundings.

That may include details about anything that's part of the contract with the outside world, even down to the bits and byte

- common data structures or language constructs
- network protocol

Yet no mention of internal architecture, implementation language or whatever.

External tests are welcome and considered a machine-readable, machine-verifiable part of the functional specifications.

### Architecture document

This document drills down to describing relevant architectural details that will make up a working solution. If it at all makes sense to not mention any specific language then so be it.

### Implementation documentation

Here all technical decisions and language-dependant details are welcome. It's still somehow more "external" than the code itself.

Unit tests are welcome and are considered a machine-readable, machine-verifiable part of the implementation documentation.

### Actual code

The last "document" is the actual code (generally split over a number of folders and many source files).

## Observations

- The documents certainly are interdependant and overlap in their content, if only because each document goes into more details about what the previous explained.
- Yet the relation is asymmetrical: from any document, it and all later documents could be completely cut off and the remaining (earlier) parts would make yet incomplete but standalone and consistent document set, allowing to rebuild all later documemnts. A typical scenario is eliminating technical debt: a prototype was coded in a langage and as the project evolves a complete rewrite is due.
