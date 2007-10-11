''
''
'' gsl_matrix_long -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_matrix_long_bi__
#define __gsl_matrix_long_bi__

#include once "gsl_types.bi"
#include once "gsl_errno.bi"
#include once "gsl_check_range.bi"
#include once "gsl_vector_long.bi"

type gsl_matrix_long
	size1 as integer
	size2 as integer
	tda as integer
	data as integer ptr
	block as gsl_block_long ptr
	owner as integer
end type

type _gsl_matrix_long_view
	matrix as gsl_matrix_long
end type

type gsl_matrix_long_view as _gsl_matrix_long_view

type _gsl_matrix_long_const_view
	matrix as gsl_matrix_long
end type

type gsl_matrix_long_const_view as _gsl_matrix_long_const_view

extern "c"
declare function gsl_matrix_long_alloc (byval n1 as integer, byval n2 as integer) as gsl_matrix_long ptr
declare function gsl_matrix_long_calloc (byval n1 as integer, byval n2 as integer) as gsl_matrix_long ptr
declare function gsl_matrix_long_alloc_from_block (byval b as gsl_block_long ptr, byval offset as integer, byval n1 as integer, byval n2 as integer, byval d2 as integer) as gsl_matrix_long ptr
declare function gsl_matrix_long_alloc_from_matrix (byval m as gsl_matrix_long ptr, byval k1 as integer, byval k2 as integer, byval n1 as integer, byval n2 as integer) as gsl_matrix_long ptr
declare function gsl_vector_long_alloc_row_from_matrix (byval m as gsl_matrix_long ptr, byval i as integer) as gsl_vector_long ptr
declare function gsl_vector_long_alloc_col_from_matrix (byval m as gsl_matrix_long ptr, byval j as integer) as gsl_vector_long ptr
declare sub gsl_matrix_long_free (byval m as gsl_matrix_long ptr)
declare function gsl_matrix_long_submatrix (byval m as gsl_matrix_long ptr, byval i as integer, byval j as integer, byval n1 as integer, byval n2 as integer) as _gsl_matrix_long_view
declare function gsl_matrix_long_row (byval m as gsl_matrix_long ptr, byval i as integer) as _gsl_vector_long_view
declare function gsl_matrix_long_column (byval m as gsl_matrix_long ptr, byval j as integer) as _gsl_vector_long_view
declare function gsl_matrix_long_diagonal (byval m as gsl_matrix_long ptr) as _gsl_vector_long_view
declare function gsl_matrix_long_subdiagonal (byval m as gsl_matrix_long ptr, byval k as integer) as _gsl_vector_long_view
declare function gsl_matrix_long_superdiagonal (byval m as gsl_matrix_long ptr, byval k as integer) as _gsl_vector_long_view
declare function gsl_matrix_long_view_array (byval base as integer ptr, byval n1 as integer, byval n2 as integer) as _gsl_matrix_long_view
declare function gsl_matrix_long_view_array_with_tda (byval base as integer ptr, byval n1 as integer, byval n2 as integer, byval tda as integer) as _gsl_matrix_long_view
declare function gsl_matrix_long_view_vector (byval v as gsl_vector_long ptr, byval n1 as integer, byval n2 as integer) as _gsl_matrix_long_view
declare function gsl_matrix_long_view_vector_with_tda (byval v as gsl_vector_long ptr, byval n1 as integer, byval n2 as integer, byval tda as integer) as _gsl_matrix_long_view
declare function gsl_matrix_long_const_submatrix (byval m as gsl_matrix_long ptr, byval i as integer, byval j as integer, byval n1 as integer, byval n2 as integer) as _gsl_matrix_long_const_view
declare function gsl_matrix_long_const_row (byval m as gsl_matrix_long ptr, byval i as integer) as _gsl_vector_long_const_view
declare function gsl_matrix_long_const_column (byval m as gsl_matrix_long ptr, byval j as integer) as _gsl_vector_long_const_view
declare function gsl_matrix_long_const_diagonal (byval m as gsl_matrix_long ptr) as _gsl_vector_long_const_view
declare function gsl_matrix_long_const_subdiagonal (byval m as gsl_matrix_long ptr, byval k as integer) as _gsl_vector_long_const_view
declare function gsl_matrix_long_const_superdiagonal (byval m as gsl_matrix_long ptr, byval k as integer) as _gsl_vector_long_const_view
declare function gsl_matrix_long_const_view_array (byval base as integer ptr, byval n1 as integer, byval n2 as integer) as _gsl_matrix_long_const_view
declare function gsl_matrix_long_const_view_array_with_tda (byval base as integer ptr, byval n1 as integer, byval n2 as integer, byval tda as integer) as _gsl_matrix_long_const_view
declare function gsl_matrix_long_const_view_vector (byval v as gsl_vector_long ptr, byval n1 as integer, byval n2 as integer) as _gsl_matrix_long_const_view
declare function gsl_matrix_long_const_view_vector_with_tda (byval v as gsl_vector_long ptr, byval n1 as integer, byval n2 as integer, byval tda as integer) as _gsl_matrix_long_const_view
declare function gsl_matrix_long_get (byval m as gsl_matrix_long ptr, byval i as integer, byval j as integer) as integer
declare sub gsl_matrix_long_set (byval m as gsl_matrix_long ptr, byval i as integer, byval j as integer, byval x as integer)
declare function gsl_matrix_long_ptr (byval m as gsl_matrix_long ptr, byval i as integer, byval j as integer) as integer ptr
declare function gsl_matrix_long_const_ptr (byval m as gsl_matrix_long ptr, byval i as integer, byval j as integer) as integer ptr
declare sub gsl_matrix_long_set_zero (byval m as gsl_matrix_long ptr)
declare sub gsl_matrix_long_set_identity (byval m as gsl_matrix_long ptr)
declare sub gsl_matrix_long_set_all (byval m as gsl_matrix_long ptr, byval x as integer)
declare function gsl_matrix_long_fread (byval stream as FILE ptr, byval m as gsl_matrix_long ptr) as integer
declare function gsl_matrix_long_fwrite (byval stream as FILE ptr, byval m as gsl_matrix_long ptr) as integer
declare function gsl_matrix_long_fscanf (byval stream as FILE ptr, byval m as gsl_matrix_long ptr) as integer
declare function gsl_matrix_long_fprintf (byval stream as FILE ptr, byval m as gsl_matrix_long ptr, byval format as zstring ptr) as integer
declare function gsl_matrix_long_memcpy (byval dest as gsl_matrix_long ptr, byval src as gsl_matrix_long ptr) as integer
declare function gsl_matrix_long_swap (byval m1 as gsl_matrix_long ptr, byval m2 as gsl_matrix_long ptr) as integer
declare function gsl_matrix_long_swap_rows (byval m as gsl_matrix_long ptr, byval i as integer, byval j as integer) as integer
declare function gsl_matrix_long_swap_columns (byval m as gsl_matrix_long ptr, byval i as integer, byval j as integer) as integer
declare function gsl_matrix_long_swap_rowcol (byval m as gsl_matrix_long ptr, byval i as integer, byval j as integer) as integer
declare function gsl_matrix_long_transpose (byval m as gsl_matrix_long ptr) as integer
declare function gsl_matrix_long_transpose_memcpy (byval dest as gsl_matrix_long ptr, byval src as gsl_matrix_long ptr) as integer
declare function gsl_matrix_long_max (byval m as gsl_matrix_long ptr) as integer
declare function gsl_matrix_long_min (byval m as gsl_matrix_long ptr) as integer
declare sub gsl_matrix_long_minmax (byval m as gsl_matrix_long ptr, byval min_out as integer ptr, byval max_out as integer ptr)
declare sub gsl_matrix_long_max_index (byval m as gsl_matrix_long ptr, byval imax as integer ptr, byval jmax as integer ptr)
declare sub gsl_matrix_long_min_index (byval m as gsl_matrix_long ptr, byval imin as integer ptr, byval jmin as integer ptr)
declare sub gsl_matrix_long_minmax_index (byval m as gsl_matrix_long ptr, byval imin as integer ptr, byval jmin as integer ptr, byval imax as integer ptr, byval jmax as integer ptr)
declare function gsl_matrix_long_isnull (byval m as gsl_matrix_long ptr) as integer
declare function gsl_matrix_long_add (byval a as gsl_matrix_long ptr, byval b as gsl_matrix_long ptr) as integer
declare function gsl_matrix_long_sub (byval a as gsl_matrix_long ptr, byval b as gsl_matrix_long ptr) as integer
declare function gsl_matrix_long_mul_elements (byval a as gsl_matrix_long ptr, byval b as gsl_matrix_long ptr) as integer
declare function gsl_matrix_long_div_elements (byval a as gsl_matrix_long ptr, byval b as gsl_matrix_long ptr) as integer
declare function gsl_matrix_long_scale (byval a as gsl_matrix_long ptr, byval x as double) as integer
declare function gsl_matrix_long_add_constant (byval a as gsl_matrix_long ptr, byval x as double) as integer
declare function gsl_matrix_long_add_diagonal (byval a as gsl_matrix_long ptr, byval x as double) as integer
declare function gsl_matrix_long_get_row (byval v as gsl_vector_long ptr, byval m as gsl_matrix_long ptr, byval i as integer) as integer
declare function gsl_matrix_long_get_col (byval v as gsl_vector_long ptr, byval m as gsl_matrix_long ptr, byval j as integer) as integer
declare function gsl_matrix_long_set_row (byval m as gsl_matrix_long ptr, byval i as integer, byval v as gsl_vector_long ptr) as integer
declare function gsl_matrix_long_set_col (byval m as gsl_matrix_long ptr, byval j as integer, byval v as gsl_vector_long ptr) as integer
end extern

#endif
