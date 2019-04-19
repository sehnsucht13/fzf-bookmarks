# fzf-bookmarks

fzf-bookmarks is a script which helps the user quickly access bookmarked directories and files. It offers fuzzy completion which is provided by [fzf](https://github.com/junegunn/fzf). 

# Dependencies
The only things required are:
- [fzf](https://github.com/junegunn/fzf)
- awk
- sed

# Usage
This script needs to run in the same shell that it is invoked in. Therefore, it must be ran with the command `source` prepended to it. A helpful alias to do this would be `alias fzf-bookmarks="source ~/path/to/fzf-bookmarks"` which must be added either to your `.profile` or to `.bashrc`. If `fzf-bookmarks` is invoked without any flags provided, all bookmarks are shown without any filtering.  

fzf-bookmarks currently supports the following options/flags:  
- `-a`: Add a directory to the bookmarks. This option requires the user to specify the name of the bookmark and optionally, a path. If no path is provided then the current folder is added to the bookmark list. NOTE: The bookmark name must be unique!  
- `-f`: List all bookmarked only. When a file is selected, the config file located in `~/.config/fzf-bookmarks` is checked for the corresponding filetype. If none is found, the default is used which attempts to open the file with `$EDITOR`.
- `-d`: List all directories bookmarked.
- `-r`: Erase a bookmark from the list. This option requires the user to specify the name of the bookmark. This can either be specified explicitly as an argument or if the flag is used without any arguments provided, fzf can be used. NOTE: It currently does not support the removal of more than one bookmark at a time but will in the future.
- `-eraseall`: Removes the bookmarks file and replaces it with a new one.
- `al`: List all aliases and select one to be executed. Handy if you want to remind yourself of an alias quickly.
- `m`: List all manpages. This feature is currently experimental and might not work as expected.

# Example config file
