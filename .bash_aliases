# aliases for editing .bash_aliases and vimrc files
alias ea='vim ~/.bash_aliases; source ~/.bash_aliases && source $HOME/.bash_aliases'
alias ev='vim /etc/vimrc; source ~/etc/vimrc'
alias eb='vim ~/.bashrc'

# git aliases
alias ga='git add .'
alias gs='git status'
alias gc='git commit -a -m'
alias gp='git push'

# jumping to git repos
alias cd422C='cd /cygdrive/c/Users/Justin/Eclipse-Workspace/EE-422C/'
alias cd360P='cd /cygdrive/c/Users/Justin/Eclipse-Workspace/EE-360P/'
alias cd445L='cd /cygdrive/c/Keil/ValvanoWareTM4C123/EE-445L-Labs'
alias cd460N='cd /cygdrive/c/Users/Justin/GitHub/Computer_Architecture/'
alias cd445LPCB='cd /cygdrive/c/Keil/ValvanoWareTM4C123/EE-445L-Labs/PCBArtistSchmatics/"EE 445L Schematics"'
alias cdgit='cd /cygdrive/c/Users/Justin/Github'
alias cdoooe='cd /cygdrive/c/Users/Justin/Github/oooe'

# create the ctags file
alias CT='ctags -R -f .tags .'
alias CTAGS='ctags -R -f .tags .'
alias TAGS='ctags -R -f .tags .'

# ssh command for UT LRC
alias MARIO='ssh jnguyen10@mario.ece.utexas.edu'
alias GRADER='ssh jnguyen10@grader.ece.utexas.edu'

# make sure ls/dir display files/folders in color
alias ls='ls -hF --color=tty'
alias dir='ls --color=auto --format=vertical'

# alias for opening files
alias open=cygstart

# for jumping to cygwin file directories
alias cdC='cd /cygdrive/c'
alias cdDOWN='cd /cygdrive/c/Users/Justin/Downloads'
alias cdJUSTIN='cd /cygdrive/c/Users/Justin'

# easy dos2unix
alias DOS=dos2unix

# easy ls -al
alias la='ls -al'
