#!/bin/sh

[ -z "$1" ] && echo 'put expression to find' && return

[ -z "$2" ] && sudo grep --color -rinw . -e "$1" || sudo grep --color -niw "$2" -e "$1"

