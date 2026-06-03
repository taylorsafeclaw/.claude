---
name: handoff
description: Use when you're about to /clear, end a session, or switch contexts but want a fresh session (or another agent) to continue the work. Triggers include planner→implementer or design→build switches, "save context for a new session", "prime a fresh session to run this", "hand this off", context getting heavy/bloated, or starting a parallel or unattended (AFK) run.
---

# Handoff

## Overview

A handoff captures the *slice* of context a fresh session needs to continue the work, in a small disposable document — so you can `/clear` and resume primed, or hand the work to another agent, worktree, or tool.

**Core principle: point, don't duplicate.** The durable record (plan, spec, ADR, ticket, code, commits) already exists. The handoff is glue that *references* those by path and states the one next action — never a copy of them. Write it from the receiver's point of view: "what would I need to pick this up cold?"

This is tool- and project-agnostic. It is not tied to any particular planning skill or workflow.

## When to use

- You're about to `/clear` or end the session, but the work isn't finished.
- Switching roles: planner → implementer, design → build, research → execution.
- Context has grown heavy and answers are degrading; a fresh session would be smarter.
- Fanning out to parallel sessions, or kicking off an unattended/AFK run.
- Passing the work to a different agent or a different tool.

**When NOT to use:** if you want to keep working in the *same* thread with a compressed history, that's `/compact` (a lossy summary that keeps you in place). Handoff is for *moving on* — a new session primed for a specific next task.

| | Handoff | Compact |
|---|---|---|
| Intent | Move on to a fresh session/agent | Stay in this thread, compressed |
| Context | Curated slice for the receiver | Lossy summary of everything |
| This session | Ended deliberately | Continues in place |

## The handoff document

Write these sections. Keep each tight; link out for anything long.

- **Objective** — the one thing the next session must accomplish, stated directly.
- **Next action** — the single concrete first step, written literally (e.g. "run Task 1 of `path/to/plan.md`", or "reproduce the bug in `src/foo.ts` then write a failing test"). This is the priming lever; it's what makes the receiver *ready to act*, not just informed.
- **Pointers** — paths/URLs to the durable artifacts: plan, spec, ticket, key files, relevant commits. Do **not** paste their contents.
- **Constraints & decisions** — non-obvious rules, choices already locked in, things to avoid. One line each.
- **State** — what's done, files changed, current test/build status; what was tried that worked, and what failed (so it isn't retried).
- **Suggested next step** — name any skill, command, or tool the next session should invoke immediately, IF one applies. Omit if none.
- **Open questions** — unresolved decisions, and for each, whether it blocks the next action or can wait.

**Redact secrets** — strip API keys, tokens, passwords, and PII before saving.

Curate ruthlessly: do not dump your full reasoning chain. The receiver treats whatever you transfer as *current* context, so transferred history competes with the actual task.

## Where to save

Save to a `handoffs` folder in the OS temp directory: `${TMPDIR:-/tmp}/handoffs/<YYYY-MM-DD>-<short-slug>.md`. Create the folder if it doesn't exist. These are disposable working docs that never touch the repo or git history — the durable record is the plan/spec/ticket the handoff points to.

Always tell the user the exact path. (Temp files may be cleared on reboot; that's fine — regenerate from the still-current artifacts if needed.)

## Resuming

No separate skill is needed. In the fresh session, point at the file:

> Read `<temp-dir>/handoffs/<file>` and continue.

The document's **Objective** + **Next action** + **Suggested next step** prime the session to act immediately.

## Common mistakes

| Mistake | Fix |
|---|---|
| Dumping the full reasoning chain / whole transcript | Curate only the slice the receiver needs; transferred history is read as live context. |
| Copying the plan/spec/ticket into the handoff | Reference it by path. Duplicated content drifts and bloats. |
| Vague "next steps: continue the work" | State ONE concrete first action, literally. |
| Saving into `docs/`, the repo, or committing the handoff | Save to the OS temp dir; the durable artifacts are the source of truth, not the handoff. |
| Leaving secrets in the doc | Redact keys/tokens/PII before writing. |
| Writing it after the session has gone cold | Write it while the context is still live. |
| Assuming a specific workflow/skill exists | Suggest a next step only if one genuinely applies; keep it generic otherwise. |
