#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"
RUNTIME_CONFIG_HOME="${DOTFILES_RUNTIME_CONFIG_HOME:-${XDG_CONFIG_HOME:-$HOME/.config}}"
if [[ "$RUNTIME_CONFIG_HOME" == "$DOTFILES_DIR" ]]; then
  RUNTIME_CONFIG_HOME="$HOME/.config"
fi
PROFILE_FILE="$RUNTIME_CONFIG_HOME/dotfiles/profile"
LOCAL_PROFILE="$DOTFILES_DIR/profiles/local.sh"

if [[ ! -d "$DOTFILES_DIR" ]]; then
  echo "dotfiles repo not found at $DOTFILES_DIR" >&2
  exit 1
fi

backup_root="$HOME/.dotfiles-backups/$(date +%Y%m%d-%H%M%S)"

prompt_yes_no() {
  local prompt="$1"
  local default="${2:-Y}"
  local reply

  if [[ "$default" == "Y" ]]; then
    read -r -p "$prompt [Y/n] " reply || true
    reply="${reply:-Y}"
  else
    read -r -p "$prompt [y/N] " reply || true
    reply="${reply:-N}"
  fi

  [[ "$reply" =~ ^[Yy]$ ]]
}

backup_file() {
  local target="$1"
  if [[ -e "$target" || -L "$target" ]]; then
    mkdir -p "$backup_root"
    cp -a "$target" "$backup_root/"
    echo "Backed up $target -> $backup_root/"
  fi
}

write_stub() {
  local target="$1"
  local content="$2"
  backup_file "$target"
  mkdir -p "$(dirname "$target")"
  printf '%s\n' "$content" >"$target"
}

