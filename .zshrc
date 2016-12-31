# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:$PATH"

export TERM=xterm-256color
ZSH_THEME="robbyrussell"
plugins=(git, vi-mode, mercurial, hg-prompt, zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

COMPLETION_WAITING_DOTS="true"

# DISABLE_AUTO_UPDATE="true"
DISABLE_UPDATE_PROMPT=true # alway check for updates

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# History
HIST_STAMPS="dd/mm/yyyy"
export HISTSIZE=2000
export HISTFILE="$HOME/.history"
setopt hist_ignore_all_dups
setopt hist_ignore_space

if [[ -z "$TMUX" ]] ;then
  tmux new-session
fi

# add todo to vimwiki
function todo() {
  parameter=$@
  sed -i "/# 1.TODO/a * [ ] ${parameter}" ~/vimwiki/index.md
}

# mercurial repository info plugin
if [ -e /usr/local/hg-plugins/prompt/prompt.py ]; then
function hg_prompt_info {
  hg prompt --angle-brackets "\
  <%{$fg_bold[blue]%}hg:(%{$fg_bold[red]%}<branch>>%{$fg_bold[blue]%})\
  %{$fg[yellow]%}<status|modified|unknown><update>\
  <patches: <patches|join( → )>>%{$reset_color%}" 2>/dev/null
  }

  PROMPT='${ret_status}%{$fg_bold[green]%}%p %{$fg[cyan]%}%c %{$fg_bold[blue]%}$(git_prompt_info)$(hg_prompt_info)%{$fg_bold[blue]%} % %{$reset_color%}'
fi

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else #   export EDITOR='mvim'
fi

# ssh
export SSH_KEY_PATH="~/.ssh/dsa_id"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scriptig

# zap bookmark manager
if [ -f ~/zap.bash ]; then
  source ~/zap.bash
fi

# wiki backup
if [ -f ~/.wiki-backup.bash ]; then
  source ~/.wiki-backup.bash
fi

# ALIASES
#
#
#

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

# git
alias gs="git status"
alias gp="git push"
alias gb="git branch"
alias gc="git commit -m \""
alias ga="git add -A"
alias gd="git diff --cached"
alias gco="git checkout"
alias gl="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gll="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit -n 10"
alias gaa="git add -A"

#Misc
alias zsh="vim ~/.zshrc"

# TODO: save i3 configs for different machines and version control that
# TODO: create a backup script instead of aliases
alias dotbackup="cp ~/.hgrc ~/ubuntu-dotfiles/ \
&& cp -r ~/vimwiki/ ~/ubuntu-dotfiles/ \
&& cp ~/.tmux.conf ~/ubuntu-dotfiles/ \
&& cp ~/.Xmodmap ~/ubuntu-dotfiles/ \
&& cp ~/.vimrc ~/ubuntu-dotfiles/ \
&& cp ~/.gvimrc ~/ubuntu-dotfiles/ \
&& cp ~/.zshrc ~/ubuntu-dotfiles/ \
&& cp ~/zap.bash ~/ubuntu-dotfiles/ \
&& cp -r ~/.bookmarks ~/ubuntu-dotfiles/ \
&& cp -r ~/.i3 ~/ubuntu-dotfiles/ \
&& cp ~/.i3status.conf ~/ubuntu-dotfiles/ \
&& cd ~/ubuntu-dotfiles \
&& git pull && git add -A && git commit && git push"

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

# vim
alias vimrc="vim ~/.vimrc"
alias vundle="git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim"

# alias viki="vim ~/vimwiki/index.md"
alias vimwiki="vim ~/vimwiki/index.md"

# tmux
alias tmuxrc="vim ~/.tmux.conf"

# ubuntu processes
alias pss="ps -ef | grep"
alias szsh="source ~/.zshrc"
alias svim="sudo vim"

# projects
alias pr="cd ~/projects && ls"
alias projects="cd ~/projects && ls"
alias ex="cd ~/projects/exercism/ruby && ls"
alias prbackup="cd ~/projects && git status && git add -A && git commit && git push"
alias prupdate="cd ~/projects && git pull"

alias scr="cd ~/work/scripts"
alias ezsh="vim ~/.zshrc"
alias sandbox="cd ~/projects/sandbox"
alias sand="cd ~/projects/sandbox"
alias kata="cd ~/projects/sandbox/ruby/katas"

# work
alias work="cd ~/work && ls"

# search in console
alias gr="grep -rnw './' -e \""
alias clip="xclip -selection cliboard"

# vpn
alias x11="x11vnc -auth guess -forever -usepw"

# start hansoft from cli, work machine
alias hansoft="cd /home/mugurel/.Hansoft/Versions/00084*/ && ./Hansoft -Url"

# tmux
alias tmuxc="tmux attach -t console || tmux"

# keyboard layouts alias querty="setxkbmap us"
alias dvorak="setxkbmap -layout us -variant dvp -option compose:102 -option numpad:shift3 -option kpdl:semi -option keypad:atm -option caps:shift"
alias touchpadOff="synclient TouchpadOff=1"
alias touchpadOn="synclient TouchpadOff=0"

alias steam="cd /home/mugurel/.wine/drive_c/Program\ Files\ \(x86\)/Steam/ && wine Steam.exe"
alias tor="cd /usr/local/tor && ./tor"

# project
alias ticketee="cd ~/projects/ticketee && rvm use 2.0@ticketee"

alias upm="cd ~/work/upm"

# work aliases, keep private
. ~/.private_work_aliases

export PATH=$HOME/bin:$PATH

# set vi mode in terminal
set -o vi
