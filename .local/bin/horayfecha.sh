#!/bin/sh
date
echo
echo 'zona horaria: ' ; readlink /etc/localtime | tr '/' ' ' | rev | cut -d' ' -f1|rev
echo
[ -z "$1" ] && echo 'pon f para cambiar fecha o h para cambiar la hora: ' && exit

case $1 in
	f) printf "pon dia mes y año (formato año-mes-dia): " && read -r entrada \
		&& sudo date +%Y%m%d -s "$(echo $entrada | sed 's/-//g')" && date ;;
	h) printf "pon hora en formato h:min → " && read -r hora \
		&& sudo date +%T -s "$hora:00" && date ;;
esac

