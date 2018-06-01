
" show syntax highlighting groups for word under cursor
function! highlighting#HighlightGroup() abort
	if !exists("*synstack")
		return
	endif
	echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunction
