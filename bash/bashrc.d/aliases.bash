# some more ls aliases
alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"

if [ ! "$(uname)" == "Darwin" ]; then
  alias say='spd-say'
fi
