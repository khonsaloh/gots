#!/bin/sh

eso=$1

fun() {
cat << EOF
	
(1) showcqt
(2) histograma
(3) espectro
(4) osciloscopio
(5) avectorscope

EOF
printf 'elige opcion: ' && read -r opcion2


case $opcion2 in
	"4") ffplay "$eso" -loglevel quiet \
		-vf 'oscilloscope=x=0.5:y=0:s=1';;
	"1") ffplay -loglevel quiet -f lavfi "amovie='$eso', asplit [a][out1]; [a] showcqt [out0]" &;;
	"3") ffplay -loglevel quiet -f lavfi "amovie='$eso', asplit [a][out1]; [a] showspectrum=mode=separate:color=intensity:slide=1:scale=cbrt [out0]";;
	"2") ffplay -loglevel quiet -i "$eso" -vf histogram;;
    	"5") ffplay -loglevel quiet -f lavfi "amovie='$eso', asplit [a][out1]; [a] avectorscope=zoom=1.3:rc=2:gc=200:bc=10:rf=1:gf=8:bf=7 [out0]";;

esac
}

hola() {
cat << EOF
	
(1) showcqt
(2) histograma
(3) espectro
(4) osciloscopio
(5) avectorscope

EOF
printf 'elige opcion: ' && read -r opcion


case $opcion in
	"4") ffplay "$a" -loglevel quiet -vf 'oscilloscope=x=0.5:y=0:s=1';;
	"1") ffplay -loglevel quiet -f lavfi "amovie='$a', asplit [a][out1]; [a] showcqt [out0]";;
	"3") ffplay -loglevel quiet -f lavfi "amovie='$a', asplit [a][out1]; [a] showspectrum=mode=separate:color=intensity:slide=1:scale=cbrt [out0]";;
	"2") ffplay -loglevel quiet -i "$a" -vf histogram;;
    	"5") ffplay -loglevel quiet -f lavfi "amovie='$a', asplit [a][out1]; [a] avectorscope=zoom=1.3:rc=2:gc=200:bc=10:rf=1:gf=8:bf=7 [out0]";;

esac
}

[ -z "$1" ] && a="$(find . -type f | fzf --cycle --reverse)" && hola #|| fun
[ -n "$1" ] && fun


