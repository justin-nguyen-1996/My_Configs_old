
" quickly open vimrc in a horizontal split
function! editing#EditVimrc() abort
	execute ':split ~/.vimrc'
endfunction

" quickly open bashrc in a horizontal split
function! editing#EditBashrc() abort
	execute ':split ~/.bashrc'
endfunction
