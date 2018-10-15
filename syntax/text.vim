
" custom highlight groups for specific keywords

hi WhiteOnGreen term=standout,bold ctermfg=White ctermbg=DarkGreen
let m = matchadd("WhiteOnGreen", "NOTE")

hi BlackOnYellow term=standout,bold ctermfg=Black ctermbg=Yellow
let m = matchadd("BlackOnYellow", "TODO")
