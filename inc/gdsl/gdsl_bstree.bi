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

#define _GDSL_BSTREE_H_
type gdsl_bstree_t as gdsl_bstree ptr
declare function gdsl_bstree_alloc(byval NAME as const zstring ptr, byval ALLOC_F as gdsl_alloc_func_t, byval FREE_F as gdsl_free_func_t, byval COMP_F as gdsl_compare_func_t) as gdsl_bstree_t
declare sub gdsl_bstree_free(byval T as gdsl_bstree_t)
declare sub gdsl_bstree_flush(byval T as gdsl_bstree_t)
declare function gdsl_bstree_get_name(byval T as const gdsl_bstree_t) as const zstring ptr
declare function gdsl_bstree_is_empty(byval T as const gdsl_bstree_t) as bool
declare function gdsl_bstree_get_root(byval T as const gdsl_bstree_t) as gdsl_element_t
declare function gdsl_bstree_get_size(byval T as const gdsl_bstree_t) as culong
declare function gdsl_bstree_get_height(byval T as const gdsl_bstree_t) as culong
declare function gdsl_bstree_set_name(byval T as gdsl_bstree_t, byval NEW_NAME as const zstring ptr) as gdsl_bstree_t
declare function gdsl_bstree_insert(byval T as gdsl_bstree_t, byval VALUE as any ptr, byval RESULT as long ptr) as gdsl_element_t
declare function gdsl_bstree_remove(byval T as gdsl_bstree_t, byval VALUE as any ptr) as gdsl_element_t
declare function gdsl_bstree_delete(byval T as gdsl_bstree_t, byval VALUE as any ptr) as gdsl_bstree_t
declare function gdsl_bstree_search(byval T as const gdsl_bstree_t, byval COMP_F as gdsl_compare_func_t, byval VALUE as any ptr) as gdsl_element_t
declare function gdsl_bstree_map_prefix(byval T as const gdsl_bstree_t, byval MAP_F as gdsl_map_func_t, byval USER_DATA as any ptr) as gdsl_element_t
declare function gdsl_bstree_map_infix(byval T as const gdsl_bstree_t, byval MAP_F as gdsl_map_func_t, byval USER_DATA as any ptr) as gdsl_element_t
declare function gdsl_bstree_map_postfix(byval T as const gdsl_bstree_t, byval MAP_F as gdsl_map_func_t, byval USER_DATA as any ptr) as gdsl_element_t
declare sub gdsl_bstree_write(byval T as const gdsl_bstree_t, byval WRITE_F as gdsl_write_func_t, byval OUTPUT_FILE as FILE ptr, byval USER_DATA as any ptr)
declare sub gdsl_bstree_write_xml(byval T as const gdsl_bstree_t, byval WRITE_F as gdsl_write_func_t, byval OUTPUT_FILE as FILE ptr, byval USER_DATA as any ptr)
declare sub gdsl_bstree_dump(byval T as const gdsl_bstree_t, byval WRITE_F as gdsl_write_func_t, byval OUTPUT_FILE as FILE ptr, byval USER_DATA as any ptr)

end extern
