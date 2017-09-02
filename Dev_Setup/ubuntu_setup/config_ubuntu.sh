# config_ubuntu.sh

# update and install packages for command line
printf "\n=========================\nadding apt repos \n=========================\n"    ; sudo add-apt-repository ppa:fontforge/fontforge
printf "\n=========================\nupdating packages\n=========================\n"    ; yes yes Y | sudo apt-get update
printf "\n=========================\ninstalling vim\n=========================\n"       ; yes yes Y | sudo apt-get install vim-gnome
printf "\n=========================\ninstalling git\n=========================\n"       ; yes yes Y | sudo apt-get install git
printf "\n=========================\ninstalling ctags\n=========================\n"     ; yes yes Y | sudo apt-get install exuberant-ctags
printf "\n=========================\ninstalling tmux\n=========================\n"      ; yes yes Y | sudo apt-get install tmux
printf "\n=========================\ninstalling dos2unix\n=========================\n"  ; yes yes Y | sudo apt-get install dos2unix
printf "\n=========================\ninstalling libgnome\n=========================\n"  ; yes yes Y | sudo apt-get install libgnome2-bin
printf "\n=========================\ninstalling xclip\n=========================\n"     ; yes yes Y | sudo apt-get install xclip
printf "\n=========================\ninstalling expect\n=========================\n"    ; yes yes Y | sudo apt-get install expect
printf "\n=========================\ninstalling fontforge\n=========================\n" ; yes yes Y | sudo apt-get install fontforge

# generate and save the new ssh key
printf "\n====================================================================\n"    
echo | ssh-keygen -t rsa -b 4096 -C "2014justinnguyen@gmail.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
xclip -sel clip < ~/.ssh/id_rsa.pub

# interactive sript with directions for installing the ssh key
printf "\n====================================================================\n"    
echo "Just copied the ~/.ssh/id_rsa.pub file into the clipboard. So don't try to copy anything (i.e. don't use Ctrl-c)"
echo "A hyperlink will open soon. After it does, go back to these instructions (more will pop up after the link is opened)"

echo
while true; do
read -p "Are you ready? " yn
case $yn in
	[Yy]* | "" ) break;;
	[Nn]*      ) ;;
	*          ) echo "Please press enter  OR  answer yes or no.";;
esac
done
echo

firefox https://github.com/settings/keys
while true; do
read -p "Ready for the rest of the instructions? " yn
case $yn in
	[Yy]* | "" ) break;;
	[Nn]*      ) ;;
	*          ) echo "Please press enter  OR  answer yes or no.";;
esac
done
echo

echo "1. Log in to Github"
echo "2. Click New SSH Key"
echo "3. Put in an appropriate title"
echo "4. Press Ctrl-v in the Key box (it should match the contents of ~/.ssh/id_rsa.pub)"
echo "5. Click Add SSH Key"

echo
while true; do
read -p "Are you done? " yn
case $yn in
	[Yy]* | "" ) break;;
	[Nn]*      ) ;;
	*          ) echo "Please press enter  OR  answer yes or no.";;
esac
done
echo

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

# get config directory from my repo
cd ~/Github/
~/clone_my_configs.sh

# take care of vimrc, plugin installation, and removing bad files
sudo cp ~/Github/My_Configs/vimrc /usr/share/vim/
~/Github/My_Configs/Dev_Setup/ubuntu_setup/.run_plugin_install.sh
sudo rm -rf ~/.vim/bundle/vim-snippets/snippets/*
sudo rm -rf ~/.vim/bundle/vim-template/templates/*

# copy over some config files
cp ~/Github/My_Configs/.bashrc      ~/
cp ~/Github/My_Configs/.inputrc     ~/
cp ~/Github/My_Configs/.tmux.conf   ~/
cp ~/Github/My_Configs/.profile     ~/
cp ~/Github/My_Configs/snippets/*   ~/.vim/bundle/vim-snippets/snippets/
cp ~/Github/My_Configs/templates/*  ~/.vim/bundle/vim-template/templates/
cp ~/Github/My_Configs/syntax/*     ~/.vim/after/syntax/
cp ~/Github/My_Configs/ftplugin/*   ~/.vim/after/ftplugin/
cp ~/Github/My_Configs/plugin/*     ~/.vim/after/plugin/

# set up git login credentials and other config stuff
cd ~/
git config --global user.email "2014justinnguyen@gmail.com"
git config --global user.name "Justin Nguyen"
git config --global push.default simple
git config --global core.autocrlf false
git config http.postBuffer 52428800

# grab miniconda script file
cd ~/  &&  wget -c http://repo.continuum.io/miniconda/Miniconda-latest-Linux-x86_64.sh --no-check-certificate
sudo chmod 755 ~/Miniconda-latest-Linux-x86_64.sh
~/Miniconda-latest-Linux-x86_64.sh -b -p $HOME/miniconda2

# source the ~/.profile so that the shell recognizes conda
source ~/.profile

# do some conda configuration
conda config --set ssl_verify false
conda config --add channels conda-forge

# install the python libraries through conda
~/Github/My_Configs/Dev_Setup/ubuntu_setup/.install_conda_libs.sh

# copy over the ipython config file
cp ~/Github/My_Configs/ipython_config.py ~/.ipython/profile_default/

# make some symlinks
ln -s ~/.vim/bundle/vim-snippets/snippets/c.snippets        ~/snippets/c.snippets
ln -s ~/.vim/bundle/vim-snippets/snippets/cpp.snippets      ~/snippets/cpp.snippets
ln -s ~/.vim/bundle/vim-snippets/snippets/java.snippets     ~/snippets/java.snippets
ln -s ~/.vim/bundle/vim-snippets/snippets/python.snippets   ~/snippets/python.snippets
ln -s ~/miniconda2/lib/python2.7/site-packages/             conda_packages

# set the dev env var in ~/.profile and source it
vim -c ":silent! %s/ENV_TYPE=\"cygwin\"/ENV_TYPE=\"ubuntu\"/g" -c ":xa" ~/.profile
source ~/.profile

# last note about permanently sourcing ~/.profile
printf "\n\n=================================================================================================================\n\n"
echo "The script sources ~/.profile but I think you need to actually restart the VM (power off) to have it be permanently sourced"
echo "Go to the snippets dir in ~/.vim/bundle/vim-snippets/snippets/ and remove all of the code folds manually"
