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
#include once "gdsl_macros.bi"

extern "C"

#define __GDSL_BINTREE_H_
type _gdsl_bintree_t as _gdsl_bintree ptr
type _gdsl_bintree_map_func_t as function(byval TREE as const _gdsl_bintree_t, byval USER_DATA as any ptr) as long
type _gdsl_bintree_write_func_t as sub(byval TREE as const _gdsl_bintree_t, byval OUTPUT_FILE as FILE ptr, byval USER_DATA as any ptr)

declare function _gdsl_bintree_alloc(byval E as const gdsl_element_t, byval LEFT as const _gdsl_bintree_t, byval RIGHT as const _gdsl_bintree_t) as _gdsl_bintree_t
declare sub _gdsl_bintree_free(byval T as _gdsl_bintree_t, byval FREE_F as const gdsl_free_func_t)
declare function _gdsl_bintree_copy(byval T as const _gdsl_bintree_t, byval COPY_F as const gdsl_copy_func_t) as _gdsl_bintree_t
declare function _gdsl_bintree_is_empty(byval T as const _gdsl_bintree_t) as bool
declare function _gdsl_bintree_is_leaf(byval T as const _gdsl_bintree_t) as bool
declare function _gdsl_bintree_is_root(byval T as const _gdsl_bintree_t) as bool
declare function _gdsl_bintree_get_content(byval T as const _gdsl_bintree_t) as gdsl_element_t
declare function _gdsl_bintree_get_parent(byval T as const _gdsl_bintree_t) as _gdsl_bintree_t
declare function _gdsl_bintree_get_left(byval T as const _gdsl_bintree_t) as _gdsl_bintree_t
declare function _gdsl_bintree_get_right(byval T as const _gdsl_bintree_t) as _gdsl_bintree_t
declare function _gdsl_bintree_get_left_ref(byval T as const _gdsl_bintree_t) as _gdsl_bintree_t ptr
declare function _gdsl_bintree_get_right_ref(byval T as const _gdsl_bintree_t) as _gdsl_bintree_t ptr
declare function _gdsl_bintree_get_height(byval T as const _gdsl_bintree_t) as culong
declare function _gdsl_bintree_get_size(byval T as const _gdsl_bintree_t) as culong
declare sub _gdsl_bintree_set_content(byval T as _gdsl_bintree_t, byval E as const gdsl_element_t)
declare sub _gdsl_bintree_set_parent(byval T as _gdsl_bintree_t, byval P as const _gdsl_bintree_t)
declare sub _gdsl_bintree_set_left(byval T as _gdsl_bintree_t, byval L as const _gdsl_bintree_t)
declare sub _gdsl_bintree_set_right(byval T as _gdsl_bintree_t, byval R as const _gdsl_bintree_t)
declare function _gdsl_bintree_rotate_left(byval T as _gdsl_bintree_t ptr) as _gdsl_bintree_t
declare function _gdsl_bintree_rotate_right(byval T as _gdsl_bintree_t ptr) as _gdsl_bintree_t
declare function _gdsl_bintree_rotate_left_right(byval T as _gdsl_bintree_t ptr) as _gdsl_bintree_t
declare function _gdsl_bintree_rotate_right_left(byval T as _gdsl_bintree_t ptr) as _gdsl_bintree_t
declare function _gdsl_bintree_map_prefix(byval T as const _gdsl_bintree_t, byval MAP_F as const _gdsl_bintree_map_func_t, byval USER_DATA as any ptr) as _gdsl_bintree_t
declare function _gdsl_bintree_map_infix(byval T as const _gdsl_bintree_t, byval MAP_F as const _gdsl_bintree_map_func_t, byval USER_DATA as any ptr) as _gdsl_bintree_t
declare function _gdsl_bintree_map_postfix(byval T as const _gdsl_bintree_t, byval MAP_F as const _gdsl_bintree_map_func_t, byval USER_DATA as any ptr) as _gdsl_bintree_t
declare sub _gdsl_bintree_write(byval T as const _gdsl_bintree_t, byval WRITE_F as const _gdsl_bintree_write_func_t, byval OUTPUT_FILE as FILE ptr, byval USER_DATA as any ptr)
declare sub _gdsl_bintree_write_xml(byval T as const _gdsl_bintree_t, byval WRITE_F as const _gdsl_bintree_write_func_t, byval OUTPUT_FILE as FILE ptr, byval USER_DATA as any ptr)
declare sub _gdsl_bintree_dump(byval T as const _gdsl_bintree_t, byval WRITE_F as const _gdsl_bintree_write_func_t, byval OUTPUT_FILE as FILE ptr, byval USER_DATA as any ptr)

end extern
