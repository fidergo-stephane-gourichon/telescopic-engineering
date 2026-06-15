---
name: telescopic
description: Survey a project's documentation, map it to telescopic-engineering stages, identify gaps and violations, and propose concrete improvements. Tracks progress in .telescopic/ so work survives across sessions.
argument-hint: "[intent]"
---

Telescopic
==========

Apply the telescopic engineering method to a project's documentation. Surveys existing docs, maps them to stages, identifies gaps and rule violations, proposes ordered changes, and applies them one at a time with commits. Progress is stored in `.telescopic/` so work survives across sessions and conversations.

Step 0 — Heed user intent
-------------------------

If `$ARGUMENTS` is non-empty it's probably a hint about the user's intent, follow it. Else the conversation context might have hints about user intents, wishes and interaction/appoval style.

Step 1 — Check for prior work
-----------------------------

Check whether any files exist under `.telescopic/` at the project root. Any such file is a sign that prior analysis was done. If they exist, read them.

Then run this quick staleness hint:

``` bash
find . -type f -newer .telescopic/report.md ! -path './.git/*' ! -path './.telescopic/*' | head -10
```

Use the output as a hint, not a rule: if the files returned look like documentation (`.md`, `.rst`, `README`, etc.), staleness is likely. If they are unrelated build artifacts or source files, the prior analysis is probably still valid. When unsure, ask the user.

Based on the prior files and the staleness hint:

- If the prior work appears **still useful** and `.telescopic/todo.md` has pending items: display them and ask "Resume from this work list, or run a fresh analysis?"

  - If **resume**: skip to **Step 4 — Apply actions**.
  - If **fresh analysis**: proceed to Step 2.

- If the prior work appears **still useful** but no todo items remain: ask "Prior analysis exists. Continue from it, or run a fresh analysis?"

  - If **continue**: skip to **Step 4 — Propose and approve** using report.md as the basis.
  - If **fresh analysis**: proceed to Step 2.

- If the prior work appears **stale or no prior work exists**: proceed to Step 2.

Step 2 — Read the method reference
----------------------------------

Read these files before performing any analysis. They are the authoritative reference for the telescopic engineering method:

- `~/.claude/skills/telescopic/docs/20_detailed_description.md` — stage definitions and rules
- `~/.claude/skills/telescopic/docs/30_faq.md` — FAQ including the recommended `doc-telescopic/` layout
- `~/.claude/skills/telescopic/docs/20_detailed_description/readme_writing.md` — catalog of README sections

Step 3 — Full analysis
----------------------

### 3a — Inventory

List all documentation files tracked by git. A reliable starting point:

``` bash
git -c submodule.recurse=false ls-files | grep -E '\.(md|rst|txt|html)$'
```

The `-c submodule.recurse=false` prevents inadvertently expanding submodules. Adapt the filter as needed. Pay particular attention to:

- `.md`, `.rst`, `.txt` files at the root level
- Everything under `doc-telescopic/`, `doc/`, `docs/`, `documentation/` (recursively)
- Per-directory `README.md` files inside source trees (`src/`, `lib/`, etc.)

Record the exact command used in the **Analysis basis** section of the report.

### 3b — Classify

For each file, read its content (or at minimum its title and first few paragraphs) and assign it, if it fits fairly well, to one of these categories:

| Category             | What belongs here                                                                           |
|----------------------|---------------------------------------------------------------------------------------------|
| `README`             | Top-level pitch for a random visitor; each section stays concise                            |
| `capability-spec`    | What the system can do; no "how", no UI detail, no implementation                           |
| `functional-spec`    | Full external contract: features, UX, protocols, acceptance tests; no language/architecture |
| `architecture`       | Solution strategy, algorithms, sub-problem breakdown; technology-agnostic                   |
| `implementation-doc` | Language/stack choices, project-wide data structures, unit tests                            |
| `code-local`         | Per-directory README or per-file companion inside the source tree                           |
| `unclassified`       | Cannot be mapped to any stage                                                               |

