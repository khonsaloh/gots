
# in order to work this file on this location, you need to source it from /etc/zsh/zprofile or define the variable zotdir there
export HISTFILE=~/.cache/zsh/history
source ~/.config/shell/profile

[ -z "$(pidof Xorg)" ] && [ "$(tty)" = "/dev/tty1" ] && startx "$HOME/.config/x11/xinitrc" 
[ -z "$(pidof Xorg)" ] && [ "$(tty)" = "/dev/tty2" ] \
	&& case "$(printf "dwm\\nbspwm\\n" | fzf --prompt 'elige escritorio: ')" in
		dwm) echo dwm > ~/.local/share/desktop && startx "$HOME/.config/x11/xinitrc";;
		bspwm) echo bspwm > ~/.local/share/desktop && startx "$HOME/.config/x11/xinitrc";;
	esac
