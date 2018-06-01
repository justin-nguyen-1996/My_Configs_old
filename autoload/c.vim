
" convert a .c file to a .h file
function! c#convertC2H() abort
	w %:r.h
	tabe %:r.h
	execute 'g/^\S.*{$/norm $h%s;'
endfunction
