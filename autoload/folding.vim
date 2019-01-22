
" use ;zf to fold all functions (in C and C++ and Java)
function! folding#FoldFunctions() abort

	" fold functions of type (bool, boolean, int, double, void)
	:silent! execute "%g/^bool/normal vf{%zf"
	:silent! execute "%g/^boolean/normal vf{%zf"
	:silent! execute "%g/^char/normal vf{%zf"
	:silent! execute "%g/^int/normal vf{%zf"
	:silent! execute "%g/^double/normal vf{%zf"
	:silent! execute "%g/^void/normal vf{%zf"

	" fold same types of functions but they're static equivalents
	:silent! execute "%g/^static bool/normal vf{%zf"
	:silent! execute "%g/^static boolean/normal vf{%zf"
	:silent! execute "%g/^static char/normal vf{%zf"
	:silent! execute "%g/^static int/normal vf{%zf"
	:silent! execute "%g/^static double/normal vf{%zf"
	:silent! execute "%g/^static void/normal vf{%zf"

	" fold functions of type (uint_t)
	:silent! execute "%g/^uint/normal vf{%zf"
	:silent! execute "%g/^static uint/normal vf{%zf"

	" fold same types of functions but they're pointer equivalents
	:silent! execute "%g/^bool*/normal vf{%zf"
	:silent! execute "%g/^boolean*/normal vf{%zf"
	:silent! execute "%g/^char*/normal vf{%zf"
	:silent! execute "%g/^int*/normal vf{%zf"
	:silent! execute "%g/^double*/normal vf{%zf"
	:silent! execute "%g/^void*/normal vf{%zf"
	:silent! execute "%g/^unsigned*/normal vf{%zf"
	:silent! execute "%g/^long*/normal vf{%zf"

	" fold same types of functions but also they're tabbed equivalents
	:silent! execute "%g/\tbool/normal vf{%zf"
	:silent! execute "%g/\tboolean/normal vf{%zf"
	:silent! execute "%g/\tint/normal vf{%zf"
	:silent! execute "%g/\tdouble/normal vf{%zf"
	:silent! execute "%g/\tvoid/normal vf{%zf"

	" fold anything that starts with a tab and then public/private
	:silent! execute "%g/\tpublic/normal vf{%zf"
	:silent! execute "%g/\tprivate/normal vf{%zf"

	" fold anything that starts with 'typedef' (e.g. structs and enums)
	:silent! execute "%g/^typedef/normal vf{%zf"
	:silent! execute "%g/^struct/normal vf{%zf"
	:silent! execute "%g/^static struct/normal vf{%zf"

	" fold other types
	:silent! execute "%g/^tid_t/normal vf{%zf"

endfunction
