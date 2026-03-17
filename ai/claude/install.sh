#!/usr/bin/env bash
# Install Claude Code config: hooks, CLAUDE.md, and settings merge.
# Sourced by bootstrap.sh — expects backup_file() to be defined.

install_claude_config() {
  local claude_dir="$HOME/.claude"
  local source_dir="$DOTFILES_DIR/ai/claude"

  if [[ ! -d "$claude_dir" ]]; then
    echo "Claude Code not installed (~/.claude not found), skipping."
    return 0
  fi

  # Hooks dir: symlink ~/.claude/hooks -> dotfiles
  local hooks_target="$claude_dir/hooks"
  local hooks_source="$source_dir/hooks"
  if [[ -L "$hooks_target" ]] && [[ "$(readlink -f "$hooks_target")" == "$(readlink -f "$hooks_source")" ]]; then
    echo "Existing $hooks_target already links to dotfiles source."
  else
    [[ -e "$hooks_target" || -L "$hooks_target" ]] && backup_file "$hooks_target"
    rm -rf "$hooks_target"
    ln -s "$hooks_source" "$hooks_target"
    echo "Linked $hooks_target -> $hooks_source"
  fi

  # CLAUDE.md: symlink ~/.claude/CLAUDE.md -> dotfiles
  local claude_md_target="$claude_dir/CLAUDE.md"
  local claude_md_source="$source_dir/CLAUDE.md"
  if [[ -L "$claude_md_target" ]] && [[ "$(readlink -f "$claude_md_target")" == "$(readlink -f "$claude_md_source")" ]]; then
    echo "Existing $claude_md_target already links to dotfiles source."
  else
    [[ -e "$claude_md_target" || -L "$claude_md_target" ]] && backup_file "$claude_md_target"
    rm -f "$claude_md_target"
    ln -s "$claude_md_source" "$claude_md_target"
    echo "Linked $claude_md_target -> $claude_md_source"
  fi

  # Settings merge: merge settings-base.json into ~/.claude/settings.json
  local base_settings="$source_dir/settings-base.json"
  local target_settings="$claude_dir/settings.json"
  if ! command -v jq >/dev/null 2>&1; then
    echo "Warning: jq not found, skipping settings.json merge."
    return 0
  fi
  if [[ ! -f "$base_settings" ]]; then
    echo "Missing source file: $base_settings"
    return 0
  fi
  if [[ -f "$target_settings" ]]; then
    local merged
    merged="$(jq -s '.[0] * .[1]' "$target_settings" "$base_settings")"
    printf '%s\n' "$merged" > "$target_settings"
    echo "Merged portable settings into $target_settings"
  else
    cp "$base_settings" "$target_settings"
    echo "Created $target_settings from base settings"
  fi
}
