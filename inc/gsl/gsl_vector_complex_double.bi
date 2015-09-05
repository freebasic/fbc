'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
''   vector/gsl_vector_complex_double.h
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
#include once "gsl/gsl_vector_double.bi"
#include once "gsl/gsl_vector_complex.bi"
#include once "gsl/gsl_block_complex_double.bi"

extern "C"

#define __GSL_VECTOR_COMPLEX_DOUBLE_H__

type gsl_vector_complex
	size as uinteger
	stride as uinteger
	data as double ptr
	block as gsl_block_complex ptr
	owner as long
end type

type _gsl_vector_complex_view
	vector as gsl_vector_complex
end type

type gsl_vector_complex_view as _gsl_vector_complex_view

type _gsl_vector_complex_const_view
	vector as gsl_vector_complex
end type

type gsl_vector_complex_const_view as const _gsl_vector_complex_const_view
declare function gsl_vector_complex_alloc(byval n as const uinteger) as gsl_vector_complex ptr
declare function gsl_vector_complex_calloc(byval n as const uinteger) as gsl_vector_complex ptr
declare function gsl_vector_complex_alloc_from_block(byval b as gsl_block_complex ptr, byval offset as const uinteger, byval n as const uinteger, byval stride as const uinteger) as gsl_vector_complex ptr
declare function gsl_vector_complex_alloc_from_vector(byval v as gsl_vector_complex ptr, byval offset as const uinteger, byval n as const uinteger, byval stride as const uinteger) as gsl_vector_complex ptr
declare sub gsl_vector_complex_free(byval v as gsl_vector_complex ptr)
declare function gsl_vector_complex_view_array(byval base as double ptr, byval n as uinteger) as _gsl_vector_complex_view
declare function gsl_vector_complex_view_array_with_stride(byval base as double ptr, byval stride as uinteger, byval n as uinteger) as _gsl_vector_complex_view
declare function gsl_vector_complex_const_view_array(byval base as const double ptr, byval n as uinteger) as _gsl_vector_complex_const_view
declare function gsl_vector_complex_const_view_array_with_stride(byval base as const double ptr, byval stride as uinteger, byval n as uinteger) as _gsl_vector_complex_const_view
declare function gsl_vector_complex_subvector(byval base as gsl_vector_complex ptr, byval i as uinteger, byval n as uinteger) as _gsl_vector_complex_view
declare function gsl_vector_complex_subvector_with_stride(byval v as gsl_vector_complex ptr, byval i as uinteger, byval stride as uinteger, byval n as uinteger) as _gsl_vector_complex_view
declare function gsl_vector_complex_const_subvector(byval base as const gsl_vector_complex ptr, byval i as uinteger, byval n as uinteger) as _gsl_vector_complex_const_view
declare function gsl_vector_complex_const_subvector_with_stride(byval v as const gsl_vector_complex ptr, byval i as uinteger, byval stride as uinteger, byval n as uinteger) as _gsl_vector_complex_const_view
declare function gsl_vector_complex_real(byval v as gsl_vector_complex ptr) as _gsl_vector_view
declare function gsl_vector_complex_imag(byval v as gsl_vector_complex ptr) as _gsl_vector_view
declare function gsl_vector_complex_const_real(byval v as const gsl_vector_complex ptr) as _gsl_vector_const_view
declare function gsl_vector_complex_const_imag(byval v as const gsl_vector_complex ptr) as _gsl_vector_const_view
declare sub gsl_vector_complex_set_zero(byval v as gsl_vector_complex ptr)
declare sub gsl_vector_complex_set_all(byval v as gsl_vector_complex ptr, byval z as gsl_complex)
declare function gsl_vector_complex_set_basis(byval v as gsl_vector_complex ptr, byval i as uinteger) as long
declare function gsl_vector_complex_fread(byval stream as FILE ptr, byval v as gsl_vector_complex ptr) as long
declare function gsl_vector_complex_fwrite(byval stream as FILE ptr, byval v as const gsl_vector_complex ptr) as long
declare function gsl_vector_complex_fscanf(byval stream as FILE ptr, byval v as gsl_vector_complex ptr) as long
declare function gsl_vector_complex_fprintf(byval stream as FILE ptr, byval v as const gsl_vector_complex ptr, byval format as const zstring ptr) as long
declare function gsl_vector_complex_memcpy(byval dest as gsl_vector_complex ptr, byval src as const gsl_vector_complex ptr) as long
declare function gsl_vector_complex_reverse(byval v as gsl_vector_complex ptr) as long
declare function gsl_vector_complex_swap(byval v as gsl_vector_complex ptr, byval w as gsl_vector_complex ptr) as long
declare function gsl_vector_complex_swap_elements(byval v as gsl_vector_complex ptr, byval i as const uinteger, byval j as const uinteger) as long
declare function gsl_vector_complex_equal(byval u as const gsl_vector_complex ptr, byval v as const gsl_vector_complex ptr) as long
declare function gsl_vector_complex_isnull(byval v as const gsl_vector_complex ptr) as long
declare function gsl_vector_complex_ispos(byval v as const gsl_vector_complex ptr) as long
declare function gsl_vector_complex_isneg(byval v as const gsl_vector_complex ptr) as long
declare function gsl_vector_complex_isnonneg(byval v as const gsl_vector_complex ptr) as long
declare function gsl_vector_complex_add(byval a as gsl_vector_complex ptr, byval b as const gsl_vector_complex ptr) as long
declare function gsl_vector_complex_sub(byval a as gsl_vector_complex ptr, byval b as const gsl_vector_complex ptr) as long
declare function gsl_vector_complex_mul(byval a as gsl_vector_complex ptr, byval b as const gsl_vector_complex ptr) as long
declare function gsl_vector_complex_div(byval a as gsl_vector_complex ptr, byval b as const gsl_vector_complex ptr) as long
declare function gsl_vector_complex_scale(byval a as gsl_vector_complex ptr, byval x as const gsl_complex) as long
declare function gsl_vector_complex_add_constant(byval a as gsl_vector_complex ptr, byval x as const gsl_complex) as long
declare function gsl_vector_complex_get(byval v as const gsl_vector_complex ptr, byval i as const uinteger) as gsl_complex
declare sub gsl_vector_complex_set(byval v as gsl_vector_complex ptr, byval i as const uinteger, byval z as gsl_complex)
declare function gsl_vector_complex_ptr(byval v as gsl_vector_complex ptr, byval i as const uinteger) as gsl_complex ptr
declare function gsl_vector_complex_const_ptr(byval v as const gsl_vector_complex ptr, byval i as const uinteger) as const gsl_complex ptr

end extern
