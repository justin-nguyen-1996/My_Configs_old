
# aliases for editing vimrc and .bashrc
alias ea='vim ~/.bashrc; source ~/.bashrc'

# some silly things because I'm really lazy (basically one-shot commands to git commit/push vimrc and other config files)
alias cpconfig='builtin cd ~/Github/My_Configs  &&  ga  &&  gs  &&  gc "update"  &&  gp  && builtin cd -'

# aliases for Ubuntu
if [ "$ENV_TYPE" == "ubuntu" ]
	then alias chmod='sudo chmod'
		 alias chown='sudo chown'
		 alias install='sudo apt-get install'
		 alias search='sudo apt-cache search'
		 #alias p='ipython -i'
		 alias p='python -i'
         alias p3='python3 -i'
		 alias ip='ipython --pylab='auto' -i'
		 alias ev='vim ~/.vimrc'
		 alias ep='vim ~/.profile'
		 alias vim='vim -p'
		 #alias rm='sudo rm'
fi

# aliases for WSL (Windows Subsystem for Linux)
if [ "$ENV_TYPE" == "wsl" ]
	then alias chmod='sudo chmod'
		 alias chown='sudo chown'
		 alias install='sudo apt-get install'
		 alias search='sudo apt-cache search'
		 alias p='python'
		 alias ip='ipython --pylab='auto' -i'
		 alias ev='vim ~/.vimrc'
		 alias ep='vim ~/.profile'
		 alias vim='vim -p'
		 alias open='wsl-open'
		 #alias rm='sudo rm'
fi

# aliases for redhat
if [ "$ENV_TYPE" == "redhat" ]
	then alias rm='sudo rm'
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
		 alias ev='sudo vim ~/.vimrc'
		 alias ep='vim ~/.profile'
		 alias vim='sudo vim -p'
fi

# aliases for Cygwin
if [ "$ENV_TYPE" == "cygwin" ]
	then alias open='cygstart'
		 alias p='python -i'
		 alias python='python -i'
		 alias ev='vim ~/.vimrc'
		 alias ep='vim ~/.profile'
		 alias vim='vim -p'
fi

# git aliases
alias ga='git add .'
alias ga..='git add ..'
alias ga...='git add ../..'
alias gs='git status'
alias gc='git commit -m'
alias gm='git merge'
alias gl='git log --oneline -n 10'
alias gll='git log --oneline -n 30'
alias glll='git log --oneline -n 50'
alias gd='git diff -w'
alias gdd='git log -1 --format=%ai'
alias gp='git push -u'
alias gr='git reset'
alias grs='git reset --soft'
alias grh='git reset --hard'
alias gb='git branch -v'
alias gba='git branch -va'
alias gco='git checkout'
alias gsl='git stash list'
alias gss='git stash'
alias gsp='git stash pop'

# ROS aliases and tab completion support
#   - see https://unix.stackexchange.com/questions/224227/how-do-you-make-an-alias-or-function-that-retains-tab-completion
# alias ccmake='pushd . > /dev/null; roscd > /dev/null; cd .. > /dev/null; catkin_make; popd >/dev/null'
alias r='rosed'
complete -F _roscomplete_file r
alias rl='roslaunch'
complete -o filenames -F _roscomplete_launch rl
alias ccbuild='catkin build && temp_ros_setup_bash=`catkin locate -d` && source $temp_ros_setup_bash/setup.bash'
alias cclean='catkin clean --yes'
alias roscd..='roscd > /dev/null && cd ..'
alias view_frames='rosrun tf view_frames && open frames.pdf'
alias rqt_tree='rosrun rqt_tf_tree rqt_tf_tree'

# create the ctags file
alias CT='ctags -R -f .tags *'
alias CT..='builtin cd ..  &&  ctags -R -f .tags *  &&  builtin cd -'
alias CTAGS='ctags -R -f .tags .'
alias TAGS='ctags -R -f .tags .'

