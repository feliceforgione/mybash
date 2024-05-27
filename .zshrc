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
echo "Welcome to ZSH"
autoload -U compinit; compinit
source ~/.zsh/fzf-tab/fzf-tab.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

source <(fzf --zsh)
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"source ~/.zsh/fzf-tab/fzf-tab.zsh