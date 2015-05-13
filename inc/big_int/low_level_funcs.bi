''
''
'' low_level_funcs -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __bigint_low_level_funcs_bi__
#define __bigint_low_level_funcs_bi__

#include once "big_int/big_int.bi"

declare sub low_level_add cdecl alias "low_level_add" (byval a as big_int_word ptr, byval a_end as big_int_word ptr, byval b as big_int_word ptr, byval b_end as big_int_word ptr, byval c as big_int_word ptr)
declare sub low_level_sub cdecl alias "low_level_sub" (byval a as big_int_word ptr, byval a_end as big_int_word ptr, byval b as big_int_word ptr, byval b_end as big_int_word ptr, byval c as big_int_word ptr)
declare sub low_level_mul cdecl alias "low_level_mul" (byval a as big_int_word ptr, byval a_end as big_int_word ptr, byval b as big_int_word ptr, byval b_end as big_int_word ptr, byval c as big_int_word ptr)
declare sub low_level_div cdecl alias "low_level_div" (byval a as big_int_word ptr, byval a_end as big_int_word ptr, byval b as big_int_word ptr, byval b_end as big_int_word ptr, byval c as big_int_word ptr, byval c_end as big_int_word ptr)
declare function low_level_cmp cdecl alias "low_level_cmp" (byval a as big_int_word ptr, byval b as big_int_word ptr, byval len as integer) as integer
declare sub low_level_or cdecl alias "low_level_or" (byval a as big_int_word ptr, byval a_end as big_int_word ptr, byval b as big_int_word ptr, byval b_end as big_int_word ptr, byval c as big_int_word ptr)
declare sub low_level_and cdecl alias "low_level_and" (byval a as big_int_word ptr, byval a_end as big_int_word ptr, byval b as big_int_word ptr, byval b_end as big_int_word ptr, byval c as big_int_word ptr)
declare sub low_level_andnot cdecl alias "low_level_andnot" (byval a as big_int_word ptr, byval a_end as big_int_word ptr, byval b as big_int_word ptr, byval b_end as big_int_word ptr, byval c as big_int_word ptr)
declare sub low_level_xor cdecl alias "low_level_xor" (byval a as big_int_word ptr, byval a_end as big_int_word ptr, byval b as big_int_word ptr, byval b_end as big_int_word ptr, byval c as big_int_word ptr)
declare sub low_level_sqr cdecl alias "low_level_sqr" (byval a as big_int_word ptr, byval a_end as big_int_word ptr, byval c as big_int_word ptr)

#endif
