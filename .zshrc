# >>> Prompt Setup >>>
PROMPT='%F{green}%n@%m:%F{blue}%~%f
-> '

# Function to set the terminal title
function set_title() {
    if [[ -n "$SSH_CONNECTION" ]]; then
        # If SSH'd into a server, set title to user@host:cwd
        # print -Pn "\e]0;%n@%m:%~\a"
		echo -ne "\033]0;${USER}@${HOST}:${PWD}\007"
    else
        # Otherwise, just set the title to the current directory
        # print -Pn "\e]0;DS96:%~\a"
		echo -ne "\033]0;DS96:${PWD}\007"
    fi
}
# Update the title every time the prompt is displayed
precmd() { set_title }

alias ssh='my_ssh'

function my_ssh() {
    local host="$1"
    echo -ne "\033]0;SSH: $host\007"  # Set terminal title to "SSH <host>"
	command ssh "$@"  # Use normal ssh otherwise
}
# <<< Prompt Setup <<<



# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('$HOME/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
        . "$HOME/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# >>> ENV Setup >>>
export PATH=$PATH:/usr/local/bin
export GIT_CONFIG_GLOBAL=~/.config/git/config
export VISUAL=nvim
# <<< ENV Setup <<<

# >>> Useful Commands >>>
alias ll='gls -alF --color=auto -h --group-directories-first'
alias ls='gls --color=auto -h --group-directories-first'
alias obsidian='cd ~/Documents/Obsidian\ Vault/'
alias cf="cd ~/repos/codeforces"
# <<< Useful Commands <<<

export DYLD_FALLBACK_LIBRARY_PATH="$(brew --prefix)/lib:$DYLD_FALLBACK_LIBRARY_PATH"

. "$HOME/.local/bin/env"
