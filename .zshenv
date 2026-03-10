export DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"

if [ -r "$DOTFILES_DIR/zsh/env.zsh" ]; then
  source "$DOTFILES_DIR/zsh/env.zsh"
fi
