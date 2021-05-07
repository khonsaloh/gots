#!/bin/sh

#nuevo="$HOME/scripts/bak/"
#time=$(date +%Y%m%d%H%M%S)
#b=$(pwd)
#c=$nuevo$time.$1
#cp "$1" "$c"
#echo "#$b" >> "$c"


[ -z "$1" ] && echo pon archivo a hacer backup && exit ||
	cp $1 $HOME/scripts/bak/$(date +%Y%m%d%H%M%S).$1 \
	&& echo '#'$(pwd) >> $HOME/scripts/bak/$(date +%Y%m%d%H%M%S).$1 \
	&& notify-send "copia creada en $HOME/scripts/bak"


