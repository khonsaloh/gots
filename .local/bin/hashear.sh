#!/bin/sh
red='\033[0;31m'
green='\033[0;32m'
echo
if [ -z "$2" ];then
	echo '256' $(sha256sum $1)
	echo 'md5' $(md5sum $1)
	echo '512' $(sha512sum $1)
else
	a=$(sha256sum "$1" | grep -w "$2") 
	[ -z "$a" ] && printf "${red}no coincide con 256\\n" || printf "${green}coincide con 256\\n"
	b=$(md5sum "$1" | grep -w "$2")
	echo
	[ -z "$b" ] && printf "${red}no coincide con md5\\n" || printf "${green}coincide con md5\\n"
	c=$(sha512sum "$1" | grep -w "$2")
	echo
	[ -z "$c" ] && printf "${red}no coincide con 512\\n" || printf "${green}coincide con 512\\n"
fi
echo

