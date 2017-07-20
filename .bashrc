
# aliases for editing vimrc and .bashrc
alias ev='vim $VIM/vimrc;'
alias ea='vim ~/.bashrc; source ~/.bashrc && source $HOME/.bashrc'

# some silly things because I'm really lazy (basically one-shot commands to git commit/push vimrc and other config files)
alias git_update='cd ~/Github/My_Configs  &&  ga  &&  gs  &&  gc "update"  &&  gp  && cd -'
alias cp_vim='cp -t ~/Github/My_Configs/ $VIM/vimrc'
alias cp_dotfiles='cp -t ~/Github/My_Configs/ ~/.inputrc ~/.bashrc ~/.profile ~/.tmux.conf'
alias cp_snippets='cp -t ~/Github/My_Configs/snippets ~/snippets/*'
alias cp_after='cp_syntax  &&  cp_ftplugin  &&  cp_plugin'
	alias cp_syntax='cp -t ~/Github/My_Configs/syntax  ~/.vim/after/syntax/*'
	alias cp_ftplugin='cp -t ~/Github/My_Configs/ftplugin  ~/.vim/after/ftplugin/*'
	alias cp_plugin='cp -t ~/Github/My_Configs/plugin/ ~/.vim/after/plugin/*'
alias cp_templates='cp -t ~/Github/My_Configs/templates/ ~/.vim/bundle/vim-template/templates/*'
alias cpconfig='cp_vim  &&  cp_dotfiles  &&  cp_snippets  &&  cp_after  &&  cp_templates  &&  git_update'

# aliases for Ubuntu (because of stupid sudo)
if [ "$ENV_TYPE" == "ubuntu" ]
	then alias vim='sudo vim'
		 alias cp='sudo cp'
		 alias mv='sudo mv'
		 alias rm='sudo rm'
		 alias mkdir='sudo mkdir'
		 alias ls='sudo ls'
		 alias chmod='sudo chmod'
		 alias DOS='sudo dos2unix'
		 alias install='sudo apt-get install'
		 alias search='sudo apt-cache search'
		 alias open='gnome-open'
		 alias p='python'
fi

# aliases for Cygwin
if [ "$ENV_TYPE" == "cygwin" ]
	then alias open='cygstart'
		 alias DOS='dos2unix'
		 alias p='python -i'
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
alias cdafter='cd ~/.vim/after/'

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
alias grep='grep -ni --color --exclude tags --exclude .tags'
alias tar='tar -xzvf'

# lazy aliases and typos
alias sl='ls'
alias l='ls'
alias ch='chmod 755'

# enable extglob (useful for something like rm !(temp.c))
shopt -s extglob

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
fi

# map cd --> cd then ls
cd() { builtin cd "${1-$(echo ~)}" && ls -F; }

# cool but useless 'red' echo
# echo() { builtin echo -e "\x1B[31m ${1} \x1B[0m"; }

# ~- means the previous directory
# !$ means the last argument in the command line

# added by Anaconda2 4.1.0 installer
# export PATH="/home/jusnguy/anaconda2/bin:$PATH"
