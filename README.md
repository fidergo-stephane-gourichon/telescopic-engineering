Telescopic engineering: restoring project viability in the AI era
=================================================================

Building with AI today feels like riding a motorbike hands-off: fast, no control, predictable crash. Gradually, people lose track of how things work, then of what they do, then of where the project is going. Telescopic engineering puts the rider back in control through a chain of progressively detailed documents, from README to code.

Why it exists
-------------

AI makes code and text cheap. What gets lost is harder to replace:

- intent drifts from what the project should actually do

- specifications silently diverge from each other and from the code

- the human in the loop loses grip on the big picture

- the rhythm that kept the work sustainable breaks down, taking the person with it

Telescopic engineering puts AI to work where it helps (consistency checks, propagation across documents) and keeps humans in charge of what only humans do well (big picture, judgment calls). See [[10_motivation.md]] for the full argument.

What it is
----------

A chain of stages, each a refinement of the previous one:

    README.md -> capability spec -> functional spec -> architecture -> implementation -> code

Upstream stays stable; downstream can be discarded and rebuilt without losing the foundation. See [[20_how_it_works.md]] for the stage-by-stage breakdown, and [[30_faq.md]] for common questions.

Name origin
-----------

Like a pocket telescope that extends in nested segments, the method extends a project as a chain of documents, each segment revealing more detail without disturbing the alignment of the whole.
