#!/bin/bash

filePaths=(
    ".env"
    ".vimrc"
    ".vim/plugin/ddc.vim"
    ".screenrc"
    ".gitconfig"
    ".gitconfig.user"
)

for filePath in "${filePaths[@]}"
do
    if [ ! -L $HOME/"$filePath" ]; then
        echo "symlink : $HOME/$filePath"
        ln -s $HOME/linux_setting/"$filePath" $HOME/"$filePath"
    fi
done

