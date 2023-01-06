#!/bin/bash

. $HOME/.env

add-apt-repository ppa:jonathonf/vim
apt update
apt install vim

curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

dirPaths=(
    ".vim/plugged"
)

for dirPath in "${dirPaths[@]}"
do
    if [ ! -d $HOME/"$dirPath" ]; then
        echo "mkdir : $HOME/$dirPath"
        mkdir $HOME/"$dirPath"
    fi
done

git submodule add $VIM_PROJECT $SETTING_PATH/.vim/project
