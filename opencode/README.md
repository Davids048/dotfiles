# OpenCode configuration

This directory is the tracked OpenCode config for this machine.

## Install / symlink

OpenCode reads global config from `~/.config/opencode`, not from `~/.opencode`.
Point that path at this repo directory:

```sh
mkdir -p ~/.config
ln -sfn ~/dotfiles/opencode ~/.config/opencode
```

Current active path:

- `~/.config/opencode` -> `/home/hal-jundas/dotfiles/opencode`
- local OpenCode install prefix: `~/.opencode` (`~/.opencode/bin/opencode` and package dependencies only; no config)

After changing `opencode.json`, agent files, skills, commands, or plugins, quit and restart OpenCode. Config is loaded at startup and is not hot-reloaded.

## Main config

- Main config: `opencode.json`
- Schema: `https://opencode.ai/config.json`
- `default_agent`: `team-lead`
- Inline agents in `opencode.json`: `team-lead`, `build`, `explore`, `general`
- File-based agents in `agents/`: `build.md`, `oracle.md`, `pr-sync-reviewer.md`
- Command: `commands/apply-karpathy-guidelines.md`
- Local skill: `skills/karpathy-guidelines/SKILL.md`
- External skills are auto-discovered from `~/.agents/skills`, currently symlinked to `~/dotfiles/agents/skills`

External skill directories currently include: `caveman`, `diagnose`, `find-skills`, `grill-me`, `grill-with-docs`, `handoff`, `improve-codebase-architecture`, `prototype`, `setup-matt-pocock-skills`, `tdd`, `to-issues`, `to-prd`, `triage`, `write-a-skill`, and `zoom-out`.

## Plugins

Configured in `opencode.json`:

- Team plugin: `file:///home/hal-jundas/opencode-team-plugin/src/index.ts`
  - Options: `stateRoot` is `/home/hal-jundas/.local/share/opencode-team-plugin`
  - External agents dir: `/home/hal-jundas/.config/opencode-team-plugin/agents` (optional; absent during audit)
  - Dashboard summary and TUI dashboard are enabled by the plugin

Configured in `tui.json`:

- Team TUI plugin: `file:///home/hal-jundas/opencode-team-plugin/src/opencode-tui-plugin.ts`
  - This is the same team plugin repository as above. OpenCode loads server
    plugins and TUI plugins from separate config files/entrypoint shapes, so the
    repo has one plugin implementation with separate server and TUI entrypoints.
  - Options: `stateRoot` is `/home/hal-jundas/.local/share/opencode-team-plugin`,
    matching the server plugin.

Auto-discovered from this config directory:

- `plugin/oav-observer.ts`
  - Posts session, tool, and permission events to `OPENCODE_AGENT_VIEW_URL` or `http://127.0.0.1:47632`
  - Optional integration; failures are ignored
- `plugins/notification.ts`
  - Sends terminal/tmux OSC notifications for `session.idle` and `permission.asked`

## Tracked config vs runtime state

Tracked here:

- `opencode.json`, `tui.json`
- agent files under `agents/`
- command files under `commands/`
- local skills under `skills/`
- plugins under `plugin/` and `plugins/`
- documentation such as this README

Not tracked / runtime only:

- OpenCode auth and state: `~/.local/share/opencode`
- Team plugin state: `~/.local/share/opencode-team-plugin`
- OpenCode install/package prefix: `~/.opencode`
- package caches: `~/.cache/opencode`
- `opencode/node_modules`, `opencode/package.json`, `opencode/package-lock.json`, `opencode/bun.lock`
- backup files matching `opencode/*.backup-*`

The repo `.gitignore` excludes `opencode/package-lock.json` and `opencode/*.backup-*`; `opencode/.gitignore` excludes local package-manager artifacts in this directory.

## Permissions and secrets

- Do not read, print, stage, or commit token values.
- Do not read secret-bearing `.env` files. `.env.example` files are documentation and may be read.
- Auth lives outside the repo at `~/.local/share/opencode/auth.json`; it may contain OpenAI and Anthropic credentials and must not be inspected or copied.
- Runtime/state directories listed above are intentionally outside this repo.
- Several agent permission blocks allow routine local work but require approval for sensitive shell actions such as `git push`, destructive git cleanup/reset, `rm -rf`, `sudo`, shutdown, and reboot.

## Setup checklist for another agent

1. Ensure this repo is at `/home/hal-jundas/dotfiles` or adjust absolute paths in `opencode.json` and `tui.json`.
2. Create the symlink: `~/.config/opencode -> /home/hal-jundas/dotfiles/opencode`.
3. Ensure `/home/hal-jundas/opencode-team-plugin` exists if team features are needed.
4. Ensure external skills are available under `~/.agents/skills` if the listed skills are expected.
5. Keep credentials in OpenCode's auth store or environment, never in this repo.
6. Restart OpenCode after any config, agent, skill, command, or plugin change.
