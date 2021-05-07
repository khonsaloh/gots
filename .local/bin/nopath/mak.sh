#!/bin/sh
#nuevo="$HOME/scripts/bak/"
#time=$(date +%Y%m%d%H%M%S)
#b=$(pwd)
#c=$nuevo$time.$1
#mv "$1" "$c"
#echo "#$b" >> "$c"


[ -z "$1" ] && echo pon archivo a mover a carpeta de backups && exit ||
	mv "$1" $HOME/scripts/bak/"$(date +%Y%m%d%H%M%S)"."$1" \
	&& echo "#"$(pwd) >> $HOME/scripts/bak/"$(date +%Y%m%d%H%M%S)"."$1" \
	&& notify-send "movido a $HOME/scripts/bak"




