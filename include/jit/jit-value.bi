''
''
'' jit-value -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __jit_value_bi__
#define __jit_value_bi__

#include "jit/jit-common.bi"

union jit_constant_t__NESTED__un
	ptr_value as any ptr
	int_value as jit_int
	uint_value as jit_uint
	nint_value as jit_nint
	nuint_value as jit_nuint
	long_value as jit_long
	ulong_value as jit_ulong
	float32_value as jit_float32
	float64_value as jit_float64
	nfloat_value as jit_nfloat
end union

type jit_constant_t
	type as jit_type_t
	un as jit_constant_t__NESTED__un
end type

declare function jit_value_create cdecl alias "jit_value_create" (byval func as jit_function_t, byval type as jit_type_t) as jit_value_t
declare function jit_value_create_nint_constant cdecl alias "jit_value_create_nint_constant" (byval func as jit_function_t, byval type as jit_type_t, byval const_value as jit_nint) as jit_value_t
declare function jit_value_create_long_constant cdecl alias "jit_value_create_long_constant" (byval func as jit_function_t, byval type as jit_type_t, byval const_value as jit_long) as jit_value_t
declare function jit_value_create_float32_constant cdecl alias "jit_value_create_float32_constant" (byval func as jit_function_t, byval type as jit_type_t, byval const_value as jit_float32) as jit_value_t
declare function jit_value_create_float64_constant cdecl alias "jit_value_create_float64_constant" (byval func as jit_function_t, byval type as jit_type_t, byval const_value as jit_float64) as jit_value_t
declare function jit_value_create_nfloat_constant cdecl alias "jit_value_create_nfloat_constant" (byval func as jit_function_t, byval type as jit_type_t, byval const_value as jit_nfloat) as jit_value_t
declare function jit_value_create_constant cdecl alias "jit_value_create_constant" (byval func as jit_function_t, byval const_value as jit_constant_t ptr) as jit_value_t
declare function jit_value_get_param cdecl alias "jit_value_get_param" (byval func as jit_function_t, byval param as uinteger) as jit_value_t
declare function jit_value_get_struct_pointer cdecl alias "jit_value_get_struct_pointer" (byval func as jit_function_t) as jit_value_t
declare function jit_value_is_temporary cdecl alias "jit_value_is_temporary" (byval value as jit_value_t) as integer
declare function jit_value_is_local cdecl alias "jit_value_is_local" (byval value as jit_value_t) as integer
declare function jit_value_is_constant cdecl alias "jit_value_is_constant" (byval value as jit_value_t) as integer
declare function jit_value_is_parameter cdecl alias "jit_value_is_parameter" (byval value as jit_value_t) as integer
declare sub jit_value_ref cdecl alias "jit_value_ref" (byval func as jit_function_t, byval value as jit_value_t)
declare sub jit_value_set_volatile cdecl alias "jit_value_set_volatile" (byval value as jit_value_t)
declare function jit_value_is_volatile cdecl alias "jit_value_is_volatile" (byval value as jit_value_t) as integer
declare sub jit_value_set_addressable cdecl alias "jit_value_set_addressable" (byval value as jit_value_t)
declare function jit_value_is_addressable cdecl alias "jit_value_is_addressable" (byval value as jit_value_t) as integer
declare function jit_value_get_type cdecl alias "jit_value_get_type" (byval value as jit_value_t) as jit_type_t
declare function jit_value_get_function cdecl alias "jit_value_get_function" (byval value as jit_value_t) as jit_function_t
declare function jit_value_get_block cdecl alias "jit_value_get_block" (byval value as jit_value_t) as jit_block_t
declare function jit_value_get_context cdecl alias "jit_value_get_context" (byval value as jit_value_t) as jit_context_t
declare function jit_value_get_constant cdecl alias "jit_value_get_constant" (byval value as jit_value_t) as jit_constant_t
declare function jit_value_get_nint_constant cdecl alias "jit_value_get_nint_constant" (byval value as jit_value_t) as jit_nint
declare function jit_value_get_long_constant cdecl alias "jit_value_get_long_constant" (byval value as jit_value_t) as jit_long
declare function jit_value_get_float32_constant cdecl alias "jit_value_get_float32_constant" (byval value as jit_value_t) as jit_float32
declare function jit_value_get_float64_constant cdecl alias "jit_value_get_float64_constant" (byval value as jit_value_t) as jit_float64
declare function jit_value_get_nfloat_constant cdecl alias "jit_value_get_nfloat_constant" (byval value as jit_value_t) as jit_nfloat
declare function jit_value_is_true cdecl alias "jit_value_is_true" (byval value as jit_value_t) as integer
declare function jit_constant_convert cdecl alias "jit_constant_convert" (byval result as jit_constant_t ptr, byval value as jit_constant_t ptr, byval type as jit_type_t, byval overflow_check as integer) as integer

#endif
