
" custom highlight groups for specific keywords

hi WhiteOnGreen term=standout,bold ctermfg=White ctermbg=DarkGreen
let m = matchadd("WhiteOnGreen", "NOTE")

hi BlackOnYellow term=standout,bold ctermfg=Black ctermbg=Yellow
let m = matchadd("BlackOnYellow", "TODO")

hi Hyperlink term=standout,bold ctermfg=Yellow
syntax match Hyperlink `\v<(((https?|ftp|gopher|telnet)://|(mailto|file|news|about|ed2k|irc|sip|magnet):)[^' \t<>"]+|(www|web|w3)[a-z0-9_-]*\.[a-z0-9._-]+\.[^' \t<>"]+)[a-z0-9/]`
