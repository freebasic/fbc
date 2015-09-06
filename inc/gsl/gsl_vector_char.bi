'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
''   vector/gsl_vector_char.h
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
#include once "gsl/gsl_types.bi"
#include once "gsl/gsl_errno.bi"
#include once "gsl/gsl_inline.bi"
#include once "gsl/gsl_check_range.bi"
#include once "gsl/gsl_block_char.bi"

extern "C"

#define __GSL_VECTOR_CHAR_H__

type gsl_vector_char
	size as uinteger
	stride as uinteger
	data as byte ptr
	block as gsl_block_char ptr
	owner as long
end type

type _gsl_vector_char_view
	vector as gsl_vector_char
end type

type gsl_vector_char_view as _gsl_vector_char_view

type _gsl_vector_char_const_view
	vector as gsl_vector_char
end type

type gsl_vector_char_const_view as const _gsl_vector_char_const_view
declare function gsl_vector_char_alloc(byval n as const uinteger) as gsl_vector_char ptr
declare function gsl_vector_char_calloc(byval n as const uinteger) as gsl_vector_char ptr
declare function gsl_vector_char_alloc_from_block(byval b as gsl_block_char ptr, byval offset as const uinteger, byval n as const uinteger, byval stride as const uinteger) as gsl_vector_char ptr
declare function gsl_vector_char_alloc_from_vector(byval v as gsl_vector_char ptr, byval offset as const uinteger, byval n as const uinteger, byval stride as const uinteger) as gsl_vector_char ptr
declare sub gsl_vector_char_free(byval v as gsl_vector_char ptr)
declare function gsl_vector_char_view_array(byval v as zstring ptr, byval n as uinteger) as _gsl_vector_char_view
declare function gsl_vector_char_view_array_with_stride(byval base as byte ptr, byval stride as uinteger, byval n as uinteger) as _gsl_vector_char_view
declare function gsl_vector_char_const_view_array(byval v as const zstring ptr, byval n as uinteger) as _gsl_vector_char_const_view
declare function gsl_vector_char_const_view_array_with_stride(byval base as const byte ptr, byval stride as uinteger, byval n as uinteger) as _gsl_vector_char_const_view
declare function gsl_vector_char_subvector(byval v as gsl_vector_char ptr, byval i as uinteger, byval n as uinteger) as _gsl_vector_char_view
declare function gsl_vector_char_subvector_with_stride(byval v as gsl_vector_char ptr, byval i as uinteger, byval stride as uinteger, byval n as uinteger) as _gsl_vector_char_view
declare function gsl_vector_char_const_subvector(byval v as const gsl_vector_char ptr, byval i as uinteger, byval n as uinteger) as _gsl_vector_char_const_view
declare function gsl_vector_char_const_subvector_with_stride(byval v as const gsl_vector_char ptr, byval i as uinteger, byval stride as uinteger, byval n as uinteger) as _gsl_vector_char_const_view
declare sub gsl_vector_char_set_zero(byval v as gsl_vector_char ptr)
declare sub gsl_vector_char_set_all(byval v as gsl_vector_char ptr, byval x as byte)
declare function gsl_vector_char_set_basis(byval v as gsl_vector_char ptr, byval i as uinteger) as long
declare function gsl_vector_char_fread(byval stream as FILE ptr, byval v as gsl_vector_char ptr) as long
declare function gsl_vector_char_fwrite(byval stream as FILE ptr, byval v as const gsl_vector_char ptr) as long
declare function gsl_vector_char_fscanf(byval stream as FILE ptr, byval v as gsl_vector_char ptr) as long
declare function gsl_vector_char_fprintf(byval stream as FILE ptr, byval v as const gsl_vector_char ptr, byval format as const zstring ptr) as long
declare function gsl_vector_char_memcpy(byval dest as gsl_vector_char ptr, byval src as const gsl_vector_char ptr) as long
declare function gsl_vector_char_reverse(byval v as gsl_vector_char ptr) as long
declare function gsl_vector_char_swap(byval v as gsl_vector_char ptr, byval w as gsl_vector_char ptr) as long
declare function gsl_vector_char_swap_elements(byval v as gsl_vector_char ptr, byval i as const uinteger, byval j as const uinteger) as long
declare function gsl_vector_char_max(byval v as const gsl_vector_char ptr) as byte
declare function gsl_vector_char_min(byval v as const gsl_vector_char ptr) as byte
declare sub gsl_vector_char_minmax(byval v as const gsl_vector_char ptr, byval min_out as byte ptr, byval max_out as byte ptr)
declare function gsl_vector_char_max_index(byval v as const gsl_vector_char ptr) as uinteger
declare function gsl_vector_char_min_index(byval v as const gsl_vector_char ptr) as uinteger
declare sub gsl_vector_char_minmax_index(byval v as const gsl_vector_char ptr, byval imin as uinteger ptr, byval imax as uinteger ptr)
declare function gsl_vector_char_add(byval a as gsl_vector_char ptr, byval b as const gsl_vector_char ptr) as long
declare function gsl_vector_char_sub(byval a as gsl_vector_char ptr, byval b as const gsl_vector_char ptr) as long
declare function gsl_vector_char_mul(byval a as gsl_vector_char ptr, byval b as const gsl_vector_char ptr) as long
declare function gsl_vector_char_div(byval a as gsl_vector_char ptr, byval b as const gsl_vector_char ptr) as long
declare function gsl_vector_char_scale(byval a as gsl_vector_char ptr, byval x as const double) as long
declare function gsl_vector_char_add_constant(byval a as gsl_vector_char ptr, byval x as const double) as long
declare function gsl_vector_char_equal(byval u as const gsl_vector_char ptr, byval v as const gsl_vector_char ptr) as long
declare function gsl_vector_char_isnull(byval v as const gsl_vector_char ptr) as long
declare function gsl_vector_char_ispos(byval v as const gsl_vector_char ptr) as long
declare function gsl_vector_char_isneg(byval v as const gsl_vector_char ptr) as long
declare function gsl_vector_char_isnonneg(byval v as const gsl_vector_char ptr) as long
declare function gsl_vector_char_get(byval v as const gsl_vector_char ptr, byval i as const uinteger) as byte
declare sub gsl_vector_char_set(byval v as gsl_vector_char ptr, byval i as const uinteger, byval x as byte)
declare function gsl_vector_char_ptr(byval v as gsl_vector_char ptr, byval i as const uinteger) as zstring ptr
declare function gsl_vector_char_const_ptr(byval v as const gsl_vector_char ptr, byval i as const uinteger) as const zstring ptr

end extern
