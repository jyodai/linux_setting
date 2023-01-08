#!/bin/bash

main() {
    . $HOME/.env

    echo '######E############################'
    echo 'vimInstall.shを実行します'
    echo '###################################'

    updateVim
    installPlug
    setProject
}

updateVim() {
    version=`vi --version | grep IMproved | grep -oP "[0-9]*\.[0-9]*"`
    
    if [ `echo "$version >= 8" | bc` == 1 ]; then
        echo 'バージョン8.0以上のため更新しません'
        return
    fi
    add-apt-repository ppa:jonathonf/vim
    apt update
    apt install vim
}

installPlug() {
    if [ -d $HOME/".vim/plugged" ]; then
        echo 'vim-plugはインストール済みです'
        return
    fi

    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    echo "mkdir : $HOME/.vim/plugged"
    mkdir $HOME/".vim/plugged"
}

setProject() {
    if [ -d $HOME/".vim/project" ]; then
        echo 'projectはセットアップ済みです'
        return
    fi

    git clone $VIM_PROJECT $SETTING_PATH/.vim/project
}

main
