gl() {
  git log --graph --abbrev-commit --pretty=oneline --decorate
}

# Test whether we're in a git repo
is-git-repo() {
  $(git rev-parse --is-inside-work-tree &> /dev/null)
}
