#!/bin/bash 

#####DOTFILE LOCATION SETUP>>>>>

DOTFILES_LOCATIONS=(
    "$HOME/dotfiles"
    "/workspace/dotfiles"
)

# Check each location
DOTFILES_DIR=""
for dir in "${DOTFILES_LOCATIONS[@]}"; do
    if [[ -d "$dir" ]]; then
        DOTFILES_DIR="$dir"
        break
    fi
done

# Exit with error if no dotfiles directory found
if [[ -z "$DOTFILES_DIR" ]]; then
    echo "Error: No dotfiles directory found in any of the following locations:" >&2
    printf "  %s\n" "${DOTFILES_LOCATIONS[@]}" >&2
    exit 1
fi
#####DOTFILE LOCATION SETUP<<<<<

ln -sf "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES_DIR/.bashrc" "$HOME/.bashrc"
ln -sf "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"
ln -sf "$DOTFILES_DIR/.tmux.conf" "$HOME/.tmux.conf"
ln -sf "$DOTFILES_DIR/.vimrc" "$HOME/.vimrc"

mkdir -p "$HOME/.config" && ln -sfn "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"
mkdir -p "$HOME/.config/htop" && ln -sfn "$DOTFILES_DIR/htoprc" "$HOME/.config/htop/"

echo "Dotfiles installed!"
