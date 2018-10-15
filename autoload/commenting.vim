
" toggle commented lines for #-style comments
function! commenting#ToggleComment_Py() abort
	if matchstr(getline(line(".")),'^\s*\#.*$') == ''
		   :execute "s:^:# :"
	else
		   :execute "s:^\s*# ::"
	endif
endfunction

" toggle commented lines for "-style comments
function! commenting#ToggleComment_Vimrc() abort
	if matchstr(getline(line(".")),'^\s*\".*$') == ''
		   :execute 's:^:" :'
	else
		   :execute 's:^\s*" ::'
	endif
endfunction