# nicer & easier aliases
alias ls='ls -hF --color=tty --hide=*.pyc --hide=*.uvgui.* --hide=*.uvopt --hide=*.bak --hide=*.htm --hide=*.dep --hide=*.lst'
alias dir='ls --color=auto'
alias cdp='cd "$(pwd -P)"'       # 1st cd to the symlink folder then run this to get to the symlink's true location
alias cdp..='cd "$(pwd -P)/.."'  # Same as `cdp` except it goes one folder up
alias la='ls -al'
alias du='du -h'
alias df='df -h'
# alias grep='grep -ni --color --exclude tags     --exclude .tags       --exclude *.o        --exclude *justi\
#                              --exclude *.bin    --exclude *.uvproj    --exclude *.uvopt'
alias grep='grep -niI --color --exclude tags  --exclude .tags --exclude *.map'

# tar aliases and helpful info
# alias tar='tar -cpzfv <folder_to_create.tar.gz> <folder_to_compress> --exclude=folder_name'
# alias untar='tar -xpzfv <folder_to_untar.tar.gz> -C <folder_to_untar_into>'

# powering off and restarting from command line
alias powerdown='poweroff'
alias shutdown='poweroff'
alias restart='reboot'
alias logout='gnome-session-quit --logout --no-prompt'
alias sleep='systemctl suspend'

# lazy aliases and typos
alias sl='ls'
alias l='ls'
alias ch='chmod 755'
alias chall='chmod -R 755 *'
alias dos='dos2unix'
alias gdb='gdbtui'
alias job='jobs'
alias jbos='jobs'
alias josb='jobs'
alias jos='jobs'
alias mkae='make'
alias more='less'
alias sp='source ~/.profile'
alias sb='source ~/.bashrc'
alias path='sed "s/:/\n/g" <<< "$PATH"'
alias kill='kill -9'
alias psa='ps -a'
alias ss='synclient VertScrollDelta=-150; synclient HorizTwoFingerScroll=0'
alias ake='make'

# Get the ubuntu version
alias ubversion='lsb_release -a'

# Add pintos ssh key
alias addkey='eval "$(ssh-agent -s)" && ssh-add ~/.ssh/id_rsa_pintos'

# I can never remember the order of `ln -s` so this command repeats
# the previous `ln -s` command with the last two arguments swapped
alias LN='$(history -p !:0 !:1 !:3 !:2)'

# enable extglob (useful for something like rm !(temp.c))
shopt -s extglob

# WSL X11 stuff
DISPLAY=:0.0
export DISPLAY

########################################################################################################################

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

# example of a spaced out version for clarity
# --> export PS1="\e[1;31m   \u   @   \h   :   \e[m   \e[1;33m   \w   \e[m   \n   $"
export PS1="\e[1;31m\n\u:\e[m\e[1;33m\w\e[m\n$ "

########################################################################################################################

# change the ugly green highlight for folders accessible by other partitions
# 'ow' --> other, writable files
# 'tw' --> sticky, writable files
# number;number;number --> bold;font-color;bg-color
export LS_COLORS=$LS_COLORS:'ow=1;34;40:tw=1;34;40:'

########################################################################################################################

# make the install alias still have autocomplete
_apt_install_complete() {
    mapfile -t COMPREPLY < <(apt-cache --no-generate pkgnames "$2");
}
complete -F _apt_install_complete install

########################################################################################################################

# map cd to `cd && ls`
cd() { builtin cd "${1-$(echo ~)}" && ls -F; }

# map open to not output junk to stdout (ubuntu)
if [ "$ENV_TYPE" == "ubuntu" ]; then function open() { gnome-open "$1" > /dev/null 2>&1 & } fi

# map jupyter notebook to not output junk to stdout
if [ "$ENV_TYPE" == "ubuntu" ]  ||  [ "$ENV_TYPE" == "wsl" ]; then function jp() { jupyter notebook "$1" > /dev/null 2>&1 & } fi

# map libreoffice to not output junk to stdout
if [ "$ENV_TYPE" == "ubuntu" ]  ||  [ "$ENV_TYPE" == "wsl" ]; then function libreoffice() { libreoffice "$1" > /dev/null 2>&1 & } fi

# map xpad sticky notes to not output junk to stdout
# if [ "$ENV_TYPE" == "ubuntu" ]  ||  [ "$ENV_TYPE" == "wsl" ]; then function xpad() { xpad > /dev/null 2>&1 & } fi

# make merging branches onto/from master easier
if [ "$ENV_TYPE" == "ubuntu" ]  ||  [ "$ENV_TYPE" == "wsl" ]; then function gm() {
	git checkout master && git merge "$1" && gp && git checkout "$1" && gb;
} fi

