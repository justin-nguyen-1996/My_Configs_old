
# aliases for editing vimrc and .bashrc
alias ea='vim ~/.bashrc; source ~/.bashrc && source $HOME/.bashrc'

# some silly things because I'm really lazy (basically one-shot commands to git commit/push vimrc and other config files)
alias cpconfig='builtin cd ~/Github/My_Configs  &&  ga  &&  gs  &&  gc "update"  &&  gp  && builtin cd -'

# aliases for Ubuntu
if [ "$ENV_TYPE" == "ubuntu" ]
	then alias ls='sudo ls'
		 alias chmod='sudo chmod'
		 alias chown='sudo chown'
		 alias install='sudo apt-get install'
		 alias search='sudo apt-cache search'
		 alias open='gnome-open {$1} > /dev/null 2>&1 &'
		 alias p='ipython -i'
		 alias ip='ipython --pylab='auto' -i'
		 alias ev='sudo vim ~/.vimrc'
fi

# aliases for redhat
if [ "$ENV_TYPE" == "redhat" ]
	then alias ls='sudo ls'
		 alias rm='sudo rm'
		 alias mv='sudo mv'
		 alias cp='sudo cp'
		 alias chmod='sudo chmod'
		 alias chown='sudo chown'
		 # alias install='sudo apt-get install'
		 # alias search='sudo apt-cache search'
		 # alias open='gnome-open'
		 alias rpm='sudo rpm -Ui'
		 alias p='ipython -i'
		 alias ip='ipython --pylab='auto' -i'
		 alias ev='sudo vim $VIM/vimrc;'
fi

# aliases for Cygwin
if [ "$ENV_TYPE" == "cygwin" ]
	then alias open='cygstart'
		 alias p='python -i'
		 alias ev='vim ~/.vimrc'
fi

# git aliases
alias ga='git add .'
alias gs='git status'
alias gc='git commit -a -m'
alias gp='git push'
alias gb='git branch -v'
alias gba='git branch -va'
alias gco='git checkout'

# jumping to git repos
alias cdgit='cd ~/Github'

# create the ctags file
alias CT='ctags -R -f .tags *'
alias CT..='builtin cd ..  &&  ctags -R -f .tags *  &&  builtin cd -'
alias CTAGS='ctags -R -f .tags .'
alias TAGS='ctags -R -f .tags .'

# ssh command for UT LRC
alias MARIO='ssh jnguyen10@mario.ece.utexas.edu'
alias GRADER='ssh jnguyen10@grader.ece.utexas.edu'

# nicer & easier ls/dir/la/grep/tar
alias ls='ls -hF --color=tty --hide=*.pyc'
alias dir='ls --color=auto'
alias la='ls -al'
alias grep='grep -ni --color --exclude tags --exclude .tags --exclude *.o --exclude *.bin'
# alias tar='tar -xzvf'
alias gitlog='git log --oneline'
alias du='du -h'
alias df='df -h'
alias libreoffice='libreoffice > /dev/null 2>&1 &'
alias vim='vim -p'

# lazy aliases and typos
alias sl='ls'
alias l='ls'
alias ch='chmod 755'
alias dos='dos2unix'
alias gdb='gdbtui'
alias job='jobs'
alias jbos='jobs'
alias more='less'

# enable extglob (useful for something like rm !(temp.c))
shopt -s extglob

################################################################################################################################

# set the command line prompt to red and yellow  -->  '1;31m' is red  
# change '#' in '1;3#m' to set the color         -->  '3#m' for fainter color (basically just remove the '1;' in front)
#   \e[1;3#m  -->  start color sequence
#   \n        -->  new line
#   \u        -->  user
#   @         -->  just an '@' symbol
#   \h        -->  host
#   :         -->  just a ':' symbol
#   \e[m      -->  ending color sequence
#   \w        -->  working directory
#   \n        -->  new line
#   $         -->  just a '$' symbol
# example of a spaced out version for clarity --> export PS1="\e[1;31m   \u   @   \h   :   \e[m   \e[1;33m   \w   \e[m   \n   $"
if [ "$ENV_TYPE" == "ubuntu" ]; then
	export PS1="\e[1;31m\n\u@\h:\e[m\e[1;33m\w\e[m\n$ "
elif [ "$ENV_TYPE" == "redhat" ]; then
	export PS1="\e[1;31m\n\u@\h:\e[m\e[1;33m\w\e[m\n$ "
fi

################################################################################################################################

# map cd to `cd && ls`
cd() { builtin cd "${1-$(echo ~)}" && ls -F; }

# map open to not output junk to stdout (ubuntu)
if [ "$ENV_TYPE" == "ubuntu" ]; then function open() { gnome-open "$1" > /dev/null 2>&1 & } fi

# map jupyter notebook to not output junk to stdout
if [ "$ENV_TYPE" == "ubuntu" ]; then function jp() { jupyter notebook "$1" > /dev/null 2>&1 & } fi

# make merging branches onto/from master easier
if [ "$ENV_TYPE" == "ubuntu" ]; then function gm() { git checkout master && git merge "$1" && gp && git checkout "$1" && gb; } fi
if [ "$ENV_TYPE" == "ubuntu" ]; then function gpm() { git checkout master && git pull && git checkout "$1" && git merge master && gp && gb; } fi

################################################################################################################################

# cool but useless 'red' echo
# echo() { builtin echo -e "\x1B[31m ${1} \x1B[0m"; }

# ~- means the previous directory
# !$ means the last argument in the command line

# `git reset <filename>` to remove from git add
# `git reset HEAD <commit id>` to remove from git commit --> use `gitlog` to see git commit id's
#      (shortcut: `git reset HEAD~#` --> # is how many commits to go back --> e.g. `git reset HEAD~1` means undo latest commit)
# `git checkout` to just quickly check something out and go back
# `git push -f origin master:justin` --> force push one branch onto another --> <remote> <new branch>:<branch you are pushing to> 
# `git checkout otherbranch myfile.txt` --> copy a file from another branch onto the current branch
# `git branch -D justin` --> delete local branch called justin
# `git push --delete origin justin` --> delete remote branch called justin
# `git remote set-url origin <url>` --> git remote set-url origin https://bitbucket.org/justins_stuff/college_senior_year

# Put pintos in PATH
alias pintos-gdb='GDBMACROS=/home/jhn545/Github/OS/Pintos/misc/gdb-macros pintos-gdb'
# source /home/jhn545/Github/OS/Pintos/.PINTOS_PATH
