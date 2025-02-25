#!/bin/bash

main() {
    . $HOME/.env

    echo ""
    updateNvim
    setProject
    echo ""
}

updateNvim() {
    version=$(nvim --version | grep -Eo "[0-9]+\.[0-9]+" | head -1)

    if [[ $(echo "$version >= 0.10" | bc) == 1 ]]; then
        echo 'バージョン0.10以上のため更新しません'
        return
    fi

    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        sudo add-apt-repository ppa:neovim-ppa/unstable
        sudo apt update
        sudo apt install neovim
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        brew install neovim
    fi
}

setProject() {
    if [[ -d $HOME/.config/nvim/project ]]; then
        echo 'projectはセットアップ済みです'
        return
    fi

    git clone $NVIM_PROJECT $SETTING_PATH/.config/nvim/project
}

main

