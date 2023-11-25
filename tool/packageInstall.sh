#!/bin/bash

main() {
    echo ""
    installPackages
    echo ""
}

installPackages() {
    packages=(
        "unzip"
        "ripgrep"
        "jq"
    )

    for package in "${packages[@]}"
    do
        if isInstalled "$package"; then
            echo "$package はインストール済みです"
            continue
        fi

        echo "$package をインストールします"
        installPackage "$package"
    done

    installDeno
}

isInstalled() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        dpkg -l | grep "$1" &> /dev/null
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        brew list "$1" &> /dev/null
    fi
}

installPackage() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        sudo apt install "$1" -y
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        brew install "$1"
    fi
}

installDeno() {
    if command -v deno &> /dev/null; then
        echo 'denoはインストール済みです'
        return
    fi

    echo 'denoをインストールします'
    curl -fsSL https://deno.land/x/install/install.sh | sh
}

main

