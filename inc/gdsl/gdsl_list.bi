'' FreeBASIC binding for gdsl-1.8
''
'' based on the C header files:
''   This file is part of the Generic Data Structures Library (GDSL).
''   Copyright (C) 1998-2006 Nicolas Darnis <ndarnis@free.fr>.
''
''   The GDSL library is free software; you can redistribute it and/or 
''   modify it under the terms of the GNU General Public License as 
''   published by the Free Software Foundation; either version 2 of
''   the License, or (at your option) any later version.
''
''   The GDSL library is distributed in the hope that it will be useful,
''   but WITHOUT ANY WARRANTY; without even the implied warranty of
''   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
''   GNU General Public License for more details.
''
''   You should have received a copy of the GNU General Public License
''   along with the GDSL library; see the file COPYING.
''   If not, write to the Free Software Foundation, Inc., 
''   51 Franklin Street, Fifth Floor, Boston, MA  02111-1301, USA.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "crt/long.bi"
#include once "crt/stdio.bi"
#include once "gdsl_types.bi"

extern "C"

#define _GDSL_LIST_H_
type gdsl_list_t as _gdsl_list ptr
type gdsl_list_cursor_t as _gdsl_list_cursor ptr
declare function gdsl_list_alloc(byval NAME as const zstring ptr, byval ALLOC_F as gdsl_alloc_func_t, byval FREE_F as gdsl_free_func_t) as gdsl_list_t
declare sub gdsl_list_free(byval L as gdsl_list_t)
declare sub gdsl_list_flush(byval L as gdsl_list_t)
declare function gdsl_list_get_name(byval L as const gdsl_list_t) as const zstring ptr
declare function gdsl_list_get_size(byval L as const gdsl_list_t) as culong
declare function gdsl_list_is_empty(byval L as const gdsl_list_t) as bool
declare function gdsl_list_get_head(byval L as const gdsl_list_t) as gdsl_element_t
declare function gdsl_list_get_tail(byval L as const gdsl_list_t) as gdsl_element_t
declare function gdsl_list_set_name(byval L as gdsl_list_t, byval NEW_NAME as const zstring ptr) as gdsl_list_t
declare function gdsl_list_insert_head(byval L as gdsl_list_t, byval VALUE as any ptr) as gdsl_element_t
declare function gdsl_list_insert_tail(byval L as gdsl_list_t, byval VALUE as any ptr) as gdsl_element_t
declare function gdsl_list_remove_head(byval L as gdsl_list_t) as gdsl_element_t
declare function gdsl_list_remove_tail(byval L as gdsl_list_t) as gdsl_element_t
declare function gdsl_list_remove(byval L as gdsl_list_t, byval COMP_F as gdsl_compare_func_t, byval VALUE as const any ptr) as gdsl_element_t
declare function gdsl_list_delete_head(byval L as gdsl_list_t) as gdsl_list_t
declare function gdsl_list_delete_tail(byval L as gdsl_list_t) as gdsl_list_t
declare function gdsl_list_delete(byval L as gdsl_list_t, byval COMP_F as gdsl_compare_func_t, byval VALUE as const any ptr) as gdsl_list_t
declare function gdsl_list_search(byval L as const gdsl_list_t, byval COMP_F as gdsl_compare_func_t, byval VALUE as const any ptr) as gdsl_element_t
declare function gdsl_list_search_by_position(byval L as const gdsl_list_t, byval POS as culong) as gdsl_element_t
declare function gdsl_list_search_max(byval L as const gdsl_list_t, byval COMP_F as gdsl_compare_func_t) as gdsl_element_t
declare function gdsl_list_search_min(byval L as const gdsl_list_t, byval COMP_F as gdsl_compare_func_t) as gdsl_element_t
declare function gdsl_list_sort(byval L as gdsl_list_t, byval COMP_F as gdsl_compare_func_t) as gdsl_list_t
declare function gdsl_list_map_forward(byval L as const gdsl_list_t, byval MAP_F as gdsl_map_func_t, byval USER_DATA as any ptr) as gdsl_element_t
declare function gdsl_list_map_backward(byval L as const gdsl_list_t, byval MAP_F as gdsl_map_func_t, byval USER_DATA as any ptr) as gdsl_element_t
declare sub gdsl_list_write(byval L as const gdsl_list_t, byval WRITE_F as gdsl_write_func_t, byval OUTPUT_FILE as FILE ptr, byval USER_DATA as any ptr)
declare sub gdsl_list_write_xml(byval L as const gdsl_list_t, byval WRITE_F as gdsl_write_func_t, byval OUTPUT_FILE as FILE ptr, byval USER_DATA as any ptr)
declare sub gdsl_list_dump(byval L as const gdsl_list_t, byval WRITE_F as gdsl_write_func_t, byval OUTPUT_FILE as FILE ptr, byval USER_DATA as any ptr)
declare function gdsl_list_cursor_alloc(byval L as const gdsl_list_t) as gdsl_list_cursor_t
declare sub gdsl_list_cursor_free(byval C as gdsl_list_cursor_t)
declare sub gdsl_list_cursor_move_to_head(byval C as gdsl_list_cursor_t)
declare sub gdsl_list_cursor_move_to_tail(byval C as gdsl_list_cursor_t)
declare function gdsl_list_cursor_move_to_value(byval C as gdsl_list_cursor_t, byval COMP_F as gdsl_compare_func_t, byval VALUE as any ptr) as gdsl_element_t
declare function gdsl_list_cursor_move_to_position(byval C as gdsl_list_cursor_t, byval POS as culong) as gdsl_element_t
declare sub gdsl_list_cursor_step_forward(byval C as gdsl_list_cursor_t)
declare sub gdsl_list_cursor_step_backward(byval C as gdsl_list_cursor_t)
declare function gdsl_list_cursor_is_on_head(byval C as const gdsl_list_cursor_t) as bool
declare function gdsl_list_cursor_is_on_tail(byval C as const gdsl_list_cursor_t) as bool
declare function gdsl_list_cursor_has_succ(byval C as const gdsl_list_cursor_t) as bool
declare function gdsl_list_cursor_has_pred(byval C as const gdsl_list_cursor_t) as bool
declare sub gdsl_list_cursor_set_content(byval C as gdsl_list_cursor_t, byval E as gdsl_element_t)
declare function gdsl_list_cursor_get_content(byval C as const gdsl_list_cursor_t) as gdsl_element_t
declare function gdsl_list_cursor_insert_after(byval C as gdsl_list_cursor_t, byval VALUE as any ptr) as gdsl_element_t
declare function gdsl_list_cursor_insert_before(byval C as gdsl_list_cursor_t, byval VALUE as any ptr) as gdsl_element_t
declare function gdsl_list_cursor_remove(byval C as gdsl_list_cursor_t) as gdsl_element_t
declare function gdsl_list_cursor_remove_after(byval C as gdsl_list_cursor_t) as gdsl_element_t
declare function gdsl_list_cursor_remove_before(byval C as gdsl_list_cursor_t) as gdsl_element_t
declare function gdsl_list_cursor_delete(byval C as gdsl_list_cursor_t) as gdsl_list_cursor_t
declare function gdsl_list_cursor_delete_after(byval C as gdsl_list_cursor_t) as gdsl_list_cursor_t
declare function gdsl_list_cursor_delete_before(byval C as gdsl_list_cursor_t) as gdsl_list_cursor_t

end extern
