source mon-utils.sh

first=$(connected | rofi -dmenu)
second=$(connected | awk -v not="$first" '$1 != not{print $1}'| rofi -dmenu)

second_res=$(resolutions "$second" | sort -r | rofi -dmenu)

position=$(echo -e "left-of\nright-of\nabove\nbelow\n" | rofi -dmenu)

xrandr --output "$first" --primary --mode $(preferred_resolution "$first") \
	--output "$second" --mode "$second_res" --$position $first
