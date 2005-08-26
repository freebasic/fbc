''
''
'' gdsl_list -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gdsl_list_bi__
#define __gdsl_list_bi__

#include once "gdsl/gdsl_types.bi"

type gdsl_list_t as _any ptr
type gdsl_list_cursor_t as any ptr

declare function gdsl_list_alloc cdecl alias "gdsl_list_alloc" (byval NAME as zstring ptr, byval ALLOC_F as gdsl_alloc_func_t, byval FREE_F as gdsl_free_func_t) as gdsl_list_t
declare sub gdsl_list_free cdecl alias "gdsl_list_free" (byval L as gdsl_list_t)
declare sub gdsl_list_flush cdecl alias "gdsl_list_flush" (byval L as gdsl_list_t)
declare function gdsl_list_get_name cdecl alias "gdsl_list_get_name" (byval L as gdsl_list_t) as zstring ptr
declare function gdsl_list_get_size cdecl alias "gdsl_list_get_size" (byval L as gdsl_list_t) as ulong
declare function gdsl_list_is_empty cdecl alias "gdsl_list_is_empty" (byval L as gdsl_list_t) as integer
declare function gdsl_list_get_head cdecl alias "gdsl_list_get_head" (byval L as gdsl_list_t) as gdsl_element_t
declare function gdsl_list_get_tail cdecl alias "gdsl_list_get_tail" (byval L as gdsl_list_t) as gdsl_element_t
declare function gdsl_list_set_name cdecl alias "gdsl_list_set_name" (byval L as gdsl_list_t, byval NEW_NAME as zstring ptr) as gdsl_list_t
declare function gdsl_list_insert_head cdecl alias "gdsl_list_insert_head" (byval L as gdsl_list_t, byval VALUE as any ptr) as gdsl_element_t
declare function gdsl_list_insert_tail cdecl alias "gdsl_list_insert_tail" (byval L as gdsl_list_t, byval VALUE as any ptr) as gdsl_element_t
declare function gdsl_list_remove_head cdecl alias "gdsl_list_remove_head" (byval L as gdsl_list_t) as gdsl_element_t
declare function gdsl_list_remove_tail cdecl alias "gdsl_list_remove_tail" (byval L as gdsl_list_t) as gdsl_element_t
declare function gdsl_list_remove cdecl alias "gdsl_list_remove" (byval L as gdsl_list_t, byval COMP_F as gdsl_compare_func_t, byval VALUE as any ptr) as gdsl_element_t
declare function gdsl_list_delete_head cdecl alias "gdsl_list_delete_head" (byval L as gdsl_list_t) as gdsl_list_t
declare function gdsl_list_delete_tail cdecl alias "gdsl_list_delete_tail" (byval L as gdsl_list_t) as gdsl_list_t
declare function gdsl_list_delete cdecl alias "gdsl_list_delete" (byval L as gdsl_list_t, byval COMP_F as gdsl_compare_func_t, byval VALUE as any ptr) as gdsl_list_t
declare function gdsl_list_search cdecl alias "gdsl_list_search" (byval L as gdsl_list_t, byval COMP_F as gdsl_compare_func_t, byval VALUE as any ptr) as gdsl_element_t
declare function gdsl_list_search_by_position cdecl alias "gdsl_list_search_by_position" (byval L as gdsl_list_t, byval POS as ulong) as gdsl_element_t
declare function gdsl_list_search_max cdecl alias "gdsl_list_search_max" (byval L as gdsl_list_t, byval COMP_F as gdsl_compare_func_t) as gdsl_element_t
declare function gdsl_list_search_min cdecl alias "gdsl_list_search_min" (byval L as gdsl_list_t, byval COMP_F as gdsl_compare_func_t) as gdsl_element_t
declare function gdsl_list_sort cdecl alias "gdsl_list_sort" (byval L as gdsl_list_t, byval COMP_F as gdsl_compare_func_t, byval MAX as gdsl_element_t) as gdsl_list_t
declare function gdsl_list_map_forward cdecl alias "gdsl_list_map_forward" (byval L as gdsl_list_t, byval MAP_F as gdsl_map_func_t, byval USER_DATA as any ptr) as gdsl_element_t
declare function gdsl_list_map_backward cdecl alias "gdsl_list_map_backward" (byval L as gdsl_list_t, byval MAP_F as gdsl_map_func_t, byval USER_DATA as any ptr) as gdsl_element_t
declare sub gdsl_list_write cdecl alias "gdsl_list_write" (byval L as gdsl_list_t, byval WRITE_F as gdsl_write_func_t, byval OUTPUT_FILE as FILE ptr, byval USER_DATA as any ptr)
declare sub gdsl_list_write_xml cdecl alias "gdsl_list_write_xml" (byval L as gdsl_list_t, byval WRITE_F as gdsl_write_func_t, byval OUTPUT_FILE as FILE ptr, byval USER_DATA as any ptr)
declare sub gdsl_list_dump cdecl alias "gdsl_list_dump" (byval L as gdsl_list_t, byval WRITE_F as gdsl_write_func_t, byval OUTPUT_FILE as FILE ptr, byval USER_DATA as any ptr)
declare function gdsl_list_cursor_alloc cdecl alias "gdsl_list_cursor_alloc" (byval L as gdsl_list_t) as gdsl_list_cursor_t
declare sub gdsl_list_cursor_free cdecl alias "gdsl_list_cursor_free" (byval C as gdsl_list_cursor_t)
declare sub gdsl_list_cursor_move_to_head cdecl alias "gdsl_list_cursor_move_to_head" (byval C as gdsl_list_cursor_t)
declare sub gdsl_list_cursor_move_to_tail cdecl alias "gdsl_list_cursor_move_to_tail" (byval C as gdsl_list_cursor_t)
declare function gdsl_list_cursor_move_to_value cdecl alias "gdsl_list_cursor_move_to_value" (byval C as gdsl_list_cursor_t, byval COMP_F as gdsl_compare_func_t, byval VALUE as any ptr) as gdsl_element_t
declare function gdsl_list_cursor_move_to_position cdecl alias "gdsl_list_cursor_move_to_position" (byval C as gdsl_list_cursor_t, byval POS as ulong) as gdsl_element_t
declare sub gdsl_list_cursor_step_forward cdecl alias "gdsl_list_cursor_step_forward" (byval C as gdsl_list_cursor_t)
declare sub gdsl_list_cursor_step_backward cdecl alias "gdsl_list_cursor_step_backward" (byval C as gdsl_list_cursor_t)
declare function gdsl_list_cursor_is_on_head cdecl alias "gdsl_list_cursor_is_on_head" (byval C as gdsl_list_cursor_t) as integer
declare function gdsl_list_cursor_is_on_tail cdecl alias "gdsl_list_cursor_is_on_tail" (byval C as gdsl_list_cursor_t) as integer
declare function gdsl_list_cursor_has_succ cdecl alias "gdsl_list_cursor_has_succ" (byval C as gdsl_list_cursor_t) as integer
declare function gdsl_list_cursor_has_pred cdecl alias "gdsl_list_cursor_has_pred" (byval C as gdsl_list_cursor_t) as integer
declare sub gdsl_list_cursor_set_content cdecl alias "gdsl_list_cursor_set_content" (byval C as gdsl_list_cursor_t, byval E as gdsl_element_t)
declare function gdsl_list_cursor_get_content cdecl alias "gdsl_list_cursor_get_content" (byval C as gdsl_list_cursor_t) as gdsl_element_t
declare function gdsl_list_cursor_insert_after cdecl alias "gdsl_list_cursor_insert_after" (byval C as gdsl_list_cursor_t, byval VALUE as any ptr) as gdsl_element_t
declare function gdsl_list_cursor_insert_before cdecl alias "gdsl_list_cursor_insert_before" (byval C as gdsl_list_cursor_t, byval VALUE as any ptr) as gdsl_element_t
declare function gdsl_list_cursor_remove cdecl alias "gdsl_list_cursor_remove" (byval C as gdsl_list_cursor_t) as gdsl_element_t
declare function gdsl_list_cursor_remove_after cdecl alias "gdsl_list_cursor_remove_after" (byval C as gdsl_list_cursor_t) as gdsl_element_t
declare function gdsl_list_cursor_remove_before cdecl alias "gdsl_list_cursor_remove_before" (byval C as gdsl_list_cursor_t) as gdsl_element_t
declare function gdsl_list_cursor_delete cdecl alias "gdsl_list_cursor_delete" (byval C as gdsl_list_cursor_t) as gdsl_list_cursor_t
declare function gdsl_list_cursor_delete_after cdecl alias "gdsl_list_cursor_delete_after" (byval C as gdsl_list_cursor_t) as gdsl_list_cursor_t
declare function gdsl_list_cursor_delete_before cdecl alias "gdsl_list_cursor_delete_before" (byval C as gdsl_list_cursor_t) as gdsl_list_cursor_t

#endif
