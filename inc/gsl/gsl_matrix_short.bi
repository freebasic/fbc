'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
''   matrix/gsl_matrix_short.h
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
#include once "gsl/gsl_vector_short.bi"

extern "C"

#define __GSL_MATRIX_SHORT_H__

type gsl_matrix_short
	size1 as uinteger
	size2 as uinteger
	tda as uinteger
	data as short ptr
	block as gsl_block_short ptr
	owner as long
end type

type _gsl_matrix_short_view
	matrix as gsl_matrix_short
end type

type gsl_matrix_short_view as _gsl_matrix_short_view

type _gsl_matrix_short_const_view
	matrix as gsl_matrix_short
end type

type gsl_matrix_short_const_view as const _gsl_matrix_short_const_view
declare function gsl_matrix_short_alloc(byval n1 as const uinteger, byval n2 as const uinteger) as gsl_matrix_short ptr
declare function gsl_matrix_short_calloc(byval n1 as const uinteger, byval n2 as const uinteger) as gsl_matrix_short ptr
declare function gsl_matrix_short_alloc_from_block(byval b as gsl_block_short ptr, byval offset as const uinteger, byval n1 as const uinteger, byval n2 as const uinteger, byval d2 as const uinteger) as gsl_matrix_short ptr
declare function gsl_matrix_short_alloc_from_matrix(byval m as gsl_matrix_short ptr, byval k1 as const uinteger, byval k2 as const uinteger, byval n1 as const uinteger, byval n2 as const uinteger) as gsl_matrix_short ptr
declare function gsl_vector_short_alloc_row_from_matrix(byval m as gsl_matrix_short ptr, byval i as const uinteger) as gsl_vector_short ptr
declare function gsl_vector_short_alloc_col_from_matrix(byval m as gsl_matrix_short ptr, byval j as const uinteger) as gsl_vector_short ptr
declare sub gsl_matrix_short_free(byval m as gsl_matrix_short ptr)
declare function gsl_matrix_short_submatrix(byval m as gsl_matrix_short ptr, byval i as const uinteger, byval j as const uinteger, byval n1 as const uinteger, byval n2 as const uinteger) as _gsl_matrix_short_view
declare function gsl_matrix_short_row(byval m as gsl_matrix_short ptr, byval i as const uinteger) as _gsl_vector_short_view
declare function gsl_matrix_short_column(byval m as gsl_matrix_short ptr, byval j as const uinteger) as _gsl_vector_short_view
declare function gsl_matrix_short_diagonal(byval m as gsl_matrix_short ptr) as _gsl_vector_short_view
declare function gsl_matrix_short_subdiagonal(byval m as gsl_matrix_short ptr, byval k as const uinteger) as _gsl_vector_short_view
declare function gsl_matrix_short_superdiagonal(byval m as gsl_matrix_short ptr, byval k as const uinteger) as _gsl_vector_short_view
declare function gsl_matrix_short_subrow(byval m as gsl_matrix_short ptr, byval i as const uinteger, byval offset as const uinteger, byval n as const uinteger) as _gsl_vector_short_view
declare function gsl_matrix_short_subcolumn(byval m as gsl_matrix_short ptr, byval j as const uinteger, byval offset as const uinteger, byval n as const uinteger) as _gsl_vector_short_view
declare function gsl_matrix_short_view_array(byval base as short ptr, byval n1 as const uinteger, byval n2 as const uinteger) as _gsl_matrix_short_view
declare function gsl_matrix_short_view_array_with_tda(byval base as short ptr, byval n1 as const uinteger, byval n2 as const uinteger, byval tda as const uinteger) as _gsl_matrix_short_view
declare function gsl_matrix_short_view_vector(byval v as gsl_vector_short ptr, byval n1 as const uinteger, byval n2 as const uinteger) as _gsl_matrix_short_view
declare function gsl_matrix_short_view_vector_with_tda(byval v as gsl_vector_short ptr, byval n1 as const uinteger, byval n2 as const uinteger, byval tda as const uinteger) as _gsl_matrix_short_view
declare function gsl_matrix_short_const_submatrix(byval m as const gsl_matrix_short ptr, byval i as const uinteger, byval j as const uinteger, byval n1 as const uinteger, byval n2 as const uinteger) as _gsl_matrix_short_const_view
declare function gsl_matrix_short_const_row(byval m as const gsl_matrix_short ptr, byval i as const uinteger) as _gsl_vector_short_const_view
declare function gsl_matrix_short_const_column(byval m as const gsl_matrix_short ptr, byval j as const uinteger) as _gsl_vector_short_const_view
declare function gsl_matrix_short_const_diagonal(byval m as const gsl_matrix_short ptr) as _gsl_vector_short_const_view
declare function gsl_matrix_short_const_subdiagonal(byval m as const gsl_matrix_short ptr, byval k as const uinteger) as _gsl_vector_short_const_view
declare function gsl_matrix_short_const_superdiagonal(byval m as const gsl_matrix_short ptr, byval k as const uinteger) as _gsl_vector_short_const_view
declare function gsl_matrix_short_const_subrow(byval m as const gsl_matrix_short ptr, byval i as const uinteger, byval offset as const uinteger, byval n as const uinteger) as _gsl_vector_short_const_view
declare function gsl_matrix_short_const_subcolumn(byval m as const gsl_matrix_short ptr, byval j as const uinteger, byval offset as const uinteger, byval n as const uinteger) as _gsl_vector_short_const_view
declare function gsl_matrix_short_const_view_array(byval base as const short ptr, byval n1 as const uinteger, byval n2 as const uinteger) as _gsl_matrix_short_const_view
declare function gsl_matrix_short_const_view_array_with_tda(byval base as const short ptr, byval n1 as const uinteger, byval n2 as const uinteger, byval tda as const uinteger) as _gsl_matrix_short_const_view
declare function gsl_matrix_short_const_view_vector(byval v as const gsl_vector_short ptr, byval n1 as const uinteger, byval n2 as const uinteger) as _gsl_matrix_short_const_view
declare function gsl_matrix_short_const_view_vector_with_tda(byval v as const gsl_vector_short ptr, byval n1 as const uinteger, byval n2 as const uinteger, byval tda as const uinteger) as _gsl_matrix_short_const_view
declare sub gsl_matrix_short_set_zero(byval m as gsl_matrix_short ptr)
declare sub gsl_matrix_short_set_identity(byval m as gsl_matrix_short ptr)
declare sub gsl_matrix_short_set_all(byval m as gsl_matrix_short ptr, byval x as short)
declare function gsl_matrix_short_fread(byval stream as FILE ptr, byval m as gsl_matrix_short ptr) as long
declare function gsl_matrix_short_fwrite(byval stream as FILE ptr, byval m as const gsl_matrix_short ptr) as long
declare function gsl_matrix_short_fscanf(byval stream as FILE ptr, byval m as gsl_matrix_short ptr) as long
declare function gsl_matrix_short_fprintf(byval stream as FILE ptr, byval m as const gsl_matrix_short ptr, byval format as const zstring ptr) as long
declare function gsl_matrix_short_memcpy(byval dest as gsl_matrix_short ptr, byval src as const gsl_matrix_short ptr) as long
declare function gsl_matrix_short_swap(byval m1 as gsl_matrix_short ptr, byval m2 as gsl_matrix_short ptr) as long
declare function gsl_matrix_short_swap_rows(byval m as gsl_matrix_short ptr, byval i as const uinteger, byval j as const uinteger) as long
declare function gsl_matrix_short_swap_columns(byval m as gsl_matrix_short ptr, byval i as const uinteger, byval j as const uinteger) as long
declare function gsl_matrix_short_swap_rowcol(byval m as gsl_matrix_short ptr, byval i as const uinteger, byval j as const uinteger) as long
declare function gsl_matrix_short_transpose(byval m as gsl_matrix_short ptr) as long
declare function gsl_matrix_short_transpose_memcpy(byval dest as gsl_matrix_short ptr, byval src as const gsl_matrix_short ptr) as long
declare function gsl_matrix_short_max(byval m as const gsl_matrix_short ptr) as short
declare function gsl_matrix_short_min(byval m as const gsl_matrix_short ptr) as short
declare sub gsl_matrix_short_minmax(byval m as const gsl_matrix_short ptr, byval min_out as short ptr, byval max_out as short ptr)
declare sub gsl_matrix_short_max_index(byval m as const gsl_matrix_short ptr, byval imax as uinteger ptr, byval jmax as uinteger ptr)
declare sub gsl_matrix_short_min_index(byval m as const gsl_matrix_short ptr, byval imin as uinteger ptr, byval jmin as uinteger ptr)
declare sub gsl_matrix_short_minmax_index(byval m as const gsl_matrix_short ptr, byval imin as uinteger ptr, byval jmin as uinteger ptr, byval imax as uinteger ptr, byval jmax as uinteger ptr)
declare function gsl_matrix_short_equal(byval a as const gsl_matrix_short ptr, byval b as const gsl_matrix_short ptr) as long
declare function gsl_matrix_short_isnull(byval m as const gsl_matrix_short ptr) as long
declare function gsl_matrix_short_ispos(byval m as const gsl_matrix_short ptr) as long
declare function gsl_matrix_short_isneg(byval m as const gsl_matrix_short ptr) as long
declare function gsl_matrix_short_isnonneg(byval m as const gsl_matrix_short ptr) as long
declare function gsl_matrix_short_add(byval a as gsl_matrix_short ptr, byval b as const gsl_matrix_short ptr) as long
declare function gsl_matrix_short_sub(byval a as gsl_matrix_short ptr, byval b as const gsl_matrix_short ptr) as long
declare function gsl_matrix_short_mul_elements(byval a as gsl_matrix_short ptr, byval b as const gsl_matrix_short ptr) as long
declare function gsl_matrix_short_div_elements(byval a as gsl_matrix_short ptr, byval b as const gsl_matrix_short ptr) as long
declare function gsl_matrix_short_scale(byval a as gsl_matrix_short ptr, byval x as const double) as long
declare function gsl_matrix_short_add_constant(byval a as gsl_matrix_short ptr, byval x as const double) as long
declare function gsl_matrix_short_add_diagonal(byval a as gsl_matrix_short ptr, byval x as const double) as long
declare function gsl_matrix_short_get_row(byval v as gsl_vector_short ptr, byval m as const gsl_matrix_short ptr, byval i as const uinteger) as long
declare function gsl_matrix_short_get_col(byval v as gsl_vector_short ptr, byval m as const gsl_matrix_short ptr, byval j as const uinteger) as long
declare function gsl_matrix_short_set_row(byval m as gsl_matrix_short ptr, byval i as const uinteger, byval v as const gsl_vector_short ptr) as long
declare function gsl_matrix_short_set_col(byval m as gsl_matrix_short ptr, byval j as const uinteger, byval v as const gsl_vector_short ptr) as long
declare function gsl_matrix_short_get(byval m as const gsl_matrix_short ptr, byval i as const uinteger, byval j as const uinteger) as short
declare sub gsl_matrix_short_set(byval m as gsl_matrix_short ptr, byval i as const uinteger, byval j as const uinteger, byval x as const short)
declare function gsl_matrix_short_ptr(byval m as gsl_matrix_short ptr, byval i as const uinteger, byval j as const uinteger) as short ptr
declare function gsl_matrix_short_const_ptr(byval m as const gsl_matrix_short ptr, byval i as const uinteger, byval j as const uinteger) as const short ptr

end extern
