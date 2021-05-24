#!/bin/sh

waldir=/usr/share/wallpaper/
[ -n "$1" ] && case $1 in
	"aleatorio") xwallpaper --zoom "$(find $waldir \
		-maxdepth 1 -type f | shuf -n 1)" ;;
	"fijo") xwallpaper --zoom "$(cat "$HOME"/.local/share/fondo.txt)" ;;
	*) xwallpaper --zoom "$(/usr/bin/find /usr/share/wallpaper/ -maxdepth 1 -type f |
		sxiv -tio 2>/dev/null)" 2>/dev/null & ;;
esac

[ -n "$1" ] && exit

cat << EOF
(1) fondo temporal
(2) rotar fondos temporales
(3) cambiar fondo de forma definitiva
(4) cambio de fondo grub
EOF
printf "opcion: " && read -r fondo

case $fondo in
	"1") xwallpaper --zoom "$(sxiv $waldir -to)" 2>/dev/null ;;
	"2")
	while true; do
		xwallpaper --zoom "$(find $waldir -maxdepth 1 -type f | shuf -n 1)"
		sleep 60
	done &
	;;
	"3") a=$(find $waldir -maxdepth 1 -type f | fzf --cycle --reverse |
		tee "$HOME"/.local/share/fondo.txt 1>/dev/null) && [ -n "$a" ] && pidof -q bspwm && bspc wm -r || exit;;
	"4") sudo $EDITOR /etc/default/grub ;;
esac

#para rotacion cargada desde inicio añadir al archivo de configuracion del gestor de ventanas (p.ej openbox ) la linea 
