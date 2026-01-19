#!/usr/bin/env bash

DOTFILES_DIR="/mnt/weka/home/hao.zhang/ds8-agent/dotfiles"

# Neovim (expects nvim/ subdir)
export XDG_CONFIG_HOME="$DOTFILES_DIR"

# tmux
export TMUX_CONF="$DOTFILES_DIR/.tmux.conf"

# htop
export HTOPRC="$DOTFILES_DIR/htoprc"

# bash
export BASH_ENV="$DOTFILES_DIR/.bashrc"

alias nvim="$DOTFILES_DIR/nvim-linux-x86_64.appimage"
alias tmux="tmux -f $TMUX_CONF"


source $DOTFILES_DIR/.bashrc
source $DOTFILES_DIR/.bashalias.sh
tmux source $TMUX_CONF

source $DOTFILES_DIR/.env

