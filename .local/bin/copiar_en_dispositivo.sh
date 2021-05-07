#!/bin/sh
#sirve para crear usbs booteables tambien
printf "presta atencion de no equvivocarte aqui\\n"
a=$(find . | fzf --cycle --height=30 --prompt='pon archivo a copiar: ')
[ -z "$a" ] && exit
lsblk
b=$(lsblk -lnp | awk '{ print $1 }' | fzf --cycle --height=11 --prompt='dispositivo al que copiar: ')
[ -z "$b" ] && exit

sudo dd bs=4M if="$a" of="$b" status=progress && sync
