DOTFILES_MACHINE_NAME="nvl72"
DOTFILES_BASH_EXEC_ZSH=1

CUDA_HOME="/home/shared-bin/cuda-12.9"
CC="/home/shared-bin/local/usr/bin/gcc-13"
CXX="/home/shared-bin/local/usr/bin/g++-13"
CUDAHOSTCXX="$CXX"
PATH_PREPENDS="$HOME/bin:/home/shared-bin/local/usr/bin:$CUDA_HOME/bin${PATH_PREPENDS:+:$PATH_PREPENDS}"
LD_LIBRARY_PATH_PREPENDS="/home/shared-bin/local/usr/lib/aarch64-linux-gnu:$CUDA_HOME/lib64${LD_LIBRARY_PATH_PREPENDS:+:$LD_LIBRARY_PATH_PREPENDS}"

export DOTFILES_MACHINE_NAME DOTFILES_BASH_EXEC_ZSH
export CUDA_HOME CC CXX CUDAHOSTCXX
export PATH_PREPENDS LD_LIBRARY_PATH_PREPENDS
