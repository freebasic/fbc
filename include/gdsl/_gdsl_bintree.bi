''
''
'' _gdsl_bintree -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef ___gdsl_bintree_bi__
#define ___gdsl_bintree_bi__

#include once "gdsl_types.bi"
#include once "gdsl_macros.bi"

type _gdsl_bintree_t as any ptr
type gdsl_bintree_map_func_t as function cdecl(byval as _gdsl_bintree_t, byval as any ptr) as integer

extern "c"
declare function _gdsl_bintree_alloc (byval E as gdsl_element_t, byval LEFT as _gdsl_bintree_t, byval RIGHT as _gdsl_bintree_t) as _gdsl_bintree_t
declare sub _gdsl_bintree_free (byval T as _gdsl_bintree_t, byval FREE_F as gdsl_free_func_t)
declare function _gdsl_bintree_copy (byval T as _gdsl_bintree_t, byval COPY_F as gdsl_copy_func_t) as _gdsl_bintree_t
declare function _gdsl_bintree_is_empty (byval T as _gdsl_bintree_t) as integer
declare function _gdsl_bintree_is_leaf (byval T as _gdsl_bintree_t) as integer
declare function _gdsl_bintree_is_root (byval T as _gdsl_bintree_t) as integer
declare function _gdsl_bintree_get_content (byval T as _gdsl_bintree_t) as gdsl_element_t
declare function _gdsl_bintree_get_parent (byval T as _gdsl_bintree_t) as _gdsl_bintree_t
declare function _gdsl_bintree_get_left (byval T as _gdsl_bintree_t) as _gdsl_bintree_t
declare function _gdsl_bintree_get_right (byval T as _gdsl_bintree_t) as _gdsl_bintree_t
declare function _gdsl_bintree_get_left_ref (byval T as _gdsl_bintree_t) as _gdsl_bintree_t ptr
declare function _gdsl_bintree_get_right_ref (byval T as _gdsl_bintree_t) as _gdsl_bintree_t ptr
declare function _gdsl_bintree_get_height (byval T as _gdsl_bintree_t) as ulong
declare function _gdsl_bintree_get_size (byval T as _gdsl_bintree_t) as ulong
declare sub _gdsl_bintree_set_content (byval T as _gdsl_bintree_t, byval E as gdsl_element_t)
declare sub _gdsl_bintree_set_parent (byval T as _gdsl_bintree_t, byval P as _gdsl_bintree_t)
declare sub _gdsl_bintree_set_left (byval T as _gdsl_bintree_t, byval L as _gdsl_bintree_t)
declare sub _gdsl_bintree_set_right (byval T as _gdsl_bintree_t, byval R as _gdsl_bintree_t)
declare function _gdsl_bintree_rotate_left (byval T as _gdsl_bintree_t ptr) as _gdsl_bintree_t
declare function _gdsl_bintree_rotate_right (byval T as _gdsl_bintree_t ptr) as _gdsl_bintree_t
declare function _gdsl_bintree_rotate_left_right (byval T as _gdsl_bintree_t ptr) as _gdsl_bintree_t
declare function _gdsl_bintree_rotate_right_left (byval T as _gdsl_bintree_t ptr) as _gdsl_bintree_t
declare function _gdsl_bintree_map_prefix (byval T as _gdsl_bintree_t, byval MAP_F as gdsl_bintree_map_func_t, byval USER_DATA as any ptr) as _gdsl_bintree_t
declare function _gdsl_bintree_map_infix (byval T as _gdsl_bintree_t, byval MAP_F as gdsl_bintree_map_func_t, byval USER_DATA as any ptr) as _gdsl_bintree_t
declare function _gdsl_bintree_map_postfix (byval T as _gdsl_bintree_t, byval MAP_F as gdsl_bintree_map_func_t, byval USER_DATA as any ptr) as _gdsl_bintree_t
declare sub _gdsl_bintree_write (byval T as _gdsl_bintree_t, byval WRITE_F as gdsl_write_func_t, byval OUTPUT_FILE as FILE ptr, byval USER_DATA as any ptr)
declare sub _gdsl_bintree_write_xml (byval T as _gdsl_bintree_t, byval WRITE_F as gdsl_write_func_t, byval OUTPUT_FILE as FILE ptr, byval USER_DATA as any ptr)
declare sub _gdsl_bintree_dump (byval T as _gdsl_bintree_t, byval WRITE_F as gdsl_write_func_t, byval OUTPUT_FILE as FILE ptr, byval USER_DATA as any ptr)
end extern

#endif
