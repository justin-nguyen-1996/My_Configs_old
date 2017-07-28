
" auto comment when pressing enter
" remove comment leader when joining lines that are both commented
" auto recognize numbered lists
set formatoptions=rcjn

" easily insert if/while/for statements by selecting the text
vnoremap ;i >O<BS>if :<ESC><ESC>i
vnoremap ;w >O<BS>while :<ESC><ESC>i
vnoremap ;f >O<BS>for :<ESC><ESC>i

" toggle commented lines for Python-style comments
function! ToggleComment()
	if matchstr(getline(line(".")),'^\s*\#.*$') == ''
		   :execute "s:^:# :"
	else
		   :execute "s:^\s*# ::"
	endif
endfunction
vnoremap ;/ :call ToggleComment()<CR>
nnoremap ;/ :call ToggleComment()<CR>

" easily wrap the selected text in a time.time() statement for quick timing
fun! s:PythonTiming(line1, line2)

	" mark line one  &&  keep track of lines selected
	execute 'normal!' 'me'
	let l:numDiff = a:line2 - a:line1

	" start timing
	execute 'normal!' 'Ostart = time.time()'

	" end timing
	while line('.') < a:line2 + 1
		execute 'normal!' 'j'
	endwhile
	execute 'normal!' 'oend = time.time()'
	execute 'normal!' 'oprint; print("end - start: "); print(end - start)'

endfun
command! -range Time :call s:PythonTiming(<line1>, <line2>)

