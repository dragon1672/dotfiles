CDPATH=.:~
cd() {
  if [[ $@ == "-" ]]; then
    command cd -
  else
    command cd $@ > /dev/null
  fi
}
