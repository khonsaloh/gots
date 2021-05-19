#!/bin/sh
#se puede usar pmount,pumount tambien sin requerir de permisos root
#montaje de archivos (iso squashfs)
[ -z "$1" ] && echo 'opciones validas son usb, usb2, win, dvd, img, AppImage o nombre de imagen a montar' && exit 1 || echo


a=$(mountpoint /media/squash)
b=$(file "$1" | awk '{ print $2 }')
echo "$b"

variable=$1

montaje(){
	if [ "$a" = "/media/squash is a mountpoint" ]; then
		sudo umount -R /media/squash
	else
		sudo mount -o loop "$variable" /media/squash
		sudo mount -o bind /dev /media/squash/dev
		sudo mount -t proc /proc /media/squash/proc
		#for i in dev ; do
		#	sudo mount --rbind "$1" /media/squash/$1
		#done
	fi
}
monta(){
	if [ "$a" = "/media/squash is a mountpoint" ]; then
		sudo umount -R /media/squash
	else
		sudo mount "$variable" -t iso9660 -o loop /media/squash
		sudo mount -o bind /dev /media/squash/dev
		sudo mount -t proc /proc /media/squash/proc
	fi
}

if [ "$b" = "Squashfs" ]; then
	montaje && notify-send "squashfs montado en /media/squash"
elif [ "$b" = "ISO" ]; then
	monta && notify-send "desmontado squashfs"
elif [ "$variable" = "AppImage" ]; then
	montaje
elif [ "$variable" = "img" ]; then
	montaje
fi

#comprueba los valores para $1 (variable de input)


a=$(mountpoint /media/usb)
b=$(mountpoint /media/sr0)
c=$(mountpoint /mnt)
d=$(mountpoint /media/usb2)
case $1 in
	"dvd") 
	if [ "$b" = "/media/sr0 is a mountpoint" ]
	then
		sudo umount /media/sr0 && notify-send "desmontado disco optico"
		sleep 0.2
		grc df -h
	fi
	if [ "$b" = "/media/sr0 is a mountpoint" ]
	then 
		sudo mount /dev/sr0 /media/sr0 && notify-send "montado disco optico"
	fi;;
	"usb")
	if [ "$a" = "/media/usb is a mountpoint" ]
	then
		sudo umount /media/usb && notify-send "desmontado usb primario"
	fi
	if [ "$a" = "/media/usb is not a mountpoint" ]
	then
		sudo mount /dev/sdb1 /media/usb && notify-send "montado usb primario en /media/usb"
	fi;;
	"win")
	if [ "$c" = "/mnt is a mountpoint" ]
	then
		sudo umount /mnt && notify-send "desmontada particion windows"	
	fi
	if [ "$c" = "/mnt is not a mountpoint" ]
	then
		sudo mount /dev/sda1 /mnt && notify-send "montada partcion windows en /mnt"
	fi;;
	"usb2")
	if [ "$d" = "/mnt is a mountpoint" ]
	then
		sudo umount /media/usb2 && notify-send "desmontado usb secundario"
		sleep 0.2
		grc df -h	
	fi
	if [ "$d" = "/mnt is not a mountpoint" ]
	then
		sudo mount /dev/sdc1 /media/usb2 && notify-send "montado usb secundario en /media/usb2"
	fi;;
esac

