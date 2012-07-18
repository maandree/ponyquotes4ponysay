#!/bin/bash

_ponies="$(perl ./pq4ps.pl)"
ponies=()

if [[ ! $# == 0 ]]; then
    p=""
    for arg in "$@"; do
	p=$p$(echo "$_ponies" | grep "^$arg@")
    done
    _ponies=$p
fi

for _pony in $_ponies; do
    ponies+=( $_pony )
done

pony="${ponies[$RANDOM%${#ponies[@]}]}"

echo "-f" $(echo $pony | cut -d @ -f 1) "$(cat ./ponyquotes/$(echo $pony | cut -d @ -f 2))"
