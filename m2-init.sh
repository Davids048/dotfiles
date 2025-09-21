echo "Setting up ds8 envrionment..."

export HOME=/mnt/sharefs/users/hao.zhang/ds8-agent
export HF_HUB_CACHE=$HOME/.cache/huggingface/hub
export XDG_CONFIG_HOME=$HOME/dotfiles
export GIT_CONFIG_GLOBAL=$HOME/dotfiles/.gitconfig

alias vim="VIMINIT='source $HOME/dotfiles/.vimrc' vim"
alias nvim="$HOME/dotfiles/nvim-linux-x86_64/bin/nvim"
export PATH="$HOME/dotfiles:$PATH"

source $HOME/dotfiles/.bashalias.sh
