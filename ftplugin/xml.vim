
" toggle a comment for the current line using XML-style comments
function! ToggleCommentLine()
    if matchstr(getline(line(".")),'^\s*<!--.*$') == ''
           :silent! execute 'normal!' "I<!-- A -->0w"
    else
           :silent! execute 'normal!' "^dw$xxxx"
    endif
endfunction
nnoremap <silent> ;/ :call ToggleCommentLine()<CR>

" TODO: 
"   - Make this function insert a <!-- above the block of selected code
"   - Then insert a --> below the block of selected code
"   - Do this by keeping track of starting line selected and the ending line selected
" toggle comments for the selected block of code using XML-style comments
function! ToggleCommentBlock()
    if matchstr(getline(line(".")),'^\s*<!--.*$') == ''
           :silent! execute 'normal!' "I<!-- A -->0w"
    else
           :silent! execute 'normal!' "^dw$xxxx"
    endif
endfunction
vnoremap <silent> ;/ :call ToggleCommentBlock()<CR>
