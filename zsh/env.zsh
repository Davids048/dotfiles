if [[ -z "${DOTFILES_DIR:-}" || ! -d "$DOTFILES_DIR" ]]; then
  for candidate in "$HOME/dotfiles" "/workspace/dotfiles"; do
    if [[ -d "$candidate" ]]; then
      export DOTFILES_DIR="$candidate"
      break
    fi
  done
fi

if [[ -r "$DOTFILES_DIR/shell/env.sh" ]]; then
  source "$DOTFILES_DIR/shell/env.sh"
fi
