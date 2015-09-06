'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
''   vector/gsl_vector_complex_float.h
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
#include once "gsl/gsl_complex.bi"
#include once "gsl/gsl_check_range.bi"
#include once "gsl/gsl_vector_float.bi"
#include once "gsl/gsl_vector_complex.bi"
#include once "gsl/gsl_block_complex_float.bi"

extern "C"

#define __GSL_VECTOR_COMPLEX_FLOAT_H__

type gsl_vector_complex_float
	size as uinteger
	stride as uinteger
	data as single ptr
	block as gsl_block_complex_float ptr
	owner as long
end type

type _gsl_vector_complex_float_view
	vector as gsl_vector_complex_float
end type

type gsl_vector_complex_float_view as _gsl_vector_complex_float_view

type _gsl_vector_complex_float_const_view
	vector as gsl_vector_complex_float
end type

type gsl_vector_complex_float_const_view as const _gsl_vector_complex_float_const_view
declare function gsl_vector_complex_float_alloc(byval n as const uinteger) as gsl_vector_complex_float ptr
declare function gsl_vector_complex_float_calloc(byval n as const uinteger) as gsl_vector_complex_float ptr
declare function gsl_vector_complex_float_alloc_from_block(byval b as gsl_block_complex_float ptr, byval offset as const uinteger, byval n as const uinteger, byval stride as const uinteger) as gsl_vector_complex_float ptr
declare function gsl_vector_complex_float_alloc_from_vector(byval v as gsl_vector_complex_float ptr, byval offset as const uinteger, byval n as const uinteger, byval stride as const uinteger) as gsl_vector_complex_float ptr
declare sub gsl_vector_complex_float_free(byval v as gsl_vector_complex_float ptr)
declare function gsl_vector_complex_float_view_array(byval base as single ptr, byval n as uinteger) as _gsl_vector_complex_float_view
declare function gsl_vector_complex_float_view_array_with_stride(byval base as single ptr, byval stride as uinteger, byval n as uinteger) as _gsl_vector_complex_float_view
declare function gsl_vector_complex_float_const_view_array(byval base as const single ptr, byval n as uinteger) as _gsl_vector_complex_float_const_view
declare function gsl_vector_complex_float_const_view_array_with_stride(byval base as const single ptr, byval stride as uinteger, byval n as uinteger) as _gsl_vector_complex_float_const_view
declare function gsl_vector_complex_float_subvector(byval base as gsl_vector_complex_float ptr, byval i as uinteger, byval n as uinteger) as _gsl_vector_complex_float_view
declare function gsl_vector_complex_float_subvector_with_stride(byval v as gsl_vector_complex_float ptr, byval i as uinteger, byval stride as uinteger, byval n as uinteger) as _gsl_vector_complex_float_view
declare function gsl_vector_complex_float_const_subvector(byval base as const gsl_vector_complex_float ptr, byval i as uinteger, byval n as uinteger) as _gsl_vector_complex_float_const_view
declare function gsl_vector_complex_float_const_subvector_with_stride(byval v as const gsl_vector_complex_float ptr, byval i as uinteger, byval stride as uinteger, byval n as uinteger) as _gsl_vector_complex_float_const_view
declare function gsl_vector_complex_float_real(byval v as gsl_vector_complex_float ptr) as _gsl_vector_float_view
declare function gsl_vector_complex_float_imag(byval v as gsl_vector_complex_float ptr) as _gsl_vector_float_view
declare function gsl_vector_complex_float_const_real(byval v as const gsl_vector_complex_float ptr) as _gsl_vector_float_const_view
declare function gsl_vector_complex_float_const_imag(byval v as const gsl_vector_complex_float ptr) as _gsl_vector_float_const_view
declare sub gsl_vector_complex_float_set_zero(byval v as gsl_vector_complex_float ptr)
declare sub gsl_vector_complex_float_set_all(byval v as gsl_vector_complex_float ptr, byval z as gsl_complex_float)
declare function gsl_vector_complex_float_set_basis(byval v as gsl_vector_complex_float ptr, byval i as uinteger) as long
declare function gsl_vector_complex_float_fread(byval stream as FILE ptr, byval v as gsl_vector_complex_float ptr) as long
declare function gsl_vector_complex_float_fwrite(byval stream as FILE ptr, byval v as const gsl_vector_complex_float ptr) as long
declare function gsl_vector_complex_float_fscanf(byval stream as FILE ptr, byval v as gsl_vector_complex_float ptr) as long
declare function gsl_vector_complex_float_fprintf(byval stream as FILE ptr, byval v as const gsl_vector_complex_float ptr, byval format as const zstring ptr) as long
declare function gsl_vector_complex_float_memcpy(byval dest as gsl_vector_complex_float ptr, byval src as const gsl_vector_complex_float ptr) as long
declare function gsl_vector_complex_float_reverse(byval v as gsl_vector_complex_float ptr) as long
declare function gsl_vector_complex_float_swap(byval v as gsl_vector_complex_float ptr, byval w as gsl_vector_complex_float ptr) as long
declare function gsl_vector_complex_float_swap_elements(byval v as gsl_vector_complex_float ptr, byval i as const uinteger, byval j as const uinteger) as long
declare function gsl_vector_complex_float_equal(byval u as const gsl_vector_complex_float ptr, byval v as const gsl_vector_complex_float ptr) as long
declare function gsl_vector_complex_float_isnull(byval v as const gsl_vector_complex_float ptr) as long
declare function gsl_vector_complex_float_ispos(byval v as const gsl_vector_complex_float ptr) as long
declare function gsl_vector_complex_float_isneg(byval v as const gsl_vector_complex_float ptr) as long
declare function gsl_vector_complex_float_isnonneg(byval v as const gsl_vector_complex_float ptr) as long
declare function gsl_vector_complex_float_add(byval a as gsl_vector_complex_float ptr, byval b as const gsl_vector_complex_float ptr) as long
declare function gsl_vector_complex_float_sub(byval a as gsl_vector_complex_float ptr, byval b as const gsl_vector_complex_float ptr) as long
declare function gsl_vector_complex_float_mul(byval a as gsl_vector_complex_float ptr, byval b as const gsl_vector_complex_float ptr) as long
declare function gsl_vector_complex_float_div(byval a as gsl_vector_complex_float ptr, byval b as const gsl_vector_complex_float ptr) as long
declare function gsl_vector_complex_float_scale(byval a as gsl_vector_complex_float ptr, byval x as const gsl_complex_float) as long
declare function gsl_vector_complex_float_add_constant(byval a as gsl_vector_complex_float ptr, byval x as const gsl_complex_float) as long
declare function gsl_vector_complex_float_get(byval v as const gsl_vector_complex_float ptr, byval i as const uinteger) as gsl_complex_float
declare sub gsl_vector_complex_float_set(byval v as gsl_vector_complex_float ptr, byval i as const uinteger, byval z as gsl_complex_float)
declare function gsl_vector_complex_float_ptr(byval v as gsl_vector_complex_float ptr, byval i as const uinteger) as gsl_complex_float ptr
declare function gsl_vector_complex_float_const_ptr(byval v as const gsl_vector_complex_float ptr, byval i as const uinteger) as const gsl_complex_float ptr

end extern
