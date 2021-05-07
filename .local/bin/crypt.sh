#!/bin/sh

verde='\033[0;32m'
cat << EOF
(1) generar clave
(2) importar clave
(3) eliminar claves privada-publica
(4) exportar clave publica
(5) desencriptar volcando a archivo
(6) desencriptar sin volcado
(7) encriptar para otro usuario
(8) servidores de claves
(9) firmar digitalmente
(10) exportar clave privada
(10) editar clave
(12) listar clave privada
(13) verificar firma digital

EOF
printf "opcion: " && read -r clave
#echo "$clave"

case $clave in
	"1") gpg --full-generate-key;;
	"2") a=$(find . | fzf --cycle --height=15) && [ -z "$a" ] && exit 1 || gpg --import "$a";;
	"3") gpg --list-keys && a=$(gpg -k | awk '/pub/{getline; print}' | sed '1d' | fzf --cycle --height=15) \
		&& gpg --delete-secret-keys "$a" && gpg --delete-keys "$a" && gpg -k;;
	"4") gpg --list-keys && a=$(gpg -k | awk '/pub/{getline; print}' | sed '1d' | fzf --cycle --height=15) \
		&& gpg -a --export -o practica.pub "$a";;
	"5") printf "%s$verde archivo a desencriptar: " && a=$(find . | fzf --cycle --height=15) \
		&& gpg -o nuevo_archivo --decrypt "$a";;
	"6") printf "%s$verde archivo a desencriptar: " && a=$(find . | fzf --cycle --reverse) && gpg --decrypt "$a";;
	"7") gpg --list-keys && printf "destinatario: " &&  a=$(gpg -k | awk '/pub/{getline; print}' | sed '1d' | fzf --cycle --height=15) \
		&& printf "archivo a cifrar: " && b=$(find . | fzf --cycle --height=15) && gpg -v -a -o mensaje.cifrado --encrypt --recipient "$a" "$b";; 
	"8") a=$(printf "enviar clave publica a servidor de claves\\nbuscar clave publica en servidor de claves\\ndescargar clave publica de servidor de claves\\n"|
		fzf --cycle --height=10);;
	"9") printf "%s$verde archivo a firmar: " && a=$(find . | fzf --cycle --height=15) && gpg --clearsign "$a";;
	"10") gpg --list-keys && a=$(gpg -k | awk '/pub/{getline; print}' | sed '1d' | fzf --cycle --height=15) \
		&& gpg -ao nueva.priv --export-secret-keys "$a";;
	"11") gpg --list-keys && printf "usuario local" && a=$(gpg -k | awk '/pub/{getline; print}' | sed '1d' | fzf --cycle --height=15) \
		&& printf "usuario destinatario" && b=$(gpg -k | awk '/pub/{getline; print}' | sed '1d' | fzf --cycle --height=15) \
		&& printf "archivo a firmar: " && c=$(find . | fzf --cycle --height=15) && gpg -u "$a" --sign -o nuevo_archivo2 --encrypt -r "$b" "$c";;
	"12") gpg --list-secret-keys --keyid-format LONG;;
	"13") a=$(printf "%s$verde firma digital: ") && gpg --verify "$a";;
esac



#encriptar para destinatario
#gpg --list-keys
#a=$(gpg -k | awk '/pub/{getline; print}' | sed '1d' | fzf --cycle --height=15)
#gpg -v -a -o mensaje.cifrado --encrypt --recipient $a archivo_a_cifrar 
#gpg --fingerprint


#encriptar asimetrica para usuario destinatario
#gpg --encrypt -a -r gonzalo@gmail.com hola


#firmar archivo
#gpg --list-keys
#printf "usuario local"
#a=$(gpg -k | awk '/pub/{getline; print}' | sed '1d' | fzf --cycle --height=15)
#printf "usuario destinatario"
#b=$(gpg -k | awk '/pub/{getline; print}' | sed '1d' | fzf --cycle --height=15)
#gpg -u $a --sign -o nuevo_archivo --encrypt -r $b archivo_a_firmar


#firmar
#gpg --clearsign archivo_a_firmar

#gpg --list-keys
#a=$(gpg -k | awk '/pub/{getline; print}' | sed '1d' | fzf --cycle --height=15)
#gpg --send-keys --keyserver pgp.rediris.es $a


#gpg --list-keys
#a=$(gpg -k | awk '/pub/{getline; print}' | sed '1d' | fzf --cycle --height=15)
#gpg --key-server pgp.rediris.es --search-keys $a 

#gpg --keyserver pgp.rediris.es --recv-keys id
 
#gpg --list-secret-keys --keyid-format LONG
