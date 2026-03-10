export DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"

if [ -r "$DOTFILES_DIR/zsh/rc.zsh" ]; then
  source "$DOTFILES_DIR/zsh/rc.zsh"
fi
