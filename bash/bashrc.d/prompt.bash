#default pre prompt is first 3 letters of username
[ -z ${MY_PROMPT_PRE_TEXT+x} ] && MY_PROMPT_PRE_TEXT=${USER:0:3}:
#default line ender
[ -z ${MY_PROMPT_LINE_ENDER+x} ] && MY_PROMPT_LINE_ENDER=" » "
[ -z ${MY_PROMPT_SHORTEN_LEN+x} ] && MY_PROMPT_SHORTEN_LEN=14
[ -z ${MY_PROMPT_PATH_SHORTCUTS+x} ] && MY_PROMPT_PATH_SHORTCUTS=(
$HOME'::~'
)

if [ -z ${PROMPT_COMMAND+x} ]; then PROMPT_COMMAND=""; fi
tmp='declare -i PROMPT_RETURN=$?'
if [[ $PROMPT_COMMAND != *$tmp* ]]; then
  PROMPT_COMMAND=" $tmp ; $PROMPT_COMMAND"
fi
unset tmp

prompt() {

  #TODO use tput and expose the vars
  local GREEN='\[\e[38;5;22m\]'
  local BLUE='\[\033[0;36m\]'
  local STATUSCOLOR=$BLUE
  local VERSIONCOLOR=$GREEN
  local DEFAULTCOL='\[\e[m\]'
  PROMPT_DIRTRIM=

  case $1 in
    set)
        shift;
        PS1="$@"
        return
        ;;

    on)
      # clear any current effects and set color
      PS1="${DEFAULTCOL}${STATUSCOLOR}"
      if [[ $* == *--google* ]]; then
        PS1=$PS1'\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\'
      elif [[ $* != *--minimal* ]]; then
        PS1=$PS1'$MY_PROMPT_PRE_TEXT'
        #PS1=$PS1'\h:' # Host
        #PS1=$PS1'\u:' # User
        #PS1=$PS1'\w'  # Full Directory path
        PS1=$PS1'$(prompt path)'  # Smart dir path
        PROMPT_DIRTRIM=2
        if [[ $* != *-light* ]]; then
          PS1=$PS1$VERSIONCOLOR
          PS1=$PS1'$(prompt git)'
          PS1=$PS1$STATUSCOLOR
          PS1=$PS1'$(prompt job)'
          PS1=$PS1'$(prompt ret)'
        fi
      fi
      PS1=$PS1'$MY_PROMPT_LINE_ENDER'$DEFAULTCOL

      ;;
    off)
      prompt on --minimal
      ;;
    job) # Show the count of background jobs in curly brackets, if not zero
      local -i jobc
      while read -r _ ; do
        ((jobc++))
      done < <(jobs -p)
      if ((jobc > 0)) ; then
        printf '{%u}' "$jobc"
      fi
      ;;

    path)
      local pwd_length=$MY_PROMPT_SHORTEN_LEN # collapse logic length trigger
      local pwd_symbol="..."
      local newPWD=$PWD
      if [ -d .git ] || git rev-parse --git-dir &> /dev/null; then
        local gitFullDir=$(git rev-parse --show-toplevel)
        local gitDir=$(basename $gitFullDir 2>/dev/null)
        newPWD=${newPWD/#$gitFullDir/$gitDir}
      fi
      #local tmp='~'
      #newPWD="${newPWD/$HOME/$tmp}"

      # Replace user defined shortcuts
      for index in "${MY_PROMPT_PATH_SHORTCUTS[@]}" ; do
        local KEY="${index%%::*}"
        local VALUE="${index##*::}"
        newPWD="${newPWD/$KEY/$VALUE}"
      done

      # Collapse logic
      local numPathsTmp="${newPWD//[^\/]}" # get just the folder slashes
      numPathsTmp=${#numPathsTmp} # could folder slashes to get number of dirs
      if [ $(echo -n $newPWD | wc -c | tr -d " ") -gt $pwd_length ] &&
        [ $numPathsTmp -gt 3 ] # has to be at more than 3 folders
    then
      newPWD=$(echo -n $newPWD | awk -F '/' '{
      print $1 "/'$pwd_symbol'/" $(NF-1) "/" $(NF)}')
    fi
    echo $newPWD
    ;;
  git)

    branch=$(git symbolic-ref HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null) || return 1 # return if there is no branch :(

    branch=${branch##*/} # trimmed down the branch name

    #TODO: use git status --porcelain to determin what file status it is
    gitstatus=$(git status -z --porcelain 2>/dev/null) #-z makes it 1 line
    statusMods=''
    if [[ -n $gitstatus ]]; then
      statusMods="*"
      #statusMods="∴"
      #statusMods="•"
      #statusMods="⟡"
    fi

    #local gitsymbol="☁ "
    #local gitsymbol="♆ "
    #local gitsymbol=""
    echo '['$gitsymbol$branch''$statusMods']'

    ;;
  ret)
    if (( $PROMPT_RETURN > 0 )) || [[ $* == *--show* ]] ; then
      if [[ $* == *--clear* ]]; then
        str='%d'
      else
        #  ⦃ ⦄ ⦅ ⦆ ⦇ ⦈ ⦉ ⦊ ⦋ ⦌ ⦍ ⦎ ⦏ ⦐ ⦑ ⦒ ⦓ ⦔ ⦕ ⦖ ⦗ ⦘ ⦙ ⦚ ⦛ ⦜ ⦝ ⦞ ⦟
        str='<%d>'
        #str='⦅%d⦆'
        #str='⦑%d⦒'
      fi
      printf $str "$PROMPT_RETURN"
    fi
    ;;
esac
}

prompt on
