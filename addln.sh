#!/bin/bash

function gr
{
    grep "^$1\$" < $2
    grep "+$1\$" < $2
    grep "^$1+" < $2
    grep "+$1+" < $2
}

function gr-echo
{
    echo "$2" | grep "^$1\$"
    echo "$2" | grep "+$1\$"
    echo "$2" | grep "^$1+"
    echo "$2" | grep "+$1+"
}


out="./unisay/share-src/unisay/ponyquotes/ponies"
for file in $(ls --color=no "./ponysay/ponies/"); do
    target=$(readlink "./ponysay/ponies/$file" | sed -e 's/^\.\///g' -e 's/\.pony$//g')
    if [[ ! $target = "" ]] && [[ ! $(gr $target $out) = "" ]]; then
	sym=$(echo $file | sed -e 's/\.pony$//g')
	echo 'adding symlink: '$sym' to '$target
        mv $out $out"~"
        touch $out
        for line in $(cat $out"~"); do
            if [[ ! $(gr-echo $target "$line") = "" ]]; then
                echo $line'+'$sym >> $out
            else
                echo $line >> $out
            fi
        done
    fi
done

