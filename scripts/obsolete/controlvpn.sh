#!/bin/bash
#This script is for easily controlling vpnConnections on NetworkManager using rofi

novpn="None"		#Disable vpn connections keyword (visible in menu)

#Awk script for printing out vpn connections
awk_vpn='
BEGIN{
	FS=" "
	OFS=" "
}

$(NF-1) == "vpn" {
	if(NF - 3 == 1){
		print $1
	}else{
		string = ""
		for( x = 1; x < FS - 3; x++){
			string = sprintf("%s ", $x)
		}
		print string
	}
}'

#Getting connection Information
activevpns=$(nmcli con show --active | awk "$awk_vpn")
echo "---------Active vpn connections---------"
echo "$activevpns"
activecount=$(nmcli con show --active | awk "$awk_vpn" | wc -l)
echo "active: $activecount"

allvpns=$(nmcli con show | awk "$awk_vpn")
echo "---------All vpn connections------------"
echo "$allvpns"

#Creating rofi input
input=""
if [ $activecount -eq 0 ]; then			#If there is no active connection you can choose any vpn but cant choose none
	input="$allvpns"
else									#Otherwise you can choose 'None' or any other vpn but those that are currently active
	exclude=$(echo "$activevpns" | tr '\n' '|' | sed 's/|$//')
	list=$(echo "$allvpns" | grep -v -E "$(echo $exclude)")
	input="$novpn\n$list"
fi

#Getting user decision
result=$(echo -e "$input" | rofi -dmenu -p "vpn") 

if [ $? -eq 0 ]; then					 #If user didn't choose an option do nothing
	if [ "$activevpns" != "" ]; then	 #If active connections existed kill them
		nmcli con down $activevpns
	fi

	if [ "$result" != "$novpn" ]; then 	#only if a connection was choosen start that connection
		nmcli con up $result
	fi
fi
