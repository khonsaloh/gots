#!/usr/bin/env sh

dir=/opt/jails

# shell to use in the jail
shell=sh

[ ! -d $dir ] && sudo mkdir -p $dir/bin/ && sudo mkdir -p "$dir"/lib/i386-linux-gnu/

case $1 in
	help|-h|--help|h) printf "pon nombre de programa a correr en la jaula como parametro\\n" && exit 1;;
	-l|--list|l) ps -awx | grep chroot | sed \$d && exit 1;;
	-q|--quit|q) a=$(ps -awx | grep chroot | head -n -1 | fzf --reverse --cycle |
		awk '{print $1}') && kill $a 2>/dev/null && notify-send "terminada instancia de jaula" && exit 1 || exit 1;;
	-ka|ka) a=$(ps -awx | grep chroot | sed \$d |
		awk '{print $1}') && kill $a && notify-send "terminadas TODAS instacias de jaulas" && exit 1;;
esac

[ -z "$1" ] && printf "pon nombre de programa a correr\\n" && exit 1 ||
	for e in "$@"; do
		ruta=$(command -v "$e")
		ldd "$ruta" 2>&1
		sudo cp -v "$ruta" $dir/bin/
		list="$(ldd $ruta | grep -E -o '/lib.*\.[0-9]')"
		for i in $list; do 
			[ -e ${dir}${i} ] && continue || sudo cp -v "$i" "${dir}${i}"
		done
	done

ruera=$(command -v "$shell")
sudo cp -v $ruera $dir/bin
lista="$(ldd $shell | grep -E -o '/lib.*\.[0-9]')"
for i in $lista; do
	[ -e ${dir}${i} ] && continue || sudo cp -v "$i" "${dir}${i}"
done

[ -d "$dir" ] && sudo chroot "$dir" bin/$shell || exit 1
