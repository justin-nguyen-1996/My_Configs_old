
" auto comment when pressing enter
" remove comment leader when joining lines that are both commented
" auto recognize numbered lists
set formatoptions=rcjn

" easily insert if/while/for statements by selecting the text
vnoremap ;i dOif () {<CR>}<ESC><ESC>kp>i{?(<CR>
vnoremap ;w dOwhile () {<CR>}<ESC><ESC>kp>i{?(<CR>
vnoremap ;f dOfor () {<CR>}<ESC><ESC>kp>i{?(<CR>

" toggle commented lines for C-style comments
function! ToggleComment()
    if matchstr(getline(line(".")),'^\s*\/\/.*$') == ''
        execute 'normal!' 'I// '
    else
        execute 'normal!' '^xxx'
    endif
endfunction
vnoremap <silent> ;/ :call ToggleComment()<CR>
nnoremap <silent> ;/ :call ToggleComment()<CR>

