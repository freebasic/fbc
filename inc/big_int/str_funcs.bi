''
''
'' str_funcs -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __bigint_str_funcs_bi__
#define __bigint_str_funcs_bi__

#include once "big_int/big_int.bi"
#include once "big_int/str_types.bi"

declare function big_int_str_create cdecl alias "big_int_str_create" (byval len as integer) as big_int_str ptr
declare function big_int_str_dup cdecl alias "big_int_str_dup" (byval s as big_int_str ptr) as big_int_str ptr
declare sub big_int_str_destroy cdecl alias "big_int_str_destroy" (byval s as big_int_str ptr)
declare function big_int_str_copy cdecl alias "big_int_str_copy" (byval dst as big_int_str ptr, byval src as big_int_str ptr) as integer
declare function big_int_str_copy_s cdecl alias "big_int_str_copy_s" (byval str as zstring ptr, byval str_len as integer, byval dst as big_int_str ptr) as integer
declare function big_int_str_realloc cdecl alias "big_int_str_realloc" (byval s as big_int_str ptr, byval len as integer) as integer

#endif
