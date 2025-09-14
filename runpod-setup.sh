#!/bin/bash
# Install softwares used on ssh servers. 

apt update 
apt install tmux vim npm nodejs tree -y

wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux-x86_64.tar.gz
tar xf nvim-linux-x86_64.tar.gz --no-same-owner

source nodejs.sh
