#!/bin/bash

echo -n 'sed < "./unisay/share-src/unisay/ponyquotes/ponies~" > "./unisay/share-src/unisay/ponyquotes/ponies"' > "./sed.sh"

## fixing unisay–ponysay renames

for line in $(cat "./renames" | sed -e 's/ --> /\+/g'); do
    old=$(echo $line | cut -d + -f 1)
    new=$(echo $line | cut -d + -f 2)
    echo -n ' -e "s/^'$old'\$/'$new'/"'     \
            '-e "s/\\+'$old'\$/\\+'$new'/"' \
            '-e "s/^'$old'\\+/'$new'\\+/"'  \
            '-e "s/\\+'$old'\\+/\\+'$new'/" ' >> "./sed.sh"
done

## removing unisay symlinks

for file in $(ls --color=no "./unisay/share/unisay/pony/"); do
    if [[ ! $(readlink "./unisay/share/unisay/pony/"$file) = "" ]]; then
        echo -n ' -e "s/^'$file'\$//"'  \
                '-e "s/\\+'$file'\$//"' \
                '-e "s/^'$file'\\+//"'  \
                '-e "s/\\+'$file'\\+//" ' >> "./sed.sh"
    fi
done

