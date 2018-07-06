# Runs specific scripts in folder upon enter and exit
function cd() {
  local exitcode
  if [ -r .exit.sh ]; then
    . .exit.sh
  fi

  # Must special treat "no argument" case
  if [ $# = 0 ]; then
    builtin cd
  else
    builtin cd "$1"
  fi
  exitcode=$?

  if [ -r .enter.sh ]; then
    . .enter.sh
  fi

  test $exitcode -eq 0
}
