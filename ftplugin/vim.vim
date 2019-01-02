
" toggle commented lines for vimrc
function! ToggleComment()
    if matchstr(getline(line(".")),'^\s*\".*$') == ''
           :silent! execute 's:^:" :'
    else
           :silent! execute 's:^\s*" ::'
    endif
endfunction
vnoremap <silent> ;/ :call ToggleComment()<CR>
nnoremap <silent> ;/ :call ToggleComment()<CR>
