#!/bin/bash

filePaths=(
    ".env"
    ".vimrc"
    ".vim/plugin/ddc.vim"
    ".screenrc"
    ".gitconfig"
    ".gitconfig.user"
)

main() {
    case "$1" in
      "u")
        execUnlink
        ;;
      *)
        execSymlink
    esac
}

execSymlink() {
    for filePath in "${filePaths[@]}"
    do
        if [ -L $HOME/"$filePath" ]; then
            echo "link already exists : $HOME/$filePath"
            continue
        fi

        if [ -f $HOME/"$filePath" ]; then
            backupName=$HOME/"$filePath"'_bk'`date +%Y%m%d`
            mv $HOME/"$filePath" $backupName
            echo "backup : $backupName"
        fi

        echo "symlink : $HOME/$filePath"
        ln -s $HOME/linux_setting/"$filePath" $HOME/"$filePath"
    done
}

execUnlink() {
    for filePath in "${filePaths[@]}"
    do
        if [ ! -L $HOME/"$filePath" ]; then
            continue
        fi

        unlink $HOME/"$filePath"
        echo "unlink : $HOME/$filePath"
    done
}

main $1
