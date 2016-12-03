if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
   set fileencodings=ucs-bom,utf-8,latin1
endif

set nocompatible	" Use Vim defaults (much better!)
set bs=indent,eol,start		" allow backspacing over everything in insert mode
"set ai			" always set autoindenting on
"set backup		" keep a backup file
set viminfo='20,\"50	" read/write a .viminfo file, don't store more
			" than 50 lines of registers
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time

" Only do this part when compiled with support for autocommands
if has("autocmd")
  augroup fedora
  autocmd!
  " In text files, always limit the width of text to 78 characters
  " autocmd BufRead *.txt set tw=78
  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif
  " don't write swapfile on most commonly used directories for NFS mounts or USB sticks
  autocmd BufNewFile,BufReadPre /media/*,/run/media/*,/mnt/* set directory=~/tmp,/var/tmp,/tmp
  " start with spec file template
  autocmd BufNewFile *.spec 0r /usr/share/vim/vimfiles/template.spec
  augroup END
endif

if has("cscope") && filereadable("/usr/bin/cscope")
   set csprg=/usr/bin/cscope
   set csto=0
   set cst
   set nocsverb
   " add any database in current directory
   if filereadable("cscope.out")
      cs add $PWD/cscope.out
   " else add database pointed to by environment
   elseif $CSCOPE_DB != ""
      cs add $CSCOPE_DB
   endif
   set csverb
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
"if &t_Co > 2 || has("gui_running")
"  syntax on
"  set hlsearch
"endif

filetype plugin on

if &term=="xterm"
     set t_Co=8
     set t_Sb=[4%dm
     set t_Sf=[3%dm
endif

set showcmd			" Show (partial) command in status line.

" set showmatch		" Show matching brackets.
					" (DISABLED) because too hard to find cursor

set ignorecase		" Do case insensitive matching

set smartcase		" Do smart case matching

" set incsearch		" Incremental search
					" (DISABLED) personal choice, your decision

set autowrite		" Automatically save before commands like :make

set hidden			" Hide buffers when they are abandoned

" set mouse=a		" Enable mouse usage (all modes)
					" (DISABLED) originally made using the
					"  mouse go into Visual mode

" enable filetype detection:
" filetype on
" filetype plugin on
" filetype indent on " file type based indentation

set tabstop=4 		" tab length is 4 spaces
set shiftwidth=4	" indentation length is 4 spaces
set autoindent		" auto indent
" set expandtab 		" change tabs to spaces

set tw=75			" set text width for automatic word wrapping
"set fo+=t
set wrap
set linebreak

" type 'Sys' then press TAB to easily output 'System.out.println('
inoremap Sys<TAB> System.out.println(

" type 'main' then press TAB to easily output the main for a .java file
inoremap main<TAB> public static void main(String[] args) {<CR>}<Esc><Esc>O

" typing gg still retains its functionality of jumping to a line
" but now it also centers the screen on that line
nnoremap gg ggzz

" map the jump-to-mark command 'm so that the
" command centers the screen upon jumping
nnoremap 'm 'mzz

" press % to visually highlight in-between brace/bracket/parentheses
noremap % v%

" autocomplete for matching brace (activated upon pressing enter)
inoremap {<CR>  {<CR>}<Esc><Esc>O

" Capital H now goes to the top of the visible screen
" Capital L now goes to the bottom of the visible screen
nnoremap H L
nnoremap L H

" set matching parenthesis/brace/bracket to be underlined
hi MatchParen cterm=underline ctermbg=none ctermfg=none

" have folds open (not folded) by default
" set nofoldenable

set foldmethod=manual
" auto save code folds (first one for saving code folds)
"					   (second one for loading code folds)
" enable code folding (minimize chunks of code into one-liners)
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview

" don't wrap back to the top after searching
set nowrapscan

" press CTRL-n to toggle between number mode and relative number mode
function! NumberToggle()
  if(&relativenumber == 1)
    set nornu
  else
    set rnu
  endif
endfunc

" auto set relative number mode
nnoremap ;n :call NumberToggle()<cr>
set rnu

" press CTRL-j/CTRL-k to go down/up half a page, respectively
noremap <C-j> <C-D>
noremap <C-k> <C-U>

" auto comments for /* (javadoc style comments)
set comments=sl:/*,mb:\ *,elx:\ */

" auto comment when pressing enter, o, or O
set formatoptions+=rco

" capital K now undoes a capital J
nnoremap K i<CR><ESC><ESC>f}i<CR><ESC><ESC>kw

" change the orientation of the windows when using :split and :vs
set splitbelow
set splitright

" use CTRL-h and CTRL-L to switch between Vim tabs
nnoremap <C-h> gT
inoremap <C-h> <ESC>gT
nnoremap <C-l> gt
inoremap <C-l> <ESC>gt

" DUMBEST HACK EVER (but I'm so happy it works)
" normally pressing CTRL-c undoes your auto-indent on a blank line
" solutions to this is to make a new line that is auto-indented for you
" 	and then type some random character, delete it, then press CTRL-c
" so, that's exactly what this hack does
inoremap <C-c> l<BS><ESC>

" lets the tags file to be in a separate directory from the source code
" basically does the following:
" 	goes up one directory at a time until it finds a file called '.tags'
set tags=.tags;/

nnoremap , ;
nnoremap < ,

" -----------------------------------------------------------------"
" -----------------------------------------------------------------"
" -----------------------------------------------------------------"
" --------------- Begin my custom ';' commands --------------------"

" use ;p to retain original indentation when pasting from another application
nnoremap ;p :set invpaste paste?<CR>
set showmode

" use ;w to remove trailing whitespace press ';w' (semicolon then 'w')
function! TrimWhitespace()
    let l:save_cursor = getpos('.')
    %s/\s\+$//e
    call setpos('.', l:save_cursor)
endfunction
nnoremap ;w :call TrimWhitespace()<CR>

" use ;h to toggle highlighted search
nnoremap ;h :set hlsearch! hlsearch?<CR>

" use ;e to toggle expandtab
" nnoremap ;e :set expandtab! expandtab?<CR>

vnoremap ;/ :call ToggleComment()<CR>
nnoremap ;/ :call ToggleComment()<CR>
function! ToggleComment()
    if matchstr(getline(line(".")),'^\s*\/\/.*$') == ''
           :execute "s:^:// :"
    else
           :execute "s:^\s*// ::"
    endif
endfunction

" use ;l to reload the file
nnoremap ;l :e<CR>

" use ;t and type a file name to open it in a VIM tab (:tabnew)
nnoremap ;t :tabnew 

" use ;m to run the Makefile in the current directory (:make)
nnoremap ;m :make<CR>

" use ;s to source the vimrc file
nnoremap ;s :source /etc/vimrc<CR>

" use ;f to format the file according to C++/Java style
nnoremap ;f :set expandtab! expandtab?<CR>gg=G''

" use ;i to put the selected lines into an if-statement
vnoremap ;i dO<TAB>if () {<CR>}<ESC>kp/}<CR>k>i{?{<CR>j0w

" use ;j to jump from a function call to that function's definition
" use T  to pop from the tag stack and go to that location
" use in conjuction with ctags
nnoremap ;j <C-]>zz
nnoremap T <C-t>zz

" Don't wake up system with blinking cursor:
" http://www.linuxpowertop.org/known.php
let &guicursor = &guicursor . ",a:blinkon0"
