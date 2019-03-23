
" toggle between having line numbers and no line numbers
function! convenient#NumberToggle() abort
  if(&relativenumber == 1)
	set nornu
	set nonu
  else
	set rnu
	set nu
  endif
endfunction

" remove trailing whitespace
function! convenient#TrimWhitespace() abort
	let l:save_cursor = getpos('.')
	%s/\s\+$//e
	call setpos('.', l:save_cursor)
endfunction

" run ctags while still in vim
function! convenient#Ctags() abort
    execute '!ctags -R -f .tags .'
    execute 'redraw!'
endfunction
