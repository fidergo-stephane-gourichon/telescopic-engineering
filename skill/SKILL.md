---
name: telescopic
description: Apply the telescopic engineering method to a project. Practically it may mean either restructure existing documentation (survey a project's documentation, map it to telescopic-engineering stages, identify gaps and violations, and propose concrete improvements), build upon it or any other task depending on user input.  Tracks progress in .telescopic/ so work survives across sessions.
argument-hint: "[intent]"
---

Telescopic
==========

Applies the telescopic engineering method to a project's progress.

The *default behavior* of this skill focuses on documentation: surveys existing docs, maps them to stages, identifies gaps and rule violations, proposes ordered changes, and applies them one at a time with commits. Progress is stored in `.telescopic/` so work survives across sessions and conversations.

Step 0 -- Heed user intent
--------------------------

If `$ARGUMENTS` is non-empty it's probably a hint about the user's intent, follow it. Else the conversation context might have hints about user intents, wishes and interaction/approval style.

The user intent may easily totally override the *default behavior* of this skill. For example, the user mentions they want to add feature foo or whatever.

Step 1 -- Read the method reference
-----------------------------------

Read these files in all cases. They are the authoritative reference for the telescopic engineering method:

- [stage definitions and rules](../../.claude/skills/telescopic/docs/20_detailed_description.md)
- [FAQ including the recommended `doc-telescopic/` layout](../../.claude/skills/telescopic/docs/30_faq.md)
- [catalog of README sections](../../.claude/skills/telescopic/docs/20_detailed_description/readme_writing.md)

Step 2 -- Act
-------------

Only if the user did not express any intent, or their intent looks like an "analyze-and-report", then read and proceed with [analyze_and_report.md](analyze_and_report.md).

In other cases, the invocation of the skill serves one purpose: to ensure the method reference is kept in mind and applied to whatever task the user expresses.
