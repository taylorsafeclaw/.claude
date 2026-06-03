#!/usr/bin/env bash
# Symlink this repo's Claude Code config into ~/.claude.
# Safe & idempotent: an existing real file/dir is backed up to <name>.bak
# before linking; an already-correct symlink is left untouched.
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="${HOME}/.claude"

link() {
  local src="$1" dst="$2"
  if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
    echo "ok      $dst"
    return
  fi
  if [ -e "$dst" ] || [ -L "$dst" ]; then
    mv "$dst" "${dst}.bak"
    echo "backup  ${dst} -> ${dst}.bak"
  fi
  mkdir -p "$(dirname "$dst")"
  ln -s "$src" "$dst"
  echo "link    $dst -> $src"
}

# Top-level files
link "${REPO_DIR}/CLAUDE.md"             "${CLAUDE_DIR}/CLAUDE.md"
link "${REPO_DIR}/statusline-command.sh" "${CLAUDE_DIR}/statusline-command.sh"

# Per-item links so untracked third-party skills in ~/.claude are left alone
for kind in skills agents commands; do
  for item in "${REPO_DIR}/${kind}"/*/; do
    [ -d "$item" ] || continue
    link "${item%/}" "${CLAUDE_DIR}/${kind}/$(basename "$item")"
  done
done

echo "Done. Restart Claude Code if it was running."
