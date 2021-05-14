#!/bin/sh

if [ -f "$1" ]; then
	tipo="$(file -b --mime-type "$1" | rev| cut -d' ' -f1 | rev)"
	case $tipo in
	  application/pg*) gpg -d "$1";; #desncripta desde binario
	  *) gpg -ca "$1";; # encripta
	esac
else
	a=$(pwd)
	b="$(file --mime-type * | grep 'application/pgp' | fzf)" \
		&& name=$(echo "$b" | cut -d' ' -f1 | tr -d ':') \
		&& tipo=$(echo "$b" | rev | cut -d' ' -f1|rev)
	[ -z "$b" ] && exit
		case $tipo in
	  		application/pg*) gpg -d "$name";; #desncripta desde binario
	  		*) gpg -ca "$a/$b";; # encripta
		esac
fi
