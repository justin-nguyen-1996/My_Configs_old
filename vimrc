set nocompatible              " be iMproved, required
filetype off                  " required

" ================================================================="
" ================================================================="
" ==================== Begin my added plugins ====================="

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-syntastic/syntastic'
Plugin 'luochen1990/rainbow'
Plugin 'godlygeek/tabular'
Plugin 'garbas/vim-snipmate'
	Plugin 'MarcWeber/vim-addon-mw-utils'
	Plugin 'tomtom/tlib_vim'
	Plugin 'honza/vim-snippets'
Plugin 'aperezdc/vim-template'
Plugin 'tpope/tpope-vim-abolish'
Plugin 'Raimondi/delimitMate'
Plugin 'tpope/vim-repeat'
call vundle#end()
filetype plugin indent on

" ================================================================="
" ================================================================="
" ===================== End my added plugins ======================"

if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
   set fileencodings=ucs-bom,utf-8,latin1
endif

set bs=indent,eol,start		" allow backspacing over everything in insert mode
set ai			            " always set autoindenting on
set viminfo='20,\"50	    " read/write a .viminfo file, don't store more than 50 lines of registers
set history=50		        " keep 50 lines of command line history
set ruler		            " show the cursor position all the time

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
  " auto-source the vimrc upon writing to the file
  autocmd bufwritepost vimrc source %
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

syntax enable

" ================================================================="
" ================================================================="
" ============== Begin additions for Syntastic plugin ============="

let &shellpipe = '2>&1| tee'
let &shellredir = '>%s 2>&1'

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_enable_signs=1
let g:syntastic_check_on_wq = 0

"let g:syntastic_auto_loc_list = 2
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
"let g:syntastic_enable_balloons = 0
"let g:syntastic_error_symbol = '✗'
"let g:syntastic_ignore_files = ['\.min\.js$', '\.min\.css$']
"let g:syntastic_loc_list_height = 5
"let g:syntastic_warning_symbol = '✗'
"let g:syntastic_style_error_symbol = '∆'
"let g:syntastic_style_warning_symbol = '∆'

" shortcut command for toggling syntastic mode (useful for when I'm just writing test code)
fun! s:toggle_syntastic()
	call SyntasticToggleMode()
endfun
command! STM :call s:toggle_syntastic()

" ================================================================="
" ================================================================="
" =========== Begin additions for Rainbow_parens plugin ==========="

" set to zero and use :RainbowToggle to switch between modes
let g:rainbow_active = 1

" ================================================================="
" ================================================================="
" =========== Begin additions for Tabular plugin ==========="

vnoremap ;t :Tabularize /

" ================================================================="
" ================================================================="
" =========== Begin additions for SnipMate plugin ==========="

let g:snippet_version = 1

" ================================================================="
" ================================================================="
" ============== Begin additions for Templates plugin ============="

" see :h template.txt

" let g:templates_user_variables = [
" 	\   ['FULLPATH', 'GetFullPath'],
" 	\ ]
" 
" function! GetFullPath()
" 	return expand('%:p')
" endfunction

" ================================================================="
" ================================================================="
" ================== Begin my 'set' vimrc things =================="

" Show (partial) command in status line
set showcmd

" Do case insensitive matching, smart case matching, don't wrap back to the top after searching
set ignorecase
set smartcase
set nowrapscan
set incsearch

" Automatically save before commands like :make
set autowrite

" Hide buffers when they are abandoned
set hidden

" set tab length, indentation length, auto indent
set tabstop=4
set shiftwidth=4
set autoindent

" disable swap file generation
set noswapfile

" change the orientation of the windows when using :split and :vs
set splitbelow
set splitright

" save state of original code folds, don't open code folds when doing searches
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview
set foldopen-=search
set viewoptions=folds,cursor

" auto comments for /* (javadoc style comments)
set comments=sl:/*,mb:\ *,elx:\ */

" lets the tags file to be in a separate directory from the source code
" basically does the following:
" 	goes up one directory at a time until it finds a file called '.tags'
set tags=.tags;/

" set manual fold method, min number of lines to make a fold = 1
set fdm=manual
set fml=1

" fold method based on file syntax
" fold level    = 2 for .java    = 1 for .c
" min fold level = 0 for folding single lines
"set fdm=syntax
"set fml=0
"if &filetype == 'java'
"	set fdn=2
"elseif &filetype == 'c'
"	set fdn=1
"endif

