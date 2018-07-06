# Runs specific scripts in folder upon enter and exit
function cd() {
  if [ -r .exit.sh ]; then
    . .exit.sh
  fi

  # Must special treat "no argument" case
  if [ $# = 0 ]; then
    builtin cd
  else
    builtin cd "$1"
  fi

  if [ -r .enter.sh ]; then
    . .enter.sh
  fi
}
