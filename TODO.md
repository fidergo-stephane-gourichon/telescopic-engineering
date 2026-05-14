Telescopic engineering: notes and open questions
================================================

ADR lifecycle: superseding and deleting
---------------------------------------

When a new ADR reverses a previous decision, the older ADR can be deleted (via `git rm`) provided the newer ADR:

1.  States in one sentence what the deleted ADR recorded, e.g.:

    > This supersedes now-deleted ADR 02, which recorded an older decision to report whole-disk device errors as-is (not suppress them).

2.  Explains why the decision was reversed.

The deleted ADR survives in git history and can be recovered if needed. The ADR directory then contains only currently-active decisions, which avoids a reader accidentally acting on a superseded one.

This practice was established while working on pmount_helper (May 2026), where ADR 02 was replaced by ADR 05.
