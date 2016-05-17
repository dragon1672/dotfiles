gl() {
  git log --graph --abbrev-commit --pretty=oneline --decorate
}

# Test whether we're in a git repo
is-git-repo() {
$(git rev-parse --is-inside-work-tree &> /dev/null)
}

stash() {
  is-git-repo && git stash "$@" || command stash
}
commit() {
  is-git-repo && git commit "$@" || command commit
}
br() {
  branch "$@"
}
branch() {
  is-git-repo && git branch "$@" || command branch
}
st() {
  is-git-repo && git st "$@" || command st
}
diff() {
  is-git-repo && git diff "$@" || command diff
}
push() {
  is-git-repo && git push "$@" || command push
}
add() {
  is-git-repo && git add "$@" || command add
}
