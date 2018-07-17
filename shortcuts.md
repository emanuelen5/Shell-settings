I've gathered some haxy stuff for the terminal since I tend to forget a lot of them.
Sources:
* [How to geek: Keyboard shortcuts for bash command shell (...)](https://www.howtogeek.com/howto/ubuntu/keyboard-shortcuts-for-bash-command-shell-for-ubuntu-debian-suse-redhat-linux-etc)
* [Digital ocean: How to use bash history commands and expansion (...)](https://www.digitalocean.com/community/tutorials/how-to-use-bash-history-commands-and-expansions-on-a-linux-vps)
* [Catonmat: Bash VI editing mode cheat sheet](http://www.catonmat.net/download/bash-vi-editing-mode-cheat-sheet.pdf)

# For emacs mode (`set -o emacs`)

## Ctrl-s behavior

```bash
stty -ixon # Make the terminal not stop when pressing Ctrl-s
stty ixany # Revert
```

## Shortcuts

### History
| Command  | Description                    |
|---------:|--------------------------------|
| `Ctrl+_` | Undo last key press            |
| `Alt+<`  | Go to start of history         |
| `Alt+>`  | Go to end of history (current) |
| `Ctrl+r` | Search backwards in history    |
| `Ctrl+s` | Search forwards in history     |
| `Ctrl+g` | Cancel search                  |
| `Ctrl+o` | Run current command            |

### Navigating
| Command  | Description                    |
|---------:|--------------------------------|
| `Ctrl+a` | Go to beginning of line        |
| `Ctrl+e` | Go to end of line              |
| `Ctrl+b` | Go backwards one character     |
| `Alt+b`  | Go backwards one word          |
| `Ctrl+f` | Go forwards one character      |
| `Alt+f`  | Go forwards one word           |

### Capitalization
| Command  | Description                    |
|---------:|--------------------------------|
| `Alt+u`  | Capitalize every character from the cursor to the end of the current word, converting the characters to upper case.| 
| `Alt+l`  | Uncapitalize every character from the cursor to the end of the current word, converting the characters to lower case.| 
| `Alt+c`  | Capitalize the character under the cursor. Your cursor will move to the end of the current word.| 

# For vi mode (`set -o vi`)
