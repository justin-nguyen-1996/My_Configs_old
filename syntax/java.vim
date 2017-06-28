
" custom highlight groups for specific keywords

hi WhiteOnRed term=standout,bold ctermfg=White ctermbg=DarkRed
let m = matchadd("WhiteOnRed", "REMOVE")
let m = matchadd("WhiteOnRed", "BROKEN")
let m = matchadd("WhiteOnRed", "BROKEN?")

hi WhiteOnGreen term=standout,bold ctermfg=White ctermbg=DarkGreen
let m = matchadd("WhiteOnGreen", "NOTE")

hi WhiteOnMagenta term=standout,bold ctermfg=White ctermbg=Magenta
let m = matchadd("WhiteOnMagenta", "TEST")

hi BlackOnYellow term=standout,bold ctermfg=Black ctermbg=Yellow
let m = matchadd("BlackOnYellow", "HERE")
