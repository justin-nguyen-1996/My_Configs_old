set nocompatible " required
filetype off     " required

" ================================================================="
" ================================================================="
" ==================== Begin added plugins ========================"

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'             " vundle plugin manager
Plugin 'tpope/vim-fugitive'               "	vim wrapper for git
Plugin 'tpope/vim-rhubarb'			      " allows :Gbrowse to open up Github URL
Plugin 'godlygeek/tabular'                " easily align things
Plugin 'SirVer/ultisnips'                 " snippets engine for easy code insertion
Plugin 'honza/vim-snippets'			      " snippets database
Plugin 'Valloric/YouCompleteMe'           " a code-completion engine with IDE-esque support for different languages
Plugin 'davidhalter/jedi'			      " semantic-completion engine for Python
Plugin 'aperezdc/vim-template'            " file templates (.c .py .java etc)
Plugin 'tpope/vim-repeat'                 " extend the '.' feature to work with plugins
Plugin 'Raimondi/delimitMate'             " auto close quotes, parentheses, braces, etc
Plugin 'luochen1990/rainbow'              " different colors for different levels of parentheses and braces
" Plugin 'ARM9/arm-syntax-vim'              " enable syntax highlighting for ARM assembly code (tbh this looks ok at best, not amazing)
" Plugin 'ctrlpvim/ctrlp.vim'               " fuzzy file finder
" Plugin 'majutsushi/tagbar'                " displays outline of file structure (classes, functions, global variables)
" Plugin 'tpope/tpope-vim-abolish'          " correct typos in insert mode
" Plugin 'Yggdroot/indentLine'              " display indention levels with thin vertical lines
call vundle#end()
filetype plugin indent on

" ================================================================="
" ================================================================="
" ===================== End of plugins list ======================="

if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
   set fileencodings=ucs-bom,utf-8,latin1
endif

set bs=indent,eol,start		" allow backspacing over everything in insert mode
set ai			            " always set autoindenting on
set viminfo='20,\"50	    " read/write a .viminfo file, don't store more than 50 lines of registers
set history=50		        " keep 50 lines of command line history

