''
''
'' service_funcs -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __bigint_service_funcs_bi__
#define __bigint_service_funcs_bi__

#include once "big_int/big_int.bi"
#include once "big_int/str_funcs.bi"

declare function big_int_version      cdecl alias "big_int_version"      () as const zstring ptr
declare function big_int_build_date   cdecl alias "big_int_build_date"   () as const zstring ptr

declare function big_int_create       cdecl alias "big_int_create"       (byval len as size_t) as big_int ptr
declare function big_int_dup          cdecl alias "big_int_dup"          (byval a as big_int ptr) as big_int ptr
declare sub      big_int_destroy      cdecl alias "big_int_destroy"      (byval a as big_int ptr)
declare sub      big_int_clear_zeros  cdecl alias "big_int_clear_zeros"  (byval a as big_int ptr)
declare function big_int_copy         cdecl alias "big_int_copy"         (byval src as big_int ptr, byval dst as big_int ptr) as integer
declare function big_int_realloc      cdecl alias "big_int_realloc"      (byval a as big_int ptr, byval len as size_t) as integer
declare function big_int_from_str     cdecl alias "big_int_from_str"     (byval s as big_int_str ptr, byval base as uinteger, byval answer as big_int ptr) as integer
declare function big_int_to_str       cdecl alias "big_int_to_str"       (byval a as big_int ptr, byval base as uinteger, byval s as big_int_str ptr) as integer
declare function big_int_from_int     cdecl alias "big_int_from_int"     (byval value as integer, byval a as big_int ptr) as integer
declare function big_int_to_int       cdecl alias "big_int_to_int"       (byval a as big_int ptr, byval value as integer ptr) as integer
declare function big_int_base_convert cdecl alias "big_int_base_convert" (byval src as big_int_str ptr, byval dst as big_int_str ptr, byval base_from as uinteger, byval base_to as uinteger) as integer
declare function big_int_serialize    cdecl alias "big_int_serialize"    (byval a as big_int ptr, byval is_sign as integer, byval s as big_int_str ptr) as integer
declare function big_int_unserialize  cdecl alias "big_int_unserialize"  (byval s as big_int_str ptr, byval is_sign as integer, byval a as big_int ptr) as integer

#endif
