#!/bin/bash
echo "Setting up ds8 envrionment..."

export WORKSPACE=/data/nfs01/david
export HF_HUB_CACHE=$WORKSPACE/.cache/huggingface/hub
export XDG_CONFIG_HOME=$WORKSPACE/dotfiles
export GIT_CONFIG_GLOBAL=$WORKSPACE/dotfiles/.gitconfig

# replace POSIX encoding
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

alias vim="VIMINIT='source $WORKSPACE/dotfiles/.vimrc' vim"
# alias nvim="$WORKSPACE/dotfiles/nvim-linux-arm64/bin/nvim"
alias nvim="$HOME/nvim-linux-arm64/bin/nvim"
alias tmux="tmux -f $WORKSPACE/dotfiles/.tmux.conf"
alias uv="/opt/conda/bin/uv"


export PATH="$WORKSPACE/dotfiles:$PATH"
export CONDA_ENVS_PATH="/data/nfs01/conda_envs"

source $WORKSPACE/dotfiles/.bashalias.sh
