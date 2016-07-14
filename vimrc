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

set showcmd			" Show (partial) command in status line.
" set showmatch		" Show matching brackets. 
					" (DISABLED) bc too hard to find cursor
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
" set incsearch		" Incremental search
					" (DISABLED) personal choice, your decision
set autowrite		" Automatically save before commands like :next and :make
set hidden			" Hide buffers when they are abandoned
" set mouse=a		" Enable mouse usage (all modes)
					" (DISABLED) originally forced using mouse into Visual mode
set tabstop=4
set shiftwidth=4
set autoindent

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
" enable code folding (minimize chunks of code into one-liners)
set foldmethod=indent
" have folds open by default
set nofoldenable
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

" press CTRL-j/CTRL-k to go down/up half a page, respectively
nnoremap <C-j> <C-D>
nnoremap <C-k> <C-U>

" auto set relative number mode
nnoremap <C-n> :call NumberToggle()<cr>
set rnu

" auto comments for /* (javadoc style comments) 
set comments=sl:/*,mb:\ *,elx:\ */
" auto comment when pressing enter, o, or O
set formatoptions+=rco

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

