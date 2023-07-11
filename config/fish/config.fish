#------------------------------------------------- greeting ---
# function fish_greeting
# 	if [ $TERM = "st-256color" ]
#         if [ (pidof st | tr ' ' '\n' | wc -l) = 1 ]
#             bash $HOME/.config/shell/tarvis.sh
#         end
# 	end
# end
#
set fish_greeting

#--------------------------------------------------- export ---
set EDITOR "nvim"
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"

#--------------------------------------------- alias & abbr ---
source $HOME/.config/shell/alias
source $HOME/.config/shell/abbr.fish

#--------------------------------------------------- prompt ---
source $HOME/.config/fish/prompts/sashimi.fish
#starship init fish | source
