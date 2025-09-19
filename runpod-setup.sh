#!/bin/bash
# Install softwares used on ssh servers. 

apt update 
apt install -y coreutils
apt install -y tmux vim  tree wget curl git htop 
apt-get update && apt-get install -y python3-dev python3.12-dev
apt install -y python3.12-venv
apt install ripgrep

if [[ -d "/workspace" ]]; then 
    rm -rf ~/.cache
    ln -sf /workspace/.cache $HOME/
fi

if [[ -f nvim-linux-x86_64.tar.gz ]]; then
    echo "Found nvim-linux-x86_64. No need to download."
else
    wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux-x86_64.tar.gz
    tar xf nvim-linux-x86_64.tar.gz --no-same-owner
fi

# install uv
curl -LsSf https://astral.sh/uv/install.sh | sh

source install.sh
source nodejs.sh
source .bashrc


npm install -g @anthropic-ai/claude-code
