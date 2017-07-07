#! /bin/sh
#
# config_ubuntu.sh
#

sudo apt-get update
sudo apt-get install vim-gnome
sudo apt-get install git
sudo apt-get install ctags
sudo apt-get install tmux
sudo apt-get install dos2unix
sudo apt-get install libgnome2-bin

cp ~/Github/My_Configs/.bashrc ~/
cp ~/Github/My_Configs/.inputrc ~/
cp ~/Github/My_Configs/.tmux.conf ~/
cp ~/Github/My_Configs/.profile ~/
cp ~/Github/My_Configs/vimrc /usr/share/vim/

vim ~/.profile
  - set variable $ENV_TYPE appropriately in .profile 
  
cd ~/  &&  git clone https://github.com/VundleVim/Vundle.vim.git 
mv ~/Vundle.vim ~/.vim/bundle/Vundle.vim
  - open vim and run :PluginInstall
  - might need to run dos2unix on files that give weird errors
  
mkdir ~/snippets
ln -s ~/.vim/bundle/vim-snippets/snippets/c.snippets ~/snippets/c.snippets
ln -s ~/.vim/bundle/vim-snippets/snippets/cpp.snippets ~/snippets/cpp.snippets
ln -s ~/.vim/bundle/vim-snippets/snippets/java.snippets ~/snippets/java.snippets
ln -s ~/.vim/bundle/vim-snippets/snippets/python.snippets ~/snippets/python.snippets
ln -s ~/miniconda2/lib/python2.7/site-packages/ conda_packages
