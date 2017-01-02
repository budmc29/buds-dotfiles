export ZSH=~/.oh-my-zsh

# Set name of the theme to load.
ZSH_THEME="robbyrussell"

export TERM=xterm-256color

if [[ -z "$TMUX" ]] ;then
  tmux new-session
fi

export LANG=en_US.UTF-8

# History
HIST_STAMPS="dd/mm/yyyy"
export HISTSIZE=2000
export HISTFILE="$HOME/.history"
setopt hist_ignore_all_dups
setopt hist_ignore_space

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
else #   export EDITOR='mvim'
fi

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scriptig

# ALIASES
#
#
#
# Ruby
plugins=(zsh-syntax-highlighting)
alias first="rvm use 1.9.3@first && rvm current && cd ~/leaderboard"
alias startup="source ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh && xmodmap ~/vimkeys"

# Rails
alias et="RAILS_ENV=test"
alias ed="RAILS_ENV=development"

alias spec="bundle exec rspec"
alias spec2="bundle exec rspec spec"
alias features="bundle exec rspec spec/features"

alias rgc="rails g controller"
alias rgm="rails g model"

alias be="bundle exec"
alias ber="bundle exec rake"

alias sr='bin/spring rspec'
alias src='bin/spring rspec spec/controllers'
alias srf='bin/spring rspec spec/features'
alias srm='bin/spring rspec spec/models'

# mercurial
alias hgc="hg commit -m \""
alias hgs="hg status"
alias hgbr="hg branch"
alias hgb="hg branches"
alias hgbm="hg bookmark"
alias hgbms="hg bookmarks"
alias hgu="hg update"
alias hgp="hg push"
alias hgl="hg log -l 5"
alias hgg="hg glog -l 5"
alias hgll="hg log -l"
alias hggl="hg glog -l"
alias hgpp="hg pull && hg push"
alias hgpu="hg pull"
alias hgpb="hg push --new-branch"
alias hgsh="hg shelve --config hooks.commit="
alias hgus="hg unshelve"
alias hgd="hg diff"
alias hgar="hg addremove"
alias hgclose="hg commit --close-branch -m \""

#git
alias gs="git status"
alias gp="git push"
alias gb="git branch"
alias gc="git commit -m \""
alias ga="git add -A"
alias gd="git diff --cached"
alias gco="git checkout"
alias gl="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gll="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit -n 10"


#Misc
alias zsh="vim ~/.zshrc"

# TODO: save i3 configs for different machines and version control that

# TODO: finish dotter update
alias dotupdate="cd ~/ubuntu-dotfiles && git pull \
&& cp ~/ubuntu-dotfiles/.vimrc ~/.vimrc \
&& cp ~/ubuntu-dotfiles/.gvimrc ~/.gvimrc \
&& cp ~/ubuntu-dotfiles/.tmux.conf ~/.tmux.conf \
&& cp ~/ubuntu-dotfiles/.hgrc ~/.hgrc \
&& cp ~/ubuntu-dotfiles/.Xmodmap ~/.Xmodmap \
&& cp -r ~/ubuntu-dotfiles/.i3 ~/ \
&& cp ~/ubuntu-dotfiles/.i3status.conf ~/ \
&& cp ~/ubuntu-dotfiles/.zshrc ~/.zshrc \
&& cp ~/ubuntu-dotfiles/zap.bash ~/zap.bash \
&& cp -r ~/ubuntu-dotfiles/.bookmarks ~/ \
&& cp -r ~/ubuntu-dotfiles/vimwiki ~/ \
&& source ~/.zshrc"

alias vimrc="vim ~/.vimrc"
alias vundle="git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim"
alias vimwiki="vim ~/vimwiki/index.md"

# tmux 
alias tmuxrc="vim ~/.tmux.conf"

# ubuntu processes
alias pss="ps -ef | grep"

# projects
alias pr="cd ~/projects && ls"
alias projects="cd ~/projects && ls"
alias ex="cd ~/projects/exercism/ruby && ls"
alias prbackup="cd ~/projects && git status && git add -A && git commit \
&& git push"

alias prupdate="cd ~/projects && git pull"

alias scr="cd ~/work/scripts"
alias ezsh="vim ~/.zshrc"
alias szsh="source ~/.zshrc"

alias sandbox="cd ~/projects/sandbox"
alias sand="cd ~/projects/sandbox"
alias kata="cd ~/projects/sandbox/ruby/katas"

# search in console
alias gr="grep -rnw './' -e \""
alias clip="xclip -selection cliboard"

# vpn
alias x11="x11vnc -auth guess -forever -usepw"

# start hansoft from cli, work machine
alias hansoft="cd /home/mugurel/.Hansoft/Versions/00084*/ && ./Hansoft -Url"

# tmux  [TODO: make a script for those in tmuxconf]
alias tmuxc="tmux attach -t console || tmux"

# keyboard layouts alias querty="setxkbmap us"
alias dvorak="setxkbmap -layout us -variant dvp -option compose:102 -option numpad:shift3 -option kpdl:semi -option keypad:atm -option caps:shift"
alias touchpadOff="synclient TouchpadOff=1"
alias touchpadOn="synclient TouchpadOff=0"

alias steam="cd /home/mugurel/.wine/drive_c/Program\ Files\ \(x86\)/Steam/ && wine Steam.exe"
alias tor="cd /usr/local/tor && ./tor"

# work
alias work="cd ~/work && ls"

# project
alias ticketee="cd ~/projects/ticketee && rvm use 2.0@ticketee"
alias upm="cd ~/work/upm"

alias todo="add_todo $@"
alias catless="catless $@"
alias dotbackup="~/projects/dotter/dotter.bash -b"

# work aliases, keep private
. ~/.private_work_aliases

export PATH=$HOME/bin:$PATH

# set vi mode in terminal
set -o vi
