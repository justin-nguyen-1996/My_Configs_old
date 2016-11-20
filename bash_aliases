# aliases for editing .bash_aliases and vimrc files
alias ea='vim ~/.bash_aliases; source ~/.bash_aliases && source $HOME/.bash_aliases'
alias ev='vim /etc/vimrc'
alias eb='vim ~/.bashrc'

# git aliases
alias ga='git add .'
alias gs='git status'
alias gc='git commit -a -m'
alias gp='git push'
alias PASS='~/.pass'

# jumping to git repos
alias cdCUR='cd /cygdrive/c/Users/Justin/Eclipse-Workspace/EE-422C/Lab1/src/assignment1'
alias cdCPP='cd ~/GitHub/Learn_CPP/'
alias cdALGO='cd ~/GitHub/Algorithms/'
alias cdCODE='cd ~/GitHub/Coding_Practice/Chapter_1'
alias cd422C='cd /cygdrive/c/Users/Justin/Eclipse-Workspace/EE-422C/'
alias cd422CCUR='cd /cygdrive/c/Users/Justin/Eclipse-Workspace/EE-422C/Lab6-Multithreading/src/assignment6'
alias cd445L='cd /cygdrive/c/Keil/ValvanoWareTM4C123/EE-445L-Labs'
alias cd445LCUR='cd /cygdrive/c/Keil/ValvanoWareTM4C123/EE-445L-Labs/Lab5'
alias cd445LPCB='cd /cygdrive/c/Keil/ValvanoWareTM4C123/EE-445L-Labs/PCBArtistSchmatics/"EE 445L Schematics"'
alias cdGIT='cd ~/GitHub/'
alias cdDOWN='cd /cygdrive/c/Users/Justin/Downloads'

# create the ctags file
alias CT='ctags -R -f .tags .'

# ssh command for UT LRC
alias MARIO='ssh jnguyen10@mario.ece.utexas.edu'

# make sure ls/dir display files/folders in color
alias ls='ls -hF --color=tty'
alias dir='ls --color=auto --format=vertical'

# for jumping to cygwin file directories
alias cdC='cd /cygdrive/c'
alias cdDOWN='cd /cygdrive/c/Users/Justin/Downloads'
