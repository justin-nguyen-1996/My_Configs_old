
# aliases for editing .bash_aliases and vimrc files
alias ev='vim $VIM/vimrc;'
alias ea='vim ~/.bashrc; source ~/.bashrc && source $HOME/.bashrc'

# some silly things because I'm really lazy (basically one-shot commands to git commit/push vimr and other config files)
alias gitupdate='cd ~/Github/My_Configs  &&  ga  &&  gs  &&  gc "update"  &&  gp  && cd -'
alias cpvim='cp -t ~/Github/My_Configs/ $VIM/vimrc && gitupdate'
alias cpconfig='cp -t ~/Github/My_Configs/ $VIM/vimrc ~/.inputrc ~/.bashrc ~/.profile ~/python.snippets ~/c.snippets ~/cpp.snippets ~/java.snippets  &&  gitupdate'

# aliases for Ubuntu (because of stupid sudo)
if [ "$ENV_TYPE" == "ubuntu" ]
	then alias vim='sudo vim'
		 alias cp='sudo cp'
		 alias mv='sudo mv'
		 alias rm='sudo rm'
		 alias chmod='sudo chmod'
		 alias ls='sudo ls'
		 alias DOS='sudo dos2unix'
		 alias install='sudo apt-get install'
		 alias search='sudo apt-cache search'
		 alias open='gnome-open'
fi

# aliases for Cygwin
if [ "$ENV_TYPE" == "cygwin" ]
	then alias open='cygstart'
		 alias DOS='dos2unix'
fi

# python aliases
alias p='python'

# git aliases
alias ga='git add .'
alias gs='git status'
alias gc='git commit -a -m'
alias gp='git push'

# jumping to git repos
alias cd422C='cd ~/Eclipse/EE-422C/'
alias cd360P='cd ~/Eclipse/EE-360P/'
alias cd445L='cd ~/c/Keil/ValvanoWareTM4C123/EE-445L-Labs'
alias cd460N='cd ~/GitHub/Computer_Architecture/'
alias cdgit='cd ~/Github'
alias cdoooe='cd ~/Github/oooe'

# create the ctags file
alias CT='ctags -R -f .tags .'
alias CTAGS='ctags -R -f .tags .'
alias TAGS='ctags -R -f .tags .'

# ssh command for UT LRC
alias MARIO='ssh jnguyen10@mario.ece.utexas.edu'
alias GRADER='ssh jnguyen10@grader.ece.utexas.edu'

# nicer & easier ls/dir/la/grep/tar
alias ls='ls -hF --color=tty'
alias dir='ls --color=auto'
alias la='ls -al'
alias grep='grep -rni --color --exclude tags --exclude .tags'
alias tar='tar -xzvf'

# enable extglob (useful for something like rm !(temp.c))
shopt -s extglob

# enable colored prompt
force_color_prompt=yes
if [ "$color_prompt" = yes ]; then
	PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;31m\]\w\[\033[00m\]\$ '
else
	PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
