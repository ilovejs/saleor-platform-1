# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

export ZSH="/root/.oh-my-zsh"

ZSH_THEME="robbyrussell"

git config --global user.name 'ilovejs'
git config --global user.email 'zhuangdeyouxiang@gmail.com'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

plugins=(git)

source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8

export ARCHFLAGS="-arch x86_64"

alias zc="vim ~/.zshrc"
alias zr="source ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"
alias l=ls
alias c=clear

alias zc='code ~/.zshrc'
alias zr='source ~/.zshrc'
alias dk=docker

nvm use 12

