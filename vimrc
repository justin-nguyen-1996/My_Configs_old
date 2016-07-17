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
"set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
"if has("autocmd")
"  filetype plugin indent on
"endif





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

set tabstop=4 		" tab length is 4 spaces
set shiftwidth=4	" indentation length is 4 spaces
set autoindent		" auto indent

" type 'Sys' then press TAB to easily output 'System.out.println('
inoremap Sys<TAB> System.out.println(

" typing gg still retains its functionality of jumping to a line
" but now it also centers the screen on that line
nnoremap gg ggzz

" map the jump-to-mark command 'm so that the 
" command centers the screen upon jumping
nnoremap 'm 'mzz

" retain original indentation when pasting from another application
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

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

""""" this doesn't work well with the javadoc style comments
" pressing CTRL-c no longer undoes the auto-indent
" set indentexpr=GetIndent()
" function GetIndent()
" 	let lnum = prevnonblank(v:lnum - 1)
" 	let ind = indent(lnum)
" 	return ind
" endfunction

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
nnoremap <C-n> :call NumberToggle()<cr>
set rnu

" press CTRL-j/CTRL-k to go down/up half a page, respectively
noremap <C-j> <C-D>
noremap <C-k> <C-U>

" auto comments for /* (javadoc style comments) 
set comments=sl:/*,mb:\ *,elx:\ */

" auto comment when pressing enter, o, or O
set formatoptions+=rco

" capital K now undoes a capital J
nnoremap K i<CR><TAB><ESC>f}i<CR><BS><ESC>

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

