#!/bin/sh

if [ -f "$1" ]; then
	case $1 in
	  *.gpg) gpg -d "$1";; #desncripta desde binario
	  *.asc) gpg -d "$1";; #desencripta desde ascii
	  *) gpg -ca "$1";; # encripta
	esac
else
	a=$(pwd)
	b=$(find . -type f | fzf --cycle --height 15)
        [ -z "$b" ] && exit 1	
		case $b in
	  		*.gpg) gpg -d "$a/$b";; #desncripta desde binario
	 		 *.asc) gpg -d "$a/$b";; #desencripta desde ascii
	  		*) gpg -ca "$a/$b";; # encripta
		esac

fi

