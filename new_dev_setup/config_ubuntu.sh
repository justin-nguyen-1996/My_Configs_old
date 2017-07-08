#! /bin/sh
#
# config_ubuntu.sh
#

# update and install packages for command line
yes yes Y | sudo apt-get update
yes yes Y | sudo apt-get install vim-gnome
yes yes Y | sudo apt-get install git
yes yes Y | sudo apt-get install exuberant-ctags
yes yes Y | sudo apt-get install tmux
yes yes Y | sudo apt-get install dos2unix
yes yes Y | sudo apt-get install libgnome2-bin
yes yes Y | sudo apt-get install xclip

# make directories
mkdir -p ~/.vim/after/syntax/
mkdir -p ~/.vim/after/ftplugin/
mkdir -p ~/.vim/after/plugin/
mkdir -p ~/.vim/bundle/
mkdir -p ~/snippets
mkdir -p ~/Github

# get the Vundle plugin
cd ~/  &&  git clone https://github.com/VundleVim/Vundle.vim.git 
mv ~/Vundle.vim ~/.vim/bundle/Vundle.vim
vim -c ":PluginInstall" -c ":qa"

# remove bad snippet and template files
rm -rf ~/.vim/bundle/vim-snippets/snippets/*
rm -rf ~/.vim/bundle/vim-template/templates/*

# get config directory from my repo
cd ~/Github/  &&  git clone git@github.com:justin-nguyen-1996/My_Configs.git

# copy over some config files
cp ~/Github/My_Configs/.bashrc ~/
cp ~/Github/My_Configs/.inputrc ~/
cp ~/Github/My_Configs/.tmux.conf ~/
cp ~/Github/My_Configs/.profile ~/
cp ~/Github/My_Configs/vimrc /usr/share/vim/
cp ~/Github/My_Configs/snippets/* ~/.vim/bundle/vim-snippets/snippets/
cp ~/Github/My_Configs/templates/* ~/.vim/bundle/vim-template/templates/
cp ~/Github/My_Configs/syntax/* ~/.vim/after/syntax/
cp ~/Github/My_Configs/ftplugin/* ~/.vim/after/ftplugin/
cp ~/Github/My_Configs/plugin/* ~/.vim/after/plugin/

# make some symlinks
ln -s ~/.vim/bundle/vim-snippets/snippets/c.snippets ~/snippets/c.snippets
ln -s ~/.vim/bundle/vim-snippets/snippets/cpp.snippets ~/snippets/cpp.snippets
ln -s ~/.vim/bundle/vim-snippets/snippets/java.snippets ~/snippets/java.snippets
ln -s ~/.vim/bundle/vim-snippets/snippets/python.snippets ~/snippets/python.snippets
# TODO
ln -s ~/miniconda2/lib/python2.7/site-packages/ conda_packages

# fix the super annoying CRLF warning thing from git
cd ~/Github/My_Configs/  &&  git config core.autocrlf false

# appropriately set the development environment variable in ~/.profile
vim -c ":silent! %s/ENV_TYPE=\"cygwin\"/ENV_TYPE=\"ubuntu\"/g" -c ":xa" ~/.profile

Miscellaneous Notes:
- sudo apt-get update
- sudo apt-get install vim-gnome
- sudo apt-get install git
- get an ssh key --> https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/
  - ssh-keygen -t rsa -b 4096 -C "2014justinnguyen@gmail.com"
- run 'git pull' so you can configure login info and use git push --simple I think
- run 'git config core.autocrlf false' on all Github dirs
- might need to run dos2unix on files that give weird errors
- remove unnecessary folders from ~/

