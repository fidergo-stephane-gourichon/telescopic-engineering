---
name: telescopic
description: Survey a project's documentation, map it to telescoping-engineering stages, identify gaps and violations, and propose concrete improvements. Tracks progress in .telescopic/ so work survives across sessions.
argument-hint: "[path]"
---

# Telescopic

Apply the telescopic engineering method to a project's documentation. Surveys existing docs,
maps them to stages, identifies gaps and rule violations, proposes ordered changes, and applies
them one at a time with commits. Progress is stored in `.telescopic/` so work survives across
sessions and conversations.

## Step 0 — Determine project root

If `$ARGUMENTS` is non-empty and resolves to a valid directory path, use it as the project root.
Otherwise use the current working directory.

## Step 1 — Check for prior work

Check whether any files exist under `.telescopic/` at the project root. Any such file is a sign
that prior analysis was done. If they exist, read them.

Then run this quick staleness hint:

```bash
find . -type f -newer .telescopic/report.md ! -path './.git/*' ! -path './.telescopic/*' | head -10
```

Use the output as a hint, not a rule: if the files returned look like documentation (`.md`, `.rst`,
`README`, etc.), staleness is likely. If they are unrelated build artifacts or source files, the
prior analysis is probably still valid. When unsure, ask the user.

Based on the prior files and the staleness hint:

-   If the prior work appears **still useful** and `.telescopic/todo.md` has pending items: display
    them and ask "Resume from this work list, or run a fresh analysis?"
    -   If **resume**: skip to **Step 4 — Apply actions**.
    -   If **fresh analysis**: proceed to Step 2.

-   If the prior work appears **still useful** but no todo items remain: ask "Prior analysis exists.
    Continue from it, or run a fresh analysis?"
    -   If **continue**: skip to **Step 4 — Propose and approve** using report.md as the basis.
    -   If **fresh analysis**: proceed to Step 2.

-   If the prior work appears **stale or no prior work exists**: proceed to Step 2.

## Step 2 — Read the method reference

Read these files before performing any analysis. They are the authoritative reference for the
telescopic engineering method:

-   `~/.claude/skills/telescopic/docs/20_detailed_description.md` — stage definitions and rules
-   `~/.claude/skills/telescopic/docs/30_faq.md` — FAQ including the recommended `doc-telescopic/` layout
-   `~/.claude/skills/telescopic/docs/readme_writing.md` — catalog of README sections

## Step 3 — Full analysis

### 3a — Inventory

List all documentation files at the project root and in subdirectories:

-   `.md`, `.rst`, `.txt` files at the root level
-   Everything under `doc-telescopic/`, `doc/`, `docs/`, `documentation/` (recursively)
-   Per-directory `README.md` files inside source trees (`src/`, `lib/`, etc.)

### 3b — Classify

For each file, read its content (or at minimum its title and first few paragraphs) and assign it
to one of these categories:

| Category | What belongs here |
|---|---|
| `README` | Top-level pitch for a random visitor; each section stays concise |
| `capability-spec` | What the system can do; no "how", no UI detail, no implementation |
| `functional-spec` | Full external contract: features, UX, protocols, acceptance tests; no language/architecture |
| `architecture` | Solution strategy, algorithms, sub-problem breakdown; technology-agnostic |
| `implementation-doc` | Language/stack choices, project-wide data structures, unit tests |
| `code-local` | Per-directory README or per-file companion inside the source tree |
| `unclassified` | Cannot be mapped to any stage |

### 3c — Identify issues

Flag each of the following, referencing specific files (and line numbers when relevant):

-   **Missing stages**: which of the six stage categories have no document. Note that
    `architecture` and `implementation-doc` may be intentionally absent for small or trivial
    projects — flag as "may be intentionally absent" rather than "missing".

-   **Intro violations**: a stage document whose introduction repeats upstream content instead of
    linking to it, or is long enough to obscure what stage this document belongs to. The goal is
    clarity: the reader should immediately know where they are in the chain and where to go for
    more context. A single short sentence with an upstream link is the ideal; a second sentence
    that adds genuine navigation value (e.g. a downstream pointer) is acceptable and not a
    violation. Flag as a violation only when the intro is so long it reads like a summary, or
    when it restates content the upstream document already covers.

-   **Scope violations**: content at the wrong stage level (e.g. implementation language named in
    a functional spec; UI layout details in a capability spec).

-   **Downstream deviation**: a downstream document contradicts a claim made in an upstream
    document.

-   **Layout issues**: no `README.md` at the repo root; stage docs not organized under `doc-telescopic/`;
    stage directories missing numeric prefixes that would enforce sort order (e.g. `10_`, `20_`).

Severity tags:

