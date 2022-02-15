#!/bin/bash

echo -n "Enter database password:"
read -s password

while true; do
	read input
	echo $password | keepassxc-cli $input ~/Sync/passwords.kdbx
done
