#!/bin/bash 

DOTFILES_DIR="$HOME/dotfiles"

ln -sf "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES_DIR/nvim/" "$HOME/.config/nvim"
ln -sf "$DOTFILES_DIR/.tmux.conf" "$HOME/.tmux.conf"


echo "Dotfiles installed!"
