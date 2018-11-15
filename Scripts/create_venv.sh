#/bin/bash

function print_usage() {
   echo "Usage: $0 <venv_name>"
}

if [ $# -lt 1 ]; then
  echo "Not enough arguments supplied"
  print_usage
  exit
fi

venv_name="$1"

cp ~/Shell-settings/Scripts/enter_exit_template/.{enter,exit}.sh .
PYTHON_EXECUTABLE=`which python`
PROMPT="($1) "

virtualenv --python="${PYTHON_EXECUTABLE}" --prompt="${PROMPT}" venv
