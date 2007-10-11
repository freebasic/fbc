''
''
'' number_theory -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __bigint_number_theory_bi__
#define __bigint_number_theory_bi__

#include once "big_int/big_int.bi"
#include once "big_int/modular_arithmetic.bi"

declare function big_int_gcd cdecl alias "big_int_gcd" (byval a as big_int ptr, byval b as big_int ptr, byval answer as big_int ptr) as integer
declare function big_int_gcd_extended cdecl alias "big_int_gcd_extended" (byval a as big_int ptr, byval b as big_int ptr, byval gcd as big_int ptr, byval x as big_int ptr, byval y as big_int ptr) as integer
declare function big_int_pow cdecl alias "big_int_pow" (byval a as big_int ptr, byval power as integer, byval answer as big_int ptr) as integer
declare function big_int_sqrt cdecl alias "big_int_sqrt" (byval a as big_int ptr, byval answer as big_int ptr) as integer
declare function big_int_sqrt_rem cdecl alias "big_int_sqrt_rem" (byval a as big_int ptr, byval answer as big_int ptr) as integer
declare function big_int_fact cdecl alias "big_int_fact" (byval n as integer, byval answer as big_int ptr) as integer
declare function big_int_miller_test cdecl alias "big_int_miller_test" (byval a as big_int ptr, byval base as big_int ptr, byval is_prime as integer ptr) as integer
declare function big_int_is_prime cdecl alias "big_int_is_prime" (byval a as big_int ptr, byval primes_to as uinteger, byval level as integer, byval is_prime as integer ptr) as integer
declare function big_int_next_prime cdecl alias "big_int_next_prime" (byval a as big_int ptr, byval answer as big_int ptr) as integer
declare function big_int_jacobi cdecl alias "big_int_jacobi" (byval a as big_int ptr, byval b as big_int ptr, byval jacobi as integer ptr) as integer

#endif
