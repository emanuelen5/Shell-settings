links=$*

GREEN_MARK=$(echo -en '\e[32m\u2713\e[0m')
has_error=false

link_install_file () {
	new_file="${HOME}/$1"
	file="$1"
	dir=$(cd -P $(dirname "$file"); pwd)

	# The symbolic link already point to the correct file
	if [ -L "$new_file" -a "$new_file" -ef "$file" ]; then
		echo " ${GREEN_MARK} Already up to date '$file'"
		return
	fi

	files_are_equal=false
	if [ -f "$new_file" ] || [ -d "$new_file" ]; then
		$(diff "$file" "$new_file" -q > /dev/null)
		files_are_equal=$?
		if [ "$files_are_equal" -eq 0 ]; then
			rm $new_file
		else
			echo "'$file' and '$new_file' differ. Merge or delete '$new_file' and run again to finish."
			has_error=true
			return
		fi
	fi

	if [ -L "$new_file" ]; then
		ln -sfn "$dir/$file" "$new_file"
		echo " ${GREEN_MARK} Corrected symbolic link for '$file'"
		return
	else
		ln -s "$dir/$file" "$new_file"
		echo " ${GREEN_MARK} Created symbolic link for '$file'"
	fi
}

for link in $links; do
	link_install_file "$link"
done

if [ "$has_error" = true ]; then
	exit 1
else
	exit 0
fi
