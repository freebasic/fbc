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

#include once "crt/stdio.bi"
#include once "gdsl_types.bi"

extern "C"

#define __GDSL_NODE_H_
type _gdsl_node_t as _gdsl_node ptr
type _gdsl_node_map_func_t as function(byval NODE as const _gdsl_node_t, byval USER_DATA as any ptr) as long
type _gdsl_node_write_func_t as sub(byval NODE as const _gdsl_node_t, byval OUTPUT_FILE as FILE ptr, byval USER_DATA as any ptr)

declare function _gdsl_node_alloc() as _gdsl_node_t
declare function _gdsl_node_free(byval NODE as _gdsl_node_t) as gdsl_element_t
declare function _gdsl_node_get_succ(byval NODE as const _gdsl_node_t) as _gdsl_node_t
declare function _gdsl_node_get_pred(byval NODE as const _gdsl_node_t) as _gdsl_node_t
declare function _gdsl_node_get_content(byval NODE as const _gdsl_node_t) as gdsl_element_t
declare sub _gdsl_node_set_succ(byval NODE as _gdsl_node_t, byval SUCC as const _gdsl_node_t)
declare sub _gdsl_node_set_pred(byval NODE as _gdsl_node_t, byval PRED as const _gdsl_node_t)
declare sub _gdsl_node_set_content(byval NODE as _gdsl_node_t, byval CONTENT as const gdsl_element_t)
declare sub _gdsl_node_link(byval NODE1 as _gdsl_node_t, byval NODE2 as _gdsl_node_t)
declare sub _gdsl_node_unlink(byval NODE1 as _gdsl_node_t, byval NODE2 as _gdsl_node_t)
declare sub _gdsl_node_write(byval NODE as const _gdsl_node_t, byval WRITE_F as const _gdsl_node_write_func_t, byval OUTPUT_FILE as FILE ptr, byval USER_DATA as any ptr)
declare sub _gdsl_node_write_xml(byval NODE as const _gdsl_node_t, byval WRITE_F as const _gdsl_node_write_func_t, byval OUTPUT_FILE as FILE ptr, byval USER_DATA as any ptr)
declare sub _gdsl_node_dump(byval NODE as const _gdsl_node_t, byval WRITE_F as const _gdsl_node_write_func_t, byval OUTPUT_FILE as FILE ptr, byval USER_DATA as any ptr)

end extern
