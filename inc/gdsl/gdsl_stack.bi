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

#define _GDSL_STACK_H_
type gdsl_stack_t as _gdsl_stack ptr
declare function gdsl_stack_alloc(byval NAME as const zstring ptr, byval ALLOC_F as gdsl_alloc_func_t, byval FREE_F as gdsl_free_func_t) as gdsl_stack_t
declare sub gdsl_stack_free(byval S as gdsl_stack_t)
declare sub gdsl_stack_flush(byval S as gdsl_stack_t)
declare function gdsl_stack_get_name(byval S as const gdsl_stack_t) as const zstring ptr
declare function gdsl_stack_get_size(byval S as const gdsl_stack_t) as culong
declare function gdsl_stack_get_growing_factor(byval S as const gdsl_stack_t) as culong
declare function gdsl_stack_is_empty(byval S as const gdsl_stack_t) as bool
declare function gdsl_stack_get_top(byval S as const gdsl_stack_t) as gdsl_element_t
declare function gdsl_stack_get_bottom(byval S as const gdsl_stack_t) as gdsl_element_t
declare function gdsl_stack_set_name(byval S as gdsl_stack_t, byval NEW_NAME as const zstring ptr) as gdsl_stack_t
declare sub gdsl_stack_set_growing_factor(byval S as gdsl_stack_t, byval G as culong)
declare function gdsl_stack_insert(byval S as gdsl_stack_t, byval VALUE as any ptr) as gdsl_element_t
declare function gdsl_stack_remove(byval S as gdsl_stack_t) as gdsl_element_t
declare function gdsl_stack_search(byval S as const gdsl_stack_t, byval COMP_F as gdsl_compare_func_t, byval VALUE as any ptr) as gdsl_element_t
declare function gdsl_stack_search_by_position(byval S as const gdsl_stack_t, byval POS as culong) as gdsl_element_t
declare function gdsl_stack_map_forward(byval S as const gdsl_stack_t, byval MAP_F as gdsl_map_func_t, byval USER_DATA as any ptr) as gdsl_element_t
declare function gdsl_stack_map_backward(byval S as const gdsl_stack_t, byval MAP_F as gdsl_map_func_t, byval USER_DATA as any ptr) as gdsl_element_t
declare sub gdsl_stack_write(byval S as const gdsl_stack_t, byval WRITE_F as gdsl_write_func_t, byval OUTPUT_FILE as FILE ptr, byval USER_DATA as any ptr)
declare sub gdsl_stack_write_xml(byval S as gdsl_stack_t, byval WRITE_F as gdsl_write_func_t, byval OUTPUT_FILE as FILE ptr, byval USER_DATA as any ptr)
declare sub gdsl_stack_dump(byval S as gdsl_stack_t, byval WRITE_F as gdsl_write_func_t, byval OUTPUT_FILE as FILE ptr, byval USER_DATA as any ptr)

end extern
