# config_ubuntu.sh

# update and install packages for command line
printf "\n=========================\nadding apt repos \n=========================\n"    ; sudo add-apt-repository ppa:fontforge/fontforge
printf "\n=========================\nadding apt repos \n=========================\n"    ; sudo apt-add-repository ppa:git-core/ppa
printf "\n=========================\nupdating packages\n=========================\n"    ; yes yes Y | sudo apt-get update
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
mkdir -p ~/.vim/after/autoload/
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

# make a symlink for the git completion file
ln -s ~/Github/My_Configs/.git-completion.bash ~/.git-completion.bash

# install vim
~/Github/My_Configs/Dev_Setup/ubuntu_setup/.install_vim.sh

# take care of vimrc, plugin installation, and removing bad files
sudo ln -s ~/Github/My_Configs/vimrc /etc/vim/
sudo ln -s ~/Github/My_Configs/vimrc ~/.vimrc
~/Github/My_Configs/Dev_Setup/ubuntu_setup/.run_plugin_install.sh
sudo rm -rf ~/.vim/bundle/vim-snippets/snippets/*
sudo rm -rf ~/.vim/bundle/vim-template/templates/*

# set up git login credentials and other config stuff
cd ~/Github/My_Configs/
git config --global user.email "2014justinnguyen@gmail.com"
git config --global user.name "Justin Nguyen"
git config --global push.default simple
git config --global core.autocrlf false
git config http.postBuffer 52428800

# grab miniconda script file
cd ~/  &&  wget -c http://repo.continuum.io/miniconda/Miniconda-latest-Linux-x86_64.sh --no-check-certificate
sudo chmod 755 ~/Miniconda-latest-Linux-x86_64.sh
~/Miniconda-latest-Linux-x86_64.sh -b -p $HOME/miniconda2

# source the ~/.profile so that the shell recognizes conda  &&  set the dev env var
cp ~/Github/My_Configs/.profile ~/
vim -c ":silent! %s/ENV_TYPE=\"cygwin\"/ENV_TYPE=\"ubuntu\"/g" -c ":xa" ~/.profile
source ~/.profile

# do some conda configuration
conda config --set ssl_verify false
conda config --add channels conda-forge

# install the python libraries through conda
~/Github/My_Configs/Dev_Setup/ubuntu_setup/.install_conda_libs.sh

# copy over the ipython config file
cp ~/Github/My_Configs/ipython_config.py ~/.ipython/profile_default/
vim -c ":q!" ~/.ipython/profile_default/ 

# make sure the ~/.ssh folder exists
mkdir -p ~/.ssh

# remove old copies to make room for symlinks
rm -rf ~/.gitconfig
rm -rf ~/.bashrc
rm -rf ~/.inputrc
rm -rf ~/.vimrc
rm -rf ~/.tmux.conf
rm -rf ~/.vim/bundle/vim-snippets/snippets
rm -rf ~/conda_packages
rm -rf ~/.vim/after/syntax
rm -rf ~/.vim/after/ftplugin
rm -rf ~/.vim/after/plugin
rm -rf ~/.vim/bundle/vim-template/templates
rm -rf ~/.ipython/profile_default/ipython_config.py
rm -rf ~/.pdbrc

# rename the original snippets folder to keep a copy of it
mv ~/.vim/bundle/vim-snippets/snippets     ~/.vim/bundle/vim-snippets/snips_original

# make symlinks
ln -s ~/Github/My_Configs/.ycm_extra_conf.py        ~/.ycm_extra_conf.py
ln -s ~/Github/My_Configs/.gitconfig                ~/.gitconfig
ln -s ~/Github/My_Configs/.bashrc                   ~/.bashrc
ln -s ~/Github/My_Configs/.inputrc                  ~/.inputrc
ln -s ~/Github/My_Configs/vimrc                     ~/.vimrc
ln -s ~/Github/My_Configs/vimrc                     /etc/vim/vimrc
ln -s ~/Github/My_Configs/.tmux.conf                ~/.tmux.conf
ln -s ~/Github/My_Configs/snippets/                 ~/.vim/bundle/vim-snippets/snippets
ln -s ~/miniconda2/lib/python2.7/site-packages/     ~/conda_packages
ln -s ~/Github/My_Configs/syntax/                   ~/.vim/after/syntax
ln -s ~/Github/My_Configs/ftplugin                  ~/.vim/after/ftplugin
ln -s ~/Github/My_Configs/plugin/                   ~/.vim/after/plugin
ln -s ~/Github/My_Configs/templates/                ~/.vim/bundle/vim-template/templates
ln -s ~/Github/My_Configs/ipython_config.py         ~/.ipython/profile_default/ipython_config.py
ln -s ~/Github/My_Configs/.pdbrc                    ~/.pdbrc
ln -s ~/Github/My_Configs/ssh_config                ~/.ssh/config
cp ~/Github/My_Configs/.profile ~/                  ##### NOTE: don't make a symlink for ~/.profile

# change the $ENV_TYPE variable as appropriate
vim -c ":execute 'normal' 'gg'" -c ":/ENV_TYPE" -c ":execute 'normal' 'n'" -c ":execute 'normal' 'wwcwubuntu'" -c ":x" ~/.profile

# copy over additions to the Fugitive plugin
vim -c "execute 'normal' 'Go'" -c ":read ~/Github/My_Configs/.my_fugitive.vim" -c ":x" ~/.vim/bundle/vim-fugitive/plugin/fugitive.vim

# source the ~/.profile  &&  ~/.inputrc
source ~/.profile

# remove the useless directories in the home directory
rm -rf ~/Desktop/
rm -rf ~/Documents/
rm -rf ~/Music/
rm -rf ~/Pictures/
rm -rf ~/Public/
rm -rf ~/Templates/
rm -rf ~/Videos/
rm -rf ~/examples.desktop
rm -rf ~/Miniconda-latest-Linux-x86_64.sh

# update and upgrade existing packages
sudo apt-get update
sudo apt-get upgrade -y

# clean up unnecessary package dependencies
sudo apt-get autoremove

# last note about permanently sourcing ~/.profile
printf "\n\n=================================================================================================\n\n"
echo "Log out and log back in to permanently source the config files"

