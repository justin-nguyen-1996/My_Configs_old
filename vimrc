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
Plugin 'godlygeek/tabular'                " easily align things
Plugin 'SirVer/ultisnips'                 " snippets engine for easy code insertion
Plugin 'honza/vim-snippets'			      " snippets database
Plugin 'nelstrom/vim-visual-star-search'  " allows use of * or # to search in visual mode
" Plugin 'Valloric/YouCompleteMe'           " a code-completion engine with IDE-esque support for different languages
" Plugin 'davidhalter/jedi'			      " semantic-completion engine for Python
Plugin 'aperezdc/vim-template'            " file templates (.c .py .java etc)
" Plugin 'tpope/vim-repeat'                 " extend the '.' feature to work with plugins
Plugin 'Raimondi/delimitMate'             " auto close quotes, parentheses, braces, etc
Plugin 'tommcdo/vim-exchange'             " easily exchange regions of text
" Plugin 'luochen1990/rainbow'              " different colors for different levels of parentheses and braces
" Plugin 'ARM9/arm-syntax-vim'              " enable syntax highlighting for ARM assembly code (tbh this is not amazing)
" Plugin 'ctrlpvim/ctrlp.vim'               " fuzzy file finder
" Plugin 'majutsushi/tagbar'                " displays outline of file structure (classes, functions, global variables)
" Plugin 'tpope/tpope-vim-abolish'          " correct typos in insert mode (among several other things)
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

  " after writing to the .vimrc file, auto-source it
  autocmd BufWritePost .vimrc source %

  " after writing to a file, remove trailing and leading whitespace
  autocmd BufWritePost * :silent call convenient#TrimWhitespace() 
  
  " set syntax highlighting for ROS's .launch files to be that of XML
  autocmd BufNewFile,BufRead *.launch set filetype=xml

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

" now you can close the file, get back in, and still maintain the original undo tree
if has('persistent_undo')
	set undolevels=5000
	" call system('mkdir -p ~/.vim/undo')
	set undodir=~/.vim/undo
	set undofile
endif

" ================================================================="
" ================================================================="
" ========== Begin additions for Fugitive plugin =================="

if !empty(glob("~/.vim/bundle/vim-fugitive/plugin/fugitive.vim"))
	augroup turbo_commit
	  autocmd!
	  autocmd BufEnter COMMIT_EDITMSG startinsert
	augroup END
endif

" ================================================================="
" ================================================================="
" ========== Begin additions for Ultisnips plugin ============="

if !empty(glob("~/.vim/bundle/ultisnips/plugin/UltiSnips.vim"))

	" Snippet completion triggers
	let g:UltiSnipsExpandTrigger="<tab>"
	let g:UltiSnipsJumpForwardTrigger="<tab>"
	let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

	" how `:UltiSnipsEdit` will split the window
	let g:UltiSnipsEditSplit="vertical"

	" tells `:UltiSnipsEdit` where to look for snippets
	let g:UltiSnipsSnippetDirectories=['~/.vim/bundle/vim-snippets/snippets']

endif

" ================================================================="
" ================================================================="
" ========== Begin additions for YouCompleteMe plugin ============="

if !empty(glob("~/.vim/bundle/YouCompleteMe/plugin/youcompleteme.vim"))
	
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
	command! LO :call ycm#OpenPreview()

	" shortcut command for quickly closing the preview window in vim
	command! LC :call ycm#ClosePreview()

	" shortcut command for quickly getting the type of a function/variable under the cursor
	" NOTE: not named TYPE because of command ordering
	command! TAYPE :call ycm#GetType()

	" shortcut command for quickly getting the documentation of a function/variable under the cursor
	command! DOC :call ycm#GetDoc()
endif

" ================================================================="
" ================================================================="
" =========== Begin additions for Rainbow_parens plugin ==========="

if !empty(glob("~/.vim/bundle/rainbow/plugin/rainbow.vim"))
	" set to zero and use :RainbowToggle to switch between modes
	let g:rainbow_active = 1

	let g:rainbow_conf = {
	\	'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
	\	'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
	\}
endif

" ================================================================="
" ================================================================="
" =========== Begin additions for Tabular plugin ==========="

