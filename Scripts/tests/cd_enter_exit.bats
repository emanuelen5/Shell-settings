. Scripts/cd_enter_exit.sh

setup () {
  cd "$BATS_TEST_DIRNAME"
  mkdir tmp
  cp cd_enter_exit.enter.sh tmp/.enter.sh
  cp cd_enter_exit.exit.sh tmp/.exit.sh
}

teardown () {
  rm -rf tmp
}

@test ".enter.sh run on enter" {
  test -f tmp/.enter.sh
  cd tmp; cd ..
  test -f tmp/entered
}

@test ".exit.sh run on exit" {
  test -f tmp/.exit.sh
  cd tmp; cd ..
  test -f tmp/exited
}

@test "Failure when directory does not exist" {
  NON_EXISTING_DIRECTORY=tmp/_nonexistend_directory
  test ! -d $NON_EXISTING_DIRECTORY # Precondition for testing
  run cd $NON_EXISTING_DIRECTORY
  test $status -ne 0
}
