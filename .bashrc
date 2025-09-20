# >>> Prompt Setup >>>
PS1='\[\e[32m\]\u@\h:\[\e[34m\]\w\[\e[0m\]\n-> '

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

ua() {
    if [ -f .venv/bin/activate ]; then
        source .venv/bin/activate  # commented out by conda initialize
        echo "Activated .venv"
    fi
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

source .bashalias.sh
