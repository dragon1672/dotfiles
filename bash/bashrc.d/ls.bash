ls() {
  command ls --color=auto $@
}
ll() {
  ls -alF
}
la() {
  ls -A
}
l() {
  ls -CF
}
