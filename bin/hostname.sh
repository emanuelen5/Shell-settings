case "$(uname -s)" in
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
		;;
esac

