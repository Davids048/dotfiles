#!/bin/bash
# Install softwares used on ssh servers. 

sudo apt update 
sudo apt install -y coreutils
sudo apt install -y tmux vim tree wget curl git htop 
sudo apt-get update && apt-get install -y python3-dev python3.12-dev
sudo apt install -y python3.12-venv
sudo apt install ripgrep


if [[ -f nvim-linux-x86_64.tar.gz ]]; then
    echo "Found nvim-linux-x86_64. No need to download."
else
    wget https://github.com/neovim/neovim/releases/download/nightly/nvim-linux-arm64.tar.gz
    tar xf nvim-linux-arm64.tar.gz --no-same-owner
fi

# source install.sh
# source nodejs.sh
# source .bashrc


