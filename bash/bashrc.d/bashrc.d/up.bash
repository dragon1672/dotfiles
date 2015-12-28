# Move up many directories
up() {
  if [[ $@ == "" ]];
  then
    cd ..
  else
    for i in `seq 1 $@`; do
      cd ..
    done
  fi
}
