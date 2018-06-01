
" shortcut command for quickly opening the preview window in vim
function! ycm#OpenPreview() abort
	execute ':YcmDiags'
endfunction

" shortcut command for quickly closing the preview window in vim
function! ycm#ClosePreview() abort
	execute ':lclose'
	execute ':pclose'
endfunction

" shortcut command for quickly getting the type of a function/variable under the cursor
" NOTE: not named TYPE because of command ordering
function! ycm#GetType() abort
	execute ':YcmCompleter GetType'
endfunction

" shortcut command for quickly getting the documentation of a function/variable under the cursor
function! ycm#GetDoc() abort
	execute ':YcmCompleter GetDoc'
	execute 'normal!' 'j'
endfunction
