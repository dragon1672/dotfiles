gl() {
  git log --graph --abbrev-commit --pretty=oneline --decorate
}

# Test whether we're in a git repo
is-git-repo() {
$(git rev-parse --is-inside-work-tree &> /dev/null)
}
stash() {
  if is-git-repo; then git stash "$@"; else command stash "$@"; fi
}
commit() {
  if is-git-repo; then git commit "$@"; else command commit "$@"; fi
}
br() {
  branch "$@"
}
branch() {
  if is-git-repo; then git branch "$@"; else command branch "$@"; fi
}
st() {
  if is-git-repo; then git st "$@"; else command st "$@"; fi
}
diff() {
  if is-git-repo; then git diff "$@"; else command diff "$@"; fi
}
push() {
  if is-git-repo; then git push "$@"; else command push "$@"; fi
}
add() {
  if is-git-repo; then git add "$@"; else command add "$@"; fi
}
