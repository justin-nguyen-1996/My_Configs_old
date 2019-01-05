
" toggle commented lines for bash-style comments
function! ToggleComment()
    if matchstr(getline(line(".")),'^\s*\#.*$') == ''
        execute 'normal!' 'I# '
    else
        execute 'normal!' '^xx'
    endif
endfunction
vnoremap <silent> ;/ :call ToggleComment()<CR>
nnoremap <silent> ;/ :call ToggleComment()<CR>
