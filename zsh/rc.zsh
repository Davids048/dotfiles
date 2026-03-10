[[ -n "${DOTFILES_ZSH_RC_LOADED:-}" ]] && return 0
typeset -g DOTFILES_ZSH_RC_LOADED=1

if [[ -z "${DOTFILES_ENV_LOADED:-}" ]]; then
  source "${DOTFILES_DIR:-$HOME/dotfiles}/zsh/env.zsh"
fi

export ZSH="${OMZ_DIR:-$HOME/.oh-my-zsh}"
ZSH_THEME="${ZSH_THEME:-gnzh}"

plugins=(
  git
  z
  fzf
  zsh-autosuggestions
  zsh-syntax-highlighting
)

if [[ -r "$ZSH/oh-my-zsh.sh" ]]; then
  source "$ZSH/oh-my-zsh.sh"
fi

setopt histignorealldups
setopt sharehistory
setopt inc_append_history
setopt BASH_AUTO_LIST
bindkey -e

HISTSIZE=${HISTSIZE:-1000}
SAVEHIST=${SAVEHIST:-1000}
HISTFILE=${HISTFILE:-$HOME/.zsh_history}
export HISTSIZE SAVEHIST HISTFILE

autoload -Uz add-zsh-hook

if command -v dircolors >/dev/null 2>&1; then
  eval "$(dircolors -b)"
fi

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format ''
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt\ %p:\ Hit\ TAB\ for\ more,%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling\ active:\ current\ selection\ at\ %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose no
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

export EDITOR="${EDITOR:-nvim}"
export VISUAL="${VISUAL:-$EDITOR}"

if [[ -f ~/.bash_aliases ]]; then
  source ~/.bash_aliases
fi

if [[ -n "${ALTERNATE_NVIM_BIN:-}" && -x "$ALTERNATE_NVIM_BIN" ]]; then
  alias nvim="$ALTERNATE_NVIM_BIN"
fi

alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias nvitop="uvx nvitop"

if [[ -f "${FZF_SHELL_ZSH:-$HOME/.fzf.zsh}" ]]; then
  source "${FZF_SHELL_ZSH:-$HOME/.fzf.zsh}"
fi

if [[ -s "$NVM_DIR/nvm.sh" ]]; then
  source "$NVM_DIR/nvm.sh"
fi

if [[ -s "$NVM_DIR/bash_completion" ]]; then
  source "$NVM_DIR/bash_completion"
fi

if [[ -x "$CONDA_ROOT/bin/conda" ]]; then
  __dotfiles_conda_setup="$("$CONDA_ROOT/bin/conda" shell.zsh hook 2>/dev/null)"
  if [[ $? -eq 0 ]]; then
    eval "$__dotfiles_conda_setup"
  elif [[ -f "$CONDA_ROOT/etc/profile.d/conda.sh" ]]; then
    source "$CONDA_ROOT/etc/profile.d/conda.sh"
  fi
  unset __dotfiles_conda_setup
fi

typeset -g MONITOR_SECONDS="${MONITOR_SECONDS:-5}"
typeset -g DOTFILES_CMD_START_EPOCH=0
typeset -g DOTFILES_CMD_LINE=""

dotfiles_set_terminal_title() {
  if [[ -n "$SSH_CONNECTION" ]]; then
    printf '\033]0;%s@%s:%s\007' "$USER" "$HOST" "$PWD"
  else
    printf '\033]0;%s:%s\007' "${DOTFILES_MACHINE_NAME:-$HOST}" "$PWD"
  fi
}

dotfiles_title_precmd() {
  dotfiles_set_terminal_title
}

dotfiles_monitor_preexec() {
  DOTFILES_CMD_START_EPOCH=$EPOCHSECONDS
  DOTFILES_CMD_LINE=$1
}

dotfiles_notify_iterm2() {
  local msg="$1"

  if [[ -n "$TMUX" ]] && command -v tmux >/dev/null 2>&1; then
    local session tty
    session=$(tmux display -p '#{session_name}' 2>/dev/null)
    tty=$(tmux list-clients -t "$session" -F '#{client_tty}' 2>/dev/null | head -n 1)
    [[ -n "$tty" && -w "$tty" ]] && printf '\e]9;%s\a' "$msg" >"$tty"
    return
  fi

  printf '\e]9;%s\a' "$msg"
}

dotfiles_monitor_precmd() {
  local exit_code=$?
  local start=${DOTFILES_CMD_START_EPOCH:-$EPOCHSECONDS}
  local elapsed=$(( EPOCHSECONDS - start ))
  local last_cmd
  last_cmd="${DOTFILES_CMD_LINE:-$(fc -ln -1 | sed 's/^[[:space:]]*//')}"

  if (( elapsed >= MONITOR_SECONDS )) && [[ $exit_code -eq 0 ]]; then
    echo "LONG RUN OK."
    dotfiles_notify_iterm2 "Success: $last_cmd (${elapsed}s)"
  fi

  if [[ $exit_code -ne 0 && $exit_code -ne 130 ]]; then
    dotfiles_notify_iterm2 "Failed: $last_cmd (Code: $exit_code, ${elapsed}s)"
  fi
}

add-zsh-hook precmd dotfiles_title_precmd
add-zsh-hook preexec dotfiles_monitor_preexec
add-zsh-hook precmd dotfiles_monitor_precmd

dotfiles_ssh() {
  local host="$1"
  printf '\033]0;SSH: %s\007' "$host"
  command ssh "$@"
}

alias ssh='dotfiles_ssh'

install_yazi() {
  if command -v yazi >/dev/null 2>&1; then
    echo "yazi is already installed: $(yazi --version)"
    return 0
  fi

  if ! command -v cargo >/dev/null 2>&1; then
    echo "cargo is not installed. Install Rust first: https://rustup.rs/"
    return 1
  fi

  echo "Installing yazi via cargo..."
  cargo install --locked yazi-fm yazi-cli
}

yy() {
  local tmp cwd
  tmp="$(mktemp -t yazi-cwd.XXXXXX)"
  yazi "$@" --cwd-file="$tmp"
  cwd="$(command cat -- "$tmp" 2>/dev/null)"
  if [[ -n "$cwd" && "$cwd" != "$PWD" ]]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}
