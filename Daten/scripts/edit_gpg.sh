#!/bin/bash

tmp=$(mktemp)

file=$1

decrypt_command="gpg --batch --yes --passphrase-fd 0 --no-symkey-cache --decrypt"
encrypt_command="gpg --batch --yes --passphrase-fd 0 --no-symkey-cache --symmetric --output -"

read -s pwd

echo $pwd | $decrypt_command $file > $tmp

if [ $? -ne 0 ]; then
	echo "Couldn't decrypt..." 2>&1
	exit 1
fi

nvim --noplugin $tmp

echo $pwd | $encrypt_command $tmp > $file

rm $tmp
