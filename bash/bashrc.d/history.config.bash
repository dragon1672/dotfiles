# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# Keep the times of the commands in history
HISTTIMEFORMAT='%F %T  '

# Force multi line commands to one line
#shopt -s cmdhist

# Ignore the fluffy commands
HISTIGNORE='ls:history:pwd:git\ st:git\ status:git\ diff:clear:exit'i

