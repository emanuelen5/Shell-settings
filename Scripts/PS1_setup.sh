## Ansi escape codes taken from http://www.termsys.demon.co.uk/vtansi.htm#colors
# Set attribute mode      <ESC>[{attr1};...;{attrn}m
# Attributes: 
#   0   Reset all attributes
#   1   Bright
#   2   Dim
#   4   Underscore
#   5   Blink
#   7   Reverse
#   8   Hidden
# Basic colors (for foreground and backgrounds with base number 'n'. E.g. <ESC>[31m for red foreground):
#   n+0  Black
#   n+1  Red
#   n+2  Green
#   n+3  Yellow
#   n+4  Blue
#   n+5  Magenta
#   n+6  Cyan
#   n+7  White
#   n+8;2;R;G;B  RGB-color (e.g. <ESC>[38;2;255;0;0m for red foreground)
# Foreground colors (starts at 30)
# Background colors (starts at 40)
# Bright foreground (starts at 90)
# Bright background (starts at 100)

# Reset
Color_Off="\e[0m"
Color_Underscore="\e[4m"
Color_Reverse="\e[7m"

# Regular Colors
Black="\e[0;30m"        # Black
Red="\e[0;31m"          # Red
Green="\e[0;32m"        # Green
Yellow="\e[0;33m"       # Yellow
Blue="\e[0;34m"         # Blue
Purple="\e[0;35m"       # Purple
Cyan="\e[0;36m"         # Cyan
White="\e[0;37m"        # White
# Background
On_Black="\e[0;40m"       # Black
On_Red="\e[0;41m"         # Red
On_Green="\e[0;42m"       # Green
On_Yellow="\e[0;43m"      # Yellow
On_Blue="\e[0;44m"        # Blue
On_Purple="\e[0;45m"      # Purple
On_Cyan="\e[0;46m"        # Cyan
On_White="\e[0;47m"       # White
# Bright foregrounds 
IBlack="\e[0;90m"       # Black
IRed="\e[0;91m"         # Red
IGreen="\e[0;92m"       # Green
IYellow="\e[0;93m"      # Yellow
IBlue="\e[0;94m"        # Blue
IPurple="\e[0;95m"      # Purple
ICyan="\e[0;96m"        # Cyan
IWhite="\e[0;97m"       # White
# Bright backgrounds
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

# High Intensty backgrounds
eOn_IBlack="\[${On_IBlack}\]"   # Black
eOn_IRed="\[${On_IRed}\]"       # Red
eOn_IGreen="\[${On_IGreen}\]"   # Green
eOn_IYellow="\[${On_IYellow}\]" # Yellow
eOn_IBlue="\[${On_IBlue}\]"     # Blue
eOn_IPurple="\[${On_IPurple}\]" # Purple
eOn_ICyan="\[${On_ICyan}\]"     # Cyan
eOn_IWhite="\[${On_IWhite}\]"   # White

# Taken from: http://mediadoneright.com/content/ultimate-git-ps1-bash-prompt
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
    git_is_ahead=`echo $status | grep "Your branch is ahead of"`;
    git_is_behind=`echo $status | grep "Your branch is behind"`;
    git_has_conflict=`echo $status | grep -P "Your branch .* conflict"`;
    git_has_diverged=`echo $status | grep -P "Your branch .* have diverged"`;
    git_rebasing=`echo $status | grep "rebase in progress"`;
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
    if [ -z "$git_is_clean" ]; then
      echo -ne ", ";
      if [ -n "$git_is_ahead" ]; then echo -ne "${ICyan}A"; fi;
      if [ -n "$git_is_behind" ]; then echo -ne "${ICyan}B"; fi;
      if [ -n "$git_has_conflict" ]; then echo -ne "${IRed}C"; fi;
      if [ -n "$git_has_diverged" ]; then echo -ne "${IRed}D"; fi;
      if [ -n "$git_rebasing" ]; then echo -ne "${IRed}R"; fi;
      if [ -n "$git_has_staged_changes" ]; then echo -ne "${IYellow}S"; fi;
      if [ -n "$git_has_unstaged_changes" ]; then echo -ne "${IRed}M"; fi;
      if [ -n "$git_has_untracked_files" ]; then echo -ne "${IYellow}?"; fi;
    fi;
    echo -ne "${Color_Off})";
  fi;
}

dir_names () {
  local dir_index=0
  dirs -p | while read dir; do
    if [ $dir_index -eq 0 ]; then
      echo -n "$(sed 's/ /\\ /' <<< "$dir")"
      echo -e "$IBlack"
    else
      echo "$(sed 's/.*\///; s/ /\\ /' <<< "$dir")"
    fi
    dir_index=$(($dir_index + 1))
  done
}

dir_names_oneline() {
  dir_names | tr '\n' ' '
}

export PS1="${eIBlack}${HistoryNumber} ${Time24h} ${eBlue}\$(dir_names_oneline)\$(ps1_git) \n${eGreen}\$ ${eColor_Off}"
