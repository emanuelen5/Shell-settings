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

# Activate venv upon entering the directory
enter_exit_template_folder="~/Shell-settings/Scripts/enter_exit_template"
if [ -d $enter_exit_template_folder ]; then
  cp $enter_exit_template_folder/.{enter,exit}.sh .
else
  echo "Could not find enter/exit scripts in '$enter_exit_template_folder'"
fi

PYTHON_EXECUTABLE=`which python`
PROMPT="($1) "

echo "Setting python prompt to \"${PROMPT}\""
echo "Using executable on path \"${PYTHON_EXECUTABLE}\""
echo "Creating virtual environment in ${PWD}/venv"
echo -n "Installing..."

virtualenv --python="${PYTHON_EXECUTABLE}" --prompt="${PROMPT}" venv >/dev/null
echo " Done!"
echo ""
echo "Don't forget to activate the virtual environment (i.e. \`source .enter.sh\`, using the enter/exit scripts)!"
