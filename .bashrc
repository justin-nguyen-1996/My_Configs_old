
# aliases for editing .bash_aliases and vimrc files
alias ev='vim $VIM/vimrc;'
alias ea='vim ~/.bashrc; source ~/.bashrc && source $HOME/.bashrc'
alias cpvim='cp $VIM/vimrc ~/Github/My_Configs/vimrc  &&  cd ~/Github/My_Configs &&  ga  &&  gs  &&  gc "update"  &&  gp  && cd -'

# git aliases
#alias ga='source ~/.bashrc && source $HOME/.bashrc && git add .'
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
alias DOS=dos2unix

# easy ls -al
alias la='ls -al'

# path to 'javac.exe'
javabin="/cygdrive/c/Program Files/Java/jdk1.8.0_101/bin"
if ! [[ $PATH =~ "$javabin" ]]; then
  PATH="$PATH:$javabin"
fi

# change starting directory
# cd _____