" searches down into subfolders
" provides tab-completion for all file-related tasks
set path+=**

" display all matching files when you tab-complete
set wildmenu

" tweaks for file browsing
let g:netrw_browse_split=4   " open in prior window
let g:netrw_altv=1           " open splits to the right
let g:netrw_liststyle=3      " tree view

" set matching parenthesis/brace/bracket to be underlined
hi MatchParen cterm=underline ctermbg=none ctermfg=none

" make the vim tab bar look prettier
hi TabLineFill ctermfg=Black ctermbg=Black
hi TabLine     ctermfg=Blue  ctermbg=Black
hi TabLineSel  ctermfg=Black ctermbg=Yellow
hi Title       ctermfg=Black ctermbg=Yellow

" set variable 'g:os' according to development environment
if !exists('g:os')
    if has('win32') || has('win16')
        let g:os = 'Windows'
    else
        let g:os = substitute(system('uname'), '\n', '', '')
    endif
endif

" a godsend that disables that stupidly annoying beep/bell once and for all
if g:os =~ 'CYGWIN'
	set belloff=all
endif

" prevent ubuntu from outputting garbage characters
if g:os =~ 'Linux'
	set t_RV=
endif

" make the clipboard the default register
if has('unnamedplus')
    set clipboard=unnamed,unnamedplus
else
	set clipboard=unnamed
endif

" ================================================================="
" ================================================================="
" =============== Begin my 'nnoremaps' vimrc things ==============="

" typing '' now also centers the screen
nnoremap '' ''zz

" map the jump-to-mark command 'm so that the
" command centers the screen upon jumping
nnoremap 'm 'mzz

"" press % to visually highlight in-between brace/bracket/parentheses
noremap % v%

" press CTRL-j/CTRL-k to go down/up half a page, respectively
noremap <C-j> <C-D>
noremap <C-k> <C-U>

" capital K enters a linefeed while maintaining normal mode
nnoremap K i<CR><ESC>

" use CTRL-h and CTRL-L to switch between Vim tabs
nnoremap <C-h> gT
inoremap <C-h> <ESC>gT
nnoremap <C-l> gt
inoremap <C-l> <ESC>gt

" use , to repeat the last find command --> use shift, to go the other way
nnoremap , ;
vnoremap , ;
nnoremap < ,

" remap the normal paste to align the pasted block with the surrounded text
nnoremap p ]p
nnoremap P ]P

" remap yb to not move the cursor backwards (repositioning the cursor was annoying)
nnoremap yb ybw

" remap CTRL-n to move to the next line that has a compile error"
nnoremap <C-n> :cn<CR>

" remap CTRL-p to move to the previous line that has a compile error"
" NOTE: can also map this to CTRL-N
nnoremap <C-p> :cp<CR>

" remap U to ~ for easier uppercasing/lowercasing
nnoremap U ~

" pressing Control-w then Control-c in split windows accidentally closes the window. I dislike this
nnoremap <C-w><C-c> <ESC>

" using 'x' will now put the 'cut' letter(s) in the black hole register "_ 
nnoremap x "_x
nnoremap X "_X

" using '' to will now put you at the (last cursor position) instead of the (last row your cursor was in)
nnoremap '' ``zz

" map Y to act the same as D & C
nnoremap Y y$

