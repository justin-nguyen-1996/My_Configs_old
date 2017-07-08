# config_cygwin.sh

# update and install packages for command line
printf "\n=========================\nupdating packages\n=========================\n" ; yes yes Y | sudo apt-get update
printf "\n=========================\ninstall vim\n=========================\n"       ; yes yes Y | sudo apt-get install vim-gnome
printf "\n=========================\ninstall git\n=========================\n"       ; yes yes Y | sudo apt-get install git
printf "\n=========================\ninstall ctags\n=========================\n"     ; yes yes Y | sudo apt-get install exuberant-ctags
printf "\n=========================\ninstall tmux\n=========================\n"      ; yes yes Y | sudo apt-get install tmux
printf "\n=========================\ninstall dos2unix\n=========================\n"  ; yes yes Y | sudo apt-get install dos2unix
printf "\n=========================\ninstall libgnome\n=========================\n"  ; yes yes Y | sudo apt-get install libgnome2-bin
printf "\n=========================\ninstall xclip\n=========================\n"     ; yes yes Y | sudo apt-get install xclip
printf "\n=========================\ninstall expect\n=========================\n"    ; yes yes Y | sudo apt-get install expect

# generate and save the new ssh key
echo 
echo "You're about to see a prompt that's going to ask you for a file location and passphrase"
echo "Just hit 'enter' 3 times"

echo
ssh-keygen -t rsa -b 4096 -C "2014justinnguyen@gmail.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
clip < ~/.ssh/id_rsa.pub

echo
echo "Just copied the ~/.ssh/id_rsa.pub file into the clipboard. So don't try to copy anything (i.e. don't use Ctrl-c)"
echo "A hyperlink will open soon. After it does, go back to these instructions (more will pop up after the link is opened)"

echo
while true; do
read -p "Are you ready? " yn
case $yn in
	[Yy]* ) break;;
	[Nn]* ) ;;
	* ) echo "Please answer yes or no.";;
esac
done
echo

cygstart https://github.com/settings/keys
while true; do
read -p "Ready for the rest of the instructions? " yn
case $yn in
	[Yy]* ) break;;
	[Nn]* ) ;;
	* ) echo "Please answer yes or no.";;
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
	[Yy]* ) break;;
	[Nn]* ) ;;
	* ) echo "Please answer yes or no.";;
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
vim -c ":PluginInstall" -c ":qa"

# remove bad snippet and template files
rm -rf ~/.vim/bundle/vim-snippets/snippets/*
rm -rf ~/.vim/bundle/vim-template/templates/*

# get config directory from my repo
cd ~/Github/  &&  git clone git@github.com:justin-nguyen-1996/My_Configs.git

# copy over some config files
cp ~/Github/My_Configs/.bashrc      ~/
cp ~/Github/My_Configs/.inputrc     ~/
cp ~/Github/My_Configs/.tmux.conf   ~/
cp ~/Github/My_Configs/.profile     ~/
cp ~/Github/My_Configs/vimrc        /usr/share/vim/
cp ~/Github/My_Configs/snippets/*   ~/.vim/bundle/vim-snippets/snippets/
cp ~/Github/My_Configs/templates/*  ~/.vim/bundle/vim-template/templates/
cp ~/Github/My_Configs/syntax/*     ~/.vim/after/syntax/
cp ~/Github/My_Configs/ftplugin/*   ~/.vim/after/ftplugin/
cp ~/Github/My_Configs/plugin/*     ~/.vim/after/plugin/

# make some symlinks
ln -s ~/.vim/bundle/vim-snippets/snippets/c.snippets        ~/snippets/c.snippets
ln -s ~/.vim/bundle/vim-snippets/snippets/cpp.snippets      ~/snippets/cpp.snippets
ln -s ~/.vim/bundle/vim-snippets/snippets/java.snippets     ~/snippets/java.snippets
ln -s ~/.vim/bundle/vim-snippets/snippets/python.snippets   ~/snippets/python.snippets
# TODO
ln -s ~/miniconda2/lib/python2.7/site-packages/ conda_packages

# fix the super annoying CRLF warning thing from git
cd ~/Github/My_Configs/  &&  git config core.autocrlf false

# appropriately set the development environment variable in ~/.profile
vim -c ":silent! %s/ENV_TYPE=\"cygwin\"/ENV_TYPE=\"ubuntu\"/g" -c ":xa" ~/.profile

# miniconda stuff --> python libraries
cd ~/  &&  wget -c http://repo.continuum.io/miniconda/Miniconda-latest-Linux-x86_64.sh --no-check-certificate
sudo chmod 755 ~/Miniconda-latest-Linux-x86_64.sh
~/Miniconda-latest-Linux-x86_64.sh
# TODO: Input stuff (https://askubuntu.com/questions/615700/install-miniconda-python-2-7)
conda config --set ssl_verify false
conda config --add channels conda-forge

printf "\n=========================\ninstall numpy\n=========================\n"     ; yes yes Y | conda install numpy
printf "\n=========================\ninstall scipy\n=========================\n"     ; yes yes Y | conda install scipy
printf "\n=========================\ninstall pandas\n=========================\n"    ; yes yes Y | conda install pandas
printf "\n=========================\ninstall scikit\n=========================\n"    ; yes yes Y | conda install scikit-learn
printf "\n=========================\ninstall matplt\n=========================\n"    ; yes yes Y | conda install matplotlib

printf "\n=========================\ninstall rasterio\n=========================\n"  ; yes yes Y | conda install rasterio
printf "\n=========================\ninstall gdal\n=========================\n"      ; yes yes Y | conda install gdal
printf "\n=========================\ninstall fiona\n=========================\n"     ; yes yes Y | conda install fiona
printf "\n=========================\ninstall shapely\n=========================\n"   ; yes yes Y | conda install shapely
printf "\n=========================\ninstall affine\n=========================\n"    ; yes yes Y | conda install affine
printf "\n=========================\ninstall pyproj\n=========================\n"    ; yes yes Y | conda install pyproj
printf "\n=========================\ninstall geopandas\n=========================\n" ; yes yes Y | conda install geopandas
printf "\n=========================\ninstall pillow\n=========================\n"    ; yes yes Y | conda install pillow

printf "\n=========================\ninstall fftw\n=========================\n"      ; yes yes Y | conda install fftw
printf "\n=========================\ninstall cython\n=========================\n"    ; yes yes Y | conda install cython
printf "\n=========================\ninstall pyfftw\n=========================\n"    ; yes yes Y | conda install pyfftw

# set up git login credentials
echo
while true; do
read -p "Alright almost done. Ready? " yn
case $yn in
    [Yy]* ) break;;
    [Nn]* ) ;;
    * ) echo "Please answer yes or no.";;
esac
done
echo
echo "6. Finally, go into ~/Github/ and run git push (yes I know that you might not have stuff to push yet ... just do it)"
echo "7. You'll probably get some on screen instructions. Follow them to set up your login info"
echo "8. Afterwards, you might get a message about 'simple'. Use that one"

