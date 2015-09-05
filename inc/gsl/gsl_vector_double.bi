'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
''   vector/gsl_vector_double.h
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
#include once "gsl/gsl_block_double.bi"

extern "C"

#define __GSL_VECTOR_DOUBLE_H__

type gsl_vector
	size as uinteger
	stride as uinteger
	data as double ptr
	block as gsl_block ptr
	owner as long
end type

type _gsl_vector_view
	vector as gsl_vector
end type

type gsl_vector_view as _gsl_vector_view

type _gsl_vector_const_view
	vector as gsl_vector
end type

type gsl_vector_const_view as const _gsl_vector_const_view
declare function gsl_vector_alloc(byval n as const uinteger) as gsl_vector ptr
declare function gsl_vector_calloc(byval n as const uinteger) as gsl_vector ptr
declare function gsl_vector_alloc_from_block(byval b as gsl_block ptr, byval offset as const uinteger, byval n as const uinteger, byval stride as const uinteger) as gsl_vector ptr
declare function gsl_vector_alloc_from_vector(byval v as gsl_vector ptr, byval offset as const uinteger, byval n as const uinteger, byval stride as const uinteger) as gsl_vector ptr
declare sub gsl_vector_free(byval v as gsl_vector ptr)
declare function gsl_vector_view_array(byval v as double ptr, byval n as uinteger) as _gsl_vector_view
declare function gsl_vector_view_array_with_stride(byval base as double ptr, byval stride as uinteger, byval n as uinteger) as _gsl_vector_view
declare function gsl_vector_const_view_array(byval v as const double ptr, byval n as uinteger) as _gsl_vector_const_view
declare function gsl_vector_const_view_array_with_stride(byval base as const double ptr, byval stride as uinteger, byval n as uinteger) as _gsl_vector_const_view
declare function gsl_vector_subvector(byval v as gsl_vector ptr, byval i as uinteger, byval n as uinteger) as _gsl_vector_view
declare function gsl_vector_subvector_with_stride(byval v as gsl_vector ptr, byval i as uinteger, byval stride as uinteger, byval n as uinteger) as _gsl_vector_view
declare function gsl_vector_const_subvector(byval v as const gsl_vector ptr, byval i as uinteger, byval n as uinteger) as _gsl_vector_const_view
declare function gsl_vector_const_subvector_with_stride(byval v as const gsl_vector ptr, byval i as uinteger, byval stride as uinteger, byval n as uinteger) as _gsl_vector_const_view
declare sub gsl_vector_set_zero(byval v as gsl_vector ptr)
declare sub gsl_vector_set_all(byval v as gsl_vector ptr, byval x as double)
declare function gsl_vector_set_basis(byval v as gsl_vector ptr, byval i as uinteger) as long
declare function gsl_vector_fread(byval stream as FILE ptr, byval v as gsl_vector ptr) as long
declare function gsl_vector_fwrite(byval stream as FILE ptr, byval v as const gsl_vector ptr) as long
declare function gsl_vector_fscanf(byval stream as FILE ptr, byval v as gsl_vector ptr) as long
declare function gsl_vector_fprintf(byval stream as FILE ptr, byval v as const gsl_vector ptr, byval format as const zstring ptr) as long
declare function gsl_vector_memcpy(byval dest as gsl_vector ptr, byval src as const gsl_vector ptr) as long
declare function gsl_vector_reverse(byval v as gsl_vector ptr) as long
declare function gsl_vector_swap(byval v as gsl_vector ptr, byval w as gsl_vector ptr) as long
declare function gsl_vector_swap_elements(byval v as gsl_vector ptr, byval i as const uinteger, byval j as const uinteger) as long
declare function gsl_vector_max(byval v as const gsl_vector ptr) as double
declare function gsl_vector_min(byval v as const gsl_vector ptr) as double
declare sub gsl_vector_minmax(byval v as const gsl_vector ptr, byval min_out as double ptr, byval max_out as double ptr)
declare function gsl_vector_max_index(byval v as const gsl_vector ptr) as uinteger
declare function gsl_vector_min_index(byval v as const gsl_vector ptr) as uinteger
declare sub gsl_vector_minmax_index(byval v as const gsl_vector ptr, byval imin as uinteger ptr, byval imax as uinteger ptr)
declare function gsl_vector_add(byval a as gsl_vector ptr, byval b as const gsl_vector ptr) as long
declare function gsl_vector_sub(byval a as gsl_vector ptr, byval b as const gsl_vector ptr) as long
declare function gsl_vector_mul(byval a as gsl_vector ptr, byval b as const gsl_vector ptr) as long
declare function gsl_vector_div(byval a as gsl_vector ptr, byval b as const gsl_vector ptr) as long
declare function gsl_vector_scale(byval a as gsl_vector ptr, byval x as const double) as long
declare function gsl_vector_add_constant(byval a as gsl_vector ptr, byval x as const double) as long
declare function gsl_vector_equal(byval u as const gsl_vector ptr, byval v as const gsl_vector ptr) as long
declare function gsl_vector_isnull(byval v as const gsl_vector ptr) as long
declare function gsl_vector_ispos(byval v as const gsl_vector ptr) as long
declare function gsl_vector_isneg(byval v as const gsl_vector ptr) as long
declare function gsl_vector_isnonneg(byval v as const gsl_vector ptr) as long
declare function gsl_vector_get(byval v as const gsl_vector ptr, byval i as const uinteger) as double
declare sub gsl_vector_set(byval v as gsl_vector ptr, byval i as const uinteger, byval x as double)
declare function gsl_vector_ptr(byval v as gsl_vector ptr, byval i as const uinteger) as double ptr
declare function gsl_vector_const_ptr(byval v as const gsl_vector ptr, byval i as const uinteger) as const double ptr

end extern
