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
    )

    for package in "${packages[@]}"
    do
        serch=`dpkg -l | grep $package`
        if [ -n "$serch" ]; then
            echo "$package"'はインストール済みです'
            continue
        fi


        echo "$package"'をインストールします'
        sudo apt install $package -y
    done

    installDeno
}

installDeno() {
    versionInfo=`deno --version`
    if [[ ! "$versionInfo" == *not\ found* ]]; then
        echo 'denoはインストール済みです'
        return
    fi

    echo 'denoをインストールします'
    curl -fsSL https://deno.land/x/install/install.sh | sh
}


main
