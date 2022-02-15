primary(){
	xrandr | awk '/primary/{print $1}'
}

connected(){
	xrandr | awk '$2 == "connected" {print $1}'
}

all(){
	xrandr | awk '{if(NR > 1 && $1 !~ /[0-9]*x[0-9]*/){print $1}}'
}

resolutions_info(){
	awk_script='
		BEGIN{
			read="f"
		}
		{
			if($1 == monitor){
				read = "t"
			} else if( $1 ~ /[0-9]*x[0-9]*/ && read == "t"){
				print $0
			}else{
				read = "f"
			}
		}
	'
	
	xrandr | awk -v monitor="$1" "$awk_script"
}

resolutions(){
	resolutions_info "$1" | awk '{print $1}'
}

preferred_resolution(){
	resolutions_info "$1" | awk '/+/{print $1}'
}
