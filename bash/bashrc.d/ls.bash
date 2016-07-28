ls() {
  if [ "$(uname)" == "Darwin" ]; then
    command ls -G "$@"
  else
    command ls --color=auto "$@"
  fi

}
ll() {
  ls -alF "$@"
}
la() {
  ls -A "$@"
}
l() {
  ls -CF "$@"
}
