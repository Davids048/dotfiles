# >>> Prompt Setup >>>
PS1='\[\e[32m\]\u@\h:\[\e[34m\]\w\[\e[0m\]\n-> '

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"

    # Set ls color scheme.
    export LS_COLORS='di=1;34:ln=1;36:so=1;35:pi=1;33:ex=1;32:bd=1;33:cd=1;33:su=1;31:sg=1;31:tw=1;34:ow=1;34:*.tar=1;31:*.tgz=1;31:*.zip=1;31:*.gz=1;31:*.bz2=1;31:*.xz=1;31:*.jpg=1;35:*.jpeg=1;35:*.png=1;35:*.gif=1;35:*.pdf=1;31'

    alias ls='ls --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF -h --color --group-directories-first'
alias la='ls -A'
alias l='ls -CF'
alias nvidia-w="watch -n 0.5 nvidia-smi"

if [[ -f "/workspace/.env" ]]; then
    source /workspace/.env
    alias nvim="$NVIM_PATH/nvim-linux-x86_64/bin/nvim"
else 
    echo "No env file for $NVIM_PATH."
fi

if [[ -d "/workspace" ]]; then 
    ln -sf /workspace/.cache $HOME/
fi


# uv related setup >>>>>
. "$HOME/.local/bin/env"
if [ -d .venv ]; then 
# source .venv/bin/activate   # commented out by conda initialize
    alias pip="uv pip"
    alias pip3="uv pip"
fi

cd() {
    builtin cd "$@" && {
        if [ -f .venv/bin/activate ]; then
# source .venv/bin/activate  # commented out by conda initialize
            echo ""
        fi
    }
}

export UV_CACHE_DIR=/workspace/.cache
# uv related setup <<<<<

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion





# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/workspace/miniconda3/bin/conda' 'shell.bash' 'hook' '--no-auto-activate-base' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/workspace/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/workspace/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/workspace/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

