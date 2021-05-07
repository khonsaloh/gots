#!/bin/sh

case $1 in
	#"") curl -4sf wttr.in;;
	moon|luna) curl -4sf wttr.in/Moon | less -FRXS;;
	a|all|-a) curl -4sf v2.wttr.in;;
	js|--json|-js) curl -4sf wttr.in/coruña?format=j1| jq -C "."| less -FXRS ;;
	-l|l) curl -4sf wttr.in/"$2";;
	-h|--help) printf "opciones validas son moon, luna, a para alternativo, js, -l para lugar especifico\\n";; 
	*) curl -4sf wttr.in/"$1" | less -FRXS;;
esac
