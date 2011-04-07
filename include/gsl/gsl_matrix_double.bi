''
''
'' gsl_matrix_double -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_matrix_double_bi__
#define __gsl_matrix_double_bi__

#include once "gsl_types.bi"
#include once "gsl_errno.bi"
#include once "gsl_check_range.bi"
#include once "gsl_vector_double.bi"

type gsl_matrix
	size1 as integer
	size2 as integer
	tda as integer
	data as double ptr
	block as gsl_block ptr
	owner as integer
end type

type _gsl_matrix_view
	matrix as gsl_matrix
end type

type gsl_matrix_view as _gsl_matrix_view

type _gsl_matrix_const_view
	matrix as gsl_matrix
end type

type gsl_matrix_const_view as _gsl_matrix_const_view

extern "c"
declare function gsl_matrix_alloc (byval n1 as integer, byval n2 as integer) as gsl_matrix ptr
declare function gsl_matrix_calloc (byval n1 as integer, byval n2 as integer) as gsl_matrix ptr
declare function gsl_matrix_alloc_from_block (byval b as gsl_block ptr, byval offset as integer, byval n1 as integer, byval n2 as integer, byval d2 as integer) as gsl_matrix ptr
declare function gsl_matrix_alloc_from_matrix (byval m as gsl_matrix ptr, byval k1 as integer, byval k2 as integer, byval n1 as integer, byval n2 as integer) as gsl_matrix ptr
declare function gsl_vector_alloc_row_from_matrix (byval m as gsl_matrix ptr, byval i as integer) as gsl_vector ptr
declare function gsl_vector_alloc_col_from_matrix (byval m as gsl_matrix ptr, byval j as integer) as gsl_vector ptr
declare sub gsl_matrix_free (byval m as gsl_matrix ptr)
declare function gsl_matrix_submatrix (byval m as gsl_matrix ptr, byval i as integer, byval j as integer, byval n1 as integer, byval n2 as integer) as _gsl_matrix_view
declare function gsl_matrix_row (byval m as gsl_matrix ptr, byval i as integer) as _gsl_vector_view
declare function gsl_matrix_column (byval m as gsl_matrix ptr, byval j as integer) as _gsl_vector_view
declare function gsl_matrix_diagonal (byval m as gsl_matrix ptr) as _gsl_vector_view
declare function gsl_matrix_subdiagonal (byval m as gsl_matrix ptr, byval k as integer) as _gsl_vector_view
declare function gsl_matrix_superdiagonal (byval m as gsl_matrix ptr, byval k as integer) as _gsl_vector_view
declare function gsl_matrix_view_array (byval base as double ptr, byval n1 as integer, byval n2 as integer) as _gsl_matrix_view
declare function gsl_matrix_view_array_with_tda (byval base as double ptr, byval n1 as integer, byval n2 as integer, byval tda as integer) as _gsl_matrix_view
declare function gsl_matrix_view_vector (byval v as gsl_vector ptr, byval n1 as integer, byval n2 as integer) as _gsl_matrix_view
declare function gsl_matrix_view_vector_with_tda (byval v as gsl_vector ptr, byval n1 as integer, byval n2 as integer, byval tda as integer) as _gsl_matrix_view
declare function gsl_matrix_const_submatrix (byval m as gsl_matrix ptr, byval i as integer, byval j as integer, byval n1 as integer, byval n2 as integer) as _gsl_matrix_const_view
declare function gsl_matrix_const_row (byval m as gsl_matrix ptr, byval i as integer) as _gsl_vector_const_view
declare function gsl_matrix_const_column (byval m as gsl_matrix ptr, byval j as integer) as _gsl_vector_const_view
declare function gsl_matrix_const_diagonal (byval m as gsl_matrix ptr) as _gsl_vector_const_view
declare function gsl_matrix_const_subdiagonal (byval m as gsl_matrix ptr, byval k as integer) as _gsl_vector_const_view
declare function gsl_matrix_const_superdiagonal (byval m as gsl_matrix ptr, byval k as integer) as _gsl_vector_const_view
declare function gsl_matrix_const_view_array (byval base as double ptr, byval n1 as integer, byval n2 as integer) as _gsl_matrix_const_view
declare function gsl_matrix_const_view_array_with_tda (byval base as double ptr, byval n1 as integer, byval n2 as integer, byval tda as integer) as _gsl_matrix_const_view
declare function gsl_matrix_const_view_vector (byval v as gsl_vector ptr, byval n1 as integer, byval n2 as integer) as _gsl_matrix_const_view
declare function gsl_matrix_const_view_vector_with_tda (byval v as gsl_vector ptr, byval n1 as integer, byval n2 as integer, byval tda as integer) as _gsl_matrix_const_view
declare function gsl_matrix_get (byval m as gsl_matrix ptr, byval i as integer, byval j as integer) as double
declare sub gsl_matrix_set (byval m as gsl_matrix ptr, byval i as integer, byval j as integer, byval x as double)
declare function gsl_matrix_ptr (byval m as gsl_matrix ptr, byval i as integer, byval j as integer) as double ptr
declare function gsl_matrix_const_ptr (byval m as gsl_matrix ptr, byval i as integer, byval j as integer) as double ptr
declare sub gsl_matrix_set_zero (byval m as gsl_matrix ptr)
declare sub gsl_matrix_set_identity (byval m as gsl_matrix ptr)
declare sub gsl_matrix_set_all (byval m as gsl_matrix ptr, byval x as double)
declare function gsl_matrix_fread (byval stream as FILE ptr, byval m as gsl_matrix ptr) as integer
declare function gsl_matrix_fwrite (byval stream as FILE ptr, byval m as gsl_matrix ptr) as integer
declare function gsl_matrix_fscanf (byval stream as FILE ptr, byval m as gsl_matrix ptr) as integer
declare function gsl_matrix_fprintf (byval stream as FILE ptr, byval m as gsl_matrix ptr, byval format as zstring ptr) as integer
declare function gsl_matrix_memcpy (byval dest as gsl_matrix ptr, byval src as gsl_matrix ptr) as integer
declare function gsl_matrix_swap (byval m1 as gsl_matrix ptr, byval m2 as gsl_matrix ptr) as integer
declare function gsl_matrix_swap_rows (byval m as gsl_matrix ptr, byval i as integer, byval j as integer) as integer
declare function gsl_matrix_swap_columns (byval m as gsl_matrix ptr, byval i as integer, byval j as integer) as integer
declare function gsl_matrix_swap_rowcol (byval m as gsl_matrix ptr, byval i as integer, byval j as integer) as integer
declare function gsl_matrix_transpose (byval m as gsl_matrix ptr) as integer
declare function gsl_matrix_transpose_memcpy (byval dest as gsl_matrix ptr, byval src as gsl_matrix ptr) as integer
declare function gsl_matrix_max (byval m as gsl_matrix ptr) as double
declare function gsl_matrix_min (byval m as gsl_matrix ptr) as double
declare sub gsl_matrix_minmax (byval m as gsl_matrix ptr, byval min_out as double ptr, byval max_out as double ptr)
declare sub gsl_matrix_max_index (byval m as gsl_matrix ptr, byval imax as integer ptr, byval jmax as integer ptr)
declare sub gsl_matrix_min_index (byval m as gsl_matrix ptr, byval imin as integer ptr, byval jmin as integer ptr)
declare sub gsl_matrix_minmax_index (byval m as gsl_matrix ptr, byval imin as integer ptr, byval jmin as integer ptr, byval imax as integer ptr, byval jmax as integer ptr)
declare function gsl_matrix_isnull (byval m as gsl_matrix ptr) as integer
declare function gsl_matrix_add (byval a as gsl_matrix ptr, byval b as gsl_matrix ptr) as integer
declare function gsl_matrix_sub (byval a as gsl_matrix ptr, byval b as gsl_matrix ptr) as integer
declare function gsl_matrix_mul_elements (byval a as gsl_matrix ptr, byval b as gsl_matrix ptr) as integer
declare function gsl_matrix_div_elements (byval a as gsl_matrix ptr, byval b as gsl_matrix ptr) as integer
declare function gsl_matrix_scale (byval a as gsl_matrix ptr, byval x as double) as integer
declare function gsl_matrix_add_constant (byval a as gsl_matrix ptr, byval x as double) as integer
declare function gsl_matrix_add_diagonal (byval a as gsl_matrix ptr, byval x as double) as integer
declare function gsl_matrix_get_row (byval v as gsl_vector ptr, byval m as gsl_matrix ptr, byval i as integer) as integer
declare function gsl_matrix_get_col (byval v as gsl_vector ptr, byval m as gsl_matrix ptr, byval j as integer) as integer
declare function gsl_matrix_set_row (byval m as gsl_matrix ptr, byval i as integer, byval v as gsl_vector ptr) as integer
declare function gsl_matrix_set_col (byval m as gsl_matrix ptr, byval j as integer, byval v as gsl_vector ptr) as integer
end extern

#endif