if !empty(glob("~/.vim/bundle/tabular/plugin/Tabular.vim"))
	vnoremap ;t :Tabularize /
endif

" ================================================================="
" ================================================================="
" ============== Begin additions for Templates plugin ============="

" see :h template.txt
" let g:templates_user_variables = [
" 	\   ['FULLPATH', 'GetFullPath'],
" 	\ ]
"
" function! GetFullPath() abort
" 	return expand('%:p')
" endfunction

" ================================================================="
" ================================================================="
" ============== Begin additions for Ctrl-P plugin ================"

" if !empty(glob("~/.vim/bundle/______"))
	let g:ctrlp_map = '<c-\>'
	let g:ctrlp_cmd = 'CtrlP'
" endif

" ================================================================="
" ================================================================="
" ============== Begin additions for pymode plugin ================"

" if !empty(glob("~/.vim/bundle/_____"))
	let g:pymode_warnings = 0
	let g:pymode_options_colorcolumn = 0
	let g:pymode_indent = 0
	let g:pymode_lint_on_fly = 0
	let g:pymode_syntax_indent_errors = 0
	let g:pymode_syntax_space_errors = 0
	let g:pymode_lint_checkers = ['pyflakes']
" endif

" ================================================================="
" ================================================================="
" ============== Begin additions for tagbar plugin ================"

" if !empty(glob("~/.vim/bundle/_____"))
	nnoremap ;n :TagbarToggle<CR>
	let g:tagbar_show_linenumbers = 2
	let g:tagbar_sort = 0
" endif

" ================================================================="
" ================================================================="
" ============ Begin additions for exchange plugin ================"

" X in visual mode triggers the exchange plugin
" Uncomment this to have cxx trigger it instead
" vmap cxx <Plug>(Exchange)

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
set smarttab
set smartindent
set textwidth=100

" use spaces instead of tabs
set expandtab

" indicate which vim mode you're currently in (INSERT, VISUAL, etc)
set showmode

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

" set relative numbering (except the current line, i.e. use normal numbering)
set rnu
set nu

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
" if !exists('g:os')
"     if has('win32') || has('win16')
"         let g:os = 'Windows'
"     else
"         let g:os = substitute(system('uname'), '\n', '', '')
"     endif
" endif

" a godsend that disables that stupidly annoying beep/bell once and for all
" if g:os =~ 'CYGWIN'
" 	set belloff=all
" endif

" prevent ubuntu from outputting garbage characters
" if g:os =~ 'Linux'
	set t_RV=
