''
''
'' jit-apply -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __jit_apply_bi__
#define __jit_apply_bi__

#include "jit/jit-type.bi"

type jit_closure_func as sub cdecl(byval as jit_type_t, byval as any ptr, byval as any ptr ptr, byval as any ptr)
type jit_closure_va_list_t as jit_closure_va_list ptr

declare sub jit_apply cdecl alias "jit_apply" (byval signature as jit_type_t, byval func as any ptr, byval args as any ptr ptr, byval num_fixed_args as uinteger, byval return_value as any ptr)
declare sub jit_apply_raw cdecl alias "jit_apply_raw" (byval signature as jit_type_t, byval func as any ptr, byval args as any ptr, byval return_value as any ptr)
declare function jit_raw_supported cdecl alias "jit_raw_supported" (byval signature as jit_type_t) as integer
declare function jit_closure_create cdecl alias "jit_closure_create" (byval context as jit_context_t, byval signature as jit_type_t, byval func as jit_closure_func, byval user_data as any ptr) as any ptr
declare function jit_closures_supported cdecl alias "jit_closures_supported" () as integer
declare function jit_closure_va_get_nint cdecl alias "jit_closure_va_get_nint" (byval va as jit_closure_va_list_t) as jit_nint
declare function jit_closure_va_get_nuint cdecl alias "jit_closure_va_get_nuint" (byval va as jit_closure_va_list_t) as jit_nuint
declare function jit_closure_va_get_long cdecl alias "jit_closure_va_get_long" (byval va as jit_closure_va_list_t) as jit_long
declare function jit_closure_va_get_ulong cdecl alias "jit_closure_va_get_ulong" (byval va as jit_closure_va_list_t) as jit_ulong
declare function jit_closure_va_get_float32 cdecl alias "jit_closure_va_get_float32" (byval va as jit_closure_va_list_t) as jit_float32
declare function jit_closure_va_get_float64 cdecl alias "jit_closure_va_get_float64" (byval va as jit_closure_va_list_t) as jit_float64
declare function jit_closure_va_get_nfloat cdecl alias "jit_closure_va_get_nfloat" (byval va as jit_closure_va_list_t) as jit_nfloat
declare function jit_closure_va_get_ptr cdecl alias "jit_closure_va_get_ptr" (byval va as jit_closure_va_list_t) as any ptr
declare sub jit_closure_va_get_struct cdecl alias "jit_closure_va_get_struct" (byval va as jit_closure_va_list_t, byval buf as any ptr, byval type as jit_type_t)

#endif
