''
''
'' gsl_matrix_complex_double -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_matrix_complex_double_bi__
#define __gsl_matrix_complex_double_bi__

#include once "gsl_types.bi"
#include once "gsl_errno.bi"
#include once "gsl_complex.bi"
#include once "gsl_check_range.bi"
#include once "gsl_vector_complex_double.bi"

type gsl_matrix_complex
	size1 as integer
	size2 as integer
	tda as integer
	data as double ptr
	block as gsl_block_complex ptr
	owner as integer
end type

type _gsl_matrix_complex_view
	matrix as gsl_matrix_complex
end type

type gsl_matrix_complex_view as _gsl_matrix_complex_view

type _gsl_matrix_complex_const_view
	matrix as gsl_matrix_complex
end type

type gsl_matrix_complex_const_view as _gsl_matrix_complex_const_view

extern "c"
declare function gsl_matrix_complex_alloc (byval n1 as integer, byval n2 as integer) as gsl_matrix_complex ptr
declare function gsl_matrix_complex_calloc (byval n1 as integer, byval n2 as integer) as gsl_matrix_complex ptr
declare function gsl_matrix_complex_alloc_from_block (byval b as gsl_block_complex ptr, byval offset as integer, byval n1 as integer, byval n2 as integer, byval d2 as integer) as gsl_matrix_complex ptr
declare function gsl_matrix_complex_alloc_from_matrix (byval b as gsl_matrix_complex ptr, byval k1 as integer, byval k2 as integer, byval n1 as integer, byval n2 as integer) as gsl_matrix_complex ptr
declare function gsl_vector_complex_alloc_row_from_matrix (byval m as gsl_matrix_complex ptr, byval i as integer) as gsl_vector_complex ptr
declare function gsl_vector_complex_alloc_col_from_matrix (byval m as gsl_matrix_complex ptr, byval j as integer) as gsl_vector_complex ptr
declare sub gsl_matrix_complex_free (byval m as gsl_matrix_complex ptr)
declare function gsl_matrix_complex_submatrix (byval m as gsl_matrix_complex ptr, byval i as integer, byval j as integer, byval n1 as integer, byval n2 as integer) as _gsl_matrix_complex_view
declare function gsl_matrix_complex_row (byval m as gsl_matrix_complex ptr, byval i as integer) as _gsl_vector_complex_view
declare function gsl_matrix_complex_column (byval m as gsl_matrix_complex ptr, byval j as integer) as _gsl_vector_complex_view
declare function gsl_matrix_complex_diagonal (byval m as gsl_matrix_complex ptr) as _gsl_vector_complex_view
declare function gsl_matrix_complex_subdiagonal (byval m as gsl_matrix_complex ptr, byval k as integer) as _gsl_vector_complex_view
declare function gsl_matrix_complex_superdiagonal (byval m as gsl_matrix_complex ptr, byval k as integer) as _gsl_vector_complex_view
declare function gsl_matrix_complex_view_array (byval base as double ptr, byval n1 as integer, byval n2 as integer) as _gsl_matrix_complex_view
declare function gsl_matrix_complex_view_array_with_tda (byval base as double ptr, byval n1 as integer, byval n2 as integer, byval tda as integer) as _gsl_matrix_complex_view
declare function gsl_matrix_complex_view_vector (byval v as gsl_vector_complex ptr, byval n1 as integer, byval n2 as integer) as _gsl_matrix_complex_view
declare function gsl_matrix_complex_view_vector_with_tda (byval v as gsl_vector_complex ptr, byval n1 as integer, byval n2 as integer, byval tda as integer) as _gsl_matrix_complex_view
declare function gsl_matrix_complex_const_submatrix (byval m as gsl_matrix_complex ptr, byval i as integer, byval j as integer, byval n1 as integer, byval n2 as integer) as _gsl_matrix_complex_const_view
declare function gsl_matrix_complex_const_row (byval m as gsl_matrix_complex ptr, byval i as integer) as _gsl_vector_complex_const_view
declare function gsl_matrix_complex_const_column (byval m as gsl_matrix_complex ptr, byval j as integer) as _gsl_vector_complex_const_view
declare function gsl_matrix_complex_const_diagonal (byval m as gsl_matrix_complex ptr) as _gsl_vector_complex_const_view
declare function gsl_matrix_complex_const_subdiagonal (byval m as gsl_matrix_complex ptr, byval k as integer) as _gsl_vector_complex_const_view
declare function gsl_matrix_complex_const_superdiagonal (byval m as gsl_matrix_complex ptr, byval k as integer) as _gsl_vector_complex_const_view
declare function gsl_matrix_complex_const_view_array (byval base as double ptr, byval n1 as integer, byval n2 as integer) as _gsl_matrix_complex_const_view
declare function gsl_matrix_complex_const_view_array_with_tda (byval base as double ptr, byval n1 as integer, byval n2 as integer, byval tda as integer) as _gsl_matrix_complex_const_view
declare function gsl_matrix_complex_const_view_vector (byval v as gsl_vector_complex ptr, byval n1 as integer, byval n2 as integer) as _gsl_matrix_complex_const_view
declare function gsl_matrix_complex_const_view_vector_with_tda (byval v as gsl_vector_complex ptr, byval n1 as integer, byval n2 as integer, byval tda as integer) as _gsl_matrix_complex_const_view
declare function gsl_matrix_complex_get (byval m as gsl_matrix_complex ptr, byval i as integer, byval j as integer) as gsl_complex
declare sub gsl_matrix_complex_set (byval m as gsl_matrix_complex ptr, byval i as integer, byval j as integer, byval x as gsl_complex)
declare function gsl_matrix_complex_ptr (byval m as gsl_matrix_complex ptr, byval i as integer, byval j as integer) as gsl_complex ptr
declare function gsl_matrix_complex_const_ptr (byval m as gsl_matrix_complex ptr, byval i as integer, byval j as integer) as gsl_complex ptr
declare sub gsl_matrix_complex_set_zero (byval m as gsl_matrix_complex ptr)
declare sub gsl_matrix_complex_set_identity (byval m as gsl_matrix_complex ptr)
declare sub gsl_matrix_complex_set_all (byval m as gsl_matrix_complex ptr, byval x as gsl_complex)
declare function gsl_matrix_complex_fread (byval stream as FILE ptr, byval m as gsl_matrix_complex ptr) as integer
declare function gsl_matrix_complex_fwrite (byval stream as FILE ptr, byval m as gsl_matrix_complex ptr) as integer
declare function gsl_matrix_complex_fscanf (byval stream as FILE ptr, byval m as gsl_matrix_complex ptr) as integer
declare function gsl_matrix_complex_fprintf (byval stream as FILE ptr, byval m as gsl_matrix_complex ptr, byval format as zstring ptr) as integer
declare function gsl_matrix_complex_memcpy (byval dest as gsl_matrix_complex ptr, byval src as gsl_matrix_complex ptr) as integer
declare function gsl_matrix_complex_swap (byval m1 as gsl_matrix_complex ptr, byval m2 as gsl_matrix_complex ptr) as integer
declare function gsl_matrix_complex_swap_rows (byval m as gsl_matrix_complex ptr, byval i as integer, byval j as integer) as integer
declare function gsl_matrix_complex_swap_columns (byval m as gsl_matrix_complex ptr, byval i as integer, byval j as integer) as integer
declare function gsl_matrix_complex_swap_rowcol (byval m as gsl_matrix_complex ptr, byval i as integer, byval j as integer) as integer
declare function gsl_matrix_complex_transpose (byval m as gsl_matrix_complex ptr) as integer
declare function gsl_matrix_complex_transpose_memcpy (byval dest as gsl_matrix_complex ptr, byval src as gsl_matrix_complex ptr) as integer
declare function gsl_matrix_complex_isnull (byval m as gsl_matrix_complex ptr) as integer
declare function gsl_matrix_complex_add (byval a as gsl_matrix_complex ptr, byval b as gsl_matrix_complex ptr) as integer
declare function gsl_matrix_complex_sub (byval a as gsl_matrix_complex ptr, byval b as gsl_matrix_complex ptr) as integer
declare function gsl_matrix_complex_mul_elements (byval a as gsl_matrix_complex ptr, byval b as gsl_matrix_complex ptr) as integer
declare function gsl_matrix_complex_div_elements (byval a as gsl_matrix_complex ptr, byval b as gsl_matrix_complex ptr) as integer
declare function gsl_matrix_complex_scale (byval a as gsl_matrix_complex ptr, byval x as gsl_complex) as integer
declare function gsl_matrix_complex_add_constant (byval a as gsl_matrix_complex ptr, byval x as gsl_complex) as integer
declare function gsl_matrix_complex_add_diagonal (byval a as gsl_matrix_complex ptr, byval x as gsl_complex) as integer
declare function gsl_matrix_complex_get_row (byval v as gsl_vector_complex ptr, byval m as gsl_matrix_complex ptr, byval i as integer) as integer
declare function gsl_matrix_complex_get_col (byval v as gsl_vector_complex ptr, byval m as gsl_matrix_complex ptr, byval j as integer) as integer
declare function gsl_matrix_complex_set_row (byval m as gsl_matrix_complex ptr, byval i as integer, byval v as gsl_vector_complex ptr) as integer
declare function gsl_matrix_complex_set_col (byval m as gsl_matrix_complex ptr, byval j as integer, byval v as gsl_vector_complex ptr) as integer
end extern

#endif
