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

extern "C"

#define _GDSL_PERM_H_
type gdsl_perm_t as gdsl_perm ptr

type gdsl_perm_position_t as long
enum
	GDSL_PERM_POSITION_FIRST = 1
	GDSL_PERM_POSITION_LAST = 2
end enum

type gdsl_perm_write_func_t as sub(byval E as culong, byval OUTPUT_FILE as FILE ptr, byval POSITION as gdsl_location_t, byval USER_DATA as any ptr)
type gdsl_perm_data_t as gdsl_perm_data ptr
declare function gdsl_perm_alloc(byval NAME as const zstring ptr, byval N as const culong) as gdsl_perm_t
declare sub gdsl_perm_free(byval P as gdsl_perm_t)
declare function gdsl_perm_copy(byval P as const gdsl_perm_t) as gdsl_perm_t
declare function gdsl_perm_get_name(byval P as const gdsl_perm_t) as const zstring ptr
declare function gdsl_perm_get_size(byval P as const gdsl_perm_t) as culong
declare function gdsl_perm_get_element(byval P as const gdsl_perm_t, byval INDIX as const culong) as culong
declare function gdsl_perm_get_elements_array(byval P as const gdsl_perm_t) as culong ptr
declare function gdsl_perm_linear_inversions_count(byval P as const gdsl_perm_t) as culong
declare function gdsl_perm_linear_cycles_count(byval P as const gdsl_perm_t) as culong
declare function gdsl_perm_canonical_cycles_count(byval P as const gdsl_perm_t) as culong
declare function gdsl_perm_set_name(byval P as gdsl_perm_t, byval NEW_NAME as const zstring ptr) as gdsl_perm_t
declare function gdsl_perm_linear_next(byval P as gdsl_perm_t) as gdsl_perm_t
declare function gdsl_perm_linear_prev(byval P as gdsl_perm_t) as gdsl_perm_t
declare function gdsl_perm_set_elements_array(byval P as gdsl_perm_t, byval ARRAY as const culong ptr) as gdsl_perm_t
declare function gdsl_perm_multiply(byval RESULT as gdsl_perm_t, byval ALPHA as const gdsl_perm_t, byval BETA as const gdsl_perm_t) as gdsl_perm_t
declare function gdsl_perm_linear_to_canonical(byval Q as gdsl_perm_t, byval P as const gdsl_perm_t) as gdsl_perm_t
declare function gdsl_perm_canonical_to_linear(byval Q as gdsl_perm_t, byval P as const gdsl_perm_t) as gdsl_perm_t
declare function gdsl_perm_inverse(byval P as gdsl_perm_t) as gdsl_perm_t
declare function gdsl_perm_reverse(byval P as gdsl_perm_t) as gdsl_perm_t
declare function gdsl_perm_randomize(byval P as gdsl_perm_t) as gdsl_perm_t
declare function gdsl_perm_apply_on_array(byval V as gdsl_element_t ptr, byval P as const gdsl_perm_t) as gdsl_element_t ptr
declare sub gdsl_perm_write(byval P as const gdsl_perm_t, byval WRITE_F as const gdsl_write_func_t, byval OUTPUT_FILE as FILE ptr, byval USER_DATA as any ptr)
declare sub gdsl_perm_write_xml(byval P as const gdsl_perm_t, byval WRITE_F as const gdsl_write_func_t, byval OUTPUT_FILE as FILE ptr, byval USER_DATA as any ptr)
declare sub gdsl_perm_dump(byval P as const gdsl_perm_t, byval WRITE_F as const gdsl_write_func_t, byval OUTPUT_FILE as FILE ptr, byval USER_DATA as any ptr)

end extern
