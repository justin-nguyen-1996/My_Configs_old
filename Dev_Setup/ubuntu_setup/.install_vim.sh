
# .install_vim.sh

printf "\n=========================\nremoving vim\n=========================\n"   ; yes yes Y | sudo apt-get remove --purge vim vim-runtime vim-gnome vim-tiny vim-gui-common

printf "\n=========================\ninstalling vim\n=========================\n" ; yes yes Y | sudo apt-get install liblua5.1-dev luajit libluajit-5.1 python-dev ruby-dev libperl-dev libncurses5-dev libatk1.0-dev libx11-dev libxpm-dev libxt-dev

printf "\n=========================\ninstalling check-install\n=========================\n" ; yes yes Y | sudo apt-get install checkinstall

printf "\n=========================\ninstalling python3 support\n=========================\n" ; yes yes Y | sudo apt-get install python3-dev

# remove old vim folders
sudo rm -rf /usr/local/share/vim /usr/bin/vim /etc/vim

# get the official vim source repo
cd ~
git clone https://github.com/vim/vim
cd vim

# configure vim with python and other goodies
./configure \
--enable-multibyte \
--enable-perlinterp=dynamic \
--enable-rubyinterp=dynamic \
--with-ruby-command=/usr/bin/ruby \
--enable-pythoninterp=dynamic \
--with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu \
--enable-python3interp \
--with-python3-config-dir=/usr/lib/python3.5/config-3.5m-x86_64-linux-gnu \
--enable-luainterp \
--with-luajit \
--enable-cscope \
--enable-gui=auto \
--with-features=huge \
--with-x \
--enable-fontset \
--enable-largefile \
--disable-netbeans \
--with-compiledby="yourname" \
--enable-fail-if-missing

# finish the install
make && sudo make install
sudo ln -s /usr/local/bin/vim /usr/bin/vim
cd ~
sudo mv ~/vim /etc

