#######################################################
# My Help Function
#######################################################

RC='\e[0m' #Reset Color
RED='\e[31m'
YELLOW='\e[33m'
GREEN='\e[32m'

zhelp() {
  local COMMANDS="z fzf history trash"
  local param="$1"
  echo " "
  if [[ "$param" == "fzf" ]]; then
    printf "${GREEN}FZF : command-line fuzzy finder${RC}\n"
    echo "---------------------------------------------------------------"
    printf "${YELLOW} Ctrl + R${RC} : search your command history\n"
    printf "${YELLOW} Ctrl + T${RC} : search o your files (with your current working directory dictating where to perform the search recursively)\n"
  elif [[ "$param" == "z" ]]; then
    printf "${GREEN}Zoxide (z) : smarter cd command, inspired by z and autojump.${RC}\n"
    echo "---------------------------------------------------------------"
    printf "${YELLOW}zoxide${RC} : man pages\n"
    printf "${YELLOW}z  <path>${RC} : jump to path that has been searched before\n"
    printf "${YELLOW}zi <path>${RC} : search previously used paths\n"
  elif [[ "$param" == "history" ]]; then
    printf "${GREEN}history : list of previous commands.${RC}\n"
    echo "---------------------------------------------------------------"
    printf "${YELLOW}history${RC} : show  previous commands. Enter ${YELLOW}!<number>${RC} to go to that command\n"
    printf "${YELLOW}history | <searchtext>${RC} : show previous commands containing the search text. Enter ${YELLOW}!<number>${RC} to go to that command\n"
  elif [[ "$param" == "trash" ]]; then
    printf "${GREEN}trash : safely remove files and directories.${RC}\n"
    echo "---------------------------------------------------------------"
    printf "${YELLOW}trash <file | dir>${RC} : removes file or directory\n"
    printf "${YELLOW}trash-list>${RC} : show list of files in trash\n"
    printf "${YELLOW}trash-restore <dir>${RC} : show list of files in ${YELLOW}<dir>${RC} that can be restored\n"
  else
    echo -e "Following commands: ${GREEN}$COMMANDS${RC}"
    echo -e "Enter a command after help : ${YELLOW}zhelp <command>${RC}"
  fi
}