-   **must fix** — a clear rule violation
-   **should fix** — deviation from recommended convention
-   **consider** — optional improvement appropriate to this project's scale

### 3d — Write the report

Create `.telescopic/` at the project root if it does not exist.

**Linking convention for all generated files** (report.md, todo.md, decisions.md): always link to
the most precise location — prefer a section anchor over a bare file link whenever the target is a
specific heading. Link text is a short human-readable label; URL uses the `../`-prefixed
project-root-relative path with an `#anchor` suffix when applicable.

Write `.telescopic/report.md` with:

-   A **header** containing: the date of analysis (e.g. `Generated: 2026-04-23`) and the git
    revision (e.g. `Revision: ` followed by the output of `git describe --always --tags --dirty`)

-   A **Current state** section grouping files by directory. Use judgment: files that naturally
    cluster together (e.g. all root-level files, all files under `doc-telescopic/`) share one
    table; avoid creating so many tables that the grouping becomes noise. Each section heading
    names the common directory prefix, and that prefix is stripped from all link texts in the
    table — keeping rows short and readable. The link URL still uses the full project-root-relative
    path prefixed with `../` (since `.telescopic/` is one level below the project root):

    ### Repo root

    | File | Stage | Notes |
    |---|---|---|
    | [README.md](../README.md) | README | |

    ### doc-telescopic/

    | File | Stage | Notes |
    |---|---|---|
    | [10_capability_specification/spec.md](../doc-telescopic/10_capability_specification/spec.md) | capability-spec | |
    | [20_functional_specification/spec.md](../doc-telescopic/20_functional_specification/spec.md) | functional-spec | |

-   A **Issues found** bullet list — **never a numbered list** (numbers break whenever an item is
    inserted or deleted). Tag each item with severity (`must fix` / `should fix` / `consider`).
    Apply the linking convention above: use a section anchor whenever possible (e.g.
    `[func spec § Introduction](../doc-telescopic/20_functional_specification/spec.md#introduction)`);
    bare file link only when the issue spans the whole document.

Then commit:

```
git add .telescopic/report.md
git commit -m "telescope: record analysis report"
```

## Step 4 — Propose and approve

Present the issues and a numbered proposed action list to the user. Order actions from least
disruptive to most (renames before reorganizations before new files before content rewrites).
Tag each with its severity.

If the existing documents are already clearly separated by stage and their contents match the
desired structure closely enough, propose a rename/move plan as the first action — before any
content edits. A rename/move plan groups all file relocations and cross-reference updates into
a single proposal for the user to review and approve before anything is applied. The test: would
an experienced reader recognize the existing document as clearly belonging to the target stage,
with no significant scope violations? If yes, moving it is the right first step.

Example:

```
- [must fix] Shorten intro of doc-telescopic/20_functional_specification/spec.md to one sentence + link to capability spec
- [should fix] Rename doc-telescopic/architecture/ → doc-telescopic/30_architecture/ to add sort prefix
- [consider] Create doc-telescopic/10_capability_specification/ with a skeleton spec.md
```

Ask the user which actions to approve. If the user declines or disagrees with any proposed action,
record it in `.telescopic/decisions.md` with a one-line summary of what was declined and, if the
user gave a reason, the reason. Commit this file and tell the user its path so they can edit or
remove the entry if they change their mind later.

Once confirmed, write the approved actions as a bullet list — **never a numbered list** (numbers
break whenever an item is inserted or deleted) — in `.telescopic/todo.md`, then commit:

```
git add .telescopic/todo.md
git commit -m "telescope: record approved action list"
```

## Step 5 — Apply actions

Work through `.telescopic/todo.md` from top to bottom.

For each item:

-   Apply the change (rename, create file, move section, shorten intro, etc.).
-   Commit the change with a descriptive message (e.g. `Shorten functional spec intro to one sentence`).
-   Remove that item from `.telescopic/todo.md`.
-   Commit the updated todo with:
    ```
    git commit -m "telescope: mark action done — [one-line description]"
    ```

The structural change and the todo update are coupled — commit them in the order above but treat
them as one logical unit: reverting one without the other would leave the state inconsistent.

Ask the user before each action, or offer to apply all in sequence — follow the user's preference.

When `.telescopic/todo.md` becomes empty, report completion and confirm that all approved changes
have been applied.

## Notes

-   Never silently skip an issue because it may be intentional — always flag and let the user decide.
-   When an action would move content between files, show the user a diff-style preview before
    applying.
-   If a required file (`README.md`, a stage doc) does not exist, propose a skeleton — do not
    create it without approval.
-   The method allows skipping or merging stages for small projects. When flagging a missing stage
    as "may be intentionally absent", suggest the lightweight option: a single-sentence
    acknowledgement file rather than a full document.
