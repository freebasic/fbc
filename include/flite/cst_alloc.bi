''
''
'' cst_alloc -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __cst_alloc_bi__
#define __cst_alloc_bi__

declare function cst_safe_alloc cdecl alias "cst_safe_alloc" (byval size as integer) as any ptr
declare function cst_safe_calloc cdecl alias "cst_safe_calloc" (byval size as integer) as any ptr
declare function cst_safe_realloc cdecl alias "cst_safe_realloc" (byval p as any ptr, byval size as integer) as any ptr

type cst_alloc_context as any ptr

declare sub cst_free cdecl alias "cst_free" (byval p as any ptr)

#endif
