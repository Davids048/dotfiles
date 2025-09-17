#!/bin/bash
# Install softwares used on ssh servers. 

apt update 
apt install tmux vim npm nodejs tree tee wget curl git htop -y
apt-get update && apt-get install -y python3-dev python3.12-dev

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
