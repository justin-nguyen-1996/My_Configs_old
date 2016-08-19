" All system-wide defaults are set in $VIMRUNTIME/debian.vim and sourced by
" the call to :runtime you can find below.  If you wish to change any of those
" settings, you should do it in this file (/etc/vim/vimrc), since debian.vim
" will be overwritten everytime an upgrade of the vim packages is performed.
" It is recommended to make changes after sourcing debian.vim since it alters
" the value of the 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
if has("syntax")
  syntax on
endif

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
" set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif





" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""" where my additions to the vimrc file begin """"""""""""""

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

" don't expand tabs to spaces for Makefiles
" autocmd FileType make set noexpandtab shiftwidth=8 softtabstop=0

" augroup filetype
"   autocmd BufNewFile,BufRead */.Postponed/* set filetype=mail
"   autocmd BufNewFile,BufRead *.txt set filetype=human
"   autocmd BufNewFile,BufRead *.java set tabstop=4 expandtab
" augroup END

" for C-like programming language syntaxes
" autocmd FileType c,cpp,java set formatoptions+=ro expandtab
" autocmd FileType c set omnifunc=ccomplete#Complete

" type 'Sys' then press TAB to easily output 'System.out.println('
inoremap Sys<TAB> System.out.println(

" typing gg still retains its functionality of jumping to a line
" but now it also centers the screen on that line
nnoremap gg ggzz

" map the jump-to-mark command 'm so that the
" command centers the screen upon jumping
nnoremap 'm 'mzz

" press % to visually highlight in-between brace/bracket/parentheses
noremap % v%

" autocomplete for matching brace (activated upon pressing enter)
inoremap {<CR>  {<CR>}<Esc>O<TAB>

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
nnoremap K i<CR><TAB><ESC>f}i<CR><BS><BS><BS><BS><ESC>

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
function! ToggleComment()
    if matchstr(getline(line(".")),'^\s*\/\/.*$') == ''
           :execute "s:^:// :"
    else
           :execute "s:^\s*// ::"
    endif
endfunction

" use ;t and type a file name to open it in a VIM tab (:tabnew)
nnoremap ;t :tabnew 

" use ;m to run the Makefile in the current directory (:make)
nnoremap ;m :make<CR>

" use ;s to source the vimrc file
nnoremap ;s :source /usr/share/vim/vimrc<CR>

" use ;f to format the file according to C++/Java style
nnoremap ;f :set expandtab! expandtab?<CR>gg=G''

" use ;x to delete the object along with its member
nnoremap ;x F.BdW

" use ;i to put the selected lines into an if-statement
vnoremap ;i dO<TAB>if () {<CR>}<ESC>kp/}<CR>k>i{?{<CR>j0w

" use ;j to jump from a function call to that function's definition
" use T  to pop from the tag stack and go to that location
" use in conjuction with ctags
nnoremap ;j <C-]>
nnoremap T <C-t>

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

