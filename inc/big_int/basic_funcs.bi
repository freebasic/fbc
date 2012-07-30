''
''
'' basic_funcs -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __bigint_basic_funcs_bi__
#define __bigint_basic_funcs_bi__

#include once "big_int/big_int.bi"
#include once "big_int/service_funcs.bi"

declare sub big_int_cmp_abs cdecl alias "big_int_cmp_abs" (byval a as big_int ptr, byval b as big_int ptr, byval cmp_flag as integer ptr)
declare sub big_int_cmp cdecl alias "big_int_cmp" (byval a as big_int ptr, byval b as big_int ptr, byval cmp_flag as integer ptr)
declare sub big_int_sign cdecl alias "big_int_sign" (byval a as big_int ptr, byval sign as sign_type ptr)
declare sub big_int_is_zero cdecl alias "big_int_is_zero" (byval a as big_int ptr, byval is_zero as integer ptr)
declare function big_int_abs cdecl alias "big_int_abs" (byval a as big_int ptr, byval answer as big_int ptr) as integer
declare function big_int_neg cdecl alias "big_int_neg" (byval a as big_int ptr, byval answer as big_int ptr) as integer
declare function big_int_inc cdecl alias "big_int_inc" (byval a as big_int ptr, byval answer as big_int ptr) as integer
declare function big_int_dec cdecl alias "big_int_dec" (byval a as big_int ptr, byval answer as big_int ptr) as integer
declare function big_int_sqr cdecl alias "big_int_sqr" (byval a as big_int ptr, byval answer as big_int ptr) as integer
declare function big_int_mul cdecl alias "big_int_mul" (byval a as big_int ptr, byval b as big_int ptr, byval answer as big_int ptr) as integer
declare function big_int_div cdecl alias "big_int_div" (byval a as big_int ptr, byval b as big_int ptr, byval answer as big_int ptr) as integer
declare function big_int_mod cdecl alias "big_int_mod" (byval a as big_int ptr, byval b as big_int ptr, byval answer as big_int ptr) as integer
declare function big_int_add cdecl alias "big_int_add" (byval a as big_int ptr, byval b as big_int ptr, byval answer as big_int ptr) as integer
declare function big_int_sub cdecl alias "big_int_sub" (byval a as big_int ptr, byval b as big_int ptr, byval answer as big_int ptr) as integer
declare function big_int_muladd cdecl alias "big_int_muladd" (byval a as big_int ptr, byval b as big_int ptr, byval c as big_int ptr, byval answer as big_int ptr) as integer
declare function big_int_div_extended cdecl alias "big_int_div_extended" (byval a as big_int ptr, byval b as big_int ptr, byval q as big_int ptr, byval r as big_int ptr) as integer

#endif
