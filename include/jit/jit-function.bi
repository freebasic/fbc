''
''
'' jit-function -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __jit_function_bi__
#define __jit_function_bi__

#include "jit/jit-common.bi"

declare function jit_function_create cdecl alias "jit_function_create" (byval context as jit_context_t, byval signature as jit_type_t) as jit_function_t
declare function jit_function_create_nested cdecl alias "jit_function_create_nested" (byval context as jit_context_t, byval signature as jit_type_t, byval parent as jit_function_t) as jit_function_t
declare sub jit_function_abandon cdecl alias "jit_function_abandon" (byval func as jit_function_t)
declare function jit_function_get_context cdecl alias "jit_function_get_context" (byval func as jit_function_t) as jit_context_t
declare function jit_function_get_signature cdecl alias "jit_function_get_signature" (byval func as jit_function_t) as jit_type_t
declare function jit_function_set_meta cdecl alias "jit_function_set_meta" (byval func as jit_function_t, byval type as integer, byval data as any ptr, byval free_data as jit_meta_free_func, byval build_only as integer) as integer
declare function jit_function_get_meta cdecl alias "jit_function_get_meta" (byval func as jit_function_t, byval type as integer) as any ptr
declare sub jit_function_free_meta cdecl alias "jit_function_free_meta" (byval func as jit_function_t, byval type as integer)
declare function jit_function_next cdecl alias "jit_function_next" (byval context as jit_context_t, byval prev as jit_function_t) as jit_function_t
declare function jit_function_previous cdecl alias "jit_function_previous" (byval context as jit_context_t, byval prev as jit_function_t) as jit_function_t
declare function jit_function_get_entry cdecl alias "jit_function_get_entry" (byval func as jit_function_t) as jit_block_t
declare function jit_function_get_current cdecl alias "jit_function_get_current" (byval func as jit_function_t) as jit_block_t
declare function jit_function_get_nested_parent cdecl alias "jit_function_get_nested_parent" (byval func as jit_function_t) as jit_function_t
declare function jit_function_compile cdecl alias "jit_function_compile" (byval func as jit_function_t) as integer
declare function jit_function_recompile cdecl alias "jit_function_recompile" (byval func as jit_function_t) as integer
declare function jit_function_is_compiled cdecl alias "jit_function_is_compiled" (byval func as jit_function_t) as integer
declare sub jit_function_set_recompilable cdecl alias "jit_function_set_recompilable" (byval func as jit_function_t)
declare sub jit_function_clear_recompilable cdecl alias "jit_function_clear_recompilable" (byval func as jit_function_t)
declare function jit_function_is_recompilable cdecl alias "jit_function_is_recompilable" (byval func as jit_function_t) as integer
declare function jit_function_compile_entry cdecl alias "jit_function_compile_entry" (byval func as jit_function_t, byval entry_point as any ptr ptr) as integer
declare sub jit_function_setup_entry cdecl alias "jit_function_setup_entry" (byval func as jit_function_t, byval entry_point as any ptr)
declare function jit_function_to_closure cdecl alias "jit_function_to_closure" (byval func as jit_function_t) as any ptr
declare function jit_function_from_closure cdecl alias "jit_function_from_closure" (byval context as jit_context_t, byval closure as any ptr) as jit_function_t
declare function jit_function_from_pc cdecl alias "jit_function_from_pc" (byval context as jit_context_t, byval pc as any ptr, byval handler as any ptr ptr) as jit_function_t
declare function jit_function_to_vtable_pointer cdecl alias "jit_function_to_vtable_pointer" (byval func as jit_function_t) as any ptr
declare function jit_function_from_vtable_pointer cdecl alias "jit_function_from_vtable_pointer" (byval context as jit_context_t, byval vtable_pointer as any ptr) as jit_function_t
declare sub jit_function_set_on_demand_compiler cdecl alias "jit_function_set_on_demand_compiler" (byval func as jit_function_t, byval on_demand as jit_on_demand_func)
declare function jit_function_get_on_demand_compiler cdecl alias "jit_function_get_on_demand_compiler" (byval func as jit_function_t) as jit_on_demand_func
declare function jit_function_apply cdecl alias "jit_function_apply" (byval func as jit_function_t, byval args as any ptr ptr, byval return_area as any ptr) as integer
declare function jit_function_apply_vararg cdecl alias "jit_function_apply_vararg" (byval func as jit_function_t, byval signature as jit_type_t, byval args as any ptr ptr, byval return_area as any ptr) as integer
declare sub jit_function_set_optimization_level cdecl alias "jit_function_set_optimization_level" (byval func as jit_function_t, byval level as uinteger)
declare function jit_function_get_optimization_level cdecl alias "jit_function_get_optimization_level" (byval func as jit_function_t) as uinteger
declare function jit_function_get_max_optimization_level cdecl alias "jit_function_get_max_optimization_level" () as uinteger

#endif
