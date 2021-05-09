#!/bin/sh

tiempo=$(date +%Y%m%d%H%M%S)

dir=$HOME/mm/
case $1 in
	'fullscr') notify-send -t 1000 "pantallazo en 2 segundos" \
		; scrot --delay 2 $dir$tiempo.png;;
	'regscr') import $dir$tiempo.png ;;
esac
a=$(fzf --reverse --cycle << EOF
pantalla completa
region de pantalla
EOF
)
[ -z "$a" ] && exit
case $a in
	'pantalla completa') notify-send -t 1000 "pantallazo en 2 segundos" \
		; scrot --delay 2 $dir$tiempo.png;;
	'region de pantalla') import $dir$tiempo.png ;;
esac
