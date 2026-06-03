# dotclaude

My personal [Claude Code](https://claude.com/claude-code) configuration — skills,
agents, commands, and global instructions — versioned and synced across machines.

This is an **allowlist** repo: it contains *only* the files I choose to publish.
My live `~/.claude` directory holds credentials and gigabytes of regenerable state
(`projects/`, `plugins/`, `sessions/`, caches) that are deliberately **not** here.

## Layout

```
CLAUDE.md               # global behavioral instructions
statusline-command.sh   # custom statusline (Oh My Zsh robbyrussell style)
skills/                 # personal skills (one dir per skill, each with SKILL.md)
agents/                 # personal subagents (empty for now)
commands/               # personal slash commands (empty for now)
install.sh              # symlinks the above into ~/.claude
```

## Install on a new machine

```sh
git clone <this-repo> ~/Development/dotclaude
cd ~/Development/dotclaude
./install.sh
```

`install.sh` symlinks each tracked item into `~/.claude`. It backs up any existing
real file to `<name>.bak` first and is safe to re-run (idempotent). It links skills
**per-directory**, so third-party skills already installed in `~/.claude/skills`
(plugins, marketplace clones) are left untouched.

## Adding a new skill

1. Create `skills/<name>/SKILL.md` here.
2. Run `./install.sh` to link it into `~/.claude/skills/<name>`.
3. Commit and push.

## Deliberately excluded

- **Secrets** — `.credentials.json` (OAuth tokens). Never committed.
- **Machine state** — `projects/`, `plugins/`, `telemetry/`, `sessions/`,
  `history.jsonl`, caches. Regenerable; not config.
- **`settings.json`** — kept local: it's rewritten programmatically and contains
  machine-specific absolute paths.
- **Third-party / company skills** — installed from marketplaces or internal to
  my work; they belong to their upstreams, not here.
