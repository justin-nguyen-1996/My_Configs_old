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

# NOTE: Must set this appropriately for the current development environment
export ENV_TYPE="ubuntu"

# Set Github repo location
export GIT=~/Github

# path to miniconda libraries
if [ "$ENV_TYPE" == "cygwin" ]
	then export PATH="$HOME/miniconda2/Scripts/:$HOME/miniconda2/:$PATH"
elif [ "$ENV_TYPE" == "ubuntu" ]
	then export PATH="$HOME/miniconda2/bin:$PATH"
elif [ "$ENV_TYPE" == "redhat" ]
	then export PATH="$HOME/miniconda2/bin:$PATH"
fi

# path to Pintos
if [ "$ENV_TYPE" == "ubuntu" ]
	then export PATH="$HOME/Github/OS/Pintos/utils/:$PATH"
fi

# path to vivado
if [ "$ENV_TYPE" == "ubuntu" ]
	then export PATH="$HOME/Vivado/Vivado/2017.4/bin:$PATH"
fi

# change starting directory
# cd _____

synclient VertScrollDelta=-150     # slow down vertical scrolling
synclient HorizTwoFingerScroll=0   # disable horizontal scrolling

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
elif [ "$ENV_TYPE" == "redhat" ]
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
