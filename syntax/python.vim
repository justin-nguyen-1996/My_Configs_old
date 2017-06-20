
" custom highlight groups for specific keywords

hi WhiteOnRed term=standout,bold ctermfg=White ctermbg=Red
let m = matchadd("WhiteOnRed", "REMOVE")
let m = matchadd("WhiteOnRed", "BROKEN")
let m = matchadd("WhiteOnRed", "BROKEN?")

hi WhiteOnGreen term=standout,bold ctermfg=White ctermbg=Green
let m = matchadd("WhiteOnGreen", "NOTE")

hi WhiteOnMagenta term=standout,bold ctermfg=White ctermbg=Magenta
let m = matchadd("WhiteOnMagenta", "TEST")
