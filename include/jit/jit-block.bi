''
''
'' jit-block -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __jit_block_bi__
#define __jit_block_bi__

#include "jit/jit-common.bi"

declare function jit_block_get_function     cdecl alias "jit_apply"                 (byval block as jit_block_t) as jit_function_t
declare function jit_block_get_context      cdecl alias "jit_block_get_context"     (byval block as jit_block_t) as jit_context_t
declare function jit_block_get_label        cdecl alias "jit_block_get_label"       (byval block as jit_block_t) as jit_label_t
declare function jit_block_next             cdecl alias "jit_block_next"            (byval func as jit_function_t, byval previous as jit_block_t) as jit_block_t
declare function jit_block_previous         cdecl alias "jit_block_previous"        (byval func as jit_function_t, byval previous as jit_block_t) as jit_block_t
declare function jit_block_from_label       cdecl alias "jit_block_from_label"      (byval func as jit_function_t, byval label as jit_label_t) as jit_block_t
declare function jit_block_set_meta         cdecl alias "jit_block_set_meta"        (byval block as jit_block_t, byval _type as integer, byval data as any ptr, byval free_data as jit_meta_free_func) as integer
declare function jit_block_get_meta         cdecl alias "jit_block_get_meta"        (byval block as jit_block_t, byval _type as integer) as any ptr
declare sub      jit_block_free_meta        cdecl alias "jit_block_free_meta"       (byval block as jit_block_t, byval _type as integer)
declare function jit_block_is_reachable     cdecl alias "jit_block_is_reachable"    (byval block as jit_block_t) as integer
declare function jit_block_ends_in_dead     cdecl alias "jit_block_ends_in_dead"    (byval block as jit_block_t) as integer
declare function jit_block_current_is_dead  cdecl alias "jit_block_current_is_dead" (byval func as jit_function_t) as integer

#endif
