#!/bin/sh

waldir=/usr/share/wallpaper/
case $1 in
	"aleatorio") xwallpaper --zoom "$(find $waldir \
		-not -path "$waldir/*" -type f | shuf -n 1)" ;;
		#&& pidof -q bspwm && bspc wm -r ;;
	"fijo") xwallpaper --zoom "$(cat $HOME/.local/share/fondo.txt)" ;;
esac

[ -n "$1" ] && exit

cat << EOF
(1) fondo temporal
(2) rotar fondos temporales
(3) cambiar fondo de forma definitiva

EOF
printf "opcion: " && read -r fondo

case $fondo in
	"1") xwallpaper --zoom "$(find $waldir -type f | fzf --cycle --reverse)" 2>/dev/null ;;
	"2")
	while true; do
		xwallpaper --zoom "$(find $waldir -type f | shuf -n 1)"
		sleep 60
	done &
	;;
	"3") a=$(find $waldir -type f | fzf --cycle --reverse |
		tee $HOME/.local/share/fondo.txt 1>/dev/null) && [ -n "$a" ] && pidof -q bspwm && bspc wm -r || exit;;
esac

#para rotacion cargada desde inicio añadir al archivo de configuracion del gestor de ventanas (p.ej openbox ) la linea 
