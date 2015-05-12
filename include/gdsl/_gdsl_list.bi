''
''
'' _gdsl_list -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef ___gdsl_list_bi__
#define ___gdsl_list_bi__

#include once "_gdsl_node.bi"
#include once "gdsl_types.bi"

type _gdsl_list_t as _gdsl_node_t
type _gdsl_list_map_func_t as function cdecl(byval as _gdsl_node_t, byval as any ptr) as integer

extern "c"
declare function _gdsl_list_alloc (byval E as gdsl_element_t) as _gdsl_list_t
declare sub _gdsl_list_free (byval L as _gdsl_list_t, byval FREE_F as gdsl_free_func_t)
declare function _gdsl_list_is_empty (byval L as _gdsl_list_t) as integer
declare function _gdsl_list_get_size (byval L as _gdsl_list_t) as ulong
declare sub _gdsl_list_link (byval L1 as _gdsl_list_t, byval L2 as _gdsl_list_t)
declare sub _gdsl_list_insert_after (byval L as _gdsl_list_t, byval PREV as _gdsl_list_t)
declare sub _gdsl_list_insert_before (byval L as _gdsl_list_t, byval SUCC as _gdsl_list_t)
declare sub _gdsl_list_remove (byval NODE as _gdsl_node_t)
declare function _gdsl_list_search (byval L as _gdsl_list_t, byval COMP_F as gdsl_compare_func_t, byval VALUE as any ptr) as _gdsl_list_t
declare function _gdsl_list_map_forward (byval L as _gdsl_list_t, byval MAP_F as _gdsl_list_map_func_t, byval USER_DATA as any ptr) as _gdsl_list_t
declare function _gdsl_list_map_backward (byval L as _gdsl_list_t, byval MAP_F as _gdsl_list_map_func_t, byval USER_DATA as any ptr) as _gdsl_list_t
declare sub _gdsl_list_write (byval L as _gdsl_list_t, byval WRITE_F as gdsl_write_func_t, byval OUTPUT_FILE as FILE ptr, byval USER_DATA as any ptr)
declare sub _gdsl_list_write_xml (byval L as _gdsl_list_t, byval WRITE_F as gdsl_write_func_t, byval OUTPUT_FILE as FILE ptr, byval USER_DATA as any ptr)
declare sub _gdsl_list_dump (byval L as _gdsl_list_t, byval WRITE_F as gdsl_write_func_t, byval OUTPUT_FILE as FILE ptr, byval USER_DATA as any ptr)
end extern

#endif
