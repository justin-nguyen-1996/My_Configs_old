
" a smarter delete operation (does not copy whitespace into registers)
" NOTE: this doesn't prevent copying whitespace using 'yy' or 'Vy'
"       my assumption is that you wanted to copy the whitespace instead of deleting it
function! deleting#SmartDelete_dd() abort
	let temp = getreg('"', 1)
	execute 'normal!' 'dd'
	if matchstr(@", '\_s*') == @"    " if just whitespace
		silent! call setreg('"', temp)
		silent! call setreg('*', temp)
		silent! call setreg('+', temp)
		silent! call setreg('0', temp)
	endif
endfunction

" NOTE: commented out because this affects visually selecting and deleting code folds
" function! Smart_Delete_Vd() range abort
" 	let temp = getreg('"', 1)
" 	execute 'normal!' . (a:lastline - a:firstline + 1) . 'dd'
" 	if matchstr(@", '\_s*') == @"    " if just whitespace
" 		silent! call setreg('"', temp)
" 		silent! call setreg('*', temp)
" 		silent! call setreg('+', temp)
" 		silent! call setreg('0', temp)
" 	endif
" endfunction
