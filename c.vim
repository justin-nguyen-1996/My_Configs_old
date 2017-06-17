
" auto comment when pressing enter
" remove comment leader when joining lines that are both commented
" auto recognize numbered lists
set formatoptions=rcjn

" use ;i/w/f/d/t to put the selected lines into an if-statement
if g:os =~ 'CYGWIN'
	vnoremap ;i dOif () {<CR>}<ESC><ESC>kp>i{?(<CR>
	vnoremap ;w dOwhile () {<CR>}<ESC><ESC>kp>i{?(<CR>
	vnoremap ;f dOfor () {<CR>}<ESC><ESC>kp>i{?(<CR>
elseif g:os =~ 'Linux'
	vnoremap ;i dO<TAB>if () {<CR>}<ESC><ESC>kp>i{?(<CR>
	vnoremap ;w dO<TAB>while () {<CR>}<ESC><ESC>kp>i{?(<CR>
	vnoremap ;f dO<TAB>for () {<CR>}<ESC><ESC>kp>i{?(<CR>
endif

