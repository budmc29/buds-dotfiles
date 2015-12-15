# ubuntu-vim
Ubuntu dotfiles backup with my plugins, .vimrc and .zshrc.

Reminder: 
Copy files to ~/ and then run ```$ vundle```
- Install Source Code Pro fonts

```
curl https://gist.githubusercontent.com/lucasdavila/3875946/raw/1c100cae16a06bef154af0f290d665405b554b3b/install_source_code_pro.sh | sh 
```

- Install zsh and oh-my-zsh
```
sudo apt-get update && sudo apt-get install zsh 

sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

- To make autocomplete plugin work: 

```
sudo apt-get install build-essential cmake
sudo apt-get install python-dev.
cd ~/.vim/bundle/YouCompleteMe && ./install.py
```

TODO: find a way to avoid changing the pc name when installing to a fresh machine
