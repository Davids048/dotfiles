export DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"

if [ -r "$DOTFILES_DIR/bash/rc.sh" ]; then
  . "$DOTFILES_DIR/bash/rc.sh"
fi
