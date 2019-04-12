
" use ;zf to fold all functions (in C and C++ and Java)
function! folding#FoldFunctions() abort

	" fold functions of type (bool, boolean, int, double, void)
	:silent! execute "%g/^bool/normal f{%zf"
	:silent! execute "%g/^boolean/normal f{%zf"
	:silent! execute "%g/^char/normal f{%zf"
	:silent! execute "%g/^int/normal f{%zf"
	:silent! execute "%g/^double/normal f{%zf"
	:silent! execute "%g/^void/normal f{%zf"
    :silent! execute "%g/^float/normal f{%zf"

	" fold same types of functions but they're static equivalents
	:silent! execute "%g/^static bool/normal f{%zf"
	:silent! execute "%g/^static boolean/normal f{%zf"
	:silent! execute "%g/^static char/normal f{%zf"
	:silent! execute "%g/^static int/normal f{%zf"
	:silent! execute "%g/^static double/normal f{%zf"
	:silent! execute "%g/^static void/normal f{%zf"
    :silent! execute "%g/^static float/normal f{%zf"

	" fold functions of type (uint_t)
	:silent! execute "%g/^uint/normal f{%zf"
	:silent! execute "%g/^static uint/normal f{%zf"

	" fold same types of functions but they're pointer equivalents
	:silent! execute "%g/^bool*/normal f{%zf"
	:silent! execute "%g/^boolean*/normal f{%zf"
	:silent! execute "%g/^char*/normal f{%zf"
	:silent! execute "%g/^int*/normal f{%zf"
	:silent! execute "%g/^double*/normal f{%zf"
	:silent! execute "%g/^void*/normal f{%zf"
	:silent! execute "%g/^unsigned*/normal f{%zf"
	:silent! execute "%g/^long*/normal f{%zf"

	" fold same types of functions but also they're tabbed equivalents
	:silent! execute "%g/\tbool/normal f{%zf"
	:silent! execute "%g/\tboolean/normal f{%zf"
	:silent! execute "%g/\tint/normal f{%zf"
	:silent! execute "%g/\tdouble/normal f{%zf"
	:silent! execute "%g/\tvoid/normal f{%zf"

	" fold anything that starts with a tab and then public/private
	:silent! execute "%g/\tpublic/normal f{%zf"
	:silent! execute "%g/\tprivate/normal f{%zf"

	" fold anything that starts with 'typedef' (e.g. structs and enums)
	:silent! execute "%g/^typedef/normal f{%zf"
	:silent! execute "%g/^struct/normal f{%zf"
	:silent! execute "%g/^static struct/normal f{%zf"

	" fold other types
	:silent! execute "%g/^tid_t/normal f{%zf"

endfunction