### 3c — Identify issues

Flag *any* deviation from the telescopic engineering ideal as defined in the reference documents.

The enumeration below is only a suggestion of things to watch out for, not limitative:

- **Missing stages**: which of the six stage categories have no document. Note that `architecture` and `implementation-doc` may be intentionally absent for small or trivial projects — flag as "may be intentionally absent" rather than "missing".

- **Intro violations**: a stage document whose introduction repeats upstream content instead of linking to it, or is long enough to obscure what stage this document belongs to. The goal is clarity: the reader should immediately know where they are in the chain and where to go for more context. A single short sentence with an upstream link is the ideal; a second sentence that adds genuine navigation value (e.g. a downstream pointer) is acceptable and not a violation. Flag as a violation only when the intro is so long it reads like a summary, or when it restates content the upstream document already covers.

- **Scope violations**: content at the wrong stage level (e.g. implementation language named in a functional spec; UI layout details in a capability spec). Sometimes scopes are a little unclear. For example consider mentioning system integration aspects in a functional spec: for a program intended for a non-admin user this is clearly a violation, while for a program targetting a system administrator this may arguably be part of the "user experience" so fit in a functional spec. Use your judgment, in doubt mention it.

- **Downstream deviation**: a downstream document contradicts a claim made in an upstream document.

- **Layout issues**: no `README.md` at the repo root; stage docs not organized under `doc-telescopic/`; no `doc-telescopic.md` index beside a populated `doc-telescopic/`; stage directories missing numeric prefixes that would enforce sort order (e.g. `10_`, `20_`); a populated stage directory `foo/` without its sibling entry file `foo.md`, or vice versa where overflow exists but no directory has been created; a stage's main content placed inside the directory (e.g. `10_capability_specification/spec.md`) rather than as the sibling entry file (the obsolete pre-purification convention); a `decisions/` directory with records but no `decisions.md` index beside it, or a `decisions.md` lacking its convention-stating preamble; any deviation from [the filesystem structuration pattern](../20_detailed_description/filesystem_structuration_pattern.md).

Document the kind of violation: rule violation, recommendation violation, improvement.

A severity tag is a good addition, always guided by impact on consistency and clarity. Navigation is considered an important part of clarity.

For example:

- **must fix** — a document at one level contradicts another document at another level
- **should fix** — an aspect at one level does not reflect at the proper level of details at another level (or is even absent)
- **consider** — documents don't follow the canonical directory layout

### 3d — Write the report

Create `.telescopic/` at the project root if it does not exist.

**Linking convention for all generated files** (report.md, todo.md, declined.md): always link to the most precise location — prefer a section anchor over a bare file link whenever the target is a specific heading. Link text is a short human-readable label; URL uses the `../`-prefixed project-root-relative path with an `#anchor` suffix when applicable.

Write `.telescopic/report.md` with:

- A **header** containing: a mention that this report was generated by the "telescopic engineering skill", the date of analysis (e.g. `Generated: 2026-04-25T16:39:23+02:00` like the output of `date --iso-8601=s`) and the git revision (e.g. `Revision: ` followed by the output of `git describe --always --tags --dirty`)

- An **Analysis basis** section immediately after the header. This section is mandatory — omitting it makes the report's epistemic basis invisible. It must state:

  - How the file inventory was obtained (e.g. the exact `git grep` or `find` command used)
  - Which files were **read in full**
  - Which files were **skimmed** (title and first section only, or first N lines), with the extent noted
  - Which files were **not read** and why (e.g. binary, test data, generated output)

  The report's claims are implicitly bounded by what appears in this section. A reader must be able to tell, from this section alone, which conclusions could be affected by content that was not read.

