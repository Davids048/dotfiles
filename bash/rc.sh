case $- in
  *i*) ;;
  *) return 0 2>/dev/null || exit 0 ;;
esac

if [ -z "${DOTFILES_DIR:-}" ] || [ ! -d "$DOTFILES_DIR" ]; then
  DOTFILES_DIR="$HOME/dotfiles"
fi
export DOTFILES_DIR

if [ -r "$DOTFILES_DIR/shell/env.sh" ]; then
  . "$DOTFILES_DIR/shell/env.sh"
fi

if [ -n "${DOTFILES_BASH_EXEC_ZSH:-}" ] \
  && [ -z "${ZSH_VERSION:-}" ] \
  && [ -t 1 ] \
  && command -v zsh >/dev/null 2>&1; then
  exec zsh -l
fi

[ -r /etc/bash.bashrc ] && . /etc/bash.bashrc

HISTCONTROL=ignoreboth
shopt -s histappend
shopt -s checkwinsize

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

[ -f ~/.bash_aliases ] && . ~/.bash_aliases

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export EDITOR="${EDITOR:-nvim}"
export VISUAL="${VISUAL:-$EDITOR}"

if [ -n "${ALTERNATE_NVIM_BIN:-}" ] && [ -x "$ALTERNATE_NVIM_BIN" ]; then
  alias nvim="$ALTERNATE_NVIM_BIN"
fi

[ -f "${FZF_SHELL_BASH:-$HOME/.fzf.bash}" ] && . "${FZF_SHELL_BASH:-$HOME/.fzf.bash}"

if [ -s "$NVM_DIR/nvm.sh" ]; then
  . "$NVM_DIR/nvm.sh"
fi

if [ -s "$NVM_DIR/bash_completion" ]; then
  . "$NVM_DIR/bash_completion"
fi

if [ -x "$CONDA_ROOT/bin/conda" ]; then
  __dotfiles_conda_setup="$("$CONDA_ROOT/bin/conda" shell.bash hook 2>/dev/null)"
  if [ $? -eq 0 ]; then
    eval "$__dotfiles_conda_setup"
  elif [ -f "$CONDA_ROOT/etc/profile.d/conda.sh" ]; then
    . "$CONDA_ROOT/etc/profile.d/conda.sh"
  fi
  unset __dotfiles_conda_setup
fi
