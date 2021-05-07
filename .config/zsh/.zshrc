
#[ -f $HOME/zsh-autosuggestions.zsh ] && source ~/zsh-autosuggestions.zsh
source $HOME/.config/zsh/boomer

#plugins
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

#alias
source ~/.config/shell/aliases

# cursor fino estatico
#echo -ne '\e[6 q'

# === LS COLORES ===
#eval "$(dircolors ~/.config/ls-colores/ls-colores)"

#source ~/.config/ls-colores/ls-colores

# === PYWALL ===
#(cat ~/.cache/wal/sequences &)
 
#autoload -U promptinit; promptinit

#. $HOME/.local/bin/z.sh

# === PROMPTS ===
#eval "$(~/descargas/build/starship init zsh)"
PS1=" %{$fg[magenta]%}%~%{$reset_color%}: "

