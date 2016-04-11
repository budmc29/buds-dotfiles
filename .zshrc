# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load.
ZSH_THEME="robbyrussell"

export TERM=xterm-256color
# TODO: attack to a detached session that is unnamed
# start tmux detached session on console load
# if [[ -z "$TMUX" ]] ;then
#     ID="`tmux ls | grep -vm1 blank | cut -d: -f1`" # get the id of blank
#     if [[ -z "$ID" ]] ;then # if not available create a new one
#         tmux new-session -s blank
#     else
#         tmux new-session -s "blank$ID" # attach-session -t "$ID" if available attach to it
#     fi
# fi

if [[ -z "$TMUX" ]] ;then
  tmux new-session
fi

# add todo to vimwiki
function todo() {
  parameter=$@
  sed -i "/# 1.TODO/a * [ ] ${parameter}" ~/vimwiki/index.md
}

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="dd/mm/yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
plugins=(git, vi-mode, mercurial)

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"

# DISABLE_AUTO_UPDATE="true"
DISABLE_UPDATE_PROMPT=true # alway check for updates
source $ZSH/oh-my-zsh.sh

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
# Ruby
alias first="rvm use 1.9.3@first && rvm current && cd ~/leaderboard"
alias startup="source ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh && xmodmap ~/vimkeys"
plugins=(zsh-syntax-highlighting)
alias rspec="spring rspec"

# Rails
alias rsp="bundle exec rspec spec"
alias spec="bundle exec rspec spec"
alias features="bundle exec rspec spec/features"

# mercurial
alias hgc="hg commit -m \""
alias hgs="hg status"
alias hgb="hg branch"
alias hgbr="hg branches"
alias hgu="hg update"
alias hgp="hg push"
alias hgpp="hg pull && hg push"
alias hgpu="hg pull"
alias hgpb="hg push --new-branch"
alias hgsh="hg shelve"
alias hgus="hg unshelve"
alias hgd="hg diff"
alias hgar="hg addremove"

#git
alias gs="git status"
alias gp="git push"
alias gb="git branch"
alias gc="git commit -m \""
alias ga="git add -A"
alias gd="git diff --cached"

alias deploy="cap staging deploy"
alias deployb="cap staging deploy -s branch="
alias rollback="cap staging deploy:rollback"
alias restart="cap staging unicorn:restart"

#Misc
alias zsh="vim ~/.zshrc"

# TODO: save i3 configs for different machines and version control that
alias dotbackup="cp ~/.hgrc ~/ubuntu-dotfiles/ \
&& cp -r ~/vimwiki/ ~/ubuntu-dotfiles/ \
&& cp -r ~/vimwiki/ ~/ubuntu-dotfiles/ \
&& cp ~/.tmux.conf ~/ubuntu-dotfiles/ \
&& cp ~/.tmux.conf ~/ubuntu-dotfiles/ \
&& cp ~/.xinitrc ~/ubuntu-dotfiles/ \
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
&& cp ~/ubuntu-dotfiles/.xinitrc ~/.vimrc \
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

#vim 
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
alias prbackup="cd ~/projects && git status && git add -A && git commit \
&& git push"

alias prupdate="cd ~/projects && git pull"

#personal
alias prs="cd ~/personal && ls"
alias personal="cd ~/personal && ls"
alias upm="cd /var/www/upostme && ls"
alias zt="zap to"

# work
alias wk="cd ~/work && ls"
alias work="cd ~/work && ls"

# search in console
alias gr="grep -rnw './' -e \""

# vpn
alias x11="x11vnc -auth guess -forever -usepw"

# start hansoft from cli, work machine
alias hansoft="cd /home/mugurel/.Hansoft/Versions/00084*/ && ./Hansoft -Url"

# tmux  [TODO: make a script for those in tmuxconf]
alias tmuxc="tmux attach -t console || tmux"

# keyboard layouts
alias querty="setxkbmap us"
# alias aoeu="setxkbmap us"
alias dvorak="setxkbmap -layout us -variant dvp -option compose:102 -option numpad:shift3 -option kpdl:semi -option keypad:atm -option caps:shift"
alias touchpadOff="synclient TouchpadOff=1"
alias touchpadOn="synclient TouchpadOff=0"

alias steam="cd /home/mugurel/.wine/drive_c/Program\ Files\ \(x86\)/Steam/ && wine Steam.exe"

# project 
alias ticketee="cd ~/projects/ticketee && rvm use 2.0@ticketee"


# WORK aliases, keep private
. ~/.startup_commands_$(hostname)
. ~/.private_work_aliases

export PATH=$HOME/bin:$PATH

# set vi mode in terminal
set -o vi
