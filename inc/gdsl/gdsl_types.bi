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
#include once "crt/sys/types.bi"

extern "C"

#define _GDSL_TYPES_H_

type gdsl_constant_t as long
enum
	GDSL_ERR_MEM_ALLOC = -1
	GDSL_MAP_STOP = 0
	GDSL_MAP_CONT = 1
	GDSL_INSERTED
	GDSL_FOUND
end enum

type gdsl_location_t as long
enum
	GDSL_LOCATION_UNDEF = 0
	GDSL_LOCATION_HEAD = 1
	GDSL_LOCATION_ROOT = 1
	GDSL_LOCATION_TOP = 1
	GDSL_LOCATION_TAIL = 2
	GDSL_LOCATION_LEAF = 2
	GDSL_LOCATION_BOTTOM = 2
	GDSL_LOCATION_FIRST = 1
	GDSL_LOCATION_LAST = 2
	GDSL_LOCATION_FIRST_COL = 1
	GDSL_LOCATION_LAST_COL = 2
	GDSL_LOCATION_FIRST_ROW = 4
	GDSL_LOCATION_LAST_ROW = 8
end enum

type gdsl_element_t as any ptr
type gdsl_alloc_func_t as function(byval USER_DATA as any ptr) as gdsl_element_t
type gdsl_free_func_t as sub(byval E as gdsl_element_t)
type gdsl_copy_func_t as function(byval E as const gdsl_element_t) as gdsl_element_t
type gdsl_map_func_t as function(byval E as const gdsl_element_t, byval LOCATION as gdsl_location_t, byval USER_DATA as any ptr) as long
type gdsl_compare_func_t as function(byval E as const gdsl_element_t, byval VALUE as any ptr) as clong
type gdsl_write_func_t as sub(byval E as const gdsl_element_t, byval OUTPUT_FILE as FILE ptr, byval LOCATION as gdsl_location_t, byval USER_DATA as any ptr)

type bool as long
#ifndef FALSE
	const FALSE = 0
#endif
#ifndef CTRUE
	const CTRUE = 1
#endif
#ifndef TRUE
	const TRUE = 1
#endif

end extern
