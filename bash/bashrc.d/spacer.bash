spacer() {
  lines=${1:-$LINES}
  for i in $(seq 1 $lines); do
    cols=$(( COLUMNS - 1 ))
    line=''
    for j in $(seq 1 $cols); do
      line=$line'~'
    done
    echo $line
  done
}
