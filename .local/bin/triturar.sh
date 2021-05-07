#!/bin/sh
echo
printf "(1) triturar archivo\\n"
printf "(2) triturar dispositivo o particion\\n"
echo
printf "opcion: " && read -r opcion
case $opcion in
	"1") a=$(find . | fzf --cycle --height=20 --prompt='elige archivo a triturar: ' ) && shred -uvz "$a";;
	"2") lsblk && a=$(lsblk -npl | awk '{ print $1 }' | fzf --cycle --height=12 --prompt='particion a triturar: ') && shred -vz "$a";;
esac

