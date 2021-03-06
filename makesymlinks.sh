#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=${PWD}
olddir=${PWD}/old
vundleDir=~/.vim/bundle/Vundle.vim
files="vimrc minttyrc"    # list of files/folders to symlink in homedir

##########

# create dotfiles_old in homedir
echo -n "Creating $olddir for backup of any existing dotfiles in ~ ..."
mkdir -p $olddir
echo "done"

# change to the dotfiles directory
#echo -n "Changing to the $dir directory ..."
#cd $dir
#echo "done"

# install vundle
if [ -d "$vundleDir" ]; then
	cd "$vundleDir"
	git pull origin master
	cd -
else
	git clone https://github.com/VundleVim/Vundle.vim.git "$vundleDir"
fi

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the ~/dotfiles directory specified in $files
for file in $files; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/.$file $olddir
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done


# update vundle:
vim +PluginInstall +qall

