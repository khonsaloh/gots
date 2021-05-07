#!/bin/sh

cat << EOF

(1) crear nuevo usuario
(2) eliminar usuario
(3) cambiar contraseña de usuario
(4) renombrar cuenta de usuario
(5) añadir nuevo grupo
(6) borrar grupo
(7) añadir usuario a un grupo
(8) eliminar usuario de un grupo
(9) cambiar la shell por defecto para un usuario

EOF
printf "ingresa indice: " && read -r indice

case $indice in
	"1") printf "nombre del usuario nuevo: " && read -r usuario && sudo useradd "$usuario";;
	"2") a=$(grep 'home' /etc/passwd | cut -d':' -f1 | fzf --cycle --height=10) && sudo userdel "$a";;
	"3") a=$(grep 'root\|home' /etc/passwd | cut -d':' -f1 | fzf --cycle --height=10) && sudo passwd "$a";;
	"4") a=$(grep 'home' /etc/passwd | cut -d':' -f1 | fzf --cycle --height=10) \
		&& printf "nombre nuevo: " && read -r nombre && sudo usermod -l "$nombre" "$a";;
	"5") printf "nombre que tendra nuevo grupo: " && read -r grupo && sudo groupadd "$grupo";;
	"6") a=$(cut -d':' -f1 /etc/group | fzf) && sudo groupdel "$a";;
	"7") a=$(cut -d':' -f1 /etc/passwd | fzf --cycle --height=40) \
		&& echo 'a que grupo lo quieres añadir? ' && b=$(awk -F':' '{print $1}' /etc/group | fzf) && sudo usermod -g "$b" "$a";;
	"8") echo 'nombre del usuario a eliminar del grupo: ' && read -r usuario  \
		&& a=$( grep $usuario /etc/group | sed 's/:.*//' | fzf --cycle --height=40) && echo 'de que grupo lo quieres eliminar?: ' \
		&&  b=$(cut -d':' -f1 /etc/group | fzf --cycle --height=15) && sudo gpasswd -d "$a" "$b";;
	"9") echo 'nombre del usuario a modificar la shell: ' \
		&& a=$( grep 'root\|home' /etc/passwd | cut -d':' -f1 /etc/passwd | fzf --cycle --height=40) \
		&& echo 'nueva shell: ' && b=$(sed '1d' /etc/shells | fzf --cycle) && sudo usermod --shell "$b" "$a";;
esac
