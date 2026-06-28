# Codex Setup

This directory is the tracked Codex handoff for a fresh machine. It should tell
an agent what to configure and where to look, without freezing the exact current
Codex config field names in this repo.

## What This Repo Owns

- `install.sh` links the shared agent guidance into the Codex runtime home when
  `bootstrap.sh` runs.
- `../AGENTS.md` is the shared durable working agreement exposed to Codex as
  global guidance.
- `../skills/` is the tracked Codex user-skill source. `install.sh` links it to
  `~/.agents/skills`, which is Codex's documented user-skill discovery path.
- This README is the setup checklist for agents configuring Codex on a new
  machine.

## Runtime State

Codex runtime config and state live outside this repo. The active runtime home is
the `CODEX_HOME` environment variable when it is set; otherwise use Codex's
documented default. `install.sh` uses that same runtime-home resolution when
linking `AGENTS.md`. Treat files there as mutable runtime/user config.

Codex user skills are source-like and are tracked here under `../skills/`.
Bootstrap links `~/.agents/skills` to that directory so local skill edits in
dotfiles are visible to fresh Codex sessions without copying.

Do not track Codex auth, sessions, logs, caches, generated state, or copied
config snippets in dotfiles. This repo should track the procedure and the links
to current documentation, not stale TOML.

## Agent Setup Checklist

When asked to set up Codex on one of my machines:

1. Run or inspect `~/dotfiles/bootstrap.sh` first so the shared agent guidance is
   linked into the active Codex runtime home and `~/.agents/skills` points at
   `~/dotfiles/ai/skills`.
2. Detect the active Codex runtime home from the environment and confirm which
   config file Codex is reading.
3. Inspect the current config before editing it, and preserve unrelated local
   values such as model choice, notification hooks, features, provider settings,
   and project entries.
4. Consult the official Codex docs for the current config syntax before changing
   permissions or reviewer behavior.
5. Configure the concepts I normally want for local development: trusted project
   entries for intended worktrees, a sandbox or permission profile suitable for
   editing the active workspace, an approval policy that defines when
   boundary-crossing actions are reviewed, an automatic reviewer for eligible
   approval requests, and narrow writable roots or command rules only when a
   repeated workflow needs them.
6. Start a fresh Codex session and verify the resulting status before calling
   the setup complete.

Remember that automatic review is a reviewer choice, not a broader permission
grant. If the sandbox, workspace roots, or network policy block something, the
right fix is usually to adjust that boundary deliberately, not to rely on the
reviewer to approve the same noisy escalation forever.

## Official References

- Codex config basics: https://developers.openai.com/codex/config-basic
- Advanced Codex configuration: https://developers.openai.com/codex/config-advanced
- Agent approvals and sandboxing: https://developers.openai.com/codex/agent-approvals-security
- Auto-review: https://developers.openai.com/codex/concepts/sandboxing/auto-review
- Permission profiles: https://developers.openai.com/codex/permissions
- Customization and agent guidance: https://developers.openai.com/codex/concepts/customization
- Codex skills: https://developers.openai.com/codex/skills
