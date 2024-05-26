#!/bin/bash

RC='\e[0m'  #Reset Colors
RED='\e[31m'
YELLOW='\e[33m'
GREEN='\e[32m'

command_exists() {
    command -v $1 >/dev/null 2>&1
}


checkEnv() {
    ## Check for requirements.
    REQUIREMENTS='curl winget'
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

#######################################################
# Link Config files
#######################################################
linkConfig() {
    ## Get the correct user home directory.
    USER_HOME=$USERPROFILE

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
    ln -svf ${GITPATH}/starship.toml ${USER_HOME}/.config/starship.toml
}


#######################################################
# Program Run 
#######################################################
checkEnv
installStarship
installFzf
installZoxide
installFastfetch
linkConfig