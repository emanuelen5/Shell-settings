I've gathered some haxy stuff for the terminal since I tend to forget a lot of them.
Sources:
* [How to geek: Keyboard shortcuts for bash command shell (...)](https://www.howtogeek.com/howto/ubuntu/keyboard-shortcuts-for-bash-command-shell-for-ubuntu-debian-suse-redhat-linux-etc)
* [Digital ocean: How to use bash history commands and expansion (...)](https://www.digitalocean.com/community/tutorials/how-to-use-bash-history-commands-and-expansions-on-a-linux-vps)
* [Catonmat: Bash VI editing mode cheat sheet](http://www.catonmat.net/download/bash-vi-editing-mode-cheat-sheet.pdf)

# For emacs mode (`set -o emacs`)

## <kbd>Ctrl</kbd>+<kbd>s</kbd> behavior

```bash
stty -ixon # Make the terminal not stop when pressing Ctrl-s
stty ixany # Revert
```

## Shortcuts

### History
| Command                       | Description                    |
|:------------------------------|--------------------------------|
| <kbd>Ctrl</kbd>+<kbd>\_</kbd> | Undo last key press            |
| <kbd>Alt</kbd>+<kbd><</kbd>   | Go to start of history         |
| <kbd>Alt</kbd>+<kbd>></kbd>   | Go to end of history (current) |
| <kbd>Ctrl</kbd>+<kbd>r</kbd>  | Search backwards in history    |
| <kbd>Ctrl</kbd>+<kbd>s</kbd>  | Search forwards in history     |
| <kbd>Ctrl</kbd>+<kbd>g</kbd>  | Cancel search                  |
| <kbd>Ctrl</kbd>+<kbd>o</kbd>  | Run current command            |

### Navigating
| Command                      | Description                    |
|:-----------------------------|--------------------------------|
| <kbd>Ctrl</kbd>+<kbd>a</kbd> | Go to beginning of line        |
| <kbd>Ctrl</kbd>+<kbd>e</kbd> | Go to end of line              |
| <kbd>Ctrl</kbd>+<kbd>b</kbd> | Go backwards one character     |
| <kbd>Alt</kbd>+<kbd>b</kbd>  | Go backwards one word          |
| <kbd>Ctrl</kbd>+<kbd>f</kbd> | Go forwards one character      |
| <kbd>Alt</kbd>+<kbd>f</kbd>  | Go forwards one word           |

### Capitalization
| Command  | Description                    |
|:---------|--------------------------------|
| <kbd>Alt</kbd>+<kbd>u</kbd>  | Capitalize every character from the cursor to the end of the current word, converting the characters to upper case.| 
| <kbd>Alt</kbd>+<kbd>l</kbd>  | Uncapitalize every character from the cursor to the end of the current word, converting the characters to lower case.| 
| <kbd>Alt</kbd>+<kbd>c</kbd>  | Capitalize the character under the cursor. Your cursor will move to the end of the current word.| 

# For vi mode (`set -o vi`)
