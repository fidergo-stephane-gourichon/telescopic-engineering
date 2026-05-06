SKILL_DIR := $(HOME)/.claude/skills/telescopic
# realpath resolves symlinks, so this works whether invoked from the repo root
# or via the ~/.claude/skills/telescopic/Makefile symlink.
REPO_ROOT := $(realpath $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))

.PHONY: install uninstall

install:
	mkdir -p $(SKILL_DIR)
	ln -sfn $(REPO_ROOT) $(SKILL_DIR)/docs
	ln -sf docs/skill/SKILL.md $(SKILL_DIR)/SKILL.md
	ln -sf docs/Makefile $(SKILL_DIR)/Makefile

uninstall:
	rm -f $(SKILL_DIR)/docs $(SKILL_DIR)/SKILL.md $(SKILL_DIR)/Makefile
	-rmdir $(SKILL_DIR) 2>/dev/null || true
