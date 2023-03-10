#!/bin/bash

filePaths=(
    ".env"
    ".vimrc"
    ".vim/plugin"
    ".vim/project"
    ".vim/ftplugin"
    ".screenrc"
    ".gitconfig"
    ".gitconfig.user"
    ".bash_aliases"
)

main() {
    echo ""
    case "$1" in
      "u")
        execUnlink
        ;;
      *)
        execSymlink
    esac
    echo ""
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

        if [ $filePath == '.bash_aliases' ]; then
            addBashCode
        fi
    done
}

addBashCode() {
    bashrc=`cat $HOME/.bashrc`
    if [[ "$bashrc" == *bash_aliases* ]]; then
        return
    fi

        code="
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
"
    echo "$code" >> $HOME/'.bashrc'
    source . ~/.bashrc
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
