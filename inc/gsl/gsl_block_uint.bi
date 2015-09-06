'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
''   block/gsl_block_uint.h
''
''   Copyright (C) 1996, 1997, 1998, 1999, 2000, 2007 Gerard Jungman, Brian Gough
''
''   This program is free software; you can redistribute it and/or modify
''   it under the terms of the GNU General Public License as published by
''   the Free Software Foundation; either version 3 of the License, or (at
''   your option) any later version.
''
''   This program is distributed in the hope that it will be useful, but
''   WITHOUT ANY WARRANTY; without even the implied warranty of
''   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
''   General Public License for more details.
''
''   You should have received a copy of the GNU General Public License
''   along with this program; if not, write to the Free Software
''   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "crt/stdlib.bi"
#include once "gsl/gsl_errno.bi"

extern "C"

#define __GSL_BLOCK_UINT_H__

type gsl_block_uint_struct
	size as uinteger
	data as ulong ptr
end type

type gsl_block_uint as gsl_block_uint_struct
declare function gsl_block_uint_alloc(byval n as const uinteger) as gsl_block_uint ptr
declare function gsl_block_uint_calloc(byval n as const uinteger) as gsl_block_uint ptr
declare sub gsl_block_uint_free(byval b as gsl_block_uint ptr)
declare function gsl_block_uint_fread(byval stream as FILE ptr, byval b as gsl_block_uint ptr) as long
declare function gsl_block_uint_fwrite(byval stream as FILE ptr, byval b as const gsl_block_uint ptr) as long
declare function gsl_block_uint_fscanf(byval stream as FILE ptr, byval b as gsl_block_uint ptr) as long
declare function gsl_block_uint_fprintf(byval stream as FILE ptr, byval b as const gsl_block_uint ptr, byval format as const zstring ptr) as long
declare function gsl_block_uint_raw_fread(byval stream as FILE ptr, byval b as ulong ptr, byval n as const uinteger, byval stride as const uinteger) as long
declare function gsl_block_uint_raw_fwrite(byval stream as FILE ptr, byval b as const ulong ptr, byval n as const uinteger, byval stride as const uinteger) as long
declare function gsl_block_uint_raw_fscanf(byval stream as FILE ptr, byval b as ulong ptr, byval n as const uinteger, byval stride as const uinteger) as long
declare function gsl_block_uint_raw_fprintf(byval stream as FILE ptr, byval b as const ulong ptr, byval n as const uinteger, byval stride as const uinteger, byval format as const zstring ptr) as long
declare function gsl_block_uint_size(byval b as const gsl_block_uint ptr) as uinteger
declare function gsl_block_uint_data(byval b as const gsl_block_uint ptr) as ulong ptr

end extern
