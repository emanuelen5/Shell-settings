# Taken from: http://mediadoneright.com/content/ultimate-git-ps1-bash-prompt

# Customize BASH PS1 prompt to show current GIT repository and branch.
# by Mike Stewart - http://MediaDoneRight.com

# SETUP CONSTANTS
# Bunch-o-predefined colors.  Makes reading code easier than escape sequences.
# I don't remember where I found this.  o_O

# Reset
Color_Off="\e[0m"       # Text Reset

# Regular Colors
Black="\e[0;30m"        # Black
Red="\e[0;31m"          # Red
Green="\e[0;32m"        # Green
Yellow="\e[0;33m"       # Yellow
Blue="\e[0;34m"         # Blue
Purple="\e[0;35m"       # Purple
Cyan="\e[0;36m"         # Cyan
White="\e[0;37m"        # White

# Bold
BBlack="\e[1;30m"       # Black
BRed="\e[1;31m"         # Red
BGreen="\e[1;32m"       # Green
BYellow="\e[1;33m"      # Yellow
BBlue="\e[1;34m"        # Blue
BPurple="\e[1;35m"      # Purple
BCyan="\e[1;36m"        # Cyan
BWhite="\e[1;37m"       # White

# Underline
UBlack="\e[4;30m"       # Black
URed="\e[4;31m"         # Red
UGreen="\e[4;32m"       # Green
UYellow="\e[4;33m"      # Yellow
UBlue="\e[4;34m"        # Blue
UPurple="\e[4;35m"      # Purple
UCyan="\e[4;36m"        # Cyan
UWhite="\e[4;37m"       # White

# Background
On_Black="\e[40m"       # Black
On_Red="\e[41m"         # Red
On_Green="\e[42m"       # Green
On_Yellow="\e[43m"      # Yellow
On_Blue="\e[44m"        # Blue
On_Purple="\e[45m"      # Purple
On_Cyan="\e[46m"        # Cyan
On_White="\e[47m"       # White

# High Intensty
IBlack="\e[0;90m"       # Black
IRed="\e[0;91m"         # Red
IGreen="\e[0;92m"       # Green
IYellow="\e[0;93m"      # Yellow
IBlue="\e[0;94m"        # Blue
IPurple="\e[0;95m"      # Purple
ICyan="\e[0;96m"        # Cyan
IWhite="\e[0;97m"       # White

# Bold High Intensty
BIBlack="\e[1;90m"      # Black
BIRed="\e[1;91m"        # Red
BIGreen="\e[1;92m"      # Green
BIYellow="\e[1;93m"     # Yellow
BIBlue="\e[1;94m"       # Blue
BIPurple="\e[1;95m"     # Purple
BICyan="\e[1;96m"       # Cyan
BIWhite="\e[1;97m"      # White

# High Intensty backgrounds
On_IBlack="\e[0;100m"   # Black
On_IRed="\e[0;101m"     # Red
On_IGreen="\e[0;102m"   # Green
On_IYellow="\e[0;103m"  # Yellow
On_IBlue="\e[0;104m"    # Blue
On_IPurple="\e[10;95m"  # Purple
On_ICyan="\e[0;106m"    # Cyan
On_IWhite="\e[0;107m"   # White

# Reset
eColor_Off="\[${Color_Off}\]"   # Text Reset

# Regular Colors
eBlack="\[${Black}\]"           # Black
eRed="\[${Red}\]"               # Red
eGreen="\[${Green}\]"           # Green
eYellow="\[${Yellow}\]"         # Yellow
eBlue="\[${Blue}\]"             # Blue
ePurple="\[${Purple}\]"         # Purple
eCyan="\[${Cyan}\]"             # Cyan
eWhite="\[${White}\]"           # White

# Bold
eBBlack="\[${BBlack}\]"         # Black
eBRed="\[${BRed}\]"             # Red
eBGreen="\[${BGreen}\]"         # Green
eBYellow="\[${BYellow}\]"       # Yellow
eBBlue="\[${BBlue}\]"           # Blue
eBPurple="\[${BPurple}\]"       # Purple
eBCyan="\[${BCyan}\]"           # Cyan
eBWhite="\[${BWhite}\]"         # White

# Underline
eUBlack="\[${UBlack}\]"         # Black
eURed="\[${URed}\]"             # Red
eUGreen="\[${UGreen}\]"         # Green
eUYellow="\[${UYellow}\]"       # Yellow
eUBlue="\[${UBlue}\]"           # Blue
eUPurple="\[${UPurple}\]"       # Purple
eUCyan="\[${UCyan}\]"           # Cyan
eUWhite="\[${UWhite}\]"         # White

