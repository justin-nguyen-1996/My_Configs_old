
" reformat multiline if-statements into single line if-statements
function! formatting#Reformat(line1, line2) abort

	" Remember line locs and numbers (bookkeeping)
	execute 'normal!' 'me'
	let l:before = line('$')

	" Join the selected lines && put a newline before every 'else'
	execute 'normal!' . (a:line2 - a:line1 + 1) . 'J'
	execute 's/else/\relse/g'

	" Recalculate the range && run Tabular
	let l:line2 = a:line2 - (l:before - line('$'))
	execute 'normal!' "V'e="
	execute 'normal!' 'f(i     '
	execute a:line1 . ',' . l:line2 . 'Tabularize /{/'
	execute a:line1 . ',' . l:line2 . 'Tabularize /}/'
endfunction

" unformat single line if-statements into multiline if-statements
function! formatting#Unformat(line1, line2) abort

	" mark line one  &&  keep track of lines selected
	execute 'normal!' 'me'
	let l:numDiff = a:line2 - a:line1 + 1

	" delete extraneous white space
	execute 'normal!' 'f dt(i '
	let c = 0
	while c < numDiff - 1
		execute 'normal!' 'f)f dt{i '
		execute 'normal!' 'j0w'
		let c += 1
	endwhile
	execute 'normal!' 'f dt{i '

	" Formatting to make the statements span multiple lines
	execute 'normal!' "'e"
	execute 'normal!' . (a:line2 - a:line1 + 1) . 'J'
	execute 's/{ /{\r/g'
	execute 'normal!' "'e"
	let c = 0
	while c < l:numDiff
		execute 'normal!' 'j'
		execute 's/}/\r}/g'
		let c += 1
	endwhile
	execute 'normal!' "V'e="
endfunction

" format the file according to C++/Java style
" NOTE: Run this on the terminal to format all the files in the vim arglist: 
"       vim * -c ':argdo FormatAll' -c ':wa' -c ':qa'
function! formatting#FormatAll() abort
  execute 'normal!' "gg=G''"
endfunction
