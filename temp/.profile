# To the extent possible under law, the author(s) have dedicated all 
# copyright and related and neighboring rights to this software to the 
# public domain worldwide. This software is distributed without any warranty. 
# You should have received a copy of the CC0 Public Domain Dedication along 
# with this software. 
# If not, see <http://creativecommons.org/publicdomain/zero/1.0/>. 

# base-files version 4.2-4

# ~/.bash_profile: executed by bash(1) for login shells.

# The latest version as installed by the Cygwin Setup program can
# always be found at /etc/defaults/etc/skel/.bash_profile

# Modifying /etc/skel/.bash_profile directly will prevent
# setup from updating it.

# The copy in your home directory (~/.bash_profile) is yours, please
# feel free to customise it to create a shell
# environment to your liking.  If you feel a change
# would be benifitial to all, please feel free to send
# a patch to the cygwin mailing list.

# User dependent .bash_profile file

#######################################################################
#######################################################################
#######################################################################
#######################################################################
#######################################################################

# if not set, then assume using MobaXTerm
export ENV_TYPE="cygwin"

# set vimrc location
if [ "$ENV_TYPE" == "cygwin" ]
	then export VIM=/etc
elif [ "$ENV_TYPE" == "ubuntu" ]
	then export VIM=/usr/share/vim/
elif [ "$ENV_TYPE" == "moba" ]
	then export VIM=/usr/share/vim/
fi

# Set Github repo location
export GIT=~/Github

# path to 'javac.exe'
if [ "$ENV_TYPE" == "cygwin" ]
	then PATH="$PATH:/cygdrive/c/Program Files/Java/jdk1.8.0_101/bin"
elif [ "$ENV_TYPE" == "ubuntu" ]
	then PATH="$PATH:~/Downloads/Java/jdk1.8.0_101/bin"
elif [ "$ENV_TYPE" == "moba" ]
	then PATH="$PATH:/cygdrive/c/Program Files/Java/jdk1.8.0_101/bin"
fi

# added by Miniconda2 4.0.5 installer (username and directory for personal laptop)
export PATH="/home/jhn545/miniconda2/bin:$PATH"

# added by Miniconda2 4.0.5 installer (username and directory for work)
export PATH="/home/jusnguy/miniconda2/bin:$PATH"

# change starting directory
# cd _____

#######################################################################
#######################################################################
#######################################################################
#######################################################################
#######################################################################

# source the users bashrc if it exists
if [ -f "${HOME}/.bashrc" ] ; then
  source "${HOME}/.bashrc"
fi

[[ -s ~/.bashrc ]] && source ~/.bashrc

# set PATH so it includes user's private bin directories
if [ "$ENV_TYPE" == "ubuntu" ]
	then PATH="$HOME/bin:$HOME/.local/bin:$PATH"
fi

# Set PATH so it includes user's private bin if it exists
# if [ -d "${HOME}/bin" ] ; then
#   PATH="${HOME}/bin:${PATH}"
# fi

# Set MANPATH so it includes users' private man if it exists
# if [ -d "${HOME}/man" ]; then
#   MANPATH="${HOME}/man:${MANPATH}"
# fi

# Set INFOPATH so it includes users' private info if it exists
# if [ -d "${HOME}/info" ]; then
#   INFOPATH="${HOME}/info:${INFOPATH}"
# fi
