#!/usr/bin/env sh

if [ "${DOTFILES_ENV_LOADED_PID:-}" = "$$" ]; then
  return 0 2>/dev/null || exit 0
fi

DOTFILES_ENV_LOADED_PID=$$

if [ -z "${DOTFILES_DIR:-}" ] || [ ! -d "$DOTFILES_DIR" ]; then
  for candidate in "$HOME/dotfiles" "/workspace/dotfiles"; do
    if [ -d "$candidate" ]; then
      DOTFILES_DIR="$candidate"
      break
    fi
  done
fi
export DOTFILES_DIR

prepend_path() {
  [ -n "$1" ] || return 0
  case ":$PATH:" in
    *":$1:"*) ;;
    *) PATH="$1${PATH:+:$PATH}" ;;
  esac
}

source_if_exists() {
  [ -r "$1" ] && . "$1"
}

sanitize_profile_name() {
  printf '%s' "$1" | tr '[:upper:]' '[:lower:]' | sed 's/\..*$//; s/[^a-z0-9._-]/-/g'
}

XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
if [ "$XDG_CONFIG_HOME" = "$DOTFILES_DIR" ]; then
  XDG_CONFIG_HOME="$HOME/.config"
fi
XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
export XDG_CONFIG_HOME XDG_CACHE_HOME XDG_STATE_HOME

default_dotfiles_state_dir="$XDG_CONFIG_HOME/dotfiles"
legacy_dotfiles_state_dir="$DOTFILES_DIR/dotfiles"

if [ -z "${DOTFILES_STATE_DIR:-}" ] || [ "$DOTFILES_STATE_DIR" = "$legacy_dotfiles_state_dir" ]; then
  DOTFILES_STATE_DIR="$default_dotfiles_state_dir"
fi

if [ -z "${DOTFILES_PROFILE_FILE:-}" ] || [ "$DOTFILES_PROFILE_FILE" = "$legacy_dotfiles_state_dir/profile" ]; then
  DOTFILES_PROFILE_FILE="$DOTFILES_STATE_DIR/profile"
fi
export DOTFILES_STATE_DIR DOTFILES_PROFILE_FILE

if [ -z "${DOTFILES_MACHINE_PROFILE:-}" ] && [ -r "$DOTFILES_PROFILE_FILE" ]; then
  DOTFILES_MACHINE_PROFILE=$(sed -n '1p' "$DOTFILES_PROFILE_FILE")
fi

if [ -z "${DOTFILES_MACHINE_PROFILE:-}" ]; then
  host_name=$(hostname -s 2>/dev/null || hostname 2>/dev/null || printf 'local')
  DOTFILES_MACHINE_PROFILE=$(sanitize_profile_name "$host_name")
fi
export DOTFILES_MACHINE_PROFILE

source_if_exists "$DOTFILES_DIR/profiles/common.sh"
source_if_exists "$DOTFILES_DIR/profiles/$DOTFILES_MACHINE_PROFILE.sh"
source_if_exists "$DOTFILES_DIR/profiles/local.sh"

CACHE_ROOT="${CACHE_ROOT:-$XDG_CACHE_HOME}"
DATA_ROOT="${DATA_ROOT:-$HOME/.local/share}"
STATE_ROOT="${STATE_ROOT:-$XDG_STATE_HOME}"
OMZ_DIR="${OMZ_DIR:-$HOME/.oh-my-zsh}"
CONDA_ROOT="${CONDA_ROOT:-$HOME/miniconda3}"
NVM_DIR="${NVM_DIR:-$HOME/.nvm}"
DOTFILES_NVIM_CONFIG_DIR="${DOTFILES_NVIM_CONFIG_DIR:-$DOTFILES_DIR/nvim}"
DOTFILES_HTOPRC="${DOTFILES_HTOPRC:-$DOTFILES_DIR/htoprc}"
UV_CACHE_DIR="${UV_CACHE_DIR:-$CACHE_ROOT/uv}"
HF_HOME="${HF_HOME:-$DATA_ROOT/huggingface}"
HTOPRC="${HTOPRC:-$DOTFILES_HTOPRC}"
export CACHE_ROOT DATA_ROOT STATE_ROOT OMZ_DIR CONDA_ROOT NVM_DIR
export DOTFILES_NVIM_CONFIG_DIR DOTFILES_HTOPRC UV_CACHE_DIR HF_HOME HTOPRC

[ -d "$HOME/.local/bin" ] && prepend_path "$HOME/.local/bin"
[ -d "$HOME/.opencode/bin" ] && prepend_path "$HOME/.opencode/bin"
[ -d "$CONDA_ROOT/bin" ] && prepend_path "$CONDA_ROOT/bin"

if [ -n "${PATH_PREPENDS:-}" ]; then
  old_ifs=$IFS
  IFS=:
  for dir in $PATH_PREPENDS; do
    [ -d "$dir" ] && prepend_path "$dir"
  done
  IFS=$old_ifs
fi

source_if_exists "$HOME/.local/bin/env"
source_if_exists "$HOME/.cargo/env"

export PATH
