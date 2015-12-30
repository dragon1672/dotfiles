CDPATH=.:~
cd() {

  if [[ ! $@ == "-" ]]; then
    # CDPATH causes ouput on ever CD
    # This gobbles up that output
    command cd $@ > /dev/null
  else
    # cd - also dumps the path to the console, but we want that
    command cd -
  fi
}
