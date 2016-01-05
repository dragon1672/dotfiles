#Sets the window title
title() {
  mytitle=$@
  echo -en '\033k'$mytitle'\033\\'
}