- A **Current state** section grouping files by directory. Use judgment: files that naturally cluster together (e.g. all root-level files, all files under `doc-telescopic/`) share one table; avoid creating so many tables that the grouping becomes noise. Each section heading names the common directory prefix, and that prefix is stripped from all link texts in the table — keeping rows short and readable. The link URL still uses the full project-root-relative path prefixed with `../` (since `.telescopic/` is one level below the project root):

  ### Repo root

  | File                      | Stage  | Notes |
  |---------------------------|--------|-------|
  | [README.md](../README.md) | README |       |

  ### doc-telescopic/

  | File                                                                               | Stage           | Notes |
  |------------------------------------------------------------------------------------|-----------------|-------|
  | [10_capability_specification.md](../doc-telescopic/10_capability_specification.md) | capability-spec |       |
  | [20_functional_specification.md](../doc-telescopic/20_functional_specification.md) | functional-spec |       |

- A **Issues found** section. Have sub-section for each observed severity (`must fix` / `should fix` / `consider`). Consider another level of subsection for "kind of violation", unless it makes little sense. Then a bullet list of relevant issues. Apply the linking convention above: use a section anchor whenever possible (e.g. `[func spec § Introduction](../doc-telescopic/20_functional_specification.md#introduction)`); bare file link only when the issue spans the whole document.

Then commit:

``` default
git add .telescopic/report.md
git commit -m "telescopic: record analysis report"
```

Step 4 — Propose and approve
----------------------------

Invite the user to read the report. Propose an action list. Order actions from least disruptive to most (renames before reorganizations before new files before content rewrites).

If the existing documents are already clearly separated by stage and their contents match the desired structure closely enough, propose a rename/move plan as the first action — before any content edits. A rename/move plan groups all file relocations and cross-reference updates into a single proposal for the user to review and approve before anything is applied. The test: would an experienced reader recognize the existing document as clearly belonging to the target stage, with no significant scope violations? If yes, moving it is the right first step.

Ask the user which actions to approve. If the user declines or disagrees with any proposed action, record it in `.telescopic/declined.md` with a one-line summary of what was declined and, if the user gave a reason, the reason. Commit this file and tell the user its path so they can edit or remove the entry if they change their mind later. (The name avoids collision with stage-level `decisions.md` files, which record project decisions, not skill-proposal rejections.)

Once confirmed, write the approved actions as a bullet list in `.telescopic/todo.md`, then commit:

``` default
git add .telescopic/todo.md
git commit -m "telescopic: record approved action list"
```

Notice that the user may elect to express their wishes free-form into `.telescopic/todo.md`. Whatever they write there is what they want, then plan of action they want to be applied.

Step 5 — Apply actions
----------------------

Work through `.telescopic/todo.md` from top to bottom.

For each item:

- Apply the change (rename, create file, move section, shorten intro, etc.).
- Remove that item from `.telescopic/todo.md`.
- One unit of work, one commit, e.g.:
  ``` default
  git add 20_functional_specification.md .telescopic/todo.md ; git commit -m "telescopic: Shorten functional spec intro to one sentence"
  ```

When `.telescopic/todo.md` becomes empty, report completion and confirm that all approved changes have been applied.

Notes
-----

- **Link generously.** Whenever any part of the content refers to another part — an upstream stage, a sibling document, a decision record, a specific section — write an actual link to it, pointing at the most precise location available (a section anchor over a bare file link). Telescopic docs live by navigation: a reference left as plain prose is a missed connection. This applies to all content you author or edit, not only to the generated `.telescopic/` files.
- **Check links.** After writing, moving, or renaming content, verify every link resolves: the target file exists, and when an `#anchor` is used the matching heading exists. Fix broken links, or flag them if the fix is not obvious. Renames and section moves are the usual cause of breakage, so re-check links in any file that pointed *into* something you just moved.
- Never silently skip an issue. The user might be waiting for you to raise it. Always flag and let the user decide.
- When an action would move content between files, show the user a diff-style preview before applying.
- The method allows skipping or merging stages for small projects. When flagging a missing stage as "may be intentionally absent", suggest the lightweight option: a single-sentence acknowledgement file rather than a full document.
- Do not write numbered lists in a file (because numbers break whenever an item is inserted or deleted). Use stable IDs instead (e.g. initials of the main key words, or just a few key words).
