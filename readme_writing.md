Writing the README
==================

This companion to [how telescopic engineering works](20_detailed_description.md) catalogs the sections worth considering in a README.md, and the rationale behind each.

The hook
--------

A one-sentence pitch immediately after the title, before any section heading, tells the visitor what the project does. This is the single most-read line -- visitors who read nothing else will read this. Examples:

- "Find files across many external drives without remembering which one has them."

- "Have your Markdown files consistent and beautiful, keep your focus on the content."

- "A pragmatic solution for running an Internet domain: DNS, web, mail, and others."

After the hook, sections flesh out the pitch.

The hook's goal is to convey *why this project exists*, not merely what it does. A hook that names only the mechanism -- "a tool for X" -- says nothing about what makes the project worth using instead of the obvious alternative. When the project embodies a key insight or takes a principled approach to a non-obvious problem, that insight belongs in the hook. The test: could a visitor tell from the hook alone that this project makes a specific, considered choice -- or does it read like any tool in the space? If the latter, the insight has not been captured.

A sharper formulation of the same test: lead with the *pain* the visitor feels, or the *tradeoff* the project resolves, not the mechanism the project uses. "Automated X for Y" tells the visitor what the tool does; "Stop suffering from Z" or "Stuck between A and B? Now you can have both" tells the visitor why they should care. A pain-led hook can be declarative, but rhetorical questions ("Wishing for X? Tired of Y?") often work harder, putting the visitor in their own situation before the project name has even registered. The mechanism form reads like every other tool in its space; the pain form earns the next sentence of attention.

In a telescopic analysis, a hook that fails this test is always a **must-fix** issue, raised without waiting for the user to notice it. The hook is the highest-visibility text in the entire project; a weak or mechanism-only hook is a more urgent problem than most structural issues deeper in the document chain.

Near-universal sections
-----------------------

- **"What's this?"** -- one to three sentences telling what kind of thing is defined here (a tool? a method? something else?) so that the reader knows what to expect in practice that solves their pain point.

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

When deciding which sections to include, apply judgment freely: skip sections that add no value for a given project, invent new section topics when the project warrants them, and adjust the canonical names when a better label serves the reader. One constraint is non-negotiable: each section's content must be consistent with its title. A "What's this?" that explains why the project exists, a "Quick start" that reads like an architecture overview, or a "Why this?" that describes usage -- these are not wrong choices of section, they are broken sections. And together the included sections must form a coherent, concise pitch: each one should earn its place by adding something the others do not already say.

Back to [how it works](20_detailed_description.md).
