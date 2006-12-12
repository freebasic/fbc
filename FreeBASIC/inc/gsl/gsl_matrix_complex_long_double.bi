		''
''
'' gsl_matrix_complex_long_double -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_matrix_complex_long_double_bi__
#define __gsl_matrix_complex_long_double_bi__

#include once "gsl_types.bi"
#include once "gsl_errno.bi"
#include once "gsl_complex.bi"
#include once "gsl_check_range.bi"
#include once "gsl_vector_complex_long_double.bi"

type gsl_matrix_complex_long_double
	size1 as integer
	size2 as integer
	tda as integer
	data as double ptr
	block as gsl_block_complex_long_double ptr
	owner as integer
end type

type _gsl_matrix_complex_long_double_view
	matrix as gsl_matrix_complex_long_double
end type

type gsl_matrix_complex_long_double_view as _gsl_matrix_complex_long_double_view

type _gsl_matrix_complex_long_double_const_view
	matrix as gsl_matrix_complex_long_double
end type

type gsl_matrix_complex_long_double_const_view as _gsl_matrix_complex_long_double_const_view

extern "c"
declare function gsl_matrix_complex_long_double_alloc (byval n1 as integer, byval n2 as integer) as gsl_matrix_complex_long_double ptr
declare function gsl_matrix_complex_long_double_calloc (byval n1 as integer, byval n2 as integer) as gsl_matrix_complex_long_double ptr
declare function gsl_matrix_complex_long_double_alloc_from_block (byval b as gsl_block_complex_long_double ptr, byval offset as integer, byval n1 as integer, byval n2 as integer, byval d2 as integer) as gsl_matrix_complex_long_double ptr
declare function gsl_matrix_complex_long_double_alloc_from_matrix (byval b as gsl_matrix_complex_long_double ptr, byval k1 as integer, byval k2 as integer, byval n1 as integer, byval n2 as integer) as gsl_matrix_complex_long_double ptr
declare function gsl_vector_complex_long_double_alloc_row_from_matrix (byval m as gsl_matrix_complex_long_double ptr, byval i as integer) as gsl_vector_complex_long_double ptr
declare function gsl_vector_complex_long_double_alloc_col_from_matrix (byval m as gsl_matrix_complex_long_double ptr, byval j as integer) as gsl_vector_complex_long_double ptr
declare sub gsl_matrix_complex_long_double_free (byval m as gsl_matrix_complex_long_double ptr)
declare function gsl_matrix_complex_long_double_submatrix (byval m as gsl_matrix_complex_long_double ptr, byval i as integer, byval j as integer, byval n1 as integer, byval n2 as integer) as _gsl_matrix_complex_long_double_view
declare function gsl_matrix_complex_long_double_row (byval m as gsl_matrix_complex_long_double ptr, byval i as integer) as _gsl_vector_complex_long_double_view
declare function gsl_matrix_complex_long_double_column (byval m as gsl_matrix_complex_long_double ptr, byval j as integer) as _gsl_vector_complex_long_double_view
declare function gsl_matrix_complex_long_double_diagonal (byval m as gsl_matrix_complex_long_double ptr) as _gsl_vector_complex_long_double_view
declare function gsl_matrix_complex_long_double_subdiagonal (byval m as gsl_matrix_complex_long_double ptr, byval k as integer) as _gsl_vector_complex_long_double_view
declare function gsl_matrix_complex_long_double_superdiagonal (byval m as gsl_matrix_complex_long_double ptr, byval k as integer) as _gsl_vector_complex_long_double_view
declare function gsl_matrix_complex_long_double_view_array (byval base as double ptr, byval n1 as integer, byval n2 as integer) as _gsl_matrix_complex_long_double_view
declare function gsl_matrix_complex_long_double_view_array_with_tda (byval base as double ptr, byval n1 as integer, byval n2 as integer, byval tda as integer) as _gsl_matrix_complex_long_double_view
declare function gsl_matrix_complex_long_double_view_vector (byval v as gsl_vector_complex_long_double ptr, byval n1 as integer, byval n2 as integer) as _gsl_matrix_complex_long_double_view
declare function gsl_matrix_complex_long_double_view_vector_with_tda (byval v as gsl_vector_complex_long_double ptr, byval n1 as integer, byval n2 as integer, byval tda as integer) as _gsl_matrix_complex_long_double_view
declare function gsl_matrix_complex_long_double_const_submatrix (byval m as gsl_matrix_complex_long_double ptr, byval i as integer, byval j as integer, byval n1 as integer, byval n2 as integer) as _gsl_matrix_complex_long_double_const_view
declare function gsl_matrix_complex_long_double_const_row (byval m as gsl_matrix_complex_long_double ptr, byval i as integer) as _gsl_vector_complex_long_double_const_view
declare function gsl_matrix_complex_long_double_const_column (byval m as gsl_matrix_complex_long_double ptr, byval j as integer) as _gsl_vector_complex_long_double_const_view
declare function gsl_matrix_complex_long_double_const_diagonal (byval m as gsl_matrix_complex_long_double ptr) as _gsl_vector_complex_long_double_const_view
declare function gsl_matrix_complex_long_double_const_subdiagonal (byval m as gsl_matrix_complex_long_double ptr, byval k as integer) as _gsl_vector_complex_long_double_const_view
declare function gsl_matrix_complex_long_double_const_superdiagonal (byval m as gsl_matrix_complex_long_double ptr, byval k as integer) as _gsl_vector_complex_long_double_const_view
declare function gsl_matrix_complex_long_double_const_view_array (byval base as double ptr, byval n1 as integer, byval n2 as integer) as _gsl_matrix_complex_long_double_const_view
declare function gsl_matrix_complex_long_double_const_view_array_with_tda (byval base as double ptr, byval n1 as integer, byval n2 as integer, byval tda as integer) as _gsl_matrix_complex_long_double_const_view
declare function gsl_matrix_complex_long_double_const_view_vector (byval v as gsl_vector_complex_long_double ptr, byval n1 as integer, byval n2 as integer) as _gsl_matrix_complex_long_double_const_view
declare function gsl_matrix_complex_long_double_const_view_vector_with_tda (byval v as gsl_vector_complex_long_double ptr, byval n1 as integer, byval n2 as integer, byval tda as integer) as _gsl_matrix_complex_long_double_const_view
declare function gsl_matrix_complex_long_double_get (byval m as gsl_matrix_complex_long_double ptr, byval i as integer, byval j as integer) as gsl_complex_long_double
declare sub gsl_matrix_complex_long_double_set (byval m as gsl_matrix_complex_long_double ptr, byval i as integer, byval j as integer, byval x as gsl_complex_long_double)
declare function gsl_matrix_complex_long_double_ptr (byval m as gsl_matrix_complex_long_double ptr, byval i as integer, byval j as integer) as gsl_complex_long_double ptr
declare function gsl_matrix_complex_long_double_const_ptr (byval m as gsl_matrix_complex_long_double ptr, byval i as integer, byval j as integer) as gsl_complex_long_double ptr
declare sub gsl_matrix_complex_long_double_set_zero (byval m as gsl_matrix_complex_long_double ptr)
declare sub gsl_matrix_complex_long_double_set_identity (byval m as gsl_matrix_complex_long_double ptr)
declare sub gsl_matrix_complex_long_double_set_all (byval m as gsl_matrix_complex_long_double ptr, byval x as gsl_complex_long_double)
declare function gsl_matrix_complex_long_double_fread (byval stream as FILE ptr, byval m as gsl_matrix_complex_long_double ptr) as integer
declare function gsl_matrix_complex_long_double_fwrite (byval stream as FILE ptr, byval m as gsl_matrix_complex_long_double ptr) as integer
declare function gsl_matrix_complex_long_double_fscanf (byval stream as FILE ptr, byval m as gsl_matrix_complex_long_double ptr) as integer
declare function gsl_matrix_complex_long_double_fprintf (byval stream as FILE ptr, byval m as gsl_matrix_complex_long_double ptr, byval format as zstring ptr) as integer
declare function gsl_matrix_complex_long_double_memcpy (byval dest as gsl_matrix_complex_long_double ptr, byval src as gsl_matrix_complex_long_double ptr) as integer
declare function gsl_matrix_complex_long_double_swap (byval m1 as gsl_matrix_complex_long_double ptr, byval m2 as gsl_matrix_complex_long_double ptr) as integer
declare function gsl_matrix_complex_long_double_swap_rows (byval m as gsl_matrix_complex_long_double ptr, byval i as integer, byval j as integer) as integer
declare function gsl_matrix_complex_long_double_swap_columns (byval m as gsl_matrix_complex_long_double ptr, byval i as integer, byval j as integer) as integer
declare function gsl_matrix_complex_long_double_swap_rowcol (byval m as gsl_matrix_complex_long_double ptr, byval i as integer, byval j as integer) as integer
declare function gsl_matrix_complex_long_double_transpose (byval m as gsl_matrix_complex_long_double ptr) as integer
declare function gsl_matrix_complex_long_double_transpose_memcpy (byval dest as gsl_matrix_complex_long_double ptr, byval src as gsl_matrix_complex_long_double ptr) as integer
declare function gsl_matrix_complex_long_double_isnull (byval m as gsl_matrix_complex_long_double ptr) as integer
declare function gsl_matrix_complex_long_double_add (byval a as gsl_matrix_complex_long_double ptr, byval b as gsl_matrix_complex_long_double ptr) as integer
declare function gsl_matrix_complex_long_double_sub (byval a as gsl_matrix_complex_long_double ptr, byval b as gsl_matrix_complex_long_double ptr) as integer
declare function gsl_matrix_complex_long_double_mul_elements (byval a as gsl_matrix_complex_long_double ptr, byval b as gsl_matrix_complex_long_double ptr) as integer
declare function gsl_matrix_complex_long_double_div_elements (byval a as gsl_matrix_complex_long_double ptr, byval b as gsl_matrix_complex_long_double ptr) as integer
declare function gsl_matrix_complex_long_double_scale (byval a as gsl_matrix_complex_long_double ptr, byval x as gsl_complex_long_double) as integer
declare function gsl_matrix_complex_long_double_add_constant (byval a as gsl_matrix_complex_long_double ptr, byval x as gsl_complex_long_double) as integer
declare function gsl_matrix_complex_long_double_add_diagonal (byval a as gsl_matrix_complex_long_double ptr, byval x as gsl_complex_long_double) as integer
declare function gsl_matrix_complex_long_double_get_row (byval v as gsl_vector_complex_long_double ptr, byval m as gsl_matrix_complex_long_double ptr, byval i as integer) as integer
declare function gsl_matrix_complex_long_double_get_col (byval v as gsl_vector_complex_long_double ptr, byval m as gsl_matrix_complex_long_double ptr, byval j as integer) as integer
declare function gsl_matrix_complex_long_double_set_row (byval m as gsl_matrix_complex_long_double ptr, byval i as integer, byval v as gsl_vector_complex_long_double ptr) as integer
declare function gsl_matrix_complex_long_double_set_col (byval m as gsl_matrix_complex_long_double ptr, byval j as integer, byval v as gsl_vector_complex_long_double ptr) as integer
end extern

#endif
