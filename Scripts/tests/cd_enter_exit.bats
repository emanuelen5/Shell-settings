
setup () {
  cd "$BATS_TEST_DIRNAME"
  mkdir tmp
  cp cd_enter_exit.enter.sh tmp/.enter.sh
  cp cd_enter_exit.exit.sh tmp/.exit.sh
}

teardown () {
  rm -rf tmp
}

@test "Run on enter" {
  test -f tmp/.enter.sh
  cd tmp; cd ..
  test -f tmp/entered
}

@test "Run on exit" {
  test -f tmp/.exit.sh
  cd tmp; cd ..
  test -f tmp/exited
}
