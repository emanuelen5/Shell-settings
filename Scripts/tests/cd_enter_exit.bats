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

@test "Script exit status does not propagate" {
  echo "false" > tmp/.enter.sh
  echo "false" > tmp/.exit.sh

  run cd tmp
  test $status # Enter status

  run cd ..
  test $status # Exit status
}

function compare_strings() {
  expected="$1"
  actual="$2"
  if [ ! "$expected" = "$actual" ]; then
    echo "Strings differ" 1>&2
    echo "  expected: '$expected'" 1>&2
    echo "  got:      '$actual'" 1>&2
    false
  fi
}

function cd_check_syntax_error() {
  script_name="$1"
  expected_string0="$script_name: line 1: syntax error near unexpected token \`syntax_failure'"
  expected_string1="$script_name: line 1: \`test ( syntax_failure )'"

  cd tmp
  echo "test ( syntax_failure )" > $script_name

  run cd .
  echo "ouput: $output" 1>&2
  test $status -eq 0
  compare_strings "$expected_string0" "${lines[0]}"
  compare_strings "$expected_string1" "${lines[1]}"
}

@test ".enter.sh syntax error" {
  cd_check_syntax_error .enter.sh
}

@test ".exit.sh syntax error" {
  cd_check_syntax_error .exit.sh
}
