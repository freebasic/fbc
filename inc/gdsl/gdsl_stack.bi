''
''
'' gdsl_stack -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gdsl_stack_bi__
#define __gdsl_stack_bi__

#include once "gdsl_types.bi"

type gdsl_stack_t as any ptr

extern "c"
declare function gdsl_stack_alloc (byval NAME as zstring ptr, byval ALLOC_F as gdsl_alloc_func_t, byval FREE_F as gdsl_free_func_t) as gdsl_stack_t
declare sub gdsl_stack_free (byval S as gdsl_stack_t)
declare sub gdsl_stack_flush (byval S as gdsl_stack_t)
declare function gdsl_stack_get_name (byval S as gdsl_stack_t) as zstring ptr
declare function gdsl_stack_get_size (byval S as gdsl_stack_t) as ulong
declare function gdsl_stack_get_growing_factor (byval S as gdsl_stack_t) as ubyte
declare function gdsl_stack_is_empty (byval S as gdsl_stack_t) as integer
declare function gdsl_stack_get_top (byval S as gdsl_stack_t) as gdsl_element_t
declare function gdsl_stack_get_bottom (byval S as gdsl_stack_t) as gdsl_element_t
declare function gdsl_stack_set_name (byval S as gdsl_stack_t, byval NEW_NAME as zstring ptr) as gdsl_stack_t
declare sub gdsl_stack_set_growing_factor (byval S as gdsl_stack_t, byval G as ubyte)
declare function gdsl_stack_insert (byval S as gdsl_stack_t, byval VALUE as any ptr) as gdsl_element_t
declare function gdsl_stack_remove (byval S as gdsl_stack_t) as gdsl_element_t
declare function gdsl_stack_search (byval S as gdsl_stack_t, byval COMP_F as gdsl_compare_func_t, byval VALUE as any ptr) as gdsl_element_t
declare function gdsl_stack_search_by_position (byval S as gdsl_stack_t, byval POS as ulong) as gdsl_element_t
declare function gdsl_stack_map_forward (byval S as gdsl_stack_t, byval MAP_F as gdsl_map_func_t, byval USER_DATA as any ptr) as gdsl_element_t
declare function gdsl_stack_map_backward (byval S as gdsl_stack_t, byval MAP_F as gdsl_map_func_t, byval USER_DATA as any ptr) as gdsl_element_t
declare sub gdsl_stack_write (byval S as gdsl_stack_t, byval WRITE_F as gdsl_write_func_t, byval OUTPUT_FILE as FILE ptr, byval USER_DATA as any ptr)
declare sub gdsl_stack_write_xml (byval S as gdsl_stack_t, byval WRITE_F as gdsl_write_func_t, byval OUTPUT_FILE as FILE ptr, byval USER_DATA as any ptr)
declare sub gdsl_stack_dump (byval S as gdsl_stack_t, byval WRITE_F as gdsl_write_func_t, byval OUTPUT_FILE as FILE ptr, byval USER_DATA as any ptr)
end extern

#endif
