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
#include once "gdsl_types.bi"
#include once "_gdsl_bintree.bi"
#include once "gdsl_macros.bi"

extern "C"

#define _GDSL_RBTREE_H_
type gdsl_rbtree_t as gdsl_rbtree ptr
declare function gdsl_rbtree_alloc(byval NAME as const zstring ptr, byval ALLOC_F as gdsl_alloc_func_t, byval FREE_F as gdsl_free_func_t, byval COMP_F as gdsl_compare_func_t) as gdsl_rbtree_t
declare sub gdsl_rbtree_free(byval T as gdsl_rbtree_t)
declare sub gdsl_rbtree_flush(byval T as gdsl_rbtree_t)
declare function gdsl_rbtree_get_name(byval T as const gdsl_rbtree_t) as zstring ptr
declare function gdsl_rbtree_is_empty(byval T as const gdsl_rbtree_t) as bool
declare function gdsl_rbtree_get_root(byval T as const gdsl_rbtree_t) as gdsl_element_t
declare function gdsl_rbtree_get_size(byval T as const gdsl_rbtree_t) as culong
declare function gdsl_rbtree_height(byval T as const gdsl_rbtree_t) as culong
declare function gdsl_rbtree_set_name(byval T as gdsl_rbtree_t, byval NEW_NAME as const zstring ptr) as gdsl_rbtree_t
declare function gdsl_rbtree_insert(byval T as gdsl_rbtree_t, byval VALUE as any ptr, byval RESULT as long ptr) as gdsl_element_t
declare function gdsl_rbtree_remove(byval T as gdsl_rbtree_t, byval VALUE as any ptr) as gdsl_element_t
declare function gdsl_rbtree_delete(byval T as gdsl_rbtree_t, byval VALUE as any ptr) as gdsl_rbtree_t
declare function gdsl_rbtree_search(byval T as const gdsl_rbtree_t, byval COMP_F as gdsl_compare_func_t, byval VALUE as any ptr) as gdsl_element_t
declare function gdsl_rbtree_map_prefix(byval T as const gdsl_rbtree_t, byval MAP_F as gdsl_map_func_t, byval USER_DATA as any ptr) as gdsl_element_t
declare function gdsl_rbtree_map_infix(byval T as const gdsl_rbtree_t, byval MAP_F as gdsl_map_func_t, byval USER_DATA as any ptr) as gdsl_element_t
declare function gdsl_rbtree_map_postfix(byval T as const gdsl_rbtree_t, byval MAP_F as gdsl_map_func_t, byval USER_DATA as any ptr) as gdsl_element_t
declare sub gdsl_rbtree_write(byval T as const gdsl_rbtree_t, byval WRITE_F as gdsl_write_func_t, byval OUTPUT_FILE as FILE ptr, byval USER_DATA as any ptr)
declare sub gdsl_rbtree_write_xml(byval T as const gdsl_rbtree_t, byval WRITE_F as gdsl_write_func_t, byval OUTPUT_FILE as FILE ptr, byval USER_DATA as any ptr)
declare sub gdsl_rbtree_dump(byval T as const gdsl_rbtree_t, byval WRITE_F as gdsl_write_func_t, byval OUTPUT_FILE as FILE ptr, byval USER_DATA as any ptr)

end extern
