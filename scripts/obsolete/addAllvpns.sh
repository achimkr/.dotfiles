#!/bin/bash
#Tries to add all files in a directory as a vpnConnection (Airvpn Openvpn file) to Networkmanager
#and renaming them to the vpn<location>TCP scheme

for i in *; do
	name="vpn$(echo $i | awk -F '[_-]' '{print $3}')TCP"
	echo "Adding $i as $name"
	nmcli con import "type" openvpn file $i
	if [ "$?" != "0" ]; then
		echo "Adding failed"	
		exit 1
	fi

	oldName=$(echo $i | awk -F '.' '{print $1}')
	nmcli con modify $oldName connection.id $name
	if [ "$?" != "0" ]; then
		echo "Renaming failed"	
		exit 1
	fi
done
