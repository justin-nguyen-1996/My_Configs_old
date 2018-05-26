
set statusline=        " start with an empty status line
set statusline+=%f\    " show file name
set statusline+=%m\    " show modified flag
set statusline+=%r     " show read-only flag
if fugitive#head() != ''
	set statusline+=[%{fugitive#head()}]    " show current git branch
endif
