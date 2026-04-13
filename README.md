Telescopic engineering: restoring project viability in the AI era
=================================================================

**Problem:** AI provides code fast, at a cost of grave loss of control.

**Solution:** restore control through a chain of progressively detailed documents, from README to code.

Semi-short pitch below, or go straight to [full details](20_detailed_description.md).

Why telescopic engineering works
--------------------------------

Telescopic engineering puts AI to work where it helps (controlled expansion from short blurbs, consistency checks, propagation across documents) and puts humans back at the center: big picture, writing and proofreading short extracts, judgment calls.

See [motivation](10_motivation.md) for the full argument.

What it is
----------

A chain of stages, each a refinement of the previous one:

    README.md -> capability spec -> functional spec -> architecture -> implementation -> code

Upstream stays stable; downstream can be discarded and rebuilt without losing the foundation. See [[20_detailed_description.md]] for the stage-by-stage breakdown, and [[30_faq.md]] for common questions.

Name origin
-----------

Like a pocket telescope that extends in nested segments, the method extends a project as a chain of documents, each segment revealing more detail without disturbing the alignment of the whole.
