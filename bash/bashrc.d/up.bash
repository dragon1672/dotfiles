# Move up many directories

#Examples ~/a/b/c/d/e $ up
#         ~/a/b/c/d $

#Examples ~/a/b/c/d/e $ up 3
#         ~/a/b $

#Examples ~/a/b/c/d/e $ up b
#         ~/a/b $

#Examples ~/a/b/c/d/e $ up b/c
#         ~/a/b/c $

up() {
  if [[ $@ == "" ]];
  then
    cd ..
  else
    #are we dealing with a number
    if [[ $@ =~ ^-?[0-9]+$ ]]; then
      local path='./'
      for i in `seq 1 $@`; do
        path="$path../"
      done
      cd $path
    else #we are dealing with a string
      local path=$PWD/
      local foundFolder=${path##*$@}
      foundFolder=${foundFolder#*/}
      local cdUp=${foundFolder//[^\/]}
      cdUp=${#cdUp}
      #lets go there
      up $cdUp
    fi
  fi
}
