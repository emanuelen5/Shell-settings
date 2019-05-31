#!/usr/bin/env bash
invocation="$0"

function print_usage {
  echo "Usage: ${invocation} STEPS_BACK [FROM_COMMIT]

Check out the tree relative to a commit (backwards) and display
its log. Mainly used for temporarily checking out parts so they
can be commited to another VCS system.

Arguments:
  STEPS_BACK   Number of commits to jump back
  FROM_COMMIT  From which commit to jump back"
}

# Check input arguments
if [ $# -lt 1 ]; then
  print_usage
  exit -1
else
  # TODO: Check that it is a positive integer
  STEPS_BACK="$1"
fi

if [ $# -lt 2 ]; then
  FROM_COMMIT="HEAD"
else
  FROM_COMMIT="$2"
fi

# Check out the real branch (instead of hash) if no steps back
if [ "$STEPS_BACK" -gt 0 ]; then
  STEPS_BACK_STR=~"$STEPS_BACK"
else
  STEPS_BACK_STR=""
fi
git checkout "${FROM_COMMIT}${STEPS_BACK_STR}" 1>/dev/null 2>/dev/null

# Display the graph
git log "$FROM_COMMIT" -"$((STEPS_BACK+2))" --oneline --graph --decorate

echo ""

# Show the whole log for the actual commit
git log -1
