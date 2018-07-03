function cd() {
  test -r .exit.sh && . .exit.sh
  if [ $# = 0 ]; then
    builtin cd
  else
    builtin cd "$1"
  fi
  test -r .enter.sh && . .enter.sh
}
