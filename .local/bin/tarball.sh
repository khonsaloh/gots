#!/bin/sh

cat << EOF

(1) zip
(2) xz
(3) lzma
(4) bz2

EOF
printf "por defecto crea tarball: " && read -r comp

case $comp in
	"1") zip -r "$1".zip "$1" ;;
	"2") xz "$1";;
	"3") lzma "$1";;
	"4") tar -jcvf "$1".tar.bz2 "$1";;
	"") tar -zcvf "$1".tar.gz "$1";;
esac

