#!/bin/sh

cat << EOF

(1) paquetes apt
(2) cambios apt
(3) superusuario
(4) depuracion
(5) errores del servidor x en la sesion
(6) kernel
(7) servicios
(8) xorg
(9) syslog
(10) volcar depuracion de programa
(11) servicio de notificacion

EOF

printf "elige opcion: " && read -r termino

case $termino in
	"1") grc tail -n 50 /var/log/apt/history.log;;
	"2") sudo grc tail -n 50 /var/log/apt/term.log;;
	"3") sudo grc tail -n 50 /var/log/auth.log;;
	"4") sudo grc tail -n 50 /var/log/debug;;
	"5") sudo grc tail -n 50 ~/.xsession-errors;;
	"6") sudo grc tail -f -n 50 /var/log/kern.log;;
	"7") sudo grc tail -f -n 50 /var/log/daemon.log;;
	"8") sudo grc tail -f -n 50 /var/log/Xorg.0.log;;
	"9") sudo grc tail -f -n 50 /var/log/syslog;;
	"11") sudo dmesg;;
esac

