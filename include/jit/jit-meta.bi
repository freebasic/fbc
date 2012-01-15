''
''
'' jit-meta -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __jit_meta_bi__
#define __jit_meta_bi__

#include "jit/jit-defs.bi"

type jit_meta_t as _jit_meta ptr

declare function jit_meta_set cdecl alias "jit_meta_set" (byval list as jit_meta_t ptr, byval type as integer, byval data as any ptr, byval free_data as jit_meta_free_func, byval pool_owner as jit_function_t) as integer
declare function jit_meta_get cdecl alias "jit_meta_get" (byval list as jit_meta_t, byval type as integer) as any ptr
declare sub jit_meta_free cdecl alias "jit_meta_free" (byval list as jit_meta_t ptr, byval type as integer)
declare sub jit_meta_destroy cdecl alias "jit_meta_destroy" (byval list as jit_meta_t ptr)

#endif
