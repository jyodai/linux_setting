#!/bin/bash

main() {
    echo '######E############################'
    echo 'createExample.shを実行します'
    echo '###################################'

    createFile
}

createFile() {
    exampleFiles=(`find $HOME/linux_setting/ -name *.example`)
    for exampleFile in "${exampleFiles[@]}"
    do
        file=`echo ${exampleFile} | sed -e "s/\.example$//"`

        if [ -f $file ]; then
            echo "$file"' は既に存在します'
            continue
        fi

        cp $exampleFile $file
        echo "$file"' を作成しました'
    done
}

main
