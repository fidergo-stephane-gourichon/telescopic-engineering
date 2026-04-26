Sync the telescopic skill after settled changes
===============================================

When changes in this repository are settled (committed and the user has signed off — not mid-edit, not exploratory drafts), run:

``` bash
cd ~/.claude/skills/telescopic && make sync_telescopic_engineering_from_origin_repository
```

This propagates the settled content to the `telescopic` skill, which embeds material from this repository.

**When to run**: after each settled change (typically after commit + user confirmation that the unit is done). Not on every intermediate edit.

**When not to run**: while a change is still being discussed, drafted, or revised.

**Remind the user when the time is coming.** When a unit of work approaches "settled" — discussed, approved, committed — proactively mention that the sync is due, so the user has the chance to ask for it before they close the conversation. The failure mode this guards against: user asks for a change, it gets approved and committed, the user closes the conversation, and the sync never happens. A short reminder ("ready to sync the telescopic skill when you are") is enough; the AI runs the sync only on the user's go-ahead.
