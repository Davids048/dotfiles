# Dotfiles

This repository is the canonical source of truth for the shared shell and editor setup. The home-directory entrypoints such as `~/.zshrc`, `~/.zshenv`, `~/.bashrc`, `~/.vimrc`, `~/.tmux.conf`, and the global Git config are small stubs that source files from this repo. Runtime app state is not supposed to live here.

The main design goal is to keep one tracked baseline while letting each machine override only the things that actually vary, such as cache roots, Conda location, whether Bash must hand off to Zsh, and similar host-specific details.

## Layout

- `shell/env.sh`
  Shared environment loader. This sets normal XDG defaults, resolves the active machine profile, and exports common paths such as `NVM_DIR`, `UV_CACHE_DIR`, and `HF_HOME`.

- `zsh/env.zsh`
  Tiny Zsh-side wrapper that loads `shell/env.sh`.

- `zsh/rc.zsh`
  Interactive Zsh behavior: Oh My Zsh, plugins, prompt hooks, aliases, notifications, `conda`, `nvm`, and helpers such as `yy`.

- `bash/rc.sh`
  Interactive Bash behavior. On machines that need it, this can hand off to `zsh -l` in a host-specific way.

- `profiles/common.sh`
  Shared defaults that apply everywhere.

- `profiles/<machine>.sh`
  Tracked exact-machine overrides. Example: `profiles/mlsys-b200.sh`.

- `profiles/local.sh`
  Untracked machine-local override file created by bootstrap when a machine does not have a tracked profile yet.

- `ai/codex/AGENTS.md`
  Shared Codex instructions. Bootstrap links this file to `~/.codex/AGENTS.md` when `~/.codex` exists.

- `bootstrap.sh`
  Interactive setup entrypoint for wiring a new machine into this repo.

## Runtime State

Runtime app state should stay outside this repo.

Current expected locations:

- NVM: `~/.nvm`
- GitHub CLI: `~/.config/gh`
- GitHub Copilot: `~/.config/github-copilot`
- Go app state: `~/.config/go`
- Lazygit: `~/.config/lazygit`
- Ngrok: `~/.config/ngrok`
- Neovim config link: `~/.config/nvim -> ~/dotfiles/nvim`
- htop config link: `~/.config/htop/htoprc -> ~/dotfiles/htoprc`

If you ever see tools recreating directories like `gh`, `github-copilot`, `go`, `lazygit`, `ngrok`, `uv`, or `nvm` under `~/dotfiles`, a shell is probably still exporting a stale `XDG_CONFIG_HOME=~/dotfiles`.

## New Machine Quick Start

Clone the repo into `~/dotfiles`:

```bash
git clone <repo-url> ~/dotfiles
cd ~/dotfiles
```

Run bootstrap:

```bash
~/dotfiles/bootstrap.sh
```

Bootstrap does four things:

1. lets you pick a tracked machine profile, or create `profiles/local.sh`
2. rewrites the home entrypoint stubs
3. links tracked Neovim and htop config into `~/.config`
4. checks for core tools: `zsh`, `tmux`, `nvim`, `fzf`, `rg`, and `yazi`

Bootstrap writes backups to `~/.dotfiles-backups/<timestamp>/` before replacing home stubs.

## What To Answer In Bootstrap

On a machine that already has a tracked profile:

- pick that profile by number or press Enter if it is already the default
- answer `y` to rewriting the home stubs
- answer `y` to linking tracked config into `~/.config`
- answer `y` or `n` on tool installs depending on whether you want bootstrap to install missing tools

On a machine that does not have a tracked profile yet:

- choose `local-only override`
- let bootstrap create `profiles/local.sh`
- fill in only the machine-specific values you actually need

## Creating A New Machine Profile

Copy an existing profile or start from a minimal one:

```bash
cp ~/dotfiles/profiles/mlsys-b200.sh ~/dotfiles/profiles/<new-machine>.sh
```

Typical variables to adjust:

- `CACHE_ROOT`
- `DATA_ROOT`
- `HF_HOME`
- `CONDA_ROOT`
- `NVM_DIR`
- `PATH_PREPENDS`
- `LD_LIBRARY_PATH_PREPENDS`
- `CUDA_HOME`
- `CC`
- `CXX`
- `CUDAHOSTCXX`
- `ALTERNATE_NVIM_BIN`
- `DOTFILES_BASH_EXEC_ZSH`

Only put machine facts in a profile. Do not put interactive aliases or shell logic there.

## Machines That Cannot Use `chsh`

Some machines do not allow changing the account login shell away from Bash. For those machines, enable host-specific Bash-to-Zsh handoff in the profile:

```sh
DOTFILES_BASH_EXEC_ZSH=1
export DOTFILES_BASH_EXEC_ZSH
```

That makes interactive Bash exec into `zsh -l` on that machine only. Do not enable it globally unless every machine needs it.

## Verifying A Fresh Setup

Open a new shell and check:

```bash
echo "$XDG_CONFIG_HOME"
echo "$DOTFILES_MACHINE_PROFILE"
echo "$NVM_DIR"
git config --global --includes --get user.name
```

Expected:

- `XDG_CONFIG_HOME` should normally be `~/.config`
- `DOTFILES_MACHINE_PROFILE` should match the selected profile
- `NVM_DIR` should point to the non-repo NVM location, usually `~/.nvm`
- Git global config should resolve through the repo include stub

If the machine uses the Bash-to-Zsh fallback, launching an interactive Bash shell should land in Zsh.

## Current Notes

- This repo intentionally tracks shell, tmux, Vim/Neovim, Git, and htop setup.
- It does not intentionally track app-owned runtime config/state such as `gh`, `github-copilot`, `go`, `lazygit`, `ngrok`, or `uv`.
- The default setup path is `bootstrap.sh` plus machine profiles.