" mappings for easily deleting the surrounding brackets/parentheses
nnoremap df( dt(me%x`ex
nnoremap d( me%x`ex
nnoremap df[ dt[me%x`ex
nnoremap d[ me%x`ex

" mappings for easily changing the surrounding brackets/parentheses
nnoremap cf( dt(me%x`exi
nnoremap c( %me%r(`er)%
nnoremap cf[ dt[me%x`exi
nnoremap c[ %me%r[`er]%

" mappings for easily yanking the surrounding brackets/parentheses
nnoremap y( v%y
nnoremap y[ v%y

" mappings for easily replacing the surrounding brackets/parentheses
nnoremap r( %me%r(`er)%
nnoremap r[ %me%r[`er]%

" ================================================================="
" ================================================================="
" =============== Begin my 'inoremaps' vimrc things ==============="

" autocomplete for matching brace (activated upon pressing enter)
if g:os =~ 'CYGWIN'
	inoremap {<CR>  {<TAB><CR>}<Esc><Esc>O
elseif g:os =~ 'Linux'
	inoremap {<CR>  {<CR>}<ESC>O
endif

" DUMBEST HACK EVER (but I'm so happy it works)
" normally pressing CTRL-c undoes your auto-indent on a blank line
" solutions to this is to make a new line that is auto-indented for you
" 	and then type some random character, delete it, then press CTRL-c
" so, that's exactly what this hack does
inoremap <C-c> l<BS><ESC>

" remap the paste function in insert mode to Control-p
inoremap <C-p> <C-R>*

" remap the autocomplete feature in vim to only look in the current file
inoremap <C-n> <C-x><C-n>

" remap the autocomplete feature for files to Control-m in insert mode
inoremap <C-k> <C-x><C-f>

" ================================================================="
" ================================================================="
" =============== Begin my 'vnoremaps' vimrc things ==============="

" remap the paste function in visual mode to Control-p
vnoremap <C-p> p

" easier uppercasing/lowercasing
vnoremap U ~

" so that your default register won't be overwritten when you paste over stuff in visual mode
vnoremap p "0p

" ================================================================="
" ================================================================="
" ============== Begin some 'function' vimrc things ==============="

" now you can close the file, get back in, and still maintain the original undo tree
if has('persistent_undo')
    set undolevels=5000
    call system('mkdir ~/.vim/undo')
    set undodir=~/.vim/undo
    set undofile
endif

"=================================================================="

" toggle commented lines for #-style comments
function! ToggleComment_Py()
	if matchstr(getline(line(".")),'^\s*\#.*$') == ''
		   :execute "s:^:# :"
	else
		   :execute "s:^\s*# ::"
	endif
endfunction
vnoremap ;# :call ToggleComment_Py()<CR>
nnoremap ;# :call ToggleComment_Py()<CR>

" toggle commented lines for "-style comments
function! ToggleComment_Vimrc()
	if matchstr(getline(line(".")),'^\s*\".*$') == ''
		   :execute 's:^:" :'
	else
		   :execute 's:^\s*" ::'
	endif
endfunction
vnoremap ;" :call ToggleComment_Vimrc()<CR>
nnoremap ;" :call ToggleComment_Vimrc()<CR>

"=================================================================="

" reformat multiline if-statements into single line if-statements
fun! s:reformat(line1, line2)
	
	" Remember line locs and numbers (bookkeeping)
	execute 'normal!' 'me'
	let l:before = line('$')
	
	" Join the selected lines && put a newline before every 'else' 
	execute 'normal!' . (a:line2 - a:line1 + 1) . 'J' 
	execute 's/else/\relse/g'

	" Recalculate the range && run Tabular
	let l:line2 = a:line2 - (l:before - line('$'))
	execute 'normal!' "V'e="
	execute 'normal!' 'f(i     '
	execute a:line1 . ',' . l:line2 . 'Tabularize /{/' 
endfun
command! -range Reformat :call s:reformat(<line1>, <line2>)

"=================================================================="

" unformat single line if-statements into multiline if-statements
fun! s:unformat(line1, line2)

	" mark line one  &&  keep track of lines selected
	execute 'normal!' 'me'
	let l:numDiff = a:line2 - a:line1 + 1

	" delete extraneous white space
	execute 'normal!' 'f dt(i '
	let c = 0
	while c < numDiff - 1
		execute 'normal!' 'f)f dt{i '
		execute 'normal!' 'j0w'
		let c += 1
	endwhile
	execute 'normal!' 'f dt{i '

	" Formatting to make the statements span multiple lines
	execute 'normal!' "'e"
	execute 'normal!' . (a:line2 - a:line1 + 1) . 'J' 
	execute 's/{ /{\r/g'
	execute 'normal!' "'e"
	let c = 0
	while c < l:numDiff
		execute 'normal!' 'j'
		execute 's/}/\r}/g'
		let c += 1
	endwhile
	execute 'normal!' "V'e="
endfun
command! -range Unformat :call s:unformat(<line1>, <line2>)

"=================================================================="

" a smarter delete operation (does not copy whitespace into registers)
" NOTE: this doesn't prevent copying whitespace using 'yy' or 'Vy'
"       my assumption is that you wanted to copy the whitespace instead of deleting it
 
function! Smart_Delete_dd()
	let temp = getreg('"', 1)
	execute 'normal!' 'dd'
	if matchstr(@", '\_s*') == @"    " if just whitespace
		call setreg('"', temp)
		call setreg('*', temp)
		call setreg('+', temp)
		call setreg('0', temp)
	endif
endfunction
nnoremap <silent> dd :call Smart_Delete_dd()<CR>

function! Smart_Delete_Vd() range
	let temp = getreg('"', 1)
	execute 'normal!' . (a:lastline - a:firstline + 1) . 'dd'
	if matchstr(@", '\_s*') == @"    " if just whitespace
		call setreg('"', temp)
		call setreg('*', temp)
		call setreg('+', temp)
		call setreg('0', temp)
	endif
endfunction
vnoremap <silent> d :call Smart_Delete_Vd()<CR>

"=================================================================="

" functions for making visual pasting act the way you'd expect it to

function! Visual_Paste_Hack_For_D()
	execute 'normal!' 'D'
	call setreg('0', getreg('"'))
endfunction
nnoremap <silent> D : call Visual_Paste_Hack_For_D()<CR>

function! Visual_Paste_Hack_For_yy()
	execute 'normal!' 'yy'
	call setreg('0', getreg('"'))
endfunction
nnoremap <silent> yy : call Visual_Paste_Hack_For_yy()<CR>

"=================================================================="

" insert the full path of the current file 
fun! s:fullpath()
	:put =expand('%:p')
endfun
command! FullPath :call s:fullpath()

" ================================================================="
" ================================================================="
" ================= Begin my custom ';' commands =================="

" use ;zf to fold all functions (in C and C++ and Java)
function! FoldFunctions()
	:silent! execute "%g/^bool/normal! vf{%zf"
	:silent! execute "%g/^boolean/normal! vf{%zf"
	:silent! execute "%g/^int/normal! vf{%zf"
	:silent! execute "%g/^double/normal! vf{%zf"
	:silent! execute "%g/^void/normal! vf{%zf"

	:silent! execute "%g/\tbool/normal! vf{%zf"
	:silent! execute "%g/\tboolean/normal! vf{%zf"
	:silent! execute "%g/\tint/normal! vf{%zf"
	:silent! execute "%g/\tdouble/normal! vf{%zf"
	:silent! execute "%g/\tvoid/normal! vf{%zf"

	:silent! execute "%g/\tpublic/normal! vf{%zf"
	:silent! execute "%g/\tprivate/normal! vf{%zf"
endfunc
nnoremap ;zf zE :call FoldFunctions()<CR><ESC>

" use ;n to toggle between number mode and relative number mode
function! NumberToggle()
  if(&relativenumber == 1)
    set nornu
	set nonu
  else
    set rnu
	set nu
  endif
endfunc
nnoremap ;n :call NumberToggle()<CR>
set rnu
set nu

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

" use ;l to reload the file
nnoremap ;l :e<CR>

" use ;t and type a file name to open it in a VIM tab (:tabnew)
nnoremap ;t :tabnew 

" use ;m to run the Makefile in the current directory (:make)
nnoremap ;m :make<CR>

" use ;s to source the vimrc file
nnoremap ;s :source $VIM/vimrc<CR>

" use ;f to format the file according to C++/Java style
nnoremap ;f :set expandtab! expandtab?<CR>gg=G''<ESC>

" use ;d to put deleted stuff in the black hole register "_
nnoremap ;d "_dd
vnoremap ;d "_d

" use ;j to jump from a function call to that function's definition
" use T  to pop from the tag stack and go to that location
" use in conjuction with ctags
nnoremap ;j <C-]>zz
nnoremap T <C-t>zz

" use ;y to copy the current text file into the clipboard
nnoremap ;y myggvG$"*y'y

" use ;v to paste from the clipboard
nnoremap ;v "*p

" use ;zf to easily fold code that lies in between the braces
" v%zf<CR>

" use ;r in visual mode to replace the visually selected word
nnoremap ;r ye:%s/<C-F>pa//g<ESC>F/i
vnoremap ;r y:%s/<C-F>pa//g<ESC>F/i

" ================================================================="
" ================================================================="
" ================== Some nice things to remember ================="

" restore color scheme --> this is not actually mapped to something
" set filetype=____   (e.g. :set filetype=cpp)

" zipping files
" zip -r file_name.zip *

" specific things for filetypes --> actually don't do this --> see ~/.vim/after/ftplugin/
" au FileType python 

" Don't wake up system with blinking cursor:
" http://www.linuxpowertop.org/known.php
let &guicursor = &guicursor . ",a:blinkon0"

