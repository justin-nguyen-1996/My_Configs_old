" ================================================================="
" ================================================================="
" ========= Begin my additions to the Fugitive plugin ============="

" wrapper around :Gtabedit that names the buffer something more reasonable (<branch>:<file_path>)
function! s:GTabEdit(file_name)
	execute ':Gtabedit ' . a:file_name
	execute ':file ' . a:file_name
endfunction
command! -bar -bang -nargs=1 -complete=customlist,s:EditRunComplete GTabEdit :call s:GTabEdit(<f-args>)

"=================================================================="

" wrapper around :Gdiff so that the buffers are in the spots I prefer (split on the right)
function! s:GDiff(...)

	" store some variables
	let l:num_args = a:0
	let l:cur_fname = @%

	" execute the actual :Gdiff command
	if (l:num_args == 0)
		execute ':Gdiff'
	else
		execute ':Gdiff ' . a:1
	endif

	" figure out number of windows open
	let l:num_windows = winnr("$")

	" if 2-way diff (normal diff)
	if (l:num_windows == 2)
		execute 'normal!' ''
		execute 'normal!' ''
		if (l:num_args == 1)
			execute ':file ' . a:1 . ' [FUG]'
		else
			execute ':file ' . l:cur_fname . ' [FUG]'
		endif
		execute 'normal!' ''

	" if 3-way diff (diff for git merge)
	else

		" save cursor position
		let l:save_cursor = getpos(".")

		" get merge branch name
		execute ':1'
		call search('>>>>>>')
		normal $
		let g:fug_diff_branch_name = expand('<cword>')

		" change right vertical window (merge branch) name
		execute 'normal!' ''
		silent execute ':file ' . g:fug_diff_branch_name . ':' . l:cur_fname . ' [FUG]'
		execute 'normal!' ''
		
		" change left vertical window (HEAD branch) name
		execute 'normal!' ''
		silent execute ':file HEAD:' . l:cur_fname . ' [FUG]'
		execute 'normal!' ''
		
		" Restore cursor position
		call setpos('.', l:save_cursor)
	endif
	
	" go to the first conflict in the diff
	execute 'normal!' 'gg]c'

endfunction
command! -bar -bang -nargs=? -complete=customlist,s:EditComplete GDiff :call s:GDiff(<f-args>)

"=================================================================="

" easily select the diff contents of the window on the right (the merge branch)
function! s:GGL()
	let l:num_windows = winnr("$")
	if l:num_windows == 3
		execute ':diffget ' . g:fug_diff_branch_name . ' | diffupdate'
	elseif l:num_windows == 2
		execute ':diffget | diffupdate'
	endif
	execute 'normal!' ']c'
endfunction
command! GGL :call s:GGL()

"=================================================================="

" easily select the diff contents of the window on the left (the HEAD branch) (should only be used for 3-way diffs)
function! s:GGH()
	let l:num_windows = winnr("$")
	if l:num_windows == 3
		execute ':diffget HEAD | diffupdate'
	endif
	execute 'normal!' ']c'
endfunction
command! GGH :call s:GGH()

"=================================================================="

" easily select the diff contents of the other window (should only be used for 2-way diffs)
function! s:GG()
	execute ':diffget | diffupdate'
	execute 'normal!' ']c'
endfunction
command! GG :call s:GG()

