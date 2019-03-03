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
	local bmarkLineNum=$(wc -l $bookmarkPath) 
	echo $bookmarkPath
	if [ "$bmarkLineNum" == 0 ]
	then
		printf "You do not have any bookmarks set\n"
		exit 0
	else
	 	selectedBookmark=$(awk '{print $1}' $bookmarkPath | fzf)
	 	if [ ! -z selectedBookmark ]
		then 
	 		cd $(awk -v var="$selectedBookmark" '$1 == var {print $2}' $bookmarkPath)
			# make the change of directory affect the parent shell 
			# and not just the subshell
			exec bash
		 fi
	fi
}

# Add a new bookmark
# If a path is not provided then the current directory is used
function addBookmark(){
	if [ -z "$2" ] 
	then
		printf "$1\t$PWD\n" >> $bookmarkPath
	else
		printf "$1\t$2\n" >> $bookmarkPath
	fi
}

function removeBookmark(){
	if [ ! -z "$2" ]
	then
		printf "Too many arguments. Either provide the name of a bookmark or do not provide anything to delete through fzf\n"
	# case of no arg provided, use fzf to select
	elif [ -z "$1" ]
	then
			selectedBookmark=$(awk '{print $1}' $bookmarkPath | fzf)
			# Handle the case of the user pressing CTRL+C
			# if we do not check that $selectedBookmark is not empty
			# then the entire list of bookmarks is deleted
			if [ ! -z $selectedBookmark ]
			then
				# remove the selected bookmark
				# using sed instead of awk since we do not 
				# have to copy the entire file over
				sed -i "/^$selectedBookmark/d" $bookmarkPath
			fi
			exit 0
	# case of providing a name manually
	else 
		local selectedBookmarkIndex=$(awk -v var="$1" '$1 == var {print NR}' $bookmarkPath)
		if [ ! -z $selectedBookmarkIndex ]
		then
				# delete the line number 
				sed -i "$selectedBookmarkIndex"d "$bookmarkPath"
		else
				printf "Bookmark not found!\n"
		fi
	fi
}

# Parse script arguments
if [ -z $1 ]
then 
	switchToBookmark
elif [ $1 == "-a" ]
then
	addBookmark "$2" "$3"
elif [ $1 == "-r" ]
then
	removeBookmark "$2" "$3"	
fi
