# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectoriesm
if [ ! "$(uname)" == "Darwin" ]; then
  shopt -s globstar
fi

# minor spell check
shopt -s cdspell
