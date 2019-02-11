
" toggle commented lines for #-style comments
function! commenting#ToggleComment_Py()
    if matchstr(getline(line(".")),'^\s*\#.*$') == ''
        execute 'normal!' 'I# '
    else
        execute 'normal!' '^xx'
    endif
endfunction

" toggle commented lines for "-style comments
function! commenting#ToggleComment_Vimrc()
    if matchstr(getline(line(".")),'^\s*\".*$') == ''
        execute 'normal!' 'I" '
    else
        execute 'normal!' '^xx'
    endif
endfunction
