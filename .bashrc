#!/bin/bash
iatest=$(expr index "$-" i)



source ./modules/_exports.sh
source ./modules/_special_functions.sh
source ./modules/_general_alias.sh
source ./modules/_my_help_manual_function.sh



#######################################################
# Start
#######################################################

clear
fastfetch

echo "Welcome to BASH"
echo "For help on new commands, type 'zhelp'"

#export PATH=$PATH:"$HOME/.local/bin:$HOME/.cargo/bin:/var/lib/flatpak/exports/bin:/.local/share/flatpak/exports/bin"

eval "$(starship init bash)"
eval "$(fzf --bash)"
eval "$(zoxide init bash)"
