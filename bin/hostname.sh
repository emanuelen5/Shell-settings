host="$(uname -s)"

case "$host" in
    Linux*) # Linux
		host=linux
		;;
    Darwin*) # Mac
		host=mac
		;;
    CYGWIN*|MINGW*|MSYS_NT*) # Windows
		host=windows
		;;
    *) # Unknown
		echo "Unknown host=$host"
		;;
esac

