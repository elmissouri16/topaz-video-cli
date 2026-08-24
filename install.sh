#!/bin/zsh

set -eu

repository_dir="${0:A:h}"
source_command="$repository_dir/bin/topaz-video"
install_dir="$HOME/.local/bin"
installed_command="$install_dir/topaz-video"

if [[ ! -d "/Applications/Topaz Video.app" ]]; then
  print -r -- "Topaz Video is not installed at /Applications/Topaz Video.app" >&2
  exit 69
fi

if [[ ! -x "$source_command" ]]; then
  print -r -- "Repository command is missing or not executable: $source_command" >&2
  exit 66
fi

mkdir -p "$install_dir"
install -m 755 "$source_command" "$installed_command"

print -r -- "Installed: $installed_command"

if [[ ":$PATH:" != *":$install_dir:"* ]]; then
  print -r -- "Add this directory to your PATH: $install_dir"
fi

print -r -- "Try: topaz-video --help"
