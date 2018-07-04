# Runs specific scripts in folder upon enter and exit
function cd() {
  test -r .exit.sh && . .exit.sh

  # Must special treat "no argument" case
  if [ $# = 0 ]; then
    builtin cd
  else
    builtin cd "$1"
  fi

  test -r .enter.sh && . .enter.sh
}
