GIT_DIR=$1

link_install_file () {
  new_file="${HOME}/$1"
  file="$1"
  if [ -f "$new_file" ] || [ -d "$new_file" ]; then
    if `diff "$file" "$new_file" -q > /dev/null`; then
      # Identical file
      echo "Skipping '$new_file'"
    else
      echo "'$file' and '$new_file' differ. Merge or delete '$new_file' and run again to finish."
    fi;
  else
    ln -s "$GIT_DIR/$file" "$new_file"
    echo "Creating symbolic link for '$file'"
  fi
}

link_install_file .gitconfig
link_install_file .bashrc
link_install_file Scripts
