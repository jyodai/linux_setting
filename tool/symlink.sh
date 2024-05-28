#!/bin/bash

filePaths=(
    ".env"
    ".vimrc"
    ".vim/plugin"
    ".vim/project"
    ".vim/ftplugin"
    ".vifm"
    ".screenrc"
    ".gitconfig"
    ".gitconfig.user"
    ".common_shell_aliases"
)

if [ "$SHELL" = "/bin/bash" ]; then
    filePaths+=(".bash_aliases")
elif [ "$SHELL" = "/bin/zsh" ]; then
    filePaths+=(".zsh_aliases")
fi

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

        if [ "$SHELL" = "/bin/bash" ] && [ "$filePath" == '.bash_aliases' ]; then
            addBashCode
        elif [ "$SHELL" = "/bin/zsh" ] && [ "$filePath" == '.zsh_aliases' ]; then
            addZshCode
        fi
    done
}

addBashCode() {
    bashrc=$(cat $HOME/.bashrc)
    if [[ "$bashrc" == *bash_aliases* ]]; then
        return
    fi

    code="
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
"
    echo "$code" >> $HOME/.bashrc
    source $HOME/.bashrc
}

addZshCode() {
    zshrc=$(cat $HOME/.zshrc)
    if [[ "$zshrc" == *zsh_aliases* ]]; then
        return
    fi

    code="
if [ -f ~/.zsh_aliases ]; then
    . ~/.zsh_aliases
fi
"
    echo "$code" >> $HOME/.zshrc
    source $HOME/.zshrc
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