choose_profile() {
  local profiles=()
  local profile_file profile_name existing default_profile choice
  local idx default_index

  while IFS= read -r profile_file; do
    profile_name="${profile_file##*/}"
    profile_name="${profile_name%.sh}"
    profiles+=("$profile_name")
  done < <(find "$DOTFILES_DIR/profiles" -maxdepth 1 -type f -name '*.sh' ! -name 'common.sh' ! -name 'local.sh' | sort)

  if [[ -f "$PROFILE_FILE" ]]; then
    existing="$(sed -n '1p' "$PROFILE_FILE")"
  else
    existing="$(hostname -s 2>/dev/null | sed 's/\..*$//')"
  fi
  default_profile="${existing:-local}"
  default_index=$((${#profiles[@]} + 1))

  for idx in "${!profiles[@]}"; do
    if [[ "${profiles[idx]}" == "$default_profile" ]]; then
      default_index=$((idx + 1))
      break
    fi
  done

  printf 'Available machine profiles:\n' >&2
  idx=1
  for profile_name in "${profiles[@]}"; do
    printf '  %s) %s\n' "$idx" "$profile_name" >&2
    ((idx+=1))
  done
  printf '  %s) local-only override\n' "$idx" >&2
  printf '\nCurrent profile: %s\n' "$default_profile" >&2

  while true; do
    read -r -p "Select profile [$default_index]: " choice || true
    choice="${choice:-$default_index}"

    if [[ "$choice" =~ ^[0-9]+$ ]]; then
      if (( choice >= 1 && choice <= ${#profiles[@]} )); then
        printf '%s\n' "${profiles[choice-1]}"
        return 0
      fi
      if (( choice == ${#profiles[@]} + 1 )); then
        printf '%s\n' "local"
        return 0
      fi
    fi

    if [[ " ${profiles[*]} " == *" $choice "* ]]; then
      printf '%s\n' "$choice"
      return 0
    fi

    if [[ "$choice" == "local" ]]; then
      printf '%s\n' "local"
      return 0
    fi

    printf 'Invalid selection: %s\n' "$choice" >&2
  done
}

ensure_local_profile() {
  if [[ -f "$LOCAL_PROFILE" ]]; then
    return 0
  fi

  mkdir -p "$(dirname "$LOCAL_PROFILE")"
  cat >"$LOCAL_PROFILE" <<'EOF'
# Untracked machine-local overrides.
# Example:
# CACHE_ROOT="/workspace/.cache"
# DATA_ROOT="/workspace/data"
# HF_HOME="/workspace/huggingface"
# CONDA_ROOT="$HOME/miniconda3"
# export CACHE_ROOT DATA_ROOT HF_HOME CONDA_ROOT
EOF
  echo "Created $LOCAL_PROFILE"
}

ensure_runtime_links() {
  mkdir -p "$RUNTIME_CONFIG_HOME" "$RUNTIME_CONFIG_HOME/htop"
  ln -sfn "$DOTFILES_DIR/nvim" "$RUNTIME_CONFIG_HOME/nvim"
  ln -sfn "$DOTFILES_DIR/htoprc" "$RUNTIME_CONFIG_HOME/htop/htoprc"
  echo "Linked ~/.config/nvim and ~/.config/htop/htoprc"
}

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

  if [[ -f "$target_file" && -s "$target_file" ]]; then
    echo "Existing $target_file is not empty. Skipping automatic install."
    echo "To install the dotfiles version manually, run:"
    echo "  cp \"$source_file\" \"$target_file\""
    return 0
  fi

  mkdir -p "$codex_dir"
  cp -f "$source_file" "$target_file"
  echo "Installed $target_file from $source_file"
}

tool_present() {
  local tool="$1"
  case "$tool" in
    nvim)
      command -v nvim >/dev/null 2>&1 || [[ -x "$DOTFILES_DIR/nvim-linux-x86_64.appimage" ]]
      ;;
    *)
      command -v "$tool" >/dev/null 2>&1
      ;;
  esac
}

offer_install() {
  local tool="$1"

  case "$tool" in
    yazi)
      if command -v cargo >/dev/null 2>&1 && prompt_yes_no "Install yazi with cargo?" Y; then
        cargo install --locked yazi-fm yazi-cli
      else
        echo "Skipping yazi. Manual option: install Rust, then run 'cargo install --locked yazi-fm yazi-cli'."
      fi
      ;;
    rg)
      if command -v cargo >/dev/null 2>&1 && prompt_yes_no "Install ripgrep with cargo?" Y; then
        cargo install ripgrep
      else
        echo "Skipping ripgrep. Manual option: install via cargo or your package manager."
      fi
      ;;
    fzf)
      if command -v git >/dev/null 2>&1 && [[ ! -d "$HOME/.fzf" ]] && prompt_yes_no "Install fzf into ~/.fzf?" Y; then
        git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
        "$HOME/.fzf/install" --all
      else
        echo "Skipping fzf. Manual option: install via ~/.fzf or your package manager."
      fi
      ;;
    nvim)
      echo "Neovim not found. Current fallback expects $DOTFILES_DIR/nvim-linux-x86_64.appimage or a system/user-local nvim install."
      ;;
    tmux|zsh)
      echo "$tool is missing. Bootstrap will not build it user-locally; install it manually or via your package manager."
      ;;
  esac
}

main() {
  local selected_profile
  local zshenv_stub zshrc_stub bashrc_stub vimrc_stub tmux_stub git_stub

  selected_profile="$(choose_profile)"
  mkdir -p "$(dirname "$PROFILE_FILE")"
  printf '%s\n' "$selected_profile" >"$PROFILE_FILE"
  echo "Selected profile: $selected_profile"

  if [[ "$selected_profile" == "local" ]]; then
    ensure_local_profile
  fi

  if prompt_yes_no "Rewrite home entrypoint stubs for bash/zsh/vim/tmux/git?" Y; then
    zshenv_stub=$'export DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"\nif [ -r "$DOTFILES_DIR/.zshenv" ]; then\n  source "$DOTFILES_DIR/.zshenv"\nfi'
    zshrc_stub=$'export DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"\nif [ -r "$DOTFILES_DIR/.zshrc" ]; then\n  source "$DOTFILES_DIR/.zshrc"\nfi'
    bashrc_stub=$'export DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"\nif [ -r "$DOTFILES_DIR/.bashrc" ]; then\n  . "$DOTFILES_DIR/.bashrc"\nfi'
    vimrc_stub=$'if filereadable(expand("$HOME/dotfiles/.vimrc"))\n  source $HOME/dotfiles/.vimrc\nendif'
    tmux_stub='source-file ~/dotfiles/.tmux.conf'
    git_stub=$'[include]\n    path = ~/dotfiles/.gitconfig'
    write_stub "$HOME/.zshenv" "$zshenv_stub"
    write_stub "$HOME/.zshrc" "$zshrc_stub"
    write_stub "$HOME/.bashrc" "$bashrc_stub"
    write_stub "$HOME/.vimrc" "$vimrc_stub"
    write_stub "$HOME/.tmux.conf" "$tmux_stub"
    write_stub "$HOME/.gitconfig" "$git_stub"
    write_stub "$RUNTIME_CONFIG_HOME/git/config" "$git_stub"
  fi

  if prompt_yes_no "Link tracked Neovim and htop configs into ~/.config?" Y; then
    ensure_runtime_links
  fi

  install_codex_agents

  echo
  echo "Checking core tool availability..."
  local tools=(zsh tmux nvim fzf rg yazi)
  local tool
  for tool in "${tools[@]}"; do
    if tool_present "$tool"; then
      echo "  OK   $tool"
    else
      echo "  MISS $tool"
      offer_install "$tool"
    fi
  done

  echo
  echo "Bootstrap complete."
  echo "Profile file: $PROFILE_FILE"
  if [[ -d "$backup_root" ]]; then
    echo "Backups: $backup_root"
  fi
}

main "$@"
