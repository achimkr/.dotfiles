#!/bin/bash

awk_vpn='
BEGIN{
	FS=" "
	OFS=" "
}

$(NF-1) == "vpn" {
	if(NF - 3 == 1){
		print $1
	}else{
		string
		for( x = 1; x < FS - 3; x++){
			string = sprintf("%s ", $x)
		}
		print string
	}
}'

activevpns=$(nmcli con show --active | awk "$awk_vpn")
echo -e "${activevpns}"
