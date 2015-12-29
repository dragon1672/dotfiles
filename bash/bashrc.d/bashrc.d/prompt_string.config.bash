# Colors terminal
GREEN='\[\033[0;32m\]'
BLUE='\[\033[0;36m\]'
DEFAULTCOL='\[\e[m\]'
# This is the prefix thingy
export PS1="${BLUE}\h:\w\$ $DEFAULTCOL"
#export PS1="${GREEN}\h:\W $DEFAULTCOL" # The green blended in too much
PROMPT_DIRTRIM=3

unset GREEN
unset BLUE
unset DEFAULTTCOL
