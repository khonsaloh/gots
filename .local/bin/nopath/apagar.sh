#!/bin/sh

cat << EOF

(1) apagar
(2) programar apagado
(3) reiniciar
(4) salir a tty
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
			sudo poweroff
		done & ;;
		*m)
		j=$(echo "$apagar" | sed 's/.$//g') 
		f=$(echo 60*"$j" | bc)
		while true; do
			sleep "$f"
			sudo poweroff
		done & ;;
		*h)
		nuevo=$(echo "$apagar" | sed 's/.$//g') 
		l=$(echo 60*60*"$nuevo" | bc) 
		while true; do
			sleep "$l"
			sudo poweroff
		done & ;;
		*e)
		nuevo=$(echo "$apagar" | sed 's/.$//g')
		nueva=$(echo "$nuevo" | sed 's/://g')
		to=$(date +%Y%m%d"$nueva")
		notify-send "el equipo se apagara a las $nuevo"
		while true; do
			da=$(date +%Y%m%d%H%M%S) 
			if [ "$da" -gt "$to" ]; then
				sudo poweroff
			else
				sleep 600
			fi
		done & ;;
		*p)
		nuevo=$(echo "$apagar" | sed 's/.$//g')
		nueva=$(echo "$nuevo" | sed 's/://g')
		notify-send "el equipo se apagara a las $nuevo"
		to=$(date +%Y%m%d"$nueva")
		while true; do
			da=$(date +%Y%m%d%H%M%S) 
			if [ "$da" -gt "$to" ]; then
				sudo poweroff
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
	"4") echo 'presiona control+alt+F[1-9]' ;;
	"5") kill -9 -1 ;;
esac

