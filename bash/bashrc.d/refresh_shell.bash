refresh_shell() {
  if [ "$(uname)" == "Darwin" ]; then
    source ~/.bash_profile
  else
    source ~/.bashrc
  fi
}
rs() {
  refresh_shell
}
