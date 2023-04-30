export ZSH=~/.oh-my-zsh
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:$PATH"

export TERM=xterm-256color
ZSH_THEME="robbyrussell"

plugins=(zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh


+export PATH=/opt/homebrew/bin:$PATH
+export PATH="/opt/homebrew/sbin:$PATH"
+
+eval "$(rbenv init -)"
+export HOMEBREW_NO_AUTO_UPDATE=1
+export PROJECTS_HOME=${HOME}/projects
+export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin/:$PATH"
+export PATH=/opt/homebrew/bin:$PATH
+
+export NVM_DIR="$HOME/.nvm"
+[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
+[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
+
+export PATH="$HOME/.rbenv/bin:$PATH"
+eval "$(rbenv init -)"

if [[ -z "$TMUX" ]] ;then
  tmux new-session
fi

export LANG=en_US.UTF-8

# History
HIST_STAMPS="dd/mm/yyyy"
export HISTSIZE=2000
export HISTFILE="$HOME/.history"
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE


# Start new tmux session when opening a new console
if [[ -z "$TMUX" ]] ;then
  tmux new-session
fi
# Functions
#
#
# Add todo to vimwiki
function add_todo() {
  if [ $1 ]; then

    parameter=$@
    sed -i "/# 1.TODO/a * [ ] ${parameter}" ~/vimwiki/index.md

    echo 'TODO added'
  else
    echo 'Usage: todo things to do'
  fi
}

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

# Load computer specific settings
HOSTNAME=`hostname`

export PROJECTS_HOME=${HOME}/work

export PATH="/usr/local/opt/imagemagick@6/bin:$PATH"

export PATH=$HOME/bin:$PATH

export NVM_DIR="$HOME/.nvm"
  . "/usr/local/opt/nvm/nvm.sh"

set -o vi
