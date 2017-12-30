export ZSH=~/.oh-my-zsh
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:$PATH"

export TERM=xterm-256color
ZSH_THEME="robbyrussell"

plugins=(zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

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

# Mercurial repository info plugin
if [ -e /usr/local/hg-plugins/prompt/prompt.py ]; then
function hg_prompt_info {
  hg prompt --angle-brackets "\
  <%{$fg_bold[blue]%}hg:(%{$fg_bold[red]%}<branch>>%{$fg_bold[blue]%})\
  %{$fg[yellow]%}<status|modified|unknown><update>\
  <patches: <patches|join( → )>>%{$reset_color%}" 2>/dev/null
  }

  PROMPT='${ret_status}%{$fg_bold[green]%}%p %{$fg[cyan]%}%c %{$fg_bold[blue]%}$(git_prompt_info)$(hg_prompt_info)%{$fg_bold[blue]%} % %{$reset_color%}'
fi
# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scriptig

# Work aliases, keep private
source ~/.aliases
source ~/.private_work_aliases

# Create computer specific config file if it's missing
HOSTNAME=`hostname`

source ~/.${HOSTNAME}_pc.config
# Load computer specific settings
TEMPLATE_FILE_NAME=/home/`whoami`/.bud-template_pc.config
CONFIG_FILE_NAME=/home/`whoami`/.`hostname`_pc.config

if [ ! -f $CONFIG_FILE_NAME ]; then
  cat $TEMPLATE_FILE_NAME > $CONFIG_FILE_NAME
fi

export PATH=$HOME/bin:$PATH

set -o vi

export NVM_DIR="/home/`whoami`/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
