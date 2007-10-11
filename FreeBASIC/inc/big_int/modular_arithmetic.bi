''
''
'' modular_arithmetic -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __bigint_modular_arithmetic_bi__
#define __bigint_modular_arithmetic_bi__

#include once "big_int/big_int.bi"

declare function big_int_addmod cdecl alias "big_int_addmod" (byval a as big_int ptr, byval b as big_int ptr, byval modulus as big_int ptr, byval answer as big_int ptr) as integer
declare function big_int_submod cdecl alias "big_int_submod" (byval a as big_int ptr, byval b as big_int ptr, byval modulus as big_int ptr, byval answer as big_int ptr) as integer
declare function big_int_mulmod cdecl alias "big_int_mulmod" (byval a as big_int ptr, byval b as big_int ptr, byval modulus as big_int ptr, byval answer as big_int ptr) as integer
declare function big_int_divmod cdecl alias "big_int_divmod" (byval a as big_int ptr, byval b as big_int ptr, byval modulus as big_int ptr, byval answer as big_int ptr) as integer
declare function big_int_powmod cdecl alias "big_int_powmod" (byval a as big_int ptr, byval b as big_int ptr, byval modulus as big_int ptr, byval answer as big_int ptr) as integer
declare function big_int_factmod cdecl alias "big_int_factmod" (byval a as big_int ptr, byval modulus as big_int ptr, byval answer as big_int ptr) as integer
declare function big_int_absmod cdecl alias "big_int_absmod" (byval a as big_int ptr, byval modulus as big_int ptr, byval answer as big_int ptr) as integer
declare function big_int_invmod cdecl alias "big_int_invmod" (byval a as big_int ptr, byval modulus as big_int ptr, byval answer as big_int ptr) as integer
declare function big_int_sqrmod cdecl alias "big_int_sqrmod" (byval a as big_int ptr, byval modulus as big_int ptr, byval answer as big_int ptr) as integer
declare function big_int_cmpmod cdecl alias "big_int_cmpmod" (byval a as big_int ptr, byval b as big_int ptr, byval modulus as big_int ptr, byval cmp_flag as integer ptr) as integer

#endif
