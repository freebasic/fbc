''
''
'' jit-dynamic -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __jit_dynamic_bi__
#define __jit_dynamic_bi__

#include "jit/jit-common.bi"

type jit_dynlib_handle_t as any ptr

declare function jit_dynlib_open cdecl alias "jit_dynlib_open" (byval name as zstring ptr) as jit_dynlib_handle_t
declare sub jit_dynlib_close cdecl alias "jit_dynlib_close" (byval handle as jit_dynlib_handle_t)
declare function jit_dynlib_get_symbol cdecl alias "jit_dynlib_get_symbol" (byval handle as jit_dynlib_handle_t, byval symbol as zstring ptr) as any ptr
declare function jit_dynlib_get_suffix cdecl alias "jit_dynlib_get_suffix" () as zstring ptr
declare sub jit_dynlib_set_debug cdecl alias "jit_dynlib_set_debug" (byval flag as integer)

#define JIT_MANGLE_PUBLIC &h0001
#define JIT_MANGLE_PROTECTED &h0002
#define JIT_MANGLE_PRIVATE &h0003
#define JIT_MANGLE_STATIC &h0008
#define JIT_MANGLE_VIRTUAL &h0010
#define JIT_MANGLE_CONST &h0020
#define JIT_MANGLE_EXPLICIT_THIS &h0040
#define JIT_MANGLE_IS_CTOR &h0080
#define JIT_MANGLE_IS_DTOR &h0100
#define JIT_MANGLE_BASE &h0200

declare function jit_mangle_global_function cdecl alias "jit_mangle_global_function" (byval name as zstring ptr, byval signature as jit_type_t, byval form as integer) as zstring ptr
declare function jit_mangle_member_function cdecl alias "jit_mangle_member_function" (byval class_name as zstring ptr, byval name as zstring ptr, byval signature as jit_type_t, byval form as integer, byval flags as integer) as zstring ptr

#endif
