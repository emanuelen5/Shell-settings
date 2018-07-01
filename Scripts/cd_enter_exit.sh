function cd() {
  test -r .exit.sh && . .exit.sh
  builtin cd $1
  test -r .enter.sh && . .enter.sh
}
