''
''
'' gdsl_bstree -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gdsl_bstree_bi__
#define __gdsl_bstree_bi__

#include once "gdsl_types.bi"

type gdsl_bstree_t as any ptr

extern "c"
declare function gdsl_bstree_alloc (byval NAME as zstring ptr, byval ALLOC_F as gdsl_alloc_func_t, byval FREE_F as gdsl_free_func_t, byval COMP_F as gdsl_compare_func_t) as gdsl_bstree_t
declare sub gdsl_bstree_free (byval T as gdsl_bstree_t)
declare sub gdsl_bstree_flush (byval T as gdsl_bstree_t)
declare function gdsl_bstree_get_name (byval T as gdsl_bstree_t) as zstring ptr
declare function gdsl_bstree_is_empty (byval T as gdsl_bstree_t) as integer
declare function gdsl_bstree_get_root (byval T as gdsl_bstree_t) as gdsl_element_t
declare function gdsl_bstree_get_size (byval T as gdsl_bstree_t) as ulong
declare function gdsl_bstree_get_height (byval T as gdsl_bstree_t) as ulong
declare function gdsl_bstree_set_name (byval T as gdsl_bstree_t, byval NEW_NAME as zstring ptr) as gdsl_bstree_t
declare function gdsl_bstree_insert (byval T as gdsl_bstree_t, byval VALUE as any ptr, byval RESULT as integer ptr) as gdsl_element_t
declare function gdsl_bstree_remove (byval T as gdsl_bstree_t, byval VALUE as any ptr) as gdsl_element_t
declare function gdsl_bstree_delete (byval T as gdsl_bstree_t, byval VALUE as any ptr) as gdsl_bstree_t
declare function gdsl_bstree_search (byval T as gdsl_bstree_t, byval COMP_F as gdsl_compare_func_t, byval VALUE as any ptr) as gdsl_element_t
declare function gdsl_bstree_map_prefix (byval T as gdsl_bstree_t, byval MAP_F as gdsl_map_func_t, byval USER_DATA as any ptr) as gdsl_element_t
declare function gdsl_bstree_map_infix (byval T as gdsl_bstree_t, byval MAP_F as gdsl_map_func_t, byval USER_DATA as any ptr) as gdsl_element_t
declare function gdsl_bstree_map_postfix (byval T as gdsl_bstree_t, byval MAP_F as gdsl_map_func_t, byval USER_DATA as any ptr) as gdsl_element_t
declare sub gdsl_bstree_write (byval T as gdsl_bstree_t, byval WRITE_F as gdsl_write_func_t, byval OUTPUT_FILE as FILE ptr, byval USER_DATA as any ptr)
declare sub gdsl_bstree_write_xml (byval T as gdsl_bstree_t, byval WRITE_F as gdsl_write_func_t, byval OUTPUT_FILE as FILE ptr, byval USER_DATA as any ptr)
declare sub gdsl_bstree_dump (byval T as gdsl_bstree_t, byval WRITE_F as gdsl_write_func_t, byval OUTPUT_FILE as FILE ptr, byval USER_DATA as any ptr)
end extern

#endif
