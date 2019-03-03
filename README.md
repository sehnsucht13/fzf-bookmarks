# fzf-bookmarks

fzf-bookmarks is a script which helps the user quickly access bookmarked directories(and possibly files in the future). It offers fuzzy completion which is provided by [fzf](https://github.com/junegunn/fzf). 

# Dependencies
The only thing required is that [fzf](https://github.com/junegunn/fzf) is installed and is in the shell path.

# Usage
fzf-bookmarks currently supports the following options:\
`-a`: Add a directory to the bookmarks. This option requires the user to specify the name of the bookmark and optionally, a path. If no path is provided then the current folder is added to the bookmark list. NOTE: The bookmark name must be unique!\
`-r`: Erase a bookmark from the list. This option requires the user to specify the name of the bookmark. This can either be specified explicitly as an argument or if the flag is used without any arguments provided, fzf can be used. NOTE: It currently does not support the removal of more than one bookmark at a time but will in the future.\
`-eraseall`: Removes the bookmarks file and replaces it with a new one. Used if most of them are useless.\

