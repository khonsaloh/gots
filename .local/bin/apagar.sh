#!/bin/sh

cat << EOF

(1) apagar
(2) programar apagado
(3) reiniciar
(4) cerrar sesion
(5) cerrar sesion

EOF
printf "opcion: " && read -r opcion

programado(){
	printf "tiempo a apagar:(añade s, m, h) "
	read -r apagar
	case $apagar in
		*s)
		p=$(echo "$apagar" | sed 's/.$//g')
		while true; do
			sleep "$p"
			sudo persist-config --shutdown --command poweroff
		done & ;;
		*m)
		j=$(echo "$apagar" | sed 's/.$//g') 
		f=$(echo 60*"$j" | bc)
		while true; do
			sleep "$f"
			sudo persist-config --shutdown --command poweroff
		done & ;;
		*h)
		nuevo=$(echo "$apagar" | sed 's/.$//g') 
		l=$(echo 60*60*"$nuevo" | bc) 
		while true; do
			sleep "$l"
			sudo persist-config --shutdown --command poweroff
		done & ;;
		*e)
		nuevo=$(echo "$apagar" | sed 's/.$//g')
		nueva=$(echo "$nuevo" | sed 's/://g')
		to=$(date +%Y%m%d"$nueva")
		notify-send "el equipo se apagara a las $nuevo" -i /usr/share/icons/papir*/48x48/apps/gnome-shutdown.png
		while true; do
			da=$(date +%Y%m%d%H%M%S) 
			if [ "$da" -gt "$to" ]; then
				sudo persist-config --shutdown --command poweroff
			else
				sleep 600
			fi
		done & ;;
		*p)
		nuevo=$(echo "$apagar" | sed 's/.$//g')
		nueva=$(echo "$nuevo" | sed 's/://g')
		notify-send "el equipo se apagara a las $nuevo" -i /usr/share/icons/papir*/48x48/apps/gnome-shutdown.png
		to=$(date +%Y%m%d"$nueva")
		while true; do
			da=$(date +%Y%m%d%H%M%S) 
			if [ "$da" -gt "$to" ]; then
				sudo persist-config --shutdown --command poweroff
			else
				sleep 60
			fi
		done & ;;
	esac
}

case $opcion in
	"1") sudo poweroff;;
	"2") programado ;;
	"3") sudo reboot ;;
	"4") echo 'presiona control+alt+basckspace' ;;
	"5") sudo shutdown -h "$1";;
esac

