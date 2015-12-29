

prompt() {

 GREEN='\[\033[0;32m\]'
 BLUE='\[\033[0;36m\]'
 DEFAULTCOL='\[\e[m\]'
 PROMPT_DIRTRIM=

 if [ $# -eq 0 ] || [[ $* == *--default* ]]; then
  export PS1="${BLUE}\h:\w\$ $DEFAULTCOL"
  PROMPT_DIRTRIM=3
elif [[ $* == *--google*  ]]; then
  PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\ $ '
elif [[ $* == *--minimal*  ]]; then
  PS1="$ $DEFAULTCOL"

fi

}
prompt
