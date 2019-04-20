. Scripts/PS1_setup.sh
GIT_DIR1="local1"
GIT_REMOTE="remote"

setup () {
  cd "$BATS_TEST_DIRNAME"
  mkdir $GIT_REMOTE
  pushd $GIT_REMOTE
    git init
    touch testfile
    git add testfile
    git commit -m "Initial commit"
  popd
  git clone $GIT_REMOTE $GIT_DIR1
}

teardown () {
  cd "$BATS_TEST_DIRNAME"
  rm -rf $GIT_DIR1
  rm -rf $GIT_REMOTE
}

function strip_colors() {
  echo $1 | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g"
}

function compare_strings() {
  expected="$1"
  actual=`strip_colors "$2"`
  if [ ! "$expected" = "$actual" ]; then
    echo "Strings differ" 1>&2
    echo "  expected: '$expected'" 1>&2
    echo "  got:      '$actual'" 1>&2
    false
  fi
}

@test "Not git repo: Nothing appended to PS1" {
  cd /
  run ps1_git
  compare_strings "" "$output"
}

@test "Branch name displayed" {
  cd $GIT_DIR1
  git checkout -b "branchname"
  run ps1_git
  compare_strings " (branchname)" "$output"
}

@test "Detached mode" {
  cd $GIT_DIR1
  echo "v1" > testfile
  git commit -am "Second commit"
  git checkout HEAD^
  run ps1_git
  compare_strings " (`git rev-parse --short HEAD`)" "$output"
}

@test "Unstaged changes" {
  cd $GIT_DIR1
  echo "v2" > testfile
  run ps1_git
  echo "$output" | grep M
}

@test "Staged changes" {
  cd $GIT_DIR1
  echo "v2" > testfile
  git add -u
  run ps1_git
  echo "$output" | grep S
}

@test "Untracked file" {
  cd $GIT_DIR1
  touch untracked_file
  run ps1_git
  echo "$output" | grep ?
}

@test "Ahead of remote" {
  cd $GIT_DIR1
  touch untracked_file
  git add -A
  git commit -m "Second commit"
  run ps1_git
  echo "$output" | grep A
}

@test "Behind remote" {
  pushd $GIT_REMOTE
    touch untracked_file
    git add -A
    git commit -m "Second commit"
  popd
  cd $GIT_DIR1
  git fetch
  run ps1_git
  echo "$output" | grep B
}

@test "Conflict" {
  false "Not implemented yet"
  echo "$output" | grep C
}

@test "Diverged" {
  false "Not implemented yet"
  echo "$output" | grep D
}

@test "Rebasing" {
  false "Not implemented yet"
  echo "$output" | grep R
}
