#!/bin/bash

main() {
    . $HOME/.env

    echo ""
    updateVim
    installPlug
    setProject
    echo ""
}

updateVim() {
    version=$(vim --version | grep -Eo "[0-9]+\.[0-9]+" | head -1)

    if [[ $(echo "$version >= 8" | bc) == 1 ]]; then
        echo 'バージョン8.0以上のため更新しません'
        return
    fi

    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        sudo add-apt-repository ppa:jonathonf/vim
        sudo apt update
        sudo apt install vim
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        brew install vim
    fi
}

installPlug() {
    if [[ -d $HOME/.vim/plugged ]]; then
        echo 'vim-plugはインストール済みです'
        return
    fi

    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    echo "mkdir : $HOME/.vim/plugged"
    mkdir -p $HOME/.vim/plugged
}

setProject() {
    if [[ -d $HOME/.vim/project ]]; then
        echo 'projectはセットアップ済みです'
        return
    fi

    git clone $VIM_PROJECT $SETTING_PATH/.vim/project
}

main

