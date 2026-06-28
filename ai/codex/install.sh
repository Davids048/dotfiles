#!/usr/bin/env bash
# Install Codex agent instructions and user skills.
# Sourced by bootstrap.sh; expects backup_file() and move_aside() to be defined.

install_codex_agents() {
  : "Link Codex guidance and user skills from dotfiles into runtime discovery paths."
  local default_codex_dir="$HOME/.codex"
  local codex_dir="${CODEX_HOME:-$default_codex_dir}"
  local source_file="$DOTFILES_DIR/ai/AGENTS.md"
  local target_file="$codex_dir/AGENTS.md"
  local skills_source="$DOTFILES_DIR/ai/skills"
  local agents_dir="$HOME/.agents"
  local skills_target="$agents_dir/skills"
  local current_target

  if [[ -n "${CODEX_HOME:-}" && "$codex_dir" != "$default_codex_dir" ]]; then
    echo "Warning: CODEX_HOME is set to $codex_dir; linking Codex guidance there instead of $default_codex_dir."
  fi

  if [[ -f "$source_file" ]]; then
    mkdir -p "$codex_dir"

    current_target=""
    if [[ -L "$target_file" ]]; then
      current_target="$(readlink -f "$target_file" 2>/dev/null || true)"
    fi

    if [[ "$current_target" == "$source_file" ]]; then
      echo "Existing $target_file already links to dotfiles source."
    else
      if [[ -f "$target_file" && -s "$target_file" ]]; then
        backup_file "$target_file"
        echo "Backed up existing $target_file before linking."
      elif [[ -e "$target_file" && ! -L "$target_file" ]]; then
        move_aside "$target_file"
      fi

      [[ -e "$target_file" || -L "$target_file" ]] && rm -f "$target_file"
      ln -s "$source_file" "$target_file"
      echo "Linked $target_file -> $source_file"
    fi
  else
    echo "Missing source file: $source_file"
  fi

  if [[ -d "$skills_source" ]]; then
    mkdir -p "$agents_dir"

    current_target=""
    if [[ -L "$skills_target" ]]; then
      current_target="$(readlink -f "$skills_target" 2>/dev/null || true)"
    fi

    if [[ "$current_target" == "$skills_source" ]]; then
      echo "Existing $skills_target already links to dotfiles source."
    else
      if [[ -L "$skills_target" ]]; then
        backup_file "$skills_target"
        rm -f "$skills_target"
      elif [[ -e "$skills_target" ]]; then
        move_aside "$skills_target"
      fi

      ln -s "$skills_source" "$skills_target"
      echo "Linked $skills_target -> $skills_source"
    fi
  else
    echo "Missing Codex skills source directory: $skills_source"
  fi
}
