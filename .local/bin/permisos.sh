#!/bin/sh

if [ -z "$1" ]; then
	c=$(find . -type f | fzf --cycle --height 15 --prompt='elige archivo: ')  
	[ -z "$c" ] && exit 1
	printf '========================\n'
	printf '| 4-permiso lectura    |\n'
	printf '| 2-permiso escritura  |\n'
	printf '| 1-permiso ejecucion  |\n'
	printf '| usuario-grupo-otros  |\n'
	printf '=======================\n'
	echo
	stat "$c" | grep Uid
		echo
		printf "p para cambiar propiedad o nueva autorizacion →  " && read -r permisos
		if [ "$permisos" = "p" ]; then
			a=$( grep 'root\|home' /etc/passwd | cut -d':' -f1 | fzf --cycle --height=12 --prompt='cambiar a: ')
			[ -z "$a" ] && exit
			sudo chown $a:$a $c
		else
			sudo chmod -R "$permisos" "$c"
		fi
else	
	printf '========================\n'
	printf '| 4-permiso lectura    |\n'
	printf '| 2-permiso escritura  |\n'
	printf '| 1-permiso ejecucion  |\n'
	printf '| usuario-grupo-otros  |\n'
	printf '=======================\n'
	echo
	stat "$1" | grep Uid
		echo
		printf "p para cambiar propiedad o nueva autorizacion →  " && read -r permisos
		if [ "$permisos" = "p" ]; then
			a=$(grep 'root\|home' /etc/passwd | cut -d':' -f1 | fzf --cycle --height=12 --prompt='cambiar a: ')
			[ -z "$a" ] && exit
			sudo chown $a:$a "$1"
		else
			sudo chmod -R "$permisos" "$1"
		fi
fi

