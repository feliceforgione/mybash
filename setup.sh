#!/bin/bash


#######################################################
## General Variables
#######################################################
RC='\e[0m'  #Reset Colors
RED='\e[31m'
YELLOW='\e[33m'
GREEN='\e[32m'

## Get the correct user home directory.
USER_HOME=$USERPROFILE




command_exists() {
    command -v $1 >/dev/null 2>&1
}


checkEnv() {
    ## Check for requirements.
    REQUIREMENTS='curl winget zsh'
    for req in ${REQUIREMENTS}; do
        if ! command_exists ${req}; then
            echo -e "${RED}To run me, you need: ${req}${RC}"
            exit 1
        fi
    done

    ## Check Package Handeler
    PACKAGEMANAGER='apt yum dnf pacman zypper'
    for pgm in ${PACKAGEMANAGER}; do
        if command_exists ${pgm}; then
            PACKAGER=${pgm}
            echo -e "Using ${pgm}"
        fi
    done

    if [ -z "${PACKAGER}" ]; then
        echo -e "${RED}Can't find a supported package manager"
        exit 1
    fi

     ## Check if the current directory is writable.
    GITPATH="$(dirname "$(realpath "$0")")"
    if [[ ! -w ${GITPATH} ]]; then
        echo -e "${RED}Can't write to ${GITPATH}${RC}"
        exit 1
    fi
     echo -e "${GREEN}Current path ${GITPATH}${RC}"
}


#######################################################
# Plugin Installation 
#######################################################
installStarship() {
     if command_exists starship; then
         echo "Starship already installed"
         return
     fi
     if ! winget install --id Starship.Starship; then
        echo -e "${RED}Something went wrong during starship install!${RC}"
        exit 1
    fi
    
}

installFzf() {
     if command_exists fzf; then
         echo "Fzf already installed"
         return
     fi
     if ! winget install fzf; then
        echo -e "${RED}Something went wrong during fzf install!${RC}"
        exit 1
    fi
    
}


installZoxide() {
    if command_exists zoxide; then
        echo "Zoxide already installed"
        return
    fi

    if ! winget install ajeetdsouza.zoxide; then
        echo -e "${RED}Something went wrong during zoxide install!${RC}"
        exit 1
    fi
}

installFastfetch() {
    if command_exists fastfetch; then
        echo "Fastfetch already installed"
        return
    fi

    if ! winget install fastfetch; then
        echo -e "${RED}Something went wrong during fastfetch install!${RC}"
        exit 1
    fi
}

install_zsh_syntax_highlighting() {
    local file_path="$USER_HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

    if [ -f "$file_path" ]; then
        echo "ZSH Syntax Highlighting installed"
    else
        echo -e "${YELLOW}Installing ZSH Syntax Highlighting....${RC}"
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$USER_HOME/.zsh/zsh-syntax-highlighting"
    fi
}

install_zsh_auto_suggestions() {
    local file_path="$USER_HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"

    if [ -f "$file_path" ]; then
        echo "ZSH Auto Suggestions installed"
    else
        echo -e "${YELLOW}Installing ZSH Auto Suggestions....${RC}"
        git clone https://github.com/zsh-users/zsh-autosuggestions "$USER_HOME/.zsh/zsh-autosuggestions"
    fi
}

install_fzf_tab() {
    local file_path="$USER_HOME/.zsh/fzf-tab/fzf-tab.zsh"

    if [ -f "$file_path" ]; then
        echo "FZF Tab installed"
    else
        echo -e "${YELLOW}Installing FZF Tab....${RC}"
        git clone https://github.com/Aloxaf/fzf-tab "$USER_HOME/.zsh/fzf-tab"
    fi
}


installPlugins() {
    echo -e "${GREEN}\nInstalling Programs....${RC}"
    installFastfetch
    installStarship
    installFzf
    installZoxide

    install_zsh_syntax_highlighting
    install_zsh_auto_suggestions
    install_fzf_tab

}

#######################################################
# Link Config files
#######################################################
linkBashConfig() {
    ## Get the correct user home directory.
   # USER_HOME=$USERPROFILE
   echo -e "\n${GREEN}Creating bashrc file....${RC}"

    ## Check if a bashrc file is already there.
    OLD_BASHRC="${USER_HOME}/.bashrc"

     if [[ -e ${OLD_BASHRC} ]]; then
        echo -e "${YELLOW}Moving old bash config file to $(printf "%q" "$USER_HOME")\.bashrc.bak${RC}"
         if ! mv ${OLD_BASHRC} ${USER_HOME}/.bashrc.bak; then
             echo -e "${RED}Can't move the old bash config file!${RC}"
            exit 1
        fi
     fi

    echo -e "${YELLOW}Linking new bash config file...${RC}"

    ## Make symbolic link.
    ln -svf ${GITPATH}/.bashrc ${USER_HOME}/.bashrc
   # ln -svf ${GITPATH}/starship.toml ${USER_HOME}/.config/starship.toml
}

linkZshConfig() {
    ## Get the correct user home directory.
    #USER_HOME=$USERPROFILE
    echo -e "\n${GREEN}Creating zshrc file....${RC}"

    ## Check if a zshrc file is already there.
    OLD_ZSHRC="${USER_HOME}/.zshrc"


     if [[ -e ${OLD_ZSHRC} ]]; then
        echo -e "${YELLOW}Moving old zsh config file to $(printf "%q" "$USER_HOME")\.zshrc.bak${RC}"
         if ! mv ${OLD_ZSHRC} ${USER_HOME}/.zshrc.bak; then
             echo -e "${RED}Can't move the old zsh config file!${RC}"
            exit 1
        fi
     fi

    echo -e "${YELLOW}Linking new zsh config file...${RC}"

    ## Make symbolic link.
    ln -svf ${GITPATH}/.zshrc ${USER_HOME}/.zshrc
}

linkConfig() {
     

    linkBashConfig
    linkZshConfig

    echo -e "\n${YELLOW}Linking starship toml file...${RC}"
    ln -svf ${GITPATH}/starship.toml ${USER_HOME}/.config/starship.toml
}


#######################################################
# Program Run 
#######################################################
checkEnv
installPlugins
linkConfig