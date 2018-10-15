
" quickly change the working directory to the file's directory
function! shell#CdHere() abort
	execute ':cd %:h'
endfunction
