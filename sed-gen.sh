#!/bin/bash

echo -n 'sed < "./unisay/share-src/unisay/ponyquotes/ponies~" > "./unisay/share-src/unisay/ponyquotes/ponies"' > "./sed.sh"

for line in $(cat "./renames" | sed -e 's/ --> /\+/g'); do
    echo -n ' -e "s/^'$(echo $line | cut -d + -f 1)'\$/'$(echo $line | cut -d + -f 2)'/g"'   \
            '-e "s/\+'$(echo $line | cut -d + -f 1)'\$/\+'$(echo $line | cut -d + -f 2)'/g"' \
            '-e "s/^'$(echo $line | cut -d + -f 1)'\+/'$(echo $line | cut -d + -f 2)'\+/g"'  \
            '-e "s/\+'$(echo $line | cut -d + -f 1)'\+/\+'$(echo $line | cut -d + -f 2)'\+/g" ' >> "./sed.sh"
done

