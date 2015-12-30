vim() {
  command vim -p $@
}

edit() {
  vim $@
}

view() {
  vim -R $@
}

vi() {
  vim $@
}