" Only do this part when compiled with support for autocommands
if has("autocmd")
  augroup fedora
  autocmd!

  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif

  " don't write swapfile on most commonly used directories for NFS mounts or USB sticks
  autocmd BufNewFile,BufReadPre /media/*,/run/media/*,/mnt/* set directory=~/tmp,/var/tmp,/tmp

  " auto-source the vimrc upon writing to the file
  autocmd BufWritePost .vimrc source %
  
  " if a new or existing file is opened and has a .s or .S extension, set the filetype to ARM
"   autocmd BufNewFile,BufRead *.s,*.S set filetype=arm " arm = armv6/7

  augroup END
endif

" enable syntax checking
syntax enable

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
" ========== Begin additions for Fugitive plugin =================="

augroup turbo_commit
  autocmd!
  autocmd BufEnter COMMIT_EDITMSG startinsert
augroup END

" ================================================================="
" ================================================================="
" ========== Begin additions for Ultisnips plugin ============="

" Snippet completion triggers
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" how `:UltiSnipsEdit` will split the window
let g:UltiSnipsEditSplit="vertical"

" tells `:UltiSnipsEdit` where to look for snippets
let g:UltiSnipsSnippetDirectories=['~/.vim/bundle/vim-snippets/snippets']

" ================================================================="
" ================================================================="
" ========== Begin additions for YouCompleteMe plugin ============="

" uncomment to use Syntastic (gcc compiler) for detecting syntax errors
" let g:ycm_show_diagnostics_ui = 0

" change the keys that cycle forwards/backwards through the completion menu
let g:ycm_key_list_select_completion = ['<Down>']
let g:ycm_key_list_previous_completion = ['<Up>']

" tell YCM which python binary to use
let g:ycm_python_binary_path = 'python'

" disable syntax highlighting for error and warning messages
let g:ycm_enable_diagnostic_highlighting = 0

" ignore annoying extra confimation of using the .ycm_confirm_extra_conf file
let g:ycm_confirm_extra_conf = 0

" uncomment to let YCM populate the location list
let g:ycm_always_populate_location_list = 1

" let YCM use the tags file for completion
let g:ycm_collect_identifiers_from_tags_files = 1

" don't let YCM include snippets in the completion menu
let g:ycm_use_ultisnips_completer = 0

" options for displaying the YCM preview window
" if want to disable YCM preview window, add `set completeopt-=preview` to vimrc. Also add `let g:ycm_add_preview_to_completeopt = 0`
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_insertion = 1

" shortcut command for quickly opening the preview window in vim
function! s:open_preview()
	execute ':YcmDiags'
endfunction
command! LO :call s:open_preview()

" shortcut command for quickly closing the preview window in vim
function! s:close_preview()
	execute ':lclose'
	execute ':pclose'
endfunction
command! LC :call s:close_preview()

" shortcut command for quickly getting the type of a function/variable
" NOTE: not named TYPE because of command ordering
function! s:get_type()
	execute ':YcmCompleter GetType'
endfunction
command! TAYPE :call s:get_type()

" shortcut command for quickly getting the documentation of a function/variable
function! s:get_doc()
	execute ':YcmCompleter GetDoc'
	execute 'normal!' 'j'
endfunction
command! DOC :call s:get_doc()

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

" set tab length, indentation length, how much backspace deletes, auto indent
set tabstop=4
set shiftwidth=4
set softtabstop=4
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

" change vimdiff options so it uses filler lines and produces diff in a vertical split
set diffopt=filler,vertical

" display all matching files when you tab-complete
set wildmenu
set wildignorecase

" change the vertical split indicator
set fillchars+=vert:│

" tweaks for file browsing
let g:netrw_browse_split=4   " open in prior window
let g:netrw_altv=1           " open splits to the right
let g:netrw_liststyle=3      " tree view

" always show the tabline (tab header bar)
set showtabline=2
set tabpagemax=30

" show the absolute file path in the title of the window itself (e.g. WSL, Cygwin, etc.)
set title

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
if $ENV_TYPE != 'wsl'
	if has('unnamedplus')
		set clipboard=unnamed,unnamedplus
	else
		set clipboard=unnamed
	endif
endif

" ================================================================="
" ================================================================="
" ================== Begin my 'highlight' things =================="

" uncomment to make searches underline instead of highlight words
" highlight Search cterm=underline ctermbg=None ctermfg=Red

" First one is the default highlight settings for vim's visual mode. Second one is more readable though
" highlight Visual cterm=reverse ctermfg=None ctermbg=DarkGray
" highlight Visual cterm=None ctermfg=Black ctermbg=White

" change highlighting for vertical splits
highlight VertSplit ctermfg=White ctermbg=DarkGray gui=none

" set matching parenthesis/brace/bracket to be underlined instead of highlight
highlight MatchParen cterm=underline ctermbg=none ctermfg=none

" make the vim tab bar look prettier
highlight   TabLine       term=None   cterm=Underline   ctermfg=Blue    ctermbg=Black    gui=None " part of tabline that isn't selected
highlight   TabLineSel    term=None   cterm=Reverse                                      gui=None " part of tabline that is highlighted
highlight   TabLineFill   term=None   cterm=None        ctermfg=Black   ctermbg=Black    gui=None " the rest of the tabline
highlight   Title         term=None   cterm=Bold        ctermfg=Black   ctermbg=Yellow   gui=None " title of the window

" change highlighting for c-style comments (e.g. Green or DarkGreen)
highlight   cCommentL   ctermfg=DarkGreen
highlight   cComment    ctermfg=DarkGreen

" change highlighting for Fugitive's :Gstatus window
highlight   gitcommitSelectedType    ctermfg=Green
highlight   gitcommitSelectedFile    ctermfg=Green
highlight   gitcommitDiscardedType   ctermfg=Red
highlight   gitcommitDiscardedFile   ctermfg=Red
highlight   gitcommitUntrackedFile   ctermfg=Red
highlight   gitcommitOnBranch        ctermfg=White
highlight   gitcommitBranch          ctermfg=White
highlight   gitcommitDiscarded       ctermfg=White
highlight   gitcommitComment         ctermfg=White
highlight   gitcommitHead            ctermfg=White
highlight   gitcommitHeader          ctermfg=White

" change highlighting for Fugitive's :Gdiff windows
highlight   DiffAdd      term=None   cterm=None   ctermfg=White   ctermbg=DarkGreen " lines in this buffer that aren't in the other buffer
highlight   DiffDelete   term=None   cterm=None   ctermfg=White   ctermbg=DarkRed   " indicates that the other buffer has content here
highlight   DiffChange   term=None   cterm=None   ctermfg=White   ctermbg=Magenta   " lines that both buffers have but were changed
highlight   DiffText     term=None   cterm=None   ctermfg=White   ctermbg=DarkGreen " the specific changed text in the changed lines

" ================================================================="
" ================================================================="
" ============== Changes to default vim status line ==============="

" make the status line always appear
set laststatus=2

" customize what the status line shows
" let b:branch_name = '' " TODO
function! s:load_my_statusline()
	set statusline=                      " start with an empty status line
	set statusline+=%F\                  " show file name
	set statusline+=%m\                  " show modified flag
	set statusline+=%r                   " show read-only flag
	set statusline+=[%{fugitive#head()}] " show current git branch
	let b:branch_name = fugitive#head() " TODO
endfunction

function! s:set_branch_name()
	let b:branch_name = fugitive#head()
endfunction

" only load the status line upon entering vim
augroup my_status_line2
	autocmd!
	autocmd BufNew,BufRead * call s:set_branch_name()
augroup END
augroup my_status_line
	autocmd!
	autocmd VimEnter * call s:load_my_statusline()
augroup END

" better colors for the status line
highlight StatusLine     term=None   cterm=None   ctermfg=Black   ctermbg=Gray       gui=None
highlight StatusLineNC   term=None   cterm=None   ctermfg=Black   ctermbg=DarkGray   gui=None

" original status line colors
" highlight StatusLine     term=None   cterm=Bold,Reverse   gui=None
" highlight StatusLineNC   term=None   cterm=Reverse        gui=None

" alternative status line colors
" highlight StatusLine     term=None   cterm=Bold   ctermfg=White   ctermbg=Blue   gui=None
" highlight StatusLineNC   term=None   cterm=None   ctermfg=White   ctermbg=Blue   gui=None

" ================================================================="
" ================================================================="
" =============== Begin my 'nnoremaps' things ====================="

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

" make control-g display the absolute path to the file
nnoremap <C-g> 1<C-g>

" ================================================================="
" ================================================================="
" =============== Begin my 'inoremaps' things ====================="

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
if $ENV_TYPE == 'wsl'
	inoremap <C-p> <C-R>"
else
	inoremap <C-p> <C-R>*
endif

" remap the autocomplete feature in vim to only look in the current file (deprecated because of YouCompleteMe)
" inoremap <C-n> <C-x><C-n>

" remap the autocomplete feature for files to Control-k in insert mode
inoremap <C-k> <C-x><C-f>

" ================================================================="
" ================================================================="
" =============== Begin my 'vnoremaps' things ====================="

" easier uppercasing/lowercasing
vnoremap U ~

" so that your default register won't be overwritten when you paste over stuff in visual mode
xnoremap p "_dP

" to avoid triggering that stupidly annoying `man` lookup that is utterly and completely useless
vnoremap K <NOP>

" ================================================================="
" ================================================================="
" ============== Begin some 'function' things ====================="

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
function! s:reformat(line1, line2)

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
endfunction
command! -range Reformat :call s:reformat(<line1>, <line2>)

"=================================================================="

" unformat single line if-statements into multiline if-statements
function! s:unformat(line1, line2)

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
endfunction
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

" NOTE: commented out because this affects visually selecting and deleting code folds
" function! Smart_Delete_Vd() range
" 	let temp = getreg('"', 1)
" 	execute 'normal!' . (a:lastline - a:firstline + 1) . 'dd'
" 	if matchstr(@", '\_s*') == @"    " if just whitespace
" 		silent! call setreg('"', temp)
" 		silent! call setreg('*', temp)
" 		silent! call setreg('+', temp)
" 		silent! call setreg('0', temp)
" 	endif
" endfunction
" vnoremap <silent> d :call Smart_Delete_Vd()<CR>

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
function! s:fullpath()
	:put =expand('%:p')
endfunction
command! FullPath :call s:fullpath()

"=================================================================="

" make an incremented list from a column of the same number
" 1.        1.
" 1.  -->   2.
" 1.        3.

function! s:AddToList(line1, line2)

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

endfunction
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

function! s:TabularEquals(line1, line2)

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

endfunction
command! -range TabE :call s:TabularEquals(<line1>, <line2>)

"=================================================================="

" convert a .c file to a .h file
function! s:convertC2H()
	w %:r.h
	tabe %:r.h
 	execute 'g/^\S.*{$/norm $h%s;'
endfunction
command! ConvertC2H :call s:convertC2H()

"=================================================================="

" quickly open vimrc in a horizontal split
function! s:editVimrc()
	execute ':split ~/.vimrc'
endfunction
command! EV :call s:editVimrc()

"=================================================================="

" quickly open bashrc in a horizontal split
function! s:editBashrc()
	execute ':split ~/.bashrc'
endfunction
command! EA :call s:editBashrc()

"=================================================================="

" quickly change the working directory to the file's directory
function! s:CdHere()
	execute ':cd %:h'
endfunction
command! CdHere :call s:CdHere()

"=================================================================="

" show syntax highlighting groups for word under cursor
function! <SID>HighlightGroup()
	if !exists("*synstack")
		return
	endif
	echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunction
command! HighlightGroup :call s:HighlightGroup()

"=================================================================="

" quickly grab the dff contents of the specified buffer (by number) into the current buffer
" in Fugitive with 2 buffers, use `:GG`
" in Fugitive with 3 buffers (b/c of git merge), use `:GG 2` to grab the HEAD branch's contents
" in Fugitive with 3 buffers (b/c of git merge), use `:GG 3` to grab the merge branch's contents
function! s:GitDiffGet(...)
	let l:num_args = a:0
	if (l:num_args == 0)
		execute ':diffget | diffupdate'
	else
		let l:buffer_num = a:1
		execute ':diffget //' . l:buffer_num . ' | diffupdate'
	endif
endfunction
command! -nargs=? GG :call s:GitDiffGet(<f-args>)

"=================================================================="

" wrapper around :Gtabedit that names the buffer something more reasonable (<branch>:<file_path>)
function! s:get_branch_name(file_name) " TODO: remove
	let l:tokens = split(a:file_name, ":")
	let l:branch_name = l:tokens[0]
	let l:file_path = l:tokens[1]
" 	return l:branch_name
	return "hi"
endfunction
function! s:GTabEdit(file_name)
	execute ':Gtabedit ' . a:file_name
	execute ':file ' . a:file_name
	
	let b:tokens = split(a:file_name, ":")
	let b:branch_name = b:tokens[0]
" 	let b:file_path = b:tokens[1] " TODO: use this?
	
	set statusline=                      " start with an empty status line
	set statusline+=%F\                  " show full file name path
	set statusline+=%m\                  " show modified flag
	set statusline+=%r                   " show read-only flag
" 	set statusline+=[%{fugitive#head()}] " show current git branch
" 	set statusline+=[%{g:branch_name}] " show current git branch
	set statusline+=[%{b:branch_name}] " show current git branch
" 	set statusline+=[%{get_branch_name()}] " show current git branch
	
endfunction
command! -nargs=1 GTabEdit :call s:GTabEdit(<f-args>)

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

endfunction
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
endfunction
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
nnoremap ;t :tabnew<C-Space>
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
endfunction
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

" Fugitive plugin mappings
nnoremap ;gs  :Gstatus<CR>
nnoremap ;gbb :Git branch -v<CR>
nnoremap ;gba :Git branch -va<CR>
nnoremap ;gt  :GTabEdit<C-Space>

" ================================================================="
" ================================================================="
" ================== Some nice things to remember ================="

" restore color scheme --> this is not actually mapped to something
" set filetype=____   (e.g. :set filetype=cpp)

" zipping files
" zip -r file_name.zip *

" check a window's vim filetype --> `:set ft?`

" check available highlight colors --> `:h cterm`

" check current highlight settings for all highlight groups --> `:highlight`

" running :Gdiff is the same as running vimdiff with the file commited in Git (vimdiff is way better than diff)

" Don't wake up system with blinking cursor:
" http://www.linuxpowertop.org/known.php
let &guicursor = &guicursor . ",a:blinkon0"

