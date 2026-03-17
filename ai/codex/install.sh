#!/usr/bin/env bash
# Install Codex agents config.
# Sourced by bootstrap.sh — expects backup_file() to be defined.

install_codex_agents() {
  local codex_dir="$HOME/.codex"
  local source_file="$DOTFILES_DIR/ai/codex/AGENTS.md"
  local target_file="$codex_dir/AGENTS.md"

  if [[ ! -d "$codex_dir" ]]; then
    return 0
  fi

  if [[ ! -f "$source_file" ]]; then
    echo "Missing source file: $source_file"
    return 0
  fi

  if [[ -L "$target_file" ]] && [[ "$(readlink -f "$target_file")" == "$source_file" ]]; then
    echo "Existing $target_file already links to dotfiles source."
    return 0
  fi

  if [[ -f "$target_file" && -s "$target_file" ]]; then
    backup_file "$target_file"
    echo "Backed up existing $target_file before linking."
  fi

  [[ -e "$target_file" ]] && rm -f "$target_file"
  mkdir -p "$codex_dir"
  ln -s "$source_file" "$target_file"
  echo "Linked $target_file -> $source_file"
}