# make merging branches onto/from master easier
if [ "$ENV_TYPE" == "ubuntu" ]  ||  [ "$ENV_TYPE" == "wsl" ]; then function gpm() {
	git checkout master && git pull && git checkout "$1" && git merge master && gp && gb;
} fi

# remove an Ubuntu package and its dependencies
if [ "$ENV_TYPE" == "ubuntu" ]  ||  [ "$ENV_TYPE" == "wsl" ]; then function remove() {
	sudo apt-get remove --purge "$1"  &&  sudo apt-get autoremove;
} fi

########################################################################################################################

### Cool but useless red echo
# echo() { builtin echo -e "\x1B[31m ${1} \x1B[0m"; }

### Some obscure linux shortcuts
# ~- means the previous directory
# !$ means the last argument in the command line (same as holding alt then pressing the . key)

### Mount and unmount temporary windows filesystem
# sudo fdisk -l
# mkdir -p /media/windows_temp/ && sudo mount -t ntfs-3g -o ro /dev/sda4 /media/windows_temp/
# sudo umount /media/windows_temp/

### List of apt libraries --> /etc/apt/sources.list

### print environment variables --> printenv

### Grep vs. Find
# grep -r "search_string" *
# find . -name "search_file"

### Search for an apt-get package --> apt-cache search keyword

### A good video player is `vlc`

### Use vim to edit all desired files and use the formatting provided in the .vimrc to format all files
# vim * -c ':argdo FormatAll' -c ':wa' -c ':qa'

### Remove all files extracted from a .tar.gz file (useful when the files weren't extracted into a folder as expected)
# tar tfz archive.tar.gz | xargs rm -rf

### fatal: bad config line 1 in file .git/config
### `gba` --> warning: ignoring broken ref refs/remotes/origin/HEAD
# This most likely means that git crashed while it was trying to push some code and now the .git/ folder is corrupted.
# The hacky way to fix this is to go to the Github repo and clone a 2nd copy to your machine.
# Then copy the entire .git/ folder of the 2nd repo to your original repo.
# This will fix the .git/config file.
# However, it will not fix the 2nd error above about the "broken refs".
# You need to push the code in the now "fixed" 1st repo to Github and then clone a 3rd copy to your machine (again).
# You can then remove the 1st and 2nd copies. The 3rd copy should work just fine.

########################################################################################################################

# `git reset HEAD~`                     --> undo previous commit that wasn't pushed (and also keep local changes)
# `git reset <filename>`                --> remove from git add
# `git reset HEAD <commit id>`          --> remove from git commit --> use `gitlog` to see git commit id's
#      (shortcut: `git reset HEAD~#`    --> # is how many commits to go back --> e.g. `git reset HEAD~1` means undo latest commit)
# `git checkout`                        --> just quickly check something out and go back
# `git push -f origin master:justin`    --> force push one branch onto another --> <remote> <new branch>:<branch you are pushing to>
# `git checkout otherbranch myfile.txt` --> copy a file from another branch onto the current branch
# `git checkout otherbranch -- dir`     --> copy a directory from another branch onto the current branch (might need to merge though ...)
# `git branch -m newbranch`             --> change current local branch name to a new name
# `git branch -D justin`                --> delete local branch called justin
# `git push --delete origin justin`     --> delete remote branch called justin
# `git remote set-url origin <url>`     --> set url origin
# `git clean -df`                       --> remove untracked files
# `git diff -- . ':(exclude).tags')`    --> exclude files from the git diff
# `git rm -r --cached .`                --> remove untracked files after .gitignore update (then git add, commit, and push)
# `git reset --soft HEAD~#`             --> move head back # commits, change the commit message
#                                           (useful for changing # commits into one commit), commit, push.
#                                           If the commits you're changing have already been
#                                           pushed then you need to do git push -f

########################################################################################################################

# Configure pintos-gdb path
alias pintos-gdb='GDBMACROS=/home/justin/Github/Pintos_Labs/misc/gdb-macros pintos-gdb'

# Setup ROS environment variables
if [ "$ENV_TYPE" == "ubuntu" ]; then
    # NOTE: Change this depending on the current ROS project
    source ~/Github/maidbot_workspace/devel/setup.bash
    source ~/Github/ROS_Tutorials/devel/setup.bash
fi
