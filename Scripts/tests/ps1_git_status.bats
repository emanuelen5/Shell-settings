. Scripts/PS1_setup.sh
GIT_DIR="local1"
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
  git clone $GIT_REMOTE $GIT_DIR
}

teardown () {
  cd "$BATS_TEST_DIRNAME"
    rm -rf $GIT_DIR
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

function contains_string() {
  haystack=`strip_colors "$1"`
  needle="$2"
  if ! `echo "$haystack" | grep -q "$needle"`; then
    echo "Could not find needle in haystack" 1>&2
    echo "  haystack: '$haystack'" 1>&2
    echo "  needle:   '$needle'" 1>&2
    false
  fi
}

@test "Not git repo: Nothing appended to PS1" {
  cd /
    run ps1_git
    compare_strings "" "$output"
}

@test "Branch name displayed" {
  cd $GIT_DIR
    git checkout -b "branchname"
    run ps1_git
    compare_strings " (branchname)" "$output"
}

@test "Detached mode" {
  cd $GIT_DIR
    echo "v1" > testfile
    git commit -am "Second commit"
    git checkout HEAD^
    run ps1_git
    compare_strings " (`git rev-parse --short HEAD`)" "$output"
}

@test "Unstaged changes" {
  cd $GIT_DIR
    echo "v2" > testfile
    run ps1_git
    contains_string "$output" M
}

@test "Staged changes" {
  cd $GIT_DIR
    echo "v2" > testfile
    git add -u
    run ps1_git
    contains_string "$output" S
}

@test "Untracked file" {
  cd $GIT_DIR
    touch untracked_file
    run ps1_git
    contains_string "$output" ?
}

@test "Ahead of remote" {
  cd $GIT_DIR
    touch untracked_file
    git add -A
    git commit -m "Second commit"
    run ps1_git
    contains_string "$output" A
}

@test "Behind remote" {
  pushd $GIT_REMOTE
    touch untracked_file
    git add -A
    git commit -m "Second commit"
  popd
  cd $GIT_DIR
    git fetch
    run ps1_git
    contains_string "$output" B
}

@test "Conflict" {
  pushd $GIT_REMOTE
    echo "v2" > testfile
    git commit -am "Second commit remote"
  popd
  cd $GIT_DIR
    echo "v3" > testfile
    git commit -am "Second commit local"
    git pull || true
    run ps1_git
    contains_string "$output" C
}

@test "Diverged" {
  pushd $GIT_REMOTE
    echo "v2" > testfile
    git commit -am "Second commit remote"
  popd
  cd $GIT_DIR
    echo "v3" > testfile
    git commit -am "Second commit local"
    git fetch
    run ps1_git
    contains_string "$output" D
}

@test "Rebasing" {
  pushd $GIT_REMOTE
    echo 2 > 2
    git add 2
    git commit -m "Second file remote"
  popd
  cd $GIT_DIR
    echo 3 > 2
    git add 2
    git commit -m "Second file local"
    git fetch
    git rebase origin/master || true
    run ps1_git
    contains_string "$output" R
}
