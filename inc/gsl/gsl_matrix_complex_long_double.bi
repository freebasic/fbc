'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
''   matrix/gsl_matrix_complex_long_double.h
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

#include once "crt/longdouble.bi"
#include once "crt/stdlib.bi"
#include once "gsl/gsl_types.bi"
#include once "gsl/gsl_errno.bi"
#include once "gsl/gsl_complex.bi"
#include once "gsl/gsl_check_range.bi"
#include once "gsl/gsl_vector_complex_long_double.bi"

extern "C"

#define __GSL_MATRIX_COMPLEX_LONG_DOUBLE_H__

type gsl_matrix_complex_long_double
	size1 as uinteger
	size2 as uinteger
	tda as uinteger
	data as clongdouble ptr
	block as gsl_block_complex_long_double ptr
	owner as long
end type

type _gsl_matrix_complex_long_double_view
	matrix as gsl_matrix_complex_long_double
end type

type gsl_matrix_complex_long_double_view as _gsl_matrix_complex_long_double_view

type _gsl_matrix_complex_long_double_const_view
	matrix as gsl_matrix_complex_long_double
end type

type gsl_matrix_complex_long_double_const_view as const _gsl_matrix_complex_long_double_const_view
declare function gsl_matrix_complex_long_double_alloc(byval n1 as const uinteger, byval n2 as const uinteger) as gsl_matrix_complex_long_double ptr
declare function gsl_matrix_complex_long_double_calloc(byval n1 as const uinteger, byval n2 as const uinteger) as gsl_matrix_complex_long_double ptr
declare function gsl_matrix_complex_long_double_alloc_from_block(byval b as gsl_block_complex_long_double ptr, byval offset as const uinteger, byval n1 as const uinteger, byval n2 as const uinteger, byval d2 as const uinteger) as gsl_matrix_complex_long_double ptr
declare function gsl_matrix_complex_long_double_alloc_from_matrix(byval b as gsl_matrix_complex_long_double ptr, byval k1 as const uinteger, byval k2 as const uinteger, byval n1 as const uinteger, byval n2 as const uinteger) as gsl_matrix_complex_long_double ptr
declare function gsl_vector_complex_long_double_alloc_row_from_matrix(byval m as gsl_matrix_complex_long_double ptr, byval i as const uinteger) as gsl_vector_complex_long_double ptr
declare function gsl_vector_complex_long_double_alloc_col_from_matrix(byval m as gsl_matrix_complex_long_double ptr, byval j as const uinteger) as gsl_vector_complex_long_double ptr
declare sub gsl_matrix_complex_long_double_free(byval m as gsl_matrix_complex_long_double ptr)
declare function gsl_matrix_complex_long_double_submatrix(byval m as gsl_matrix_complex_long_double ptr, byval i as const uinteger, byval j as const uinteger, byval n1 as const uinteger, byval n2 as const uinteger) as _gsl_matrix_complex_long_double_view
declare function gsl_matrix_complex_long_double_row(byval m as gsl_matrix_complex_long_double ptr, byval i as const uinteger) as _gsl_vector_complex_long_double_view
declare function gsl_matrix_complex_long_double_column(byval m as gsl_matrix_complex_long_double ptr, byval j as const uinteger) as _gsl_vector_complex_long_double_view
declare function gsl_matrix_complex_long_double_diagonal(byval m as gsl_matrix_complex_long_double ptr) as _gsl_vector_complex_long_double_view
declare function gsl_matrix_complex_long_double_subdiagonal(byval m as gsl_matrix_complex_long_double ptr, byval k as const uinteger) as _gsl_vector_complex_long_double_view
declare function gsl_matrix_complex_long_double_superdiagonal(byval m as gsl_matrix_complex_long_double ptr, byval k as const uinteger) as _gsl_vector_complex_long_double_view
declare function gsl_matrix_complex_long_double_subrow(byval m as gsl_matrix_complex_long_double ptr, byval i as const uinteger, byval offset as const uinteger, byval n as const uinteger) as _gsl_vector_complex_long_double_view
declare function gsl_matrix_complex_long_double_subcolumn(byval m as gsl_matrix_complex_long_double ptr, byval j as const uinteger, byval offset as const uinteger, byval n as const uinteger) as _gsl_vector_complex_long_double_view
declare function gsl_matrix_complex_long_double_view_array(byval base as clongdouble ptr, byval n1 as const uinteger, byval n2 as const uinteger) as _gsl_matrix_complex_long_double_view
declare function gsl_matrix_complex_long_double_view_array_with_tda(byval base as clongdouble ptr, byval n1 as const uinteger, byval n2 as const uinteger, byval tda as const uinteger) as _gsl_matrix_complex_long_double_view
declare function gsl_matrix_complex_long_double_view_vector(byval v as gsl_vector_complex_long_double ptr, byval n1 as const uinteger, byval n2 as const uinteger) as _gsl_matrix_complex_long_double_view
declare function gsl_matrix_complex_long_double_view_vector_with_tda(byval v as gsl_vector_complex_long_double ptr, byval n1 as const uinteger, byval n2 as const uinteger, byval tda as const uinteger) as _gsl_matrix_complex_long_double_view
declare function gsl_matrix_complex_long_double_const_submatrix(byval m as const gsl_matrix_complex_long_double ptr, byval i as const uinteger, byval j as const uinteger, byval n1 as const uinteger, byval n2 as const uinteger) as _gsl_matrix_complex_long_double_const_view
declare function gsl_matrix_complex_long_double_const_row(byval m as const gsl_matrix_complex_long_double ptr, byval i as const uinteger) as _gsl_vector_complex_long_double_const_view
declare function gsl_matrix_complex_long_double_const_column(byval m as const gsl_matrix_complex_long_double ptr, byval j as const uinteger) as _gsl_vector_complex_long_double_const_view
declare function gsl_matrix_complex_long_double_const_diagonal(byval m as const gsl_matrix_complex_long_double ptr) as _gsl_vector_complex_long_double_const_view
declare function gsl_matrix_complex_long_double_const_subdiagonal(byval m as const gsl_matrix_complex_long_double ptr, byval k as const uinteger) as _gsl_vector_complex_long_double_const_view
declare function gsl_matrix_complex_long_double_const_superdiagonal(byval m as const gsl_matrix_complex_long_double ptr, byval k as const uinteger) as _gsl_vector_complex_long_double_const_view
declare function gsl_matrix_complex_long_double_const_subrow(byval m as const gsl_matrix_complex_long_double ptr, byval i as const uinteger, byval offset as const uinteger, byval n as const uinteger) as _gsl_vector_complex_long_double_const_view
declare function gsl_matrix_complex_long_double_const_subcolumn(byval m as const gsl_matrix_complex_long_double ptr, byval j as const uinteger, byval offset as const uinteger, byval n as const uinteger) as _gsl_vector_complex_long_double_const_view
declare function gsl_matrix_complex_long_double_const_view_array(byval base as const clongdouble ptr, byval n1 as const uinteger, byval n2 as const uinteger) as _gsl_matrix_complex_long_double_const_view
declare function gsl_matrix_complex_long_double_const_view_array_with_tda(byval base as const clongdouble ptr, byval n1 as const uinteger, byval n2 as const uinteger, byval tda as const uinteger) as _gsl_matrix_complex_long_double_const_view
declare function gsl_matrix_complex_long_double_const_view_vector(byval v as const gsl_vector_complex_long_double ptr, byval n1 as const uinteger, byval n2 as const uinteger) as _gsl_matrix_complex_long_double_const_view
declare function gsl_matrix_complex_long_double_const_view_vector_with_tda(byval v as const gsl_vector_complex_long_double ptr, byval n1 as const uinteger, byval n2 as const uinteger, byval tda as const uinteger) as _gsl_matrix_complex_long_double_const_view
declare sub gsl_matrix_complex_long_double_set_zero(byval m as gsl_matrix_complex_long_double ptr)
declare sub gsl_matrix_complex_long_double_set_identity(byval m as gsl_matrix_complex_long_double ptr)
declare sub gsl_matrix_complex_long_double_set_all(byval m as gsl_matrix_complex_long_double ptr, byval x as gsl_complex_long_double)
declare function gsl_matrix_complex_long_double_fread(byval stream as FILE ptr, byval m as gsl_matrix_complex_long_double ptr) as long
declare function gsl_matrix_complex_long_double_fwrite(byval stream as FILE ptr, byval m as const gsl_matrix_complex_long_double ptr) as long
declare function gsl_matrix_complex_long_double_fscanf(byval stream as FILE ptr, byval m as gsl_matrix_complex_long_double ptr) as long
declare function gsl_matrix_complex_long_double_fprintf(byval stream as FILE ptr, byval m as const gsl_matrix_complex_long_double ptr, byval format as const zstring ptr) as long
declare function gsl_matrix_complex_long_double_memcpy(byval dest as gsl_matrix_complex_long_double ptr, byval src as const gsl_matrix_complex_long_double ptr) as long
declare function gsl_matrix_complex_long_double_swap(byval m1 as gsl_matrix_complex_long_double ptr, byval m2 as gsl_matrix_complex_long_double ptr) as long
declare function gsl_matrix_complex_long_double_swap_rows(byval m as gsl_matrix_complex_long_double ptr, byval i as const uinteger, byval j as const uinteger) as long
declare function gsl_matrix_complex_long_double_swap_columns(byval m as gsl_matrix_complex_long_double ptr, byval i as const uinteger, byval j as const uinteger) as long
declare function gsl_matrix_complex_long_double_swap_rowcol(byval m as gsl_matrix_complex_long_double ptr, byval i as const uinteger, byval j as const uinteger) as long
declare function gsl_matrix_complex_long_double_transpose(byval m as gsl_matrix_complex_long_double ptr) as long
declare function gsl_matrix_complex_long_double_transpose_memcpy(byval dest as gsl_matrix_complex_long_double ptr, byval src as const gsl_matrix_complex_long_double ptr) as long
declare function gsl_matrix_complex_long_double_equal(byval a as const gsl_matrix_complex_long_double ptr, byval b as const gsl_matrix_complex_long_double ptr) as long
declare function gsl_matrix_complex_long_double_isnull(byval m as const gsl_matrix_complex_long_double ptr) as long
declare function gsl_matrix_complex_long_double_ispos(byval m as const gsl_matrix_complex_long_double ptr) as long
declare function gsl_matrix_complex_long_double_isneg(byval m as const gsl_matrix_complex_long_double ptr) as long
declare function gsl_matrix_complex_long_double_isnonneg(byval m as const gsl_matrix_complex_long_double ptr) as long
declare function gsl_matrix_complex_long_double_add(byval a as gsl_matrix_complex_long_double ptr, byval b as const gsl_matrix_complex_long_double ptr) as long
declare function gsl_matrix_complex_long_double_sub(byval a as gsl_matrix_complex_long_double ptr, byval b as const gsl_matrix_complex_long_double ptr) as long
declare function gsl_matrix_complex_long_double_mul_elements(byval a as gsl_matrix_complex_long_double ptr, byval b as const gsl_matrix_complex_long_double ptr) as long
declare function gsl_matrix_complex_long_double_div_elements(byval a as gsl_matrix_complex_long_double ptr, byval b as const gsl_matrix_complex_long_double ptr) as long
declare function gsl_matrix_complex_long_double_scale(byval a as gsl_matrix_complex_long_double ptr, byval x as const gsl_complex_long_double) as long
declare function gsl_matrix_complex_long_double_add_constant(byval a as gsl_matrix_complex_long_double ptr, byval x as const gsl_complex_long_double) as long
declare function gsl_matrix_complex_long_double_add_diagonal(byval a as gsl_matrix_complex_long_double ptr, byval x as const gsl_complex_long_double) as long
declare function gsl_matrix_complex_long_double_get_row(byval v as gsl_vector_complex_long_double ptr, byval m as const gsl_matrix_complex_long_double ptr, byval i as const uinteger) as long
declare function gsl_matrix_complex_long_double_get_col(byval v as gsl_vector_complex_long_double ptr, byval m as const gsl_matrix_complex_long_double ptr, byval j as const uinteger) as long
declare function gsl_matrix_complex_long_double_set_row(byval m as gsl_matrix_complex_long_double ptr, byval i as const uinteger, byval v as const gsl_vector_complex_long_double ptr) as long
declare function gsl_matrix_complex_long_double_set_col(byval m as gsl_matrix_complex_long_double ptr, byval j as const uinteger, byval v as const gsl_vector_complex_long_double ptr) as long
declare function gsl_matrix_complex_long_double_get(byval m as const gsl_matrix_complex_long_double ptr, byval i as const uinteger, byval j as const uinteger) as gsl_complex_long_double
declare sub gsl_matrix_complex_long_double_set(byval m as gsl_matrix_complex_long_double ptr, byval i as const uinteger, byval j as const uinteger, byval x as const gsl_complex_long_double)
declare function gsl_matrix_complex_long_double_ptr(byval m as gsl_matrix_complex_long_double ptr, byval i as const uinteger, byval j as const uinteger) as gsl_complex_long_double ptr
declare function gsl_matrix_complex_long_double_const_ptr(byval m as const gsl_matrix_complex_long_double ptr, byval i as const uinteger, byval j as const uinteger) as const gsl_complex_long_double ptr

end extern
