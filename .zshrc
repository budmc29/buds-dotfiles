export ZSH=~/.oh-my-zsh
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:$path"

export TERM=xterm-256color
ZSH_THEME="robbyrussell"

plugins=(fast-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8

# History
HIST_STAMPS="dd/mm/yyyy"
export HISTSIZE=2000
export HISTFILE="$HOME/.history"
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE

# Functions
#
#

function catless() {
  if [ $1 ]; then
    cat $1 | less
  else
    echo 'Usage: catless filename'
  fi
}

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
fi

# Work aliases, keep private
source ~/.aliases

source ~/.work_config

export PROJECTS_HOME=${HOME}/projects

export PATH="/usr/local/opt/imagemagick@6/bin:$PATH"

export PATH=$HOME/bin:$PATH

# Start new tmux session when opening a new console
if [[ -z "$TMUX" ]] ;then
  tmux new-session
fi

set -o vi
