#! /bin/sh
#
# temp.sh
#

# vim -c ":PluginInstall" -c ":qa"
# vim -c ":silent! %s/ENV_TYPE=\"cygwin\"/ENV_TYPE=\"ubuntu\"/g" -c ":xa" ~/.profile

# yes yes Y | sudo apt-get install exuberant-ctags
# Y | sudo apt-get remove exuberant-ctags

# yes yes Y | sudo apt-get update
# yes yes Y | sudo apt-get install vim-gnome
# yes yes Y | sudo apt-get install git
# yes yes Y | sudo apt-get install exuberant-ctags
# yes yes Y | sudo apt-get install tmux
# yes yes Y | sudo apt-get install dos2unix
# yes yes Y | sudo apt-get install libgnome2-bin

echo | ssh-keygen -t rsa -b 4096 -C "2014justinnguyen@gmail.com"
