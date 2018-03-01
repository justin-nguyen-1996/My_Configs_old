set nocompatible " required
filetype off     " required

" ================================================================="
" ================================================================="
" ==================== Begin my added plugins ====================="

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'             " Vundle plugin manager
Plugin 'vim-syntastic/syntastic'          " syntax checker
Plugin 'luochen1990/rainbow'              " different colors for different levels of parentheses and braces
Plugin 'godlygeek/tabular'                " easily align things
Plugin 'garbas/vim-snipmate'              " snippets for easy code insertion
	Plugin 'MarcWeber/vim-addon-mw-utils' " helper for snippets
	Plugin 'tomtom/tlib_vim'              " helper for snippets
	Plugin 'honza/vim-snippets'           " helper for snippets
Plugin 'aperezdc/vim-template'            " file templates (.c .py .java etc)
"Plugin 'tpope/tpope-vim-abolish'          " correct typos in insert mode
Plugin 'Raimondi/delimitMate'             " auto close quotes, parentheses, braces, etc
Plugin 'tpope/vim-repeat'                 " extend the '.' feature to work with plugins
"Plugin 'ctrlpvim/ctrlp.vim'               " fuzzy file finder
"Plugin 'majutsushi/tagbar'                " displays outline of file structure (classes, functions, global variables)
Plugin 'ARM9/arm-syntax-vim'              " enable syntax highlighting for ARM assembly code (tbh this looks ok at best, not amazing)
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
au BufNewFile,BufRead *.s,*.S set filetype=arm " arm = armv6/7

" WSL yank support
let s:clip = '/mnt/c/Windows/System32/clip.exe'  " default location
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * call system('echo '.shellescape(join(v:event.regcontents, "\<CR>")).' | '.s:clip)
    augroup END
end

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

let g:rainbow_conf = {
\	'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
\	'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
\}

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
" ============== Begin additions for Ctrl-P plugin ================"
let g:ctrlp_map = '<c-\>'
let g:ctrlp_cmd = 'CtrlP'

" ================================================================="
" ================================================================="
" ============== Begin additions for pymode plugin ================"
let g:pymode_warnings = 0
let g:pymode_options_colorcolumn = 0
let g:pymode_indent = 0
let g:pymode_lint_on_fly = 0
let g:pymode_syntax_indent_errors = 0
let g:pymode_syntax_space_errors = 0
let g:pymode_lint_checkers = ['pyflakes']

" ================================================================="
" ================================================================="
" ============== Begin additions for tagbar plugin ================"
nnoremap ;n :TagbarToggle<CR>
let g:tagbar_show_linenumbers = 2
let g:tagbar_sort = 0

" ================================================================="
" ================================================================="
" ================== Begin my 'set' vimrc things =================="

" Show (partial) command in status line
set showcmd

" colorscheme
set background=dark

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

" no highlight search
set nohlsearch

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
set wildignorecase

" tweaks for file browsing
let g:netrw_browse_split=4   " open in prior window
let g:netrw_altv=1           " open splits to the right
let g:netrw_liststyle=3      " tree view

" set matching parenthesis/brace/bracket to be underlined instead of highlight
hi MatchParen cterm=underline ctermbg=none ctermfg=none

" always show the tabline (tab header bar)
set showtabline=2
set tabpagemax=30

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
nnoremap <C-l> gt

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

