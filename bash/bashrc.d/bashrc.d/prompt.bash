

if [ -z ${PROMPT_COMMAND+x} ]; then PROMPT_COMMAND=""; fi
tmp='declare -i PROMPT_RETURN=$?'
if [[ $PROMPT_COMMAND != *$tmp* ]]; then
  PROMPT_COMMAND=" $tmp ; $PROMPT_COMMAND"
fi
unset tmp

prompt() {

  GREEN='\e[38;5;22m'
  BLUE='\[\033[5;36m\]'
  STATUSCOLOR=$BLUE
  VERSIONCOLOR=$GREEN
  DEFAULTCOL='\[\e[m\]'
  PROMPT_DIRTRIM=

  case $1 in
    on)
      PS1="${STATUSCOLOR}"
      if [ $# -eq 1 ] || [[ $* == *--default* ]]; then
        #PS1=$PS1'\h:\w'
        PS1=$PS1'\u:\w'
        PROMPT_DIRTRIM=2
        if [[ $* != *--light* ]]; then
          PS1=$PS1$VERSIONCOLOR
          PS1=$PS1'$(prompt git)'
          PS1=$PS1$STATUSCOLOR
          PS1=$PS1'$(prompt ret)'
        fi
      elif [[ $* == *--google*  ]]; then
        PS1=$PS1'\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\'
        #elif [[ $* == *--minimal*  ]]; then
      fi
      PS1=$PS1'$ '$DEFAULTCOL

      ;;
    off)
      prompt on --minimal
      ;;
    git)

      branch=$(git symbolic-ref HEAD 2>/dev/null)
      if [[ ! -n $branch ]]; then return 1; fi # there is no branch :(

      branch=${branch##*/} # trimmed down the branch name

      #TODO: use git status --porcelain to determin what file status it is
      gitstatus=$(git status -z --porcelain) #-z makes it 1 line
      statusMods=''
      if [[ -n $gitstatus ]]; then
        statusMods="*"
      fi

      printf '[git:'$branch''$statusMods']'

      ;;
    ret)
      if (( $PROMPT_RETURN > 0 )) || [[ $* == *--show* ]] ; then
        if [[ $* == *--clear* ]]; then
          str='%d'
        else
          str='<%d>'
        fi
        printf $str "$PROMPT_RETURN"
      fi
      ;;
  esac
}

prompt on
