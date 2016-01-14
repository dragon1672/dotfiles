# Move up many directories
up() {
  if [[ $@ == "" ]];
  then
    cd ..
  else
    local path=''
    for i in `seq 1 $@`; do
      path="$path../"
    done
    cd $path
  fi
}
