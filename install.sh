#!/usr/bin/env bash

CURRENT_DIR=$PWD;

cd "$(dirname "${BASH_SOURCE}")";

git pull origin master;

function doIt() {
	rsync -avh --no-perms ./dotfiles/. ~;
	source ~/.bash_profile;
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt;
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt;
	fi;
fi;
unset doIt;

cd "$CURRENT_DIR"