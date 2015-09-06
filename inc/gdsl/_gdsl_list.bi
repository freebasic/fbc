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
#include once "_gdsl_node.bi"
#include once "gdsl_types.bi"

extern "C"

#define __GDSL_LIST_H_
type _gdsl_list_t as _gdsl_node_t
declare function _gdsl_list_alloc(byval E as const gdsl_element_t) as _gdsl_list_t
declare sub _gdsl_list_free(byval L as _gdsl_list_t, byval FREE_F as const gdsl_free_func_t)
declare function _gdsl_list_is_empty(byval L as const _gdsl_list_t) as bool
declare function _gdsl_list_get_size(byval L as const _gdsl_list_t) as culong
declare sub _gdsl_list_link(byval L1 as _gdsl_list_t, byval L2 as _gdsl_list_t)
declare sub _gdsl_list_insert_after(byval L as _gdsl_list_t, byval PREV as _gdsl_list_t)
declare sub _gdsl_list_insert_before(byval L as _gdsl_list_t, byval SUCC as _gdsl_list_t)
declare sub _gdsl_list_remove(byval NODE as _gdsl_node_t)
declare function _gdsl_list_search(byval L as _gdsl_list_t, byval COMP_F as const gdsl_compare_func_t, byval VALUE as any ptr) as _gdsl_list_t
declare function _gdsl_list_map_forward(byval L as const _gdsl_list_t, byval MAP_F as const _gdsl_node_map_func_t, byval USER_DATA as any ptr) as _gdsl_list_t
declare function _gdsl_list_map_backward(byval L as const _gdsl_list_t, byval MAP_F as const _gdsl_node_map_func_t, byval USER_DATA as any ptr) as _gdsl_list_t
declare sub _gdsl_list_write(byval L as const _gdsl_list_t, byval WRITE_F as const _gdsl_node_write_func_t, byval OUTPUT_FILE as FILE ptr, byval USER_DATA as any ptr)
declare sub _gdsl_list_write_xml(byval L as const _gdsl_list_t, byval WRITE_F as const _gdsl_node_write_func_t, byval OUTPUT_FILE as FILE ptr, byval USER_DATA as any ptr)
declare sub _gdsl_list_dump(byval L as const _gdsl_list_t, byval WRITE_F as const _gdsl_node_write_func_t, byval OUTPUT_FILE as FILE ptr, byval USER_DATA as any ptr)

end extern
