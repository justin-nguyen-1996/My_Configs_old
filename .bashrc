
# aliases for editing .bash_aliases and vimrc files
alias ev='vim $VIM/vimrc;'
alias ea='vim ~/.bashrc; source ~/.bashrc && source $HOME/.bashrc'

# some silly things because I'm really lazy (basically one-shot commands to git commit/push vimr and other config files)
alias gitupdate='cd ~/Github/My_Configs  &&  ga  &&  gs  &&  gc "update"  &&  gp  && cd -'
alias cpvim='cp -t ~/Github/My_Configs/ $VIM/vimrc && gitupdate'
alias cpconfig='cp -t ~/Github/My_Configs/ $VIM/vimrc ~/.inputrc ~/.bashrc ~/.profile ~/python.snippets ~/c.snippets ~/cpp.snippets ~/java.snippets  &&  gitupdate'

# special aliases for ubuntu (because of stupid sudo)
if [ "$ENV_TYPE" == "ubuntu" ]
	then alias vim='sudo vim'
		 alias cp='sudo cp'
		 alias mv='sudo mv'
		 alias rm='sudo rm'
		 alias chmod='sudo chmod'
		 alias ls='sudo ls'
		 alias DOS='sudo dos2unix'
		 alias install='sudo apt-get install'
fi

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

# make sure ls/dir display files/folders in color
alias ls='ls -hF --color=tty'
alias dir='ls --color=auto'

# alias for opening files
alias open=cygstart

# easy dos2unix
if [ "$ENV_TYPE" != "ubuntu" ]
	then alias DOS=dos2unix
fi

# easy ls -al
alias la='ls -al'

# python aliases
alias p='python'

