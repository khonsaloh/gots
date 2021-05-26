#!/usr/bin/env dash

menu=$(printf "hacer backup\\nrestaurar desde el backup" | dmenu -i -l 20)

bakdir="$HOME/bak/"
case $menu in
	"hacer backup")
		time=$(date +%Y%m%d%H%M%S)
		c=$(echo $bakdir$time.$1)

		cp $1 $c && echo '#'$(echo $PWD) >> $bakdir$time.$1 \
			&& notify-send "copia creada en $bakdir"
		;;
	"restaurar desde el backup")
		[ -n "$1" ] && b=$(echo "$1" | column -t -s '.' | awk '{print $NF}') && echo $b && a=$(awk END{print} $1 | sed s/"#"//g) && echo '$a' \
			[ -f "$a/$b" ] && echo "$a/$b" 'existe' && cp $1 $a/$b$(date +%Y%m%d%H%M%S) && notify-send "restablecido en $a/$b"
			[ ! -f "$a/$b" ] && echo "$a/$b" 'no existe' && sudo cp $1 $a/$b && notify-send "restablecido en $a/$b"

		[ -z "$1" ] && fullpath=$(find $bakdir | fzf --reverse --cycle) || exit ||
			filename=$(echo "$fullpath" | column -t -s '.' | awk '{print $NF}') \
			&& echo $filename && originaldir=$(awk END{print} $fullpath | sed s/"#"//g) \
			&& [ -f "$originaldir/$filename" ] && echo "$originaldir/$filename" 'existe' && cp $fullpath $originaldir/$filename$(date +%Y%m%d%H%M%S) \
			&& notify-send "restablecido en $originaldir/$filename" || echo "$originaldir/$filename" 'no existe' \
			&& sudo cp $fullpath $originaldir/$filename && notify-send "restablecido en $originaldir/$filename" && exit
		
		;;
esac

#[ -n "$1" ] && b=$(echo "$1" | column -t -s '.' | awk '{print $NF}') && echo $b && a=$(awk END{print} $1 | sed s/"#"//g) && echo '$a' \
#	[ -f "$a/$b" ] && echo "$a/$b" 'existe' && cp $1 $a/$b$(date +%Y%m%d%H%M%S) && notify-send "restablecido en $a/$b"
#	[ ! -f "$a/$b" ] && echo "$a/$b" 'no existe' && sudo cp $1 $a/$b && notify-send "restablecido en $a/$b"

#[ -z "$1" ] && c=$(find $HOME/scripts/bak/ | fzf --reverse --cycle) || exit ||
#	b=$(echo "$c" | column -t -s '.' | awk '{print $NF}') \
#	&& echo $b && a=$(awk END{print} $c | sed s/"#"//g) \
#	&& [ -f "$a/$b" ] && echo "$a/$b" 'existe' && cp $c $a/$b$(date +%Y%m%d%H%M%S) \
#	&& notify-send "restablecido en $a/$b" || echo "$a/$b" 'no existe' && sudo cp $c $a/$b && notify-send "restablecido en $a/$b" && exit



#carpeta="$HOME/scripts/bak/"
#time=$(date +%Y%m%d%H%M%S)
#c=$(echo $carpeta$time.$1)

#cp $1 $c && echo '#'$(echo $PWD) >> $carpeta$time.$1 \
#	&& notify-send "copia creada en $carpeta"
