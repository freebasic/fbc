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

#define _GDSL_HASH_H_
type gdsl_hash_t as hash_table ptr
type gdsl_key_func_t as function(byval VALUE as any ptr) as const zstring ptr
type gdsl_hash_func_t as function(byval KEY as const zstring ptr) as culong

declare function gdsl_hash(byval KEY as const zstring ptr) as culong
declare function gdsl_hash_alloc(byval NAME as const zstring ptr, byval ALLOC_F as gdsl_alloc_func_t, byval FREE_F as gdsl_free_func_t, byval KEY_F as gdsl_key_func_t, byval HASH_F as gdsl_hash_func_t, byval INITIAL_ENTRIES_NB as ushort) as gdsl_hash_t
declare sub gdsl_hash_free(byval H as gdsl_hash_t)
declare sub gdsl_hash_flush(byval H as gdsl_hash_t)
declare function gdsl_hash_get_name(byval H as const gdsl_hash_t) as const zstring ptr
declare function gdsl_hash_get_entries_number(byval H as const gdsl_hash_t) as ushort
declare function gdsl_hash_get_lists_max_size(byval H as const gdsl_hash_t) as ushort
declare function gdsl_hash_get_longest_list_size(byval H as const gdsl_hash_t) as ushort
declare function gdsl_hash_get_size(byval H as const gdsl_hash_t) as culong
declare function gdsl_hash_get_fill_factor(byval H as const gdsl_hash_t) as double
declare function gdsl_hash_set_name(byval H as gdsl_hash_t, byval NEW_NAME as const zstring ptr) as gdsl_hash_t
declare function gdsl_hash_insert(byval H as gdsl_hash_t, byval VALUE as any ptr) as gdsl_element_t
declare function gdsl_hash_remove(byval H as gdsl_hash_t, byval KEY as const zstring ptr) as gdsl_element_t
declare function gdsl_hash_delete(byval H as gdsl_hash_t, byval KEY as const zstring ptr) as gdsl_hash_t
declare function gdsl_hash_modify(byval H as gdsl_hash_t, byval NEW_ENTRIES_NB as ushort, byval NEW_LISTS_MAX_SIZE as ushort) as gdsl_hash_t
declare function gdsl_hash_search(byval H as const gdsl_hash_t, byval KEY as const zstring ptr) as gdsl_element_t
declare function gdsl_hash_map(byval H as const gdsl_hash_t, byval MAP_F as gdsl_map_func_t, byval USER_DATA as any ptr) as gdsl_element_t
declare sub gdsl_hash_write(byval H as const gdsl_hash_t, byval WRITE_F as gdsl_write_func_t, byval OUTPUT_FILE as FILE ptr, byval USER_DATA as any ptr)
declare sub gdsl_hash_write_xml(byval H as const gdsl_hash_t, byval WRITE_F as gdsl_write_func_t, byval OUTPUT_FILE as FILE ptr, byval USER_DATA as any ptr)
declare sub gdsl_hash_dump(byval H as const gdsl_hash_t, byval WRITE_F as gdsl_write_func_t, byval OUTPUT_FILE as FILE ptr, byval USER_DATA as any ptr)

end extern
