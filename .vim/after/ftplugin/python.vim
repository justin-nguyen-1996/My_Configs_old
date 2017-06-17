
" auto comment when pressing enter
" remove comment leader when joining lines that are both commented
" auto recognize numbered lists
set formatoptions=rcjn

" easily insert if/while/for statements by selecting the text
vnoremap ;i >Oif :<ESC><ESC>
vnoremap ;w >Owhile :<ESC><ESC>
vnoremap ;f >Ofor :<ESC><ESC>

