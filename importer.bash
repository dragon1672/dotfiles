currentDir=$(dirname $0)

# takes in {dot file name} {directory to export to}
generalImporter() {
  local name=$1
  local dir=$2
  mkdir -p "$dir"
  cp -f "$HOME/.$name" "$dir/$name"
  if [[ -d "$HOME/$name.d/" ]]; then
    rm -rf "$dir/$name.d"
    mkdir -p "$dir/$name.d"
    cp -r "$HOME/$name.d/" "$dir/"
  fi
}

generalImporter bashrc "$currentDir/bash"
generalImporter profile "$currentDir/bash"
generalImporter inputrc "$currentDir/bash"
generalImporter tmux.conf "$currentDir/tmux"
