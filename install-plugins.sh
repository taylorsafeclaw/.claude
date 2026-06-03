#!/usr/bin/env bash
# Reinstall the Claude Code plugins I use, on a new machine.
# This is the manifest: it records WHICH plugins I run, not their content
# (the content lives upstream and stays current). Re-runnable.
#
# The official marketplace (anthropics/claude-plugins-official) is built in,
# so its plugins just need installing. Only extra marketplaces need adding.
set -uo pipefail

# --- Extra (non-default) marketplaces ---
# Not currently the source of any enabled plugin below, but part of my setup.
claude plugin marketplace add openai/codex-plugin-cc || true

# --- Enabled plugins (all from the built-in official marketplace) ---
# Note: frontend-design is intentionally NOT here — I run my own fork from
# skills/frontend-design/ in this repo, so the marketplace plugin is disabled.
for p in \
  superpowers \
  posthog \
  plugin-dev \
  supabase \
  code-simplifier \
  swift-lsp \
; do
  echo "==> installing ${p}@claude-plugins-official"
  claude plugin install "${p}@claude-plugins-official" || echo "  (skipped/failed: ${p})"
done

echo "Done. Restart Claude Code to load the plugins."
