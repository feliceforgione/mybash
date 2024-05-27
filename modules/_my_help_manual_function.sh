#######################################################
# My Help Function
#######################################################

# function help {
#   local ecode=${2:-0}

#   [[ -n $1 ]] && printf "\n $1\n" >&2

# cat >&2 << helpMessage

#   Usage: ${0##*/} <ofile> <file.c> [ <cflags> ... --log [ \$(<./bldflags)]]

#     ${0##*/} calls 'gcc -Wall -o <ofile> <file.c> <cflags> <\$(<./bldflags)>'
#     If the file './bldflags' exists in the present directory, its contents are
#     read into the script as additional flags to pass to gcc. It is intended to
#     provide a simple way of specifying additional libraries common to the source
#     files to be built. (e.g. -lssl -lcrypto).

#     If the -log option is given, then the compile string and compiler ouput are
#     written to a long file in ./log/<ofile>_gcc.log

#   Options:

#     -h  |  --help  program help (this file)
#     -l  |  --log   write compile string and compiler ouput to ./log/<ofile>_gcc.log

# helpMessage

#   exit $ecode
# }

RC='\e[0m'  #Reset Color
RED='\e[31m'
YELLOW='\e[33m'
GREEN='\e[32m'



 help() {
  local param="$1"
  echo " "
  if [[ "$param" == "fzf" ]]; then
    printf "${GREEN}FZF${RC} : command-line fuzzy finder\n"
    echo "---------------------------------------------------------------"
    printf "${YELLOW} Ctrl + R${RC} : search your command history\n" 
    printf "${YELLOW} Ctrl + T${RC} : search o your files (with your current working directory dictating where to perform the search recursively)\n"
  else
        echo -e "Following commands: ${GREEN}fzf${RC}"
        echo -e "Enter a command after help : ${YELLOW}help fzf${RC}"
  fi
}

