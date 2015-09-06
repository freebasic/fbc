'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
''   matrix/gsl_matrix_uchar.h
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
#include once "gsl/gsl_vector_uchar.bi"

extern "C"

#define __GSL_MATRIX_UCHAR_H__

type gsl_matrix_uchar
	size1 as uinteger
	size2 as uinteger
	tda as uinteger
	data as ubyte ptr
	block as gsl_block_uchar ptr
	owner as long
end type

type _gsl_matrix_uchar_view
	matrix as gsl_matrix_uchar
end type

type gsl_matrix_uchar_view as _gsl_matrix_uchar_view

type _gsl_matrix_uchar_const_view
	matrix as gsl_matrix_uchar
end type

type gsl_matrix_uchar_const_view as const _gsl_matrix_uchar_const_view
declare function gsl_matrix_uchar_alloc(byval n1 as const uinteger, byval n2 as const uinteger) as gsl_matrix_uchar ptr
declare function gsl_matrix_uchar_calloc(byval n1 as const uinteger, byval n2 as const uinteger) as gsl_matrix_uchar ptr
declare function gsl_matrix_uchar_alloc_from_block(byval b as gsl_block_uchar ptr, byval offset as const uinteger, byval n1 as const uinteger, byval n2 as const uinteger, byval d2 as const uinteger) as gsl_matrix_uchar ptr
declare function gsl_matrix_uchar_alloc_from_matrix(byval m as gsl_matrix_uchar ptr, byval k1 as const uinteger, byval k2 as const uinteger, byval n1 as const uinteger, byval n2 as const uinteger) as gsl_matrix_uchar ptr
declare function gsl_vector_uchar_alloc_row_from_matrix(byval m as gsl_matrix_uchar ptr, byval i as const uinteger) as gsl_vector_uchar ptr
declare function gsl_vector_uchar_alloc_col_from_matrix(byval m as gsl_matrix_uchar ptr, byval j as const uinteger) as gsl_vector_uchar ptr
declare sub gsl_matrix_uchar_free(byval m as gsl_matrix_uchar ptr)
declare function gsl_matrix_uchar_submatrix(byval m as gsl_matrix_uchar ptr, byval i as const uinteger, byval j as const uinteger, byval n1 as const uinteger, byval n2 as const uinteger) as _gsl_matrix_uchar_view
declare function gsl_matrix_uchar_row(byval m as gsl_matrix_uchar ptr, byval i as const uinteger) as _gsl_vector_uchar_view
declare function gsl_matrix_uchar_column(byval m as gsl_matrix_uchar ptr, byval j as const uinteger) as _gsl_vector_uchar_view
declare function gsl_matrix_uchar_diagonal(byval m as gsl_matrix_uchar ptr) as _gsl_vector_uchar_view
declare function gsl_matrix_uchar_subdiagonal(byval m as gsl_matrix_uchar ptr, byval k as const uinteger) as _gsl_vector_uchar_view
declare function gsl_matrix_uchar_superdiagonal(byval m as gsl_matrix_uchar ptr, byval k as const uinteger) as _gsl_vector_uchar_view
declare function gsl_matrix_uchar_subrow(byval m as gsl_matrix_uchar ptr, byval i as const uinteger, byval offset as const uinteger, byval n as const uinteger) as _gsl_vector_uchar_view
declare function gsl_matrix_uchar_subcolumn(byval m as gsl_matrix_uchar ptr, byval j as const uinteger, byval offset as const uinteger, byval n as const uinteger) as _gsl_vector_uchar_view
declare function gsl_matrix_uchar_view_array(byval base as ubyte ptr, byval n1 as const uinteger, byval n2 as const uinteger) as _gsl_matrix_uchar_view
declare function gsl_matrix_uchar_view_array_with_tda(byval base as ubyte ptr, byval n1 as const uinteger, byval n2 as const uinteger, byval tda as const uinteger) as _gsl_matrix_uchar_view
declare function gsl_matrix_uchar_view_vector(byval v as gsl_vector_uchar ptr, byval n1 as const uinteger, byval n2 as const uinteger) as _gsl_matrix_uchar_view
declare function gsl_matrix_uchar_view_vector_with_tda(byval v as gsl_vector_uchar ptr, byval n1 as const uinteger, byval n2 as const uinteger, byval tda as const uinteger) as _gsl_matrix_uchar_view
declare function gsl_matrix_uchar_const_submatrix(byval m as const gsl_matrix_uchar ptr, byval i as const uinteger, byval j as const uinteger, byval n1 as const uinteger, byval n2 as const uinteger) as _gsl_matrix_uchar_const_view
declare function gsl_matrix_uchar_const_row(byval m as const gsl_matrix_uchar ptr, byval i as const uinteger) as _gsl_vector_uchar_const_view
declare function gsl_matrix_uchar_const_column(byval m as const gsl_matrix_uchar ptr, byval j as const uinteger) as _gsl_vector_uchar_const_view
declare function gsl_matrix_uchar_const_diagonal(byval m as const gsl_matrix_uchar ptr) as _gsl_vector_uchar_const_view
declare function gsl_matrix_uchar_const_subdiagonal(byval m as const gsl_matrix_uchar ptr, byval k as const uinteger) as _gsl_vector_uchar_const_view
declare function gsl_matrix_uchar_const_superdiagonal(byval m as const gsl_matrix_uchar ptr, byval k as const uinteger) as _gsl_vector_uchar_const_view
declare function gsl_matrix_uchar_const_subrow(byval m as const gsl_matrix_uchar ptr, byval i as const uinteger, byval offset as const uinteger, byval n as const uinteger) as _gsl_vector_uchar_const_view
declare function gsl_matrix_uchar_const_subcolumn(byval m as const gsl_matrix_uchar ptr, byval j as const uinteger, byval offset as const uinteger, byval n as const uinteger) as _gsl_vector_uchar_const_view
declare function gsl_matrix_uchar_const_view_array(byval base as const ubyte ptr, byval n1 as const uinteger, byval n2 as const uinteger) as _gsl_matrix_uchar_const_view
declare function gsl_matrix_uchar_const_view_array_with_tda(byval base as const ubyte ptr, byval n1 as const uinteger, byval n2 as const uinteger, byval tda as const uinteger) as _gsl_matrix_uchar_const_view
declare function gsl_matrix_uchar_const_view_vector(byval v as const gsl_vector_uchar ptr, byval n1 as const uinteger, byval n2 as const uinteger) as _gsl_matrix_uchar_const_view
declare function gsl_matrix_uchar_const_view_vector_with_tda(byval v as const gsl_vector_uchar ptr, byval n1 as const uinteger, byval n2 as const uinteger, byval tda as const uinteger) as _gsl_matrix_uchar_const_view
declare sub gsl_matrix_uchar_set_zero(byval m as gsl_matrix_uchar ptr)
declare sub gsl_matrix_uchar_set_identity(byval m as gsl_matrix_uchar ptr)
declare sub gsl_matrix_uchar_set_all(byval m as gsl_matrix_uchar ptr, byval x as ubyte)
declare function gsl_matrix_uchar_fread(byval stream as FILE ptr, byval m as gsl_matrix_uchar ptr) as long
declare function gsl_matrix_uchar_fwrite(byval stream as FILE ptr, byval m as const gsl_matrix_uchar ptr) as long
declare function gsl_matrix_uchar_fscanf(byval stream as FILE ptr, byval m as gsl_matrix_uchar ptr) as long
declare function gsl_matrix_uchar_fprintf(byval stream as FILE ptr, byval m as const gsl_matrix_uchar ptr, byval format as const zstring ptr) as long
declare function gsl_matrix_uchar_memcpy(byval dest as gsl_matrix_uchar ptr, byval src as const gsl_matrix_uchar ptr) as long
declare function gsl_matrix_uchar_swap(byval m1 as gsl_matrix_uchar ptr, byval m2 as gsl_matrix_uchar ptr) as long
declare function gsl_matrix_uchar_swap_rows(byval m as gsl_matrix_uchar ptr, byval i as const uinteger, byval j as const uinteger) as long
declare function gsl_matrix_uchar_swap_columns(byval m as gsl_matrix_uchar ptr, byval i as const uinteger, byval j as const uinteger) as long
declare function gsl_matrix_uchar_swap_rowcol(byval m as gsl_matrix_uchar ptr, byval i as const uinteger, byval j as const uinteger) as long
declare function gsl_matrix_uchar_transpose(byval m as gsl_matrix_uchar ptr) as long
declare function gsl_matrix_uchar_transpose_memcpy(byval dest as gsl_matrix_uchar ptr, byval src as const gsl_matrix_uchar ptr) as long
declare function gsl_matrix_uchar_max(byval m as const gsl_matrix_uchar ptr) as ubyte
declare function gsl_matrix_uchar_min(byval m as const gsl_matrix_uchar ptr) as ubyte
declare sub gsl_matrix_uchar_minmax(byval m as const gsl_matrix_uchar ptr, byval min_out as ubyte ptr, byval max_out as ubyte ptr)
declare sub gsl_matrix_uchar_max_index(byval m as const gsl_matrix_uchar ptr, byval imax as uinteger ptr, byval jmax as uinteger ptr)
declare sub gsl_matrix_uchar_min_index(byval m as const gsl_matrix_uchar ptr, byval imin as uinteger ptr, byval jmin as uinteger ptr)
declare sub gsl_matrix_uchar_minmax_index(byval m as const gsl_matrix_uchar ptr, byval imin as uinteger ptr, byval jmin as uinteger ptr, byval imax as uinteger ptr, byval jmax as uinteger ptr)
declare function gsl_matrix_uchar_equal(byval a as const gsl_matrix_uchar ptr, byval b as const gsl_matrix_uchar ptr) as long
declare function gsl_matrix_uchar_isnull(byval m as const gsl_matrix_uchar ptr) as long
declare function gsl_matrix_uchar_ispos(byval m as const gsl_matrix_uchar ptr) as long
declare function gsl_matrix_uchar_isneg(byval m as const gsl_matrix_uchar ptr) as long
declare function gsl_matrix_uchar_isnonneg(byval m as const gsl_matrix_uchar ptr) as long
declare function gsl_matrix_uchar_add(byval a as gsl_matrix_uchar ptr, byval b as const gsl_matrix_uchar ptr) as long
declare function gsl_matrix_uchar_sub(byval a as gsl_matrix_uchar ptr, byval b as const gsl_matrix_uchar ptr) as long
declare function gsl_matrix_uchar_mul_elements(byval a as gsl_matrix_uchar ptr, byval b as const gsl_matrix_uchar ptr) as long
declare function gsl_matrix_uchar_div_elements(byval a as gsl_matrix_uchar ptr, byval b as const gsl_matrix_uchar ptr) as long
declare function gsl_matrix_uchar_scale(byval a as gsl_matrix_uchar ptr, byval x as const double) as long
declare function gsl_matrix_uchar_add_constant(byval a as gsl_matrix_uchar ptr, byval x as const double) as long
declare function gsl_matrix_uchar_add_diagonal(byval a as gsl_matrix_uchar ptr, byval x as const double) as long
declare function gsl_matrix_uchar_get_row(byval v as gsl_vector_uchar ptr, byval m as const gsl_matrix_uchar ptr, byval i as const uinteger) as long
declare function gsl_matrix_uchar_get_col(byval v as gsl_vector_uchar ptr, byval m as const gsl_matrix_uchar ptr, byval j as const uinteger) as long
declare function gsl_matrix_uchar_set_row(byval m as gsl_matrix_uchar ptr, byval i as const uinteger, byval v as const gsl_vector_uchar ptr) as long
declare function gsl_matrix_uchar_set_col(byval m as gsl_matrix_uchar ptr, byval j as const uinteger, byval v as const gsl_vector_uchar ptr) as long
declare function gsl_matrix_uchar_get(byval m as const gsl_matrix_uchar ptr, byval i as const uinteger, byval j as const uinteger) as ubyte
declare sub gsl_matrix_uchar_set(byval m as gsl_matrix_uchar ptr, byval i as const uinteger, byval j as const uinteger, byval x as const ubyte)
declare function gsl_matrix_uchar_ptr(byval m as gsl_matrix_uchar ptr, byval i as const uinteger, byval j as const uinteger) as ubyte ptr
declare function gsl_matrix_uchar_const_ptr(byval m as const gsl_matrix_uchar ptr, byval i as const uinteger, byval j as const uinteger) as const ubyte ptr

end extern
