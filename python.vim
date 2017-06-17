
" use ;i/w/f/d/t to put the selected lines into an if-statement
if $ENV_TYPE == "cygwin"
	vnoremap ;i >Oif :<ESC><ESC>
	vnoremap ;w >Owhile :<ESC><ESC>
	vnoremap ;f >Ofor :<ESC><ESC>
elseif $ENV_TYPE == "ubuntu"
	vnoremap ;i >Oif :<ESC><ESC>
	vnoremap ;w >Owhile :<ESC><ESC>
	vnoremap ;f >Ofor :<ESC><ESC>
endif

