
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