" mappings for easily deleting the surrounding brackets/parentheses
" ==========================================================================================================
nnoremap <silent> <Plug>Map_df( dt(me%x`ex:silent! call repeat#set("\<plug>Map_df(", v:count)<cr>
nmap df( <Plug>Map_df(

nnoremap <silent> <Plug>Map_d( me%x`ex:silent! call repeat#set("\<Plug>Map_d(", v:count)<CR>
nmap d( <Plug>Map_d(

nnoremap <silent> <Plug>Map_df[ dt[me%x`ex:silent! call repeat#set("\<Plug>Map_df[", v:count)<CR>
nmap df[ <Plug>Map_df[

nnoremap <silent> <Plug>Map_d[ me%x`ex:silent! call repeat#set("\<Plug>Map_d[", v:count)<CR>
nmap d[ <Plug>Map_df[
" ==========================================================================================================

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

" mapping to easily insert spaces on interior sides of matching parentheses
nnoremap ( %i <ESC>l%a <ESC>h
nnoremap ) %a <ESC>h%i <ESC>l

" move to next function in C
nnoremap <silent> ]] :call search("^\\(\\w.*\\)\\?{")<CR>
nnoremap <silent> [[ :call search("^\\(\\w.*\\)\\?{", "b")<CR>

" ================================================================="
" ================================================================="
" =============== Begin my 'inoremaps' vimrc things ==============="

" autocomplete for matching brace (activated upon pressing enter)
if g:os =~ 'CYGWIN'
	inoremap {<CR>  {<CR>}<Esc><Esc>O
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

" easier uppercasing/lowercasing
vnoremap U ~

" so that your default register won't be overwritten when you paste over stuff in visual mode
xnoremap p "_dP

" to avoid triggering that stupidly annoying `man` lookup that is utterly and completely useless
vnoremap K <NOP>

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
	execute a:line1 . ',' . l:line2 . 'Tabularize /}/' 
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
		silent! call setreg('"', temp)
		silent! call setreg('*', temp)
		silent! call setreg('+', temp)
		silent! call setreg('0', temp)
	endif
endfunction
nnoremap <silent> dd :call Smart_Delete_dd()<CR>

function! Smart_Delete_Vd() range
	let temp = getreg('"', 1)
	execute 'normal!' . (a:lastline - a:firstline + 1) . 'dd'
	if matchstr(@", '\_s*') == @"    " if just whitespace
		silent! call setreg('"', temp)
		silent! call setreg('*', temp)
		silent! call setreg('+', temp)
		silent! call setreg('0', temp)
	endif
endfunction
vnoremap <silent> d :call Smart_Delete_Vd()<CR>

"=================================================================="

" make it easier to jump down to where you stopped the visual copy
" --> visual copying always puts you back at the top line of the visual range
"     (but what if you wanted to copy downwards and stay down there?)
 
" function! Visual_Copy_Hack() range
" 	let l:lineDiff = a:lastline - a:firstline
" 	execute a:firstline . ',' . a:lastline . 'y'
" 	execute 'normal!' l:lineDiff . 'j'
" 	execute 'normal!' 'mj'
" 	execute 'normal!' l:lineDiff . 'k'
" endfunction
" vnoremap <silent> y :call Visual_Copy_Hack()<CR>

"=================================================================="

" insert the full path of the current file 
fun! s:fullpath()
	:put =expand('%:p')
endfun
command! FullPath :call s:fullpath()

"=================================================================="

" make an incremented list from a column of the same number
" 1.        1.
" 1.  -->   2.
" 1.        3.

fun! s:AddToList(line1, line2)

	" mark line1  &&  keep track of lines selected
	execute 'normal!' 'me'
	let l:numDiff = a:line2 - a:line1
	let l:colNum  = col('.')

	" loop through and increment the list
	let i = numDiff
	let j = 0
	execute 'normal!' 'j'
	while i > 0
		execute 'normal!' 'mr'
		while j < i
			execute 'normal!' 'j'
			while col('.') != l:colNum
				execute 'normal!' 'h'
			endwhile
			let j += 1
		endwhile
		execute 'normal!' '`rj'
		let i -= 1
		let j = 0
	endwhile

	" return to the beginning of the list incrementation
	execute 'normal!' '`e'

endfun
command! -range Add :call s:AddToList(<line1>, <line2>)

"=================================================================="

" align all the '=' signs when doing something like this:
" temp = fxn( a = asdf,
"             b = asdfasdfasdf,
"             c_asdf = asdf,
"             d_asdfasdf = asdf )
"
" to turn it into this:
" temp = fxn( a          = asdf,
"             b          = asdfasdfasdf,
"             c_asdf     = asdf,
"             d_asdfasdf = asdf )

fun! s:TabularEquals(line1, line2)

	" mark line1  &&  keep track of lines selected
	execute 'normal!' 'me'
	let l:lineDiff = a:line2 - a:line1

	" put the first argument on a new line and align it with the other arguments 
	execute 'normal!' '0f=f=B'
	let l:colNum = col('.')
	execute 'normal!' 'i'

	" align all of the arguments with where they should be
	execute 'normal' 'l'
	let l:curCol = col('.')
	let l:curLine = line('.')
	let l:endLine = l:curLine + l:lineDiff
	while l:curLine < l:endLine+1
		while l:curCol < l:colNum
			execute 'normal!' 'i '
			execute 'normal!' 'l'
			let l:curCol = col('.')
		endwhile
		execute 'normal!' 'j0w'
		let l:curLine += 1
		let l:curCol = col('.')
	endwhile

	" line up the '=' signs
	execute 'normal!' '`ejw'
	let l:curLine = line('.')
	execute l:curLine . ',' . (l:curLine+l:lineDiff) . ' Tabularize /=/'

	" put the aligned arguments back on the first line
	execute 'normal!' '`eJJ'

endfun
command! -range TabE :call s:TabularEquals(<line1>, <line2>)

"=================================================================="

" convert a .c file to a .h file
fun! s:convertC2H()
	execute 'normal!' 'meggVGy`e'
	execute 'tabnew %:r.h'
	execute 'normal!' 'p'
 	execute 'g/^\S.*{$/norm $h%s;'
endfun
command! ConvertC2H :call s:convertC2H()

" ================================================================="
" ================================================================="
" ================= Begin my custom ';' commands =================="

" use ;zf to fold all functions (in C and C++ and Java)
function! FoldFunctions()

	" fold functions of type (bool, boolean, int, double, void)
	:silent! execute "%g/^bool/normal! vf{%zf"
	:silent! execute "%g/^boolean/normal! vf{%zf"
	:silent! execute "%g/^char/normal! vf{%zf"
	:silent! execute "%g/^int/normal! vf{%zf"
	:silent! execute "%g/^double/normal! vf{%zf"
	:silent! execute "%g/^void/normal! vf{%zf"
	
	" fold same types of functions but they're static equivalents
	:silent! execute "%g/^static bool/normal! vf{%zf"
	:silent! execute "%g/^static boolean/normal! vf{%zf"
	:silent! execute "%g/^static char/normal! vf{%zf"
	:silent! execute "%g/^static int/normal! vf{%zf"
	:silent! execute "%g/^static double/normal! vf{%zf"
	:silent! execute "%g/^static void/normal! vf{%zf"

	" fold functions of type (uint_t)
	:silent! execute "%g/^uint/normal! vf{%zf"
	:silent! execute "%g/^static uint/normal! vf{%zf"
	
	" fold same types of functions but they're pointer equivalents
	:silent! execute "%g/^bool*/normal! vf{%zf"
	:silent! execute "%g/^boolean*/normal! vf{%zf"
	:silent! execute "%g/^char*/normal! vf{%zf"
	:silent! execute "%g/^int*/normal! vf{%zf"
	:silent! execute "%g/^double*/normal! vf{%zf"
	:silent! execute "%g/^void*/normal! vf{%zf"
	:silent! execute "%g/^unsigned*/normal! vf{%zf"
	:silent! execute "%g/^long*/normal! vf{%zf"

	" fold same types of functions but also they're tabbed equivalents
	:silent! execute "%g/\tbool/normal! vf{%zf"
	:silent! execute "%g/\tboolean/normal! vf{%zf"
	:silent! execute "%g/\tint/normal! vf{%zf"
	:silent! execute "%g/\tdouble/normal! vf{%zf"
	:silent! execute "%g/\tvoid/normal! vf{%zf"

	" fold anything that starts with a tab and then public/private
	:silent! execute "%g/\tpublic/normal! vf{%zf"
	:silent! execute "%g/\tprivate/normal! vf{%zf"

	" fold anything that starts with 'typedef' (e.g. structs and enums)
	:silent! execute "%g/^typedef/normal! vf{%zf"
	:silent! execute "%g/^struct/normal! vf{%zf"
	:silent! execute "%g/^static struct/normal! vf{%zf"

	" fold other types
	:silent! execute "%g/^tid_t/normal! vf{%zf"
	
endfunc
nnoremap ;zf zE :call FoldFunctions()<CR><ESC>

" use ;n to toggle between number mode and relative number mode
function! s:NumberToggle()
  if(&relativenumber == 1)
    set nornu
	set nonu
  else
    set rnu
	set nu
  endif
endfunc
command! NumberToggle :call s:NumberToggle()
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
" use ;T to open a file from the directory of the current open file
nnoremap ;t :tabnew 
nnoremap ;T :tabnew %:p:h/

" use ;m to run the Makefile in the current directory (:make)
nnoremap ;m :make<CR>

" use ;s to source the vimrc file
nnoremap ;s :source ~/.vimrc<CR>

" use ;f to format the file according to C++/Java style
function! s:FormatToggle()
  execute "set expandtab!"
  execute "set expandtab?"
  execute 'normal!' "gg=G''"
endfunc
command! FormatToggle :call s:FormatToggle()

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

" use ;r to comment out the current line and stick a REMOVE at the end
nnoremap ;r I//<C-c>A // REMOVE<C-c>

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

