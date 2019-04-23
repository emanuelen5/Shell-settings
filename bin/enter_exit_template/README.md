# Template for enter/exit scripts for a virtual environment *venv*
This is an example that sets up a virtual environment *venv* located in the folder upon entry, and deactivates it upon exit.

## Why
To automate setup of environment when in specific folders.

## How
1. Copy these scripts into a folder
2. Create a virtual environment *venv* in the folder: `virtualenv venv`
3. Modify the `cd` function: `source cd_enter_exit.sh` (located in the bin folder).
4. `cd` into the folder to run `.enter.sh` (activates the virtual environment *venv*)
5. `cd` out from the folder to run `.exit.sh` (deactivates the virtual environment *venv*)