" endif

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
function! s:load_my_statusline() abort
	set statusline=                        " start with an empty status line
	set statusline+=[%{fugitive#head()}]\  " show current git branch
	set statusline+=%t\                    " show file name (f = relative file name, F = absolute path to file name)
" 	set statusline+=[%n]\                  " show buffer number
	set statusline+=%m\                    " show modified flag
	set statusline+=%r\                    " show read-only flag
endfunction

" only load the status line upon entering vim
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

" make jumping to previous/next location center the screen
nnoremap <C-o> <C-o>zz
nnoremap <C-i> <C-i>zz

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

" mappings for automatically jumping to the next/previous error
" :cnext and :cprevious are for the quickfix list (e.g. for :make)
" :lnext and :lprevious are for the location list (e.g. for YCM)
function! s:my_jump_to_next_error() abort
	if exists('g:ycm_show_diagnostics_ui')  &&  g:ycm_show_diagnostics_ui == 1
		nnoremap <C-n> :lne<CR>
		nnoremap <C-p> :lp<CR>
	else
		nnoremap <C-n> :cn<CR>
		nnoremap <C-p> :cp<CR>
	endif
endfunction
augroup my_error_jump
	autocmd!
	autocmd VimEnter * call s:my_jump_to_next_error()
augroup END

" mappings for easily deleting the surrounding brackets/parentheses
" TODO: I think the vim plugin creator kana has a plugin that fixes this
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
" if g:os =~ 'CYGWIN'
" 	inoremap {<CR>  {<CR>}<Esc><Esc>O
" elseif g:os =~ 'Linux'
	inoremap {<CR>  {<CR>}<ESC>O
" endif

" DUMBEST HACK EVER (but I'm so happy it works)
" normally pressing CTRL-c undoes your auto-indent on a blank line
" solutions to this is to make a new line that is auto-indented for you
" 	and then type some random character, delete it, then press CTRL-c
" so, that's exactly what this hack does
inoremap <C-c> l<BS><ESC>

" remap the paste function in insert mode to Control-p
if $ENV_TYPE == 'wsl'
	inoremap <C-p> <C-R>0
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
vnoremap p "_dP

" to avoid triggering that stupidly annoying `man` lookup that is utterly and completely useless
vnoremap K <NOP>

" visually select up to (instead of including) the next white line
vnoremap } }k
vnoremap { {j

" ================================================================="
" ================================================================="
" ========= Begin some 'function/command' things =================="

"=================================================================="

" toggle commented lines for #-style comments
vnoremap <silent> ;# :call commenting#ToggleComment_Py()<CR>
nnoremap <silent> ;# :call commenting#ToggleComment_Py()<CR>

" toggle commented lines for "-style comments
vnoremap <silent> ;" :call commenting#ToggleComment_Vimrc()<CR>
nnoremap <silent> ;" :call commenting#ToggleComment_Vimrc()<CR>

"=================================================================="

" reformat multiline if-statements into single line if-statements
command! -range Reformat :call formatting#Reformat(<line1>, <line2>)

" unformat single line if-statements into multiline if-statements
command! -range Unformat :call formatting#Unformat(<line1>, <line2>)

"=================================================================="

" convert a .c file to a .h file
command! ConvertC2H :call c#convertC2H()

"=================================================================="

" a smarter delete operation (does not copy whitespace into registers)
" NOTE: this doesn't prevent copying whitespace using 'yy' or 'Vy'
"       my assumption is that you wanted to copy the whitespace instead of deleting it
nnoremap <silent> dd :call deleting#SmartDelete_dd()<CR>

" NOTE: commented out because this affects visually selecting and deleting code folds
" vnoremap <silent> d :call Smart_Delete_Vd()<CR>

"=================================================================="

" quickly open vimrc in a horizontal split
command! EV :call editing#EditVimrc()

" quickly open bashrc in a horizontal split
command! EA :call editing#EditBashrc()

"=================================================================="

" quickly change the working directory to the file's directory
command! CdHere :call shell#CdHere()

"=================================================================="

" show syntax highlighting groups for word under cursor
command! HighlightGroup :call highlighting#HighlightGroup()

"=================================================================="

" wrapper around :only for quicker access
command! O :call buffers#QuickOnly()

"=================================================================="

" toggle between number mode and relative number mode
command! NumberToggle :call convenient#NumberToggle()

" format the file according to C++/Java style
command! FormatToggle :call formatting#FormatToggle()

" ================================================================="
" ================================================================="
" ================= Begin my custom ';' commands =================="

" use ;zf to fold all functions (in C and C++ and Java)
nnoremap ;zf zE :call folding#FoldFunctions()<CR><ESC>

" use ;p to retain original indentation when pasting from another application
nnoremap ;p :set invpaste paste?<CR>

" use ;w to remove trailing whitespace
nnoremap ;w :call convenient#TrimWhitespace()<CR>

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

" use ;d to put deleted stuff in the black hole register "_
nnoremap ;d "_dd
vnoremap ;d "_d

" use ;j to jump from a function call to that function's definition
" use T  to pop from the tag stack and go to that location
" use in conjuction with ctags
nnoremap ;j <C-]>zz
nnoremap T <C-t>zz

" use ;y to copy the current text file into the clipboard
" nnoremap ;y myggvG$"*y'y

" use ;y to copy the current line, comment it out, then paste the line below
nnoremap <silent> ;y yy:call ToggleComment()<CR>p

" use ;v to paste from the clipboard
nnoremap ;v "*p

" use ;r to comment out the current line and stick a REMOVE at the end
nnoremap ;r I//<C-c>A // REMOVE<C-c>

" Fugitive plugin mappings
nnoremap ;gs  :Gstatus<CR>
nnoremap ;gbb :Git branch -v<CR>
nnoremap ;gba :Git branch -va<CR>
nnoremap ;gt  :GTabEdit<C-Space>
nnoremap ;gd  :GDiff<C-Space>

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

" activate Exchange.vim with cx<motion>

" don't forget about 'cgn'

