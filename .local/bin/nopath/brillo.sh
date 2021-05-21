#!/bin/bash

pidof -q redshift && exit

[ -n "$1" ] && xrandr --output LVDS \
	--brightness "$(bc -l <<< "$1"/100)" || echo 'pon valores de 10 a 100 ' 

bc -l <<< "$(xrandr --verbose | grep Brightness | awk '{ print $2 }')"*100
