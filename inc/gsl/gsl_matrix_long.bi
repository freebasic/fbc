'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
''   matrix/gsl_matrix_long.h
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

#include once "crt/long.bi"
#include once "crt/stdlib.bi"
#include once "gsl/gsl_types.bi"
#include once "gsl/gsl_errno.bi"
#include once "gsl/gsl_inline.bi"
#include once "gsl/gsl_check_range.bi"
#include once "gsl/gsl_vector_long.bi"

extern "C"

#define __GSL_MATRIX_LONG_H__

type gsl_matrix_long
	size1 as uinteger
	size2 as uinteger
	tda as uinteger
	data as clong ptr
	block as gsl_block_long ptr
	owner as long
end type

type _gsl_matrix_long_view
	matrix as gsl_matrix_long
end type

type gsl_matrix_long_view as _gsl_matrix_long_view

type _gsl_matrix_long_const_view
	matrix as gsl_matrix_long
end type

type gsl_matrix_long_const_view as const _gsl_matrix_long_const_view
declare function gsl_matrix_long_alloc(byval n1 as const uinteger, byval n2 as const uinteger) as gsl_matrix_long ptr
declare function gsl_matrix_long_calloc(byval n1 as const uinteger, byval n2 as const uinteger) as gsl_matrix_long ptr
declare function gsl_matrix_long_alloc_from_block(byval b as gsl_block_long ptr, byval offset as const uinteger, byval n1 as const uinteger, byval n2 as const uinteger, byval d2 as const uinteger) as gsl_matrix_long ptr
declare function gsl_matrix_long_alloc_from_matrix(byval m as gsl_matrix_long ptr, byval k1 as const uinteger, byval k2 as const uinteger, byval n1 as const uinteger, byval n2 as const uinteger) as gsl_matrix_long ptr
declare function gsl_vector_long_alloc_row_from_matrix(byval m as gsl_matrix_long ptr, byval i as const uinteger) as gsl_vector_long ptr
declare function gsl_vector_long_alloc_col_from_matrix(byval m as gsl_matrix_long ptr, byval j as const uinteger) as gsl_vector_long ptr
declare sub gsl_matrix_long_free(byval m as gsl_matrix_long ptr)
declare function gsl_matrix_long_submatrix(byval m as gsl_matrix_long ptr, byval i as const uinteger, byval j as const uinteger, byval n1 as const uinteger, byval n2 as const uinteger) as _gsl_matrix_long_view
declare function gsl_matrix_long_row(byval m as gsl_matrix_long ptr, byval i as const uinteger) as _gsl_vector_long_view
declare function gsl_matrix_long_column(byval m as gsl_matrix_long ptr, byval j as const uinteger) as _gsl_vector_long_view
declare function gsl_matrix_long_diagonal(byval m as gsl_matrix_long ptr) as _gsl_vector_long_view
declare function gsl_matrix_long_subdiagonal(byval m as gsl_matrix_long ptr, byval k as const uinteger) as _gsl_vector_long_view
declare function gsl_matrix_long_superdiagonal(byval m as gsl_matrix_long ptr, byval k as const uinteger) as _gsl_vector_long_view
declare function gsl_matrix_long_subrow(byval m as gsl_matrix_long ptr, byval i as const uinteger, byval offset as const uinteger, byval n as const uinteger) as _gsl_vector_long_view
declare function gsl_matrix_long_subcolumn(byval m as gsl_matrix_long ptr, byval j as const uinteger, byval offset as const uinteger, byval n as const uinteger) as _gsl_vector_long_view
declare function gsl_matrix_long_view_array(byval base as clong ptr, byval n1 as const uinteger, byval n2 as const uinteger) as _gsl_matrix_long_view
declare function gsl_matrix_long_view_array_with_tda(byval base as clong ptr, byval n1 as const uinteger, byval n2 as const uinteger, byval tda as const uinteger) as _gsl_matrix_long_view
declare function gsl_matrix_long_view_vector(byval v as gsl_vector_long ptr, byval n1 as const uinteger, byval n2 as const uinteger) as _gsl_matrix_long_view
declare function gsl_matrix_long_view_vector_with_tda(byval v as gsl_vector_long ptr, byval n1 as const uinteger, byval n2 as const uinteger, byval tda as const uinteger) as _gsl_matrix_long_view
declare function gsl_matrix_long_const_submatrix(byval m as const gsl_matrix_long ptr, byval i as const uinteger, byval j as const uinteger, byval n1 as const uinteger, byval n2 as const uinteger) as _gsl_matrix_long_const_view
declare function gsl_matrix_long_const_row(byval m as const gsl_matrix_long ptr, byval i as const uinteger) as _gsl_vector_long_const_view
declare function gsl_matrix_long_const_column(byval m as const gsl_matrix_long ptr, byval j as const uinteger) as _gsl_vector_long_const_view
declare function gsl_matrix_long_const_diagonal(byval m as const gsl_matrix_long ptr) as _gsl_vector_long_const_view
declare function gsl_matrix_long_const_subdiagonal(byval m as const gsl_matrix_long ptr, byval k as const uinteger) as _gsl_vector_long_const_view
declare function gsl_matrix_long_const_superdiagonal(byval m as const gsl_matrix_long ptr, byval k as const uinteger) as _gsl_vector_long_const_view
declare function gsl_matrix_long_const_subrow(byval m as const gsl_matrix_long ptr, byval i as const uinteger, byval offset as const uinteger, byval n as const uinteger) as _gsl_vector_long_const_view
declare function gsl_matrix_long_const_subcolumn(byval m as const gsl_matrix_long ptr, byval j as const uinteger, byval offset as const uinteger, byval n as const uinteger) as _gsl_vector_long_const_view
declare function gsl_matrix_long_const_view_array(byval base as const clong ptr, byval n1 as const uinteger, byval n2 as const uinteger) as _gsl_matrix_long_const_view
declare function gsl_matrix_long_const_view_array_with_tda(byval base as const clong ptr, byval n1 as const uinteger, byval n2 as const uinteger, byval tda as const uinteger) as _gsl_matrix_long_const_view
declare function gsl_matrix_long_const_view_vector(byval v as const gsl_vector_long ptr, byval n1 as const uinteger, byval n2 as const uinteger) as _gsl_matrix_long_const_view
declare function gsl_matrix_long_const_view_vector_with_tda(byval v as const gsl_vector_long ptr, byval n1 as const uinteger, byval n2 as const uinteger, byval tda as const uinteger) as _gsl_matrix_long_const_view
declare sub gsl_matrix_long_set_zero(byval m as gsl_matrix_long ptr)
declare sub gsl_matrix_long_set_identity(byval m as gsl_matrix_long ptr)
declare sub gsl_matrix_long_set_all(byval m as gsl_matrix_long ptr, byval x as clong)
declare function gsl_matrix_long_fread(byval stream as FILE ptr, byval m as gsl_matrix_long ptr) as long
declare function gsl_matrix_long_fwrite(byval stream as FILE ptr, byval m as const gsl_matrix_long ptr) as long
declare function gsl_matrix_long_fscanf(byval stream as FILE ptr, byval m as gsl_matrix_long ptr) as long
declare function gsl_matrix_long_fprintf(byval stream as FILE ptr, byval m as const gsl_matrix_long ptr, byval format as const zstring ptr) as long
declare function gsl_matrix_long_memcpy(byval dest as gsl_matrix_long ptr, byval src as const gsl_matrix_long ptr) as long
declare function gsl_matrix_long_swap(byval m1 as gsl_matrix_long ptr, byval m2 as gsl_matrix_long ptr) as long
declare function gsl_matrix_long_swap_rows(byval m as gsl_matrix_long ptr, byval i as const uinteger, byval j as const uinteger) as long
declare function gsl_matrix_long_swap_columns(byval m as gsl_matrix_long ptr, byval i as const uinteger, byval j as const uinteger) as long
declare function gsl_matrix_long_swap_rowcol(byval m as gsl_matrix_long ptr, byval i as const uinteger, byval j as const uinteger) as long
declare function gsl_matrix_long_transpose(byval m as gsl_matrix_long ptr) as long
declare function gsl_matrix_long_transpose_memcpy(byval dest as gsl_matrix_long ptr, byval src as const gsl_matrix_long ptr) as long
declare function gsl_matrix_long_max(byval m as const gsl_matrix_long ptr) as clong
declare function gsl_matrix_long_min(byval m as const gsl_matrix_long ptr) as clong
declare sub gsl_matrix_long_minmax(byval m as const gsl_matrix_long ptr, byval min_out as clong ptr, byval max_out as clong ptr)
declare sub gsl_matrix_long_max_index(byval m as const gsl_matrix_long ptr, byval imax as uinteger ptr, byval jmax as uinteger ptr)
declare sub gsl_matrix_long_min_index(byval m as const gsl_matrix_long ptr, byval imin as uinteger ptr, byval jmin as uinteger ptr)
declare sub gsl_matrix_long_minmax_index(byval m as const gsl_matrix_long ptr, byval imin as uinteger ptr, byval jmin as uinteger ptr, byval imax as uinteger ptr, byval jmax as uinteger ptr)
declare function gsl_matrix_long_equal(byval a as const gsl_matrix_long ptr, byval b as const gsl_matrix_long ptr) as long
declare function gsl_matrix_long_isnull(byval m as const gsl_matrix_long ptr) as long
declare function gsl_matrix_long_ispos(byval m as const gsl_matrix_long ptr) as long
declare function gsl_matrix_long_isneg(byval m as const gsl_matrix_long ptr) as long
declare function gsl_matrix_long_isnonneg(byval m as const gsl_matrix_long ptr) as long
declare function gsl_matrix_long_add(byval a as gsl_matrix_long ptr, byval b as const gsl_matrix_long ptr) as long
declare function gsl_matrix_long_sub(byval a as gsl_matrix_long ptr, byval b as const gsl_matrix_long ptr) as long
declare function gsl_matrix_long_mul_elements(byval a as gsl_matrix_long ptr, byval b as const gsl_matrix_long ptr) as long
declare function gsl_matrix_long_div_elements(byval a as gsl_matrix_long ptr, byval b as const gsl_matrix_long ptr) as long
declare function gsl_matrix_long_scale(byval a as gsl_matrix_long ptr, byval x as const double) as long
declare function gsl_matrix_long_add_constant(byval a as gsl_matrix_long ptr, byval x as const double) as long
declare function gsl_matrix_long_add_diagonal(byval a as gsl_matrix_long ptr, byval x as const double) as long
declare function gsl_matrix_long_get_row(byval v as gsl_vector_long ptr, byval m as const gsl_matrix_long ptr, byval i as const uinteger) as long
declare function gsl_matrix_long_get_col(byval v as gsl_vector_long ptr, byval m as const gsl_matrix_long ptr, byval j as const uinteger) as long
declare function gsl_matrix_long_set_row(byval m as gsl_matrix_long ptr, byval i as const uinteger, byval v as const gsl_vector_long ptr) as long
declare function gsl_matrix_long_set_col(byval m as gsl_matrix_long ptr, byval j as const uinteger, byval v as const gsl_vector_long ptr) as long
declare function gsl_matrix_long_get(byval m as const gsl_matrix_long ptr, byval i as const uinteger, byval j as const uinteger) as clong
declare sub gsl_matrix_long_set(byval m as gsl_matrix_long ptr, byval i as const uinteger, byval j as const uinteger, byval x as const clong)
declare function gsl_matrix_long_ptr(byval m as gsl_matrix_long ptr, byval i as const uinteger, byval j as const uinteger) as clong ptr
declare function gsl_matrix_long_const_ptr(byval m as const gsl_matrix_long ptr, byval i as const uinteger, byval j as const uinteger) as const clong ptr

end extern
