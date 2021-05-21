#!/bin/sh
#para establecer de forma definitiva; lanzar comando desde algun archivo que inicie
xrandr
echo
printf " pulsa c para cambiar resolucion: " && read -r resol
case $resol in
	"c") xrandr --output LVDS --mode "$(xrandr | awk '{ print $1 }' \
		| sed '3,10!d' | fzf --height=12 --reverse --cycle)" 2>/dev/null;;
	*) exit 1;;
esac
