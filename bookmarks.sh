#! /usr/bin/bash

# Holds the selected bookmark
selectedBookmark=""

# holds the path to the bookmark file
bookmarkPath="$HOME/.config/fzf-bookmarks/bookmarks"

# check if fzf is installed
if   ! type "fzf" > /dev/null; then
		echo "fzf is not installed! Please install it before using this program"
		exit 1
fi

# check if the bookmark file exists
# if it does not, it will be created in the .config folder
function checkBookmarkDirectory(){
	if [ ! -d "$HOME/.config/fzf-bookmarks" ]
	then
			cd "$HOME/.config"
			mkdir "fzf-bookmarks"
			cd "fzf-bookmarks"
			touch "bookmarks"
	fi
}

# change directories to the selected bookmark
function switchToBookmark(){
	 selectedBookmark=$(awk '{print $1}' $bookmarkPath | fzf)
	 cd $(awk -v va="$selectedBookmark" '$1 == va {print $2}' $bookmarkPath)
	 # make the change of directory affect the parent shell 
	 # and not just the subshell
	 exec bash
}

# Add a new bookmark
function addBookmark(){
	if [ -z "$2" ] 
	then
		printf "$1\t$PWD\n" >> $bookmarkPath
	else
		printf "$1\t$2\n" >> $bookmarkPath
	fi
}

checkBookmarkDirectory
