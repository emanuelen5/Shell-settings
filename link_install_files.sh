GIT_DIR=$1
shift
links=$*

GREEN_MARK=$(echo -en '\e[32m\u2713\e[0m')

link_install_file () {
  new_file="${HOME}/$1"
  file="$1"
  if [ -f "$new_file" ] || [ -d "$new_file" ]; then
    if ! `diff "$file" "$new_file" -q > /dev/null`; then
      echo "'$file' and '$new_file' differ. Merge or delete '$new_file' and run again to finish."
    fi;
  else
    ln -s "$GIT_DIR/$file" "$new_file"
    echo " ${GREEN_MARK} Creating symbolic link for '$file'"
  fi
}

for link in $links; do
	link_install_file "$link"
done
