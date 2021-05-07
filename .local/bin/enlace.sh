#!/bin/sh
#crea enlaces simbolicos

#a=$(find $HOME -not -path "./.cache*" -not -path "./.mozilla*" -not -path "./thumbnails*" 2>/dev/null | fzf --cycle --height=15) 

[ -n "$1" ] && ln -s $(pwd)/"$1" "$1.lnk" ||
	b=$(find . | fzf --cycle --height 15 --prompt='elige archivo para crear enlace: ') && [ -n "$b" ] \
	&& ln -s $(pwd)/"$b" "$b.lnk"
