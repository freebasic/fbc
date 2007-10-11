''
''
'' _gdsl_bstree -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef ___gdsl_bstree_bi__
#define ___gdsl_bstree_bi__

#include once "_gdsl_bintree.bi"
#include once "gdsl_macros.bi"
#include once "gdsl_types.bi"

type _gdsl_bstree_t as _gdsl_bintree_t
type gdsl_bstree_map_func_t as function cdecl(byval as _gdsl_bstree_t, byval as any ptr) as integer

extern "c"
declare function _gdsl_bstree_alloc (byval E as gdsl_element_t) as _gdsl_bstree_t
declare sub _gdsl_bstree_free (byval T as _gdsl_bstree_t, byval FREE_F as gdsl_free_func_t)
declare function _gdsl_bstree_copy (byval T as _gdsl_bstree_t, byval COPY_F as gdsl_copy_func_t) as _gdsl_bstree_t
declare function _gdsl_bstree_is_empty (byval T as _gdsl_bstree_t) as integer
declare function _gdsl_bstree_is_leaf (byval T as _gdsl_bstree_t) as integer
declare function _gdsl_bstree_get_content (byval T as _gdsl_bstree_t) as gdsl_element_t
declare function _gdsl_bstree_is_root (byval T as _gdsl_bstree_t) as integer
declare function _gdsl_bstree_get_parent (byval T as _gdsl_bstree_t) as _gdsl_bstree_t
declare function _gdsl_bstree_get_left (byval T as _gdsl_bstree_t) as _gdsl_bstree_t
declare function _gdsl_bstree_get_right (byval T as _gdsl_bstree_t) as _gdsl_bstree_t
declare function _gdsl_bstree_get_size (byval T as _gdsl_bstree_t) as ulong
declare function _gdsl_bstree_get_height (byval T as _gdsl_bstree_t) as ulong
declare function _gdsl_bstree_insert (byval T as _gdsl_bstree_t ptr, byval COMP_F as gdsl_compare_func_t, byval VALUE as gdsl_element_t, byval RESULT as integer ptr) as _gdsl_bstree_t
declare function _gdsl_bstree_remove (byval T as _gdsl_bstree_t ptr, byval COMP_F as gdsl_compare_func_t, byval VALUE as gdsl_element_t) as gdsl_element_t
declare function _gdsl_bstree_search (byval T as _gdsl_bstree_t, byval COMP_F as gdsl_compare_func_t, byval VALUE as gdsl_element_t) as _gdsl_bstree_t
declare function _gdsl_bstree_search_next (byval T as _gdsl_bstree_t, byval COMP_F as gdsl_compare_func_t, byval VALUE as gdsl_element_t) as _gdsl_bstree_t
declare function _gdsl_bstree_map_prefix (byval T as _gdsl_bstree_t, byval MAP_F as gdsl_bstree_map_func_t, byval USER_DATA as any ptr) as _gdsl_bstree_t
declare function _gdsl_bstree_map_infix (byval T as _gdsl_bstree_t, byval MAP_F as gdsl_bstree_map_func_t, byval USER_DATA as any ptr) as _gdsl_bstree_t
declare function _gdsl_bstree_map_postfix (byval T as _gdsl_bstree_t, byval MAP_F as gdsl_bstree_map_func_t, byval USER_DATA as any ptr) as _gdsl_bstree_t
declare sub _gdsl_bstree_write (byval T as _gdsl_bstree_t, byval WRITE_F as gdsl_write_func_t, byval OUTPUT_FILE as FILE ptr, byval USER_DATA as any ptr)
declare sub _gdsl_bstree_write_xml (byval T as _gdsl_bstree_t, byval WRITE_F as gdsl_write_func_t, byval OUTPUT_FILE as FILE ptr, byval USER_DATA as any ptr)
declare sub _gdsl_bstree_dump (byval T as _gdsl_bstree_t, byval WRITE_F as gdsl_write_func_t, byval OUTPUT_FILE as FILE ptr, byval USER_DATA as any ptr)
end extern

#endif
