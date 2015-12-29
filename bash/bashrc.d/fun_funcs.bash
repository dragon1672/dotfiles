matrix() { # this might be dangerous to run for a long time...consider remaking this sucker
  LC_ALL=C tr -c "[:digit:]" " " < /dev/urandom | dd cbs=$COLUMNS conv=unblock | GREP_COLOR="2;32" grep --color "[^ ]"
}
