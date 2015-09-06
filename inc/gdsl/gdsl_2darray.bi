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

#define _GDSL_2DARRAY_H_
type gdsl_2darray_t as gdsl_2darray ptr
declare function gdsl_2darray_alloc(byval NAME as const zstring ptr, byval R as const culong, byval C as const culong, byval ALLOC_F as const gdsl_alloc_func_t, byval FREE_F as const gdsl_free_func_t) as gdsl_2darray_t
declare sub gdsl_2darray_free(byval A as gdsl_2darray_t)
declare function gdsl_2darray_get_name(byval A as const gdsl_2darray_t) as const zstring ptr
declare function gdsl_2darray_get_rows_number(byval A as const gdsl_2darray_t) as culong
declare function gdsl_2darray_get_columns_number(byval A as const gdsl_2darray_t) as culong
declare function gdsl_2darray_get_size(byval A as const gdsl_2darray_t) as culong
declare function gdsl_2darray_get_content(byval A as const gdsl_2darray_t, byval R as const culong, byval C as const culong) as gdsl_element_t
declare function gdsl_2darray_set_name(byval A as gdsl_2darray_t, byval NEW_NAME as const zstring ptr) as gdsl_2darray_t
declare function gdsl_2darray_set_content(byval A as gdsl_2darray_t, byval R as const culong, byval C as const culong, byval VALUE as any ptr) as gdsl_element_t
declare sub gdsl_2darray_write(byval A as const gdsl_2darray_t, byval WRITE_F as const gdsl_write_func_t, byval OUTPUT_FILE as FILE ptr, byval USER_DATA as any ptr)
declare sub gdsl_2darray_write_xml(byval A as const gdsl_2darray_t, byval WRITE_F as const gdsl_write_func_t, byval OUTPUT_FILE as FILE ptr, byval USER_DATA as any ptr)
declare sub gdsl_2darray_dump(byval A as const gdsl_2darray_t, byval WRITE_F as const gdsl_write_func_t, byval OUTPUT_FILE as FILE ptr, byval USER_DATA as any ptr)

end extern