# Background
eOn_Black="\[${On_Black}\]"     # Black
eOn_Red="\[${On_Red}\]"         # Red
eOn_Green="\[${On_Green}\]"     # Green
eOn_Yellow="\[${On_Yellow}\]"   # Yellow
eOn_Blue="\[${On_Blue}\]"       # Blue
eOn_Purple="\[${On_Purple}\]"   # Purple
eOn_Cyan="\[${On_Cyan}\]"       # Cyan
eOn_White="\[${On_White}\]"     # White

# High Intensty
eIBlack="\[${IBlack}\]"         # Black
eIRed="\[${IRed}\]"             # Red
eIGreen="\[${IGreen}\]"         # Green
eIYellow="\[${IYellow}\]"       # Yellow
eIBlue="\[${IBlue}\]"           # Blue
eIPurple="\[${IPurple}\]"       # Purple
eICyan="\[${ICyan}\]"           # Cyan
eIWhite="\[${IWhite}\]"         # White

# Bold High Intensty
eBIBlack="\[${BIBlack}\]"       # Black
eBIRed="\[${BIRed}\]"           # Red
eBIGreen="\[${BIGreen}\]"       # Green
eBIYellow="\[${BIYellow}\]"     # Yellow
eBIBlue="\[${BIBlue}\]"         # Blue
eBIPurple="\[${BIPurple}\]"     # Purple
eBICyan="\[${BICyan}\]"         # Cyan
eBIWhite="\[${BIWhite}\]"       # White

# High Intensty backgrounds
eOn_IBlack="\[${On_IBlack}\]"   # Black
eOn_IRed="\[${On_IRed}\]"       # Red
eOn_IGreen="\[${On_IGreen}\]"   # Green
eOn_IYellow="\[${On_IYellow}\]" # Yellow
eOn_IBlue="\[${On_IBlue}\]"     # Blue
eOn_IPurple="\[${On_IPurple}\]" # Purple
eOn_ICyan="\[${On_ICyan}\]"     # Cyan
eOn_IWhite="\[${On_IWhite}\]"   # White

# Various variables you might want for your PS1 prompt instead
# see https://ss64.com/bash/syntax-prompt.html
Date="\d" # The data, in "Weekday Month Date" format (e.g., "Tue May 26")
hostname="\h" # The hostname, up to the first "." (e.g. deckard)
Hostname="\H" # The whole hostname (e.g. deckard.SS64.com)

Time21hs="\A" # The time in 24-hour HH:MM format
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
ps1_git () {
  status=`git status 2>/dev/null`;
  if [ $? -eq 0 ]; then
    branch_name=`echo $status | grep -Po "(?<=On branch )\\S+"`;

    # If not on a branch
    if [ -z "$branch_name" ]; then
      branch_name=`echo $status | grep -Po "(?<=HEAD detached at )\\S+"`;
    fi;
    echo -ne "${Color_Off} (";
    git_is_clean=`echo $status | grep "nothing to commit"`;
    git_is_updated=`echo $status | grep "up-to-date"`;
    git_is_ahead=`echo $status | grep "Your branch is ahead of"`;
    git_has_staged_changes=`echo $status | grep "Changes to be committed:"`;
    git_has_unstaged_changes=`echo $status | grep "Changes not staged for commit"`;
    git_has_untracked_files=`echo $status | grep "Untracked files:"`;
    if [ -n "$git_is_clean" ]; then
      echo -ne "${IGreen}";
    elif [ -n "$git_has_unstaged_changes" ]; then
      echo -ne "${IRed}";
    else
      echo -ne "${IYellow}";
    fi
    echo -ne "$branch_name";
    if [ -n "$git_is_ahead" ] || [ -n "$git_has_staged_changes" ] || [ -n "$git_has_unstaged_changes" ] || [ -n "$git_has_untracked_files" ]; then echo -ne ", "; fi;
    if [ -n "$git_is_ahead" ]; then echo -ne "${ICyan}A"; fi;
    if [ -n "$git_has_staged_changes" ]; then echo -ne "${IYellow}S"; fi;
    if [ -n "$git_has_unstaged_changes" ]; then echo -ne "${IRed}M"; fi;
    if [ -n "$git_has_untracked_files" ]; then echo -ne "${IYellow}?"; fi;
    echo -ne "${Color_Off})";
  fi;
}

export PS1="${eIBlack}${CommandNumber} ${Time24h} ${eBlue}${PathShort}${eColor_Off}\$(ps1_git)"$'\n'"${eGreen}\$ ${eColor_Off}"
