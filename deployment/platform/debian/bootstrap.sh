#!/bin/sh

echo 'debian'

apt update

# install
apt install zsh git docker

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash

# will overwrite .zshrc !!!
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

vim ~/.zshrc
echo 'add nvm init snippet'
source ~/.zshrc

nvm install 12
nvm use 12

# yarn
npm install -g yarn

# nano editor off
export VISUAL=vim
export EDITOR="$VISUAL"

# commit 81c12c7daf53dc56be7d67012309ba35712b0611 (HEAD -> 2.10, tag: 2.10.2, origin/2.10)
# Author: Marcin G<C4><99>bala <maarcin.gebala@gmail.com>
# Date:   Wed Jul 22 16:35:48 2020 +0200

apt install docker-compose

# export DOCKER_HOST=127.0.0.1:2376 

# daemon
sudo service docker start

# sudo systemctl unmask docker.service
# sudo systemctl unmask docker.socket

sudo systemctl start docker.service
sudo systemctl status docker

# systemctl status docker.service
