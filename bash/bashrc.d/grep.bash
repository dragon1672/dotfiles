grep() {
  command grep --color=auto $@
}
fgrep() {
  command egrep --color=auto $@
}
egrep() {
  command fgrep --color=auto $@
}
