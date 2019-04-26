# fzf-bookmarks

fzf-bookmarks is a script which helps the user quickly access bookmarked directories and files. It offers fuzzy completion which is provided by [fzf](https://github.com/junegunn/fzf). 

# Dependencies
The only things required are:
- [fzf](https://github.com/junegunn/fzf)
- awk
- sed

# Usage
This script needs to run in the same shell that it is invoked in. Therefore, it must be ran with the command `source` prepended to it. A helpful alias to do this would be `alias fzf-bookmarks='source ~/path/to/fzf-bookmarks'` which must be added to your `.bashrc`. If `fzf-bookmarks` is invoked without any flags provided, all bookmarks are shown without any filtering.  

fzf-bookmarks currently supports the following options/flags:  
- `-a` or `--add`: Add a directory to the bookmarks. This option requires the user to specify the name of the bookmark and optionally, a path. If no path is provided then the current folder is added to the bookmark list. NOTE: The bookmark name must be unique and it must not contain any spaces. On the other hand, the path provided can contain spaces.
- `-f` or `--file`: List all bookmarked only. When a file is selected, the config file located in `~/.config/fzf-bookmarks` is checked for the corresponding filetype. If none is found, the default is used which attempts to open the file with `$EDITOR`.
- `-d` or `--dir`: List all directories bookmarked.
- `-r` or `--remove`: Erase a bookmark from the list. This option requires the user to specify the name of the bookmark. This can either be specified explicitly as an argument or if the flag is used without any arguments provided, fzf can be used. NOTE: It currently does not support the removal of more than one bookmark at a time but will in the future.
- `-eraseall`: Removes the bookmarks file and replaces it with a new one.
- `-al` or `--alias`: List all aliases and select one to be executed. Handy if you want to remind yourself of an alias quickly and execute it at the same time. All aliases are retrieved from the `.bashrc` file. A valid alias is considered to be one of the form `alias myAliasName='someBashCommandHere'`.
- `-m` or `--man`: List all manpages. This feature is currently experimental and might not work as expected.
- `-h` or `--help`: List all available options.
- `--usage`: List a small preamble regarding the usage of this program.

# Example config file
Here is an example config file
```
c       $EDITOR
rs      $EDITOR
pdf     zathura
epub    zathura
png     vimiv
jpg     vimiv
txt     $EDITOR
DEFAULT $EDITOR
```
The only things which need to be added are the filetype and the corresponding program. If `$EDITOR` is a terminal one(vim, nano...), then it will be called in the current terminal/bash instance. If it is not then it will be run in the background with the `&` flag appended at the end of the command.

Another thing to note is that the filetype of the program is determined by looking at the file name starting from its last character until the first `.` is encountered. As an example `myfile.png` will have a filetype of `png`. On the other hand, if we create a file like `myfile.txt.pdf` then its file type will be `pdf`.
