Writing the README
==================

This companion to the telescopic engineering guide catalogs the sections worth considering in a README.md, and the rationale behind each.

The hook
--------

A one-sentence pitch immediately after the title, before any section heading, tells the visitor what the project does. This is the single most-read line -- visitors who read nothing else will read this. Examples:

- "Find files across many external drives without remembering which one has them."

- "Have your Markdown files consistent and beautiful, keep your focus on the content."

- "A pragmatic solution for running an Internet domain: DNS, web, mail, and others."

After the hook, sections flesh out the pitch.

Near-universal sections
-----------------------

- **"What's this?"** -- one to three sentences expanding the hook into a concrete description.

- **"Why this?" or "the challenge"** -- what problem the project solves, or why the problem is hard enough to warrant a tool. When the difficulty is non-obvious, explaining it justifies the project's existence and educates the visitor.

- **"Quick start"** -- the shortest path from zero to a working result. Actual runnable commands, not prose descriptions. Prerequisites presented as a ready-to-paste `apt install` line (or equivalent) rather than a prose list. Commands shown with a `$` prompt prefix in a fenced `shell` block, with output (when shown) on bare lines following the command.

- **"More"** -- an ordered list of deeper documents in the project, collecting all links that appeared in previous sections. This is the visitor's map to everything else.

Situational sections
--------------------

Not every README needs all of these. Include them when they serve the visitor.

- **"Who is this for?" and anti-audience** -- the target audience, and when useful, who the project is *not* for (with pointers to better-fitting alternatives). Saying "not a good fit for users who want X; see Y instead" saves both the visitor's time and the maintainer's issue tracker.

- **"Show me" or before/after demonstration** -- a visual demonstration of what the tool does: input on one side, output on the other. Worth more than a paragraph of description.

- **Examples with actual output** -- representative commands followed by their output, using the same `$`-prefixed `shell` block format as in "Quick start".

- **Diagram** -- an ASCII diagram of the architecture, workflow, or data flow. When the project has a pipeline or layered structure, a diagram communicates it faster than any paragraph.

- **Features list** -- a bulleted list of notable capabilities, each one sentence. Useful when the project does several distinct things that the hook alone cannot convey.

- **Security or trust stance** -- when the project handles isolation, credentials, or runs with elevated context, the README addresses trust directly: what the threat model is, what the project does about it, what the visitor should verify.

- **Scope limitation or philosophy** -- the project's design values, what it deliberately does not do, and constraints on contributions. Sets expectations for both users and contributors.

- **Name origin** -- when the project name is non-obvious, a one-sentence etymology helps memorability. Always as a dedicated short section (e.g. "Why this name?"), never diluted into an earlier section.

- **Status** -- for incomplete projects, a one-line status indicator ("Algorithm design phase", "Prototype, not yet usable") prevents the visitor from trying to use something that does not work yet.

Out of scope here
-----------------

The following can appear in a README but are about visitor experience rather than the document chain consistency that the telescopic engineering guide is about. They are not forbidden; they are simply not covered here.

- **Troubleshooting** -- common failure modes with their fixes.

- **Companion or alternative projects** -- pointers to related tools that solve the same problem differently.

- **File overview table** -- a table mapping files to their purpose, useful for orientation in small projects.

Flexibility
-----------

The sections above are a palette, not a template. A README may reorder them, merge them, or omit any that do not serve clarity. A three-line README for a trivial script and a multi-section README for a complex system are both valid -- the test is whether the visitor gets what they need.
