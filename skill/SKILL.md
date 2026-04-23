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

Before any analysis, check whether `.telescopic/todo.md` exists at the project root and contains
any items.

-   If it exists and has content: display the items and ask the user: "There is pending work from
    a prior session. Resume from this list, or run a fresh analysis?"

    -   If the user chooses **resume**: skip to **Step 4 — Apply actions**.
    -   If the user chooses **fresh analysis**: proceed to Step 2.

-   If it does not exist or is empty: proceed to Step 2.

## Step 2 — Read the method reference

Read these files before performing any analysis. They are the authoritative reference for the
telescopic engineering method:

-   `~/.claude/skills/telescopic/docs/20_detailed_description.md` — stage definitions and rules
-   `~/.claude/skills/telescopic/docs/30_faq.md` — FAQ including the recommended `doc/` layout
-   `~/.claude/skills/telescopic/docs/readme_writing.md` — catalog of README sections

## Step 3 — Full analysis

### 3a — Inventory

List all documentation files at the project root and in subdirectories:

-   `.md`, `.rst`, `.txt` files at the root level
-   Everything under `doc/`, `docs/`, `documentation/` (recursively)
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

-   **Intro violations**: a stage document whose introduction is longer than one sentence, or that
    repeats upstream content instead of linking to it. (Per the method: "the introduction of any
    stage document is extremely short: rather than repeating the upstream content, it is just one
    introductory sentence and a link upstream.")

-   **Scope violations**: content at the wrong stage level (e.g. implementation language named in
    a functional spec; UI layout details in a capability spec).

-   **Downstream deviation**: a downstream document contradicts a claim made in an upstream
    document.

-   **Layout issues**: no `README.md` at the repo root; stage docs not organized under `doc/`;
    stage directories missing numeric prefixes that would enforce sort order (e.g. `10_`, `20_`).

Severity tags:

-   **must fix** — a clear rule violation
-   **should fix** — deviation from recommended convention
-   **consider** — optional improvement appropriate to this project's scale

### 3d — Write the report

Create `.telescopic/` at the project root if it does not exist.

Write `.telescopic/report.md` with:

1.  A **Current state** table:

    | File | Stage | Notes |
    |---|---|---|
    | README.md | README | |
    | doc/10_capability_specification/spec.md | capability-spec | |

2.  A **Issues found** list, each tagged with severity (`must fix` / `should fix` / `consider`).

Then commit:

```
git add .telescopic/report.md
git commit -m "telescope: record analysis report"
```

## Step 4 — Propose and approve

Present the issues and a numbered proposed action list to the user. Order actions from least
disruptive to most (renames before reorganizations before new files before content rewrites).
Tag each with its severity.

Example:

```
1. [must fix] Shorten intro of doc/20_functional_specification/spec.md to one sentence + link to capability spec
2. [should fix] Rename doc/architecture/ → doc/30_architecture/ to add sort prefix
3. [consider] Create doc/10_capability_specification/ with a skeleton spec.md
```

Ask the user which actions to approve. Once confirmed, write the approved actions as a numbered
list in `.telescopic/todo.md`, then commit:

```
git add .telescopic/todo.md
git commit -m "telescope: record approved action list"
```

## Step 5 — Apply actions

Work through `.telescopic/todo.md` from item 1 downward.

For each item:

1.  Apply the change (rename, create file, move section, shorten intro, etc.).
2.  Commit the change with a descriptive message (e.g. `Shorten functional spec intro to one sentence`).
3.  Remove that item from `.telescopic/todo.md`.
4.  Commit the updated todo with:
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
