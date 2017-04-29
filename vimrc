if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
   set fileencodings=ucs-bom,utf-8,latin1
endif

set nocompatible	" Use Vim defaults (much better!)
set bs=indent,eol,start		" allow backspacing over everything in insert mode
"set ai			" always set autoindenting on
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

syntax enable
filetype plugin on

if &term=="xterm"
     set t_Co=8
     set t_Sb=[4%dm
     set t_Sf=[3%dm
endif

" ================================================================="
" ================================================================="
" ================== Begin my 'set' vimrc things =================="

" Show (partial) command in status line
set showcmd			

" Do case insensitive matching, smart case matching, don't wrap back to the top after searching
set ignorecase		
set smartcase		
set nowrapscan

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

" enable code folding, auto code fold saving, don't open code folds when doing searches
set foldmethod=manual
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview
set foldopen-=search

set viewoptions=folds,cursor

" auto comments for /* (javadoc style comments)
set comments=sl:/*,mb:\ *,elx:\ */

" auto comment when pressing enter, o, or O
set formatoptions+=rco

" lets the tags file to be in a separate directory from the source code
" basically does the following:
" 	goes up one directory at a time until it finds a file called '.tags'
set tags=.tags;/

" a godsend that disables that stupidly annoying beep/bell once and for all
set belloff=all

" searches down into subfolders
" provides tab-completion for all file-related tasks
set path+=**

" display all matching files when you tab-complete
set wildmenu

" tweaks for file browsing
let g:netrw_browse_split=4   " open in prior window
let g:netrw_altv=1           " open splits to the right
let g:netrw_liststyle=3      " tree view

" ================================================================="
" ================================================================="
" =============== Begin my 'nnoremaps' vimrc things ==============="

" make navigation easier when lines get wrapped
nnoremap j gj
nnoremap k gk

" typing '' now also centers the screen
nnoremap '' ''zz

" map the jump-to-mark command 'm so that the
" command centers the screen upon jumping
nnoremap 'm 'mzz

" press % to visually highlight in-between brace/bracket/parentheses
noremap % v%

" press CTRL-j/CTRL-k to go down/up half a page, respectively
noremap <C-j> <C-D>
noremap <C-k> <C-U>

" capital K now undoes a capital J
nnoremap K i<CR><ESC><ESC>f}i<CR><ESC><ESC>kw

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

" remap cb to delete the entire previous word
nnoremap cb cb<DEL>

" remap CTRL-n to move to the next line that has a compile error"
nnoremap <C-n> :cn<CR>

" remap CTRL-p to move to the previous line that has a compile error"
" NOTE: can also map this to CTRL-N
nnoremap <C-p> :cp<CR>

" remap ~ to U for easier uppercasing/lowercasing
nnoremap U ~

" ================================================================="
" ================================================================="
" =============== Begin my 'inoremaps' vimrc things ==============="

" type 'Sys' then press TAB to easily output 'System.out.println('
inoremap Sys<TAB> System.out.println(

" type 'main' then press TAB to easily output the main for a .java file
inoremap main<TAB> public static void main(String[] args) {<CR>}<Esc><Esc>O

" autocomplete for matching brace (activated upon pressing enter)
inoremap {<CR>  {<CR>}<Esc><Esc>O

" DUMBEST HACK EVER (but I'm so happy it works)
" normally pressing CTRL-c undoes your auto-indent on a blank line
" solutions to this is to make a new line that is auto-indented for you
" 	and then type some random character, delete it, then press CTRL-c
" so, that's exactly what this hack does
inoremap <C-c> l<BS><ESC>

" remap the paste function in insert mode to Control-p
inoremap <C-p> <C-R>"

" remap the autocomplete feature in vim to only look in the current file
inoremap <C-n> <C-x><C-n>

" remap the autocomplete feature for files to Control-m in insert mode
inoremap <C-k> <C-x><C-f>

" ================================================================="
" ================================================================="
" =============== Begin my 'vnoremaps' vimrc things ==============="

" type Sys after selecting a var to easily print the var to the console
vnoremap Sys<TAB> d<ESC>aSystem.out.println(": " + );<ESC>F(f"pf)F p

" type cout after selecting a var to easily print the var to the console
vnoremap cout<TAB> d<ESC>acout << ": " <<  << "\n";<ESC>Ftf"pf<f<f p

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

" toggle commented lines
vnoremap ;/ :call ToggleComment()<CR>
nnoremap ;/ :call ToggleComment()<CR>
function! ToggleComment()
	if matchstr(getline(line(".")),'^\s*\/\/.*$') == ''
		   :execute "s:^:// :"
	else
		   :execute "s:^\s*// ::"
	endif
endfunction


" ================================================================="
" ================================================================="
" ================= Begin my custom ';' commands =================="
"
" use ;n to toggle between number mode and relative number mode
function! NumberToggle()
  if(&relativenumber == 1)
    set nornu
  else
    set rnu
  endif
endfunc
nnoremap ;n :call NumberToggle()<cr>
set rnu

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
nnoremap ;s :source /etc/vimrc<CR>

" use ;f to format the file according to C++/Java style
nnoremap ;f :set expandtab! expandtab?<CR>gg=G''<ESC>

" use ;i/w/f/d/t to put the selected lines into an if-statement
vnoremap ;i dOif () {<CR>}<ESC><ESC>kp>i{?(<CR>
vnoremap ;w dOwhile () {<CR>}<ESC><ESC>kp>i{?(<CR>
vnoremap ;f dOfor () {<CR>}<ESC><ESC>kp>i{?(<CR>
vnoremap ;d dOdo {<CR>} while ();<ESC><ESC>kp>i{/while (<CR>f(
vnoremap ;t dOtry {<CR>} catch () {<CR><CR>}<ESC><ESC>kkkp>i{/catch ()<CR>f(

" use ;j to jump from a function call to that function's definition
" use T  to pop from the tag stack and go to that location
" use in conjuction with ctags
nnoremap ;j <C-]>zz
nnoremap T <C-t>zz

" use ;y to copy the current text file into the clipboard
nnoremap ;y myggvG$"*y'y

" use ;v to paste from the clipboard
nnoremap ;v "*p

" use ;cout
nnoremap ;cout<TAB> v0wd<ESC>acout << ": " <<  << "\n";<ESC>Ftf"pf<f<f p

" use ;Sys
nnoremap ;Sys<TAB> vbd<ESC>aSystem.out.println(": " + );<ESC>F(f"pf)F p

" use ;zf to easily fold code that lies in between the braces
nnoremap ;zf V%zf

" use ;r in visual mode to replace the visually selected word
vnoremap ;r y:%s/<C-F>pa/

" ================================================================="
" ================================================================="
" ================== Some nice things to remember ================="

" restore color scheme --> this is not actually mapped to something
" set filetype=____   (e.g. :set filetype=cpp)

" zipping files
" zip -r file_name.zip *

" macro for turning something like int x = { asdf_0, qwer_0, zxcv_0 }; into int x = { asdf_1, qwer_1, zxcv_1 };
" usage:
" 1. put a 1 above the line that you want to start copying
" 2. mark that line into the m-register using mm
" 3. copy that 1 into the w-register using "wyw
" 3. copy the following macro into the q-register: yypmnf_lvwh"wp,lvwh"wp,lvwhh"wp'm'm"wyw'n
" 4. execute the macro by using <number_here>@q on the line you want to copy
" 5. (if desired) remove the underscores by selecting the lines and doing a replace

" Don't wake up system with blinking cursor:
" http://www.linuxpowertop.org/known.php
let &guicursor = &guicursor . ",a:blinkon0"

