spacer() {
  lines=${1:-$LINES}
  for i in $(seq 1 $lines); do
    for j in $(seq 1 $COLUMNS); do
      echo -n '~'
    done
    echo
  done
}
