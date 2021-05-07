
# in order to work this file on this location, you need to source it from /etc/zsh/zprofile or define the variable zotdir there
export HISTFILE=~/.cache/zsh/history
source ~/.config/shell/profile

[ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ] && startx "$HOME/.config/x11/xinitrc" 
#[ -z "$(pidof Xorg)" ] && [[ "$(tty)" == "/dev/tty1" ]] && startx "$HOME/.config/x11/xinitrc" 
[ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty2" ] && startx "$HOME/.config/x11/xinitrc" 
#[ -z "$(pidof Xorg)" ] && [[ "$(tty)" == "/dev/tty3" ]] && startx "$HOME/.config/.xinitrc" 
[ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty4" ] && startx "$HOME/.config/x11/xinitrc" 
#[ -z "$(pidof lightdm)" ] && [[ "$(tty)" == "/dev/tty1" ]] &&
#	case "$(pidof lightdm)" in
#		&& startx /usr/bin/bspwm;; 
#		&& startx /usr/bin/jwm ;;
#		*) && startx "$HOME/.config/.xinitrc" ;;
#	esac
