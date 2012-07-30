''
''
'' jit-context -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __jit_context_bi__
#define __jit_context_bi__

#include "jit/jit-common.bi"

declare function jit_context_create cdecl alias "jit_context_create" () as jit_context_t
declare sub      jit_context_destroy cdecl alias "jit_context_destroy" (byval context as jit_context_t) 
declare function jit_context_supports_threads cdecl alias "jit_context_supports_threads" (byval context as jit_context_t) as integer
declare sub      jit_context_build_start cdecl alias "jit_context_build_start" (byval context as jit_context_t)
declare sub      jit_context_build_end cdecl alias "jit_context_build_end" (byval context as jit_context_t)
declare sub      jit_context_set_on_demand_driver cdecl alias "jit_context_set_on_demand_driver" (byval context as jit_context_t, byval driver as jit_on_demand_driver_func)
declare function jit_context_set_meta cdecl alias "jit_context_set_meta" (byval context as jit_context_t, byval _type as integer, byval data as any ptr, byval free_data as jit_meta_free_func) as integer
declare function jit_context_set_meta_numeric cdecl alias "jit_context_set_meta_numeric" (byval context as jit_context_t, byval _type as integer, byval data as jit_nuint) as integer
declare function jit_context_get_meta cdecl alias "jit_context_get_meta" (byval context as jit_context_t, byval _type as integer) as any ptr
declare function jit_context_get_meta_numeric cdecl alias "jit_context_get_meta_numeric" (byval context as jit_context_t, byval _type as integer) as jit_nuint
declare sub      jit_context_free_meta cdecl alias "jit_context_free_meta" (byval context as jit_context_t, byval _type as integer)

#define JIT_OPTION_CACHE_LIMIT 10000
#define JIT_OPTION_CACHE_PAGE_SIZE 10001
#define JIT_OPTION_PRE_COMPILE 10002
#define JIT_OPTION_DONT_FOLD 10003
#define JIT_OPTION_POSITION_INDEPENDENT 10004

#endif
