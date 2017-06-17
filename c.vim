
" use ;i/w/f/d/t to put the selected lines into an if-statement
if $ENV_TYPE == "cygwin"
	vnoremap ;i dOif () {<CR>}<ESC><ESC>kp>i{?(<CR>
	vnoremap ;w dOwhile () {<CR>}<ESC><ESC>kp>i{?(<CR>
	vnoremap ;f dOfor () {<CR>}<ESC><ESC>kp>i{?(<CR>
elseif $ENV_TYPE == "ubuntu"
	vnoremap ;i dO<TAB>if () {<CR>}<ESC><ESC>kp>i{?(<CR>
	vnoremap ;w dO<TAB>while () {<CR>}<ESC><ESC>kp>i{?(<CR>
	vnoremap ;f dO<TAB>for () {<CR>}<ESC><ESC>kp>i{?(<CR>
endif
