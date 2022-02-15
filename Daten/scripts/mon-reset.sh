#!/bin/bash
source mon-utils.sh

prefRes=$(xrandr )

primary=$(primary)
xrandr --output $primary --mode $(preferred_resolution eDP1)

for i in $(all); do
	if [ "$i" != "$primary" ]; then
		xrandr --output "$i" --off
	fi
done
