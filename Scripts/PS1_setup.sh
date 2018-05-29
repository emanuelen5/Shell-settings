# Taken from: http://mediadoneright.com/content/ultimate-git-ps1-bash-prompt

# Customize BASH PS1 prompt to show current GIT repository and branch.
# by Mike Stewart - http://MediaDoneRight.com

# SETUP CONSTANTS
# Bunch-o-predefined colors.  Makes reading code easier than escape sequences.
# I don't remember where I found this.  o_O

# Reset
Color_Off="\[\033[0m\]"       # Text Reset

# Regular Colors
Black="\[\033[0;30m\]"        # Black
Red="\[\033[0;31m\]"          # Red
Green="\[\033[0;32m\]"        # Green
Yellow="\[\033[0;33m\]"       # Yellow
Blue="\[\033[0;34m\]"         # Blue
Purple="\[\033[0;35m\]"       # Purple
Cyan="\[\033[0;36m\]"         # Cyan
White="\[\033[0;37m\]"        # White

# Bold
BBlack="\[\033[1;30m\]"       # Black
BRed="\[\033[1;31m\]"         # Red
BGreen="\[\033[1;32m\]"       # Green
BYellow="\[\033[1;33m\]"      # Yellow
BBlue="\[\033[1;34m\]"        # Blue
BPurple="\[\033[1;35m\]"      # Purple
BCyan="\[\033[1;36m\]"        # Cyan
BWhite="\[\033[1;37m\]"       # White

# Underline
UBlack="\[\033[4;30m\]"       # Black
URed="\[\033[4;31m\]"         # Red
UGreen="\[\033[4;32m\]"       # Green
UYellow="\[\033[4;33m\]"      # Yellow
UBlue="\[\033[4;34m\]"        # Blue
UPurple="\[\033[4;35m\]"      # Purple
UCyan="\[\033[4;36m\]"        # Cyan
UWhite="\[\033[4;37m\]"       # White

# Background
On_Black="\[\033[40m\]"       # Black
On_Red="\[\033[41m\]"         # Red
On_Green="\[\033[42m\]"       # Green
On_Yellow="\[\033[43m\]"      # Yellow
On_Blue="\[\033[44m\]"        # Blue
On_Purple="\[\033[45m\]"      # Purple
On_Cyan="\[\033[46m\]"        # Cyan
On_White="\[\033[47m\]"       # White

# High Intensty
IBlack="\[\033[0;90m\]"       # Black
IRed="\[\033[0;91m\]"         # Red
IGreen="\[\033[0;92m\]"       # Green
IYellow="\[\033[0;93m\]"      # Yellow
IBlue="\[\033[0;94m\]"        # Blue
IPurple="\[\033[0;95m\]"      # Purple
ICyan="\[\033[0;96m\]"        # Cyan
IWhite="\[\033[0;97m\]"       # White

# Bold High Intensty
BIBlack="\[\033[1;90m\]"      # Black
BIRed="\[\033[1;91m\]"        # Red
BIGreen="\[\033[1;92m\]"      # Green
BIYellow="\[\033[1;93m\]"     # Yellow
BIBlue="\[\033[1;94m\]"       # Blue
BIPurple="\[\033[1;95m\]"     # Purple
BICyan="\[\033[1;96m\]"       # Cyan
BIWhite="\[\033[1;97m\]"      # White

# High Intensty backgrounds
On_IBlack="\[\033[0;100m\]"   # Black
On_IRed="\[\033[0;101m\]"     # Red
On_IGreen="\[\033[0;102m\]"   # Green
On_IYellow="\[\033[0;103m\]"  # Yellow
On_IBlue="\[\033[0;104m\]"    # Blue
On_IPurple="\[\033[10;95m\]"  # Purple
On_ICyan="\[\033[0;106m\]"    # Cyan
On_IWhite="\[\033[0;107m\]"   # White

# Various variables you might want for your PS1 prompt instead
# see https://ss64.com/bash/syntax-prompt.html
Date="\d" # The data, in "Weekday Month Date" format (e.g., "Tue May 26")
hostname="\h" # The hostname, up to the first "." (e.g. deckard)
Hostname="\H" # The whole hostname (e.g. deckard.SS64.com)

Time24h="\t" # The time in 24-hour HH:MM:SS format
Time12h="\T" # The time in 12-hour HH:MM:SS format
Time12a="\@" # The time in 12-hour am/pm format
PathShort="\w" # The current working directory
PathFull="\W" # The basename of $PWD
Jobs="\j" # The number of jobs currently managed by the shell
ShellBasename="\l" # The basename of the shell's terminal device name
ShellName="\s" # The name of the shell. The basename of $0 (portion following the final slash)
Username="\u" # The username of the current user
BashVersion="\v" # The version of Bash (e.g. 2.00)
BashRelease="\V" # The release of Bash. Version + patchlevel (e.g. 2.00.0)
HistoryNumber="\!" # The history number of this command
CommandNumber="\#" # The command number of this command
#"\$" - If you are not root: inserts "$"; if you are root "#"
#"\nnn" - The character whose ASCII code is the octal value nnn
#\n - A newline
#\r - Carriage return
#\e - An escape character (typically a color code)
#\a - A bell character
#\\ - A backslash

# This is evaluated when the start for the shell row is printed
dynamic_echo_git_color='$(
  status=`git status 2>/dev/null`;
  if [ $? -eq 0 ]; then
    branch_name=`echo $status | grep -Po "(?<=On branch )\\S+"`;

    # If not on a branch
    if [ -z "$branch_name" ]; then
      branch_name=`echo $status | grep -Po "(?<=HEAD detached at )\\S+"`;
    fi;
    echo -n "'${Color_Off}' (";
    git_is_clean=`echo $status | grep "nothing to commit"`;
    git_is_updated=`echo $status | grep "up-to-date"`;
    git_is_ahead=`echo $status | grep "Your branch is ahead of"`;
    git_has_staged_changes=`echo $status | grep "Changes to be committed:"`;
    git_has_unstaged_changes=`echo $status | grep "Changes not staged for commit"`;
    git_has_untracked_files=`echo $status | grep "Untracked files:"`;
    if [ -n "$git_is_clean" ]; then
      echo -n "'${IGreen}'";
    elif [ -n "$git_has_unstaged_changes" ]; then
      echo -n "'${IRed}'";
    else
      echo -n "'${IYellow}'";
    fi
    echo -n "$branch_name";
    if [ -n "$git_is_ahead" ] || [ -n "$git_has_staged_changes" ] || [ -n "$git_has_unstaged_changes" ] || [ -n "$git_has_untracked_files" ]; then echo -n ", "; fi;
    if [ -n "$git_is_ahead" ]; then echo -n "'${ICyan}'A"; fi;
    if [ -n "$git_has_staged_changes" ]; then echo -n "'${IYellow}'S"; fi;
    if [ -n "$git_has_unstaged_changes" ]; then echo -n "'${IRed}'M"; fi;
    if [ -n "$git_has_untracked_files" ]; then echo -n "'${IYellow}'?"; fi;
    echo -n "'${Color_Off}')";
  fi;
)'
export PS1="${IBlack}${Time12h}${dynamic_echo_git_color}${Green} \$ ${Color_Off}"
