''
''
'' gsl_matrix_int -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_matrix_int_bi__
#define __gsl_matrix_int_bi__

#include once "gsl_types.bi"
#include once "gsl_errno.bi"
#include once "gsl_check_range.bi"
#include once "gsl_vector_int.bi"

type gsl_matrix_int
	size1 as integer
	size2 as integer
	tda as integer
	data as integer ptr
	block as gsl_block_int ptr
	owner as integer
end type

type _gsl_matrix_int_view
	matrix as gsl_matrix_int
end type

type gsl_matrix_int_view as _gsl_matrix_int_view

type _gsl_matrix_int_const_view
	matrix as gsl_matrix_int
end type

type gsl_matrix_int_const_view as _gsl_matrix_int_const_view

extern "c"
declare function gsl_matrix_int_alloc (byval n1 as integer, byval n2 as integer) as gsl_matrix_int ptr
declare function gsl_matrix_int_calloc (byval n1 as integer, byval n2 as integer) as gsl_matrix_int ptr
declare function gsl_matrix_int_alloc_from_block (byval b as gsl_block_int ptr, byval offset as integer, byval n1 as integer, byval n2 as integer, byval d2 as integer) as gsl_matrix_int ptr
declare function gsl_matrix_int_alloc_from_matrix (byval m as gsl_matrix_int ptr, byval k1 as integer, byval k2 as integer, byval n1 as integer, byval n2 as integer) as gsl_matrix_int ptr
declare function gsl_vector_int_alloc_row_from_matrix (byval m as gsl_matrix_int ptr, byval i as integer) as gsl_vector_int ptr
declare function gsl_vector_int_alloc_col_from_matrix (byval m as gsl_matrix_int ptr, byval j as integer) as gsl_vector_int ptr
declare sub gsl_matrix_int_free (byval m as gsl_matrix_int ptr)
declare function gsl_matrix_int_submatrix (byval m as gsl_matrix_int ptr, byval i as integer, byval j as integer, byval n1 as integer, byval n2 as integer) as _gsl_matrix_int_view
declare function gsl_matrix_int_row (byval m as gsl_matrix_int ptr, byval i as integer) as _gsl_vector_int_view
declare function gsl_matrix_int_column (byval m as gsl_matrix_int ptr, byval j as integer) as _gsl_vector_int_view
declare function gsl_matrix_int_diagonal (byval m as gsl_matrix_int ptr) as _gsl_vector_int_view
declare function gsl_matrix_int_subdiagonal (byval m as gsl_matrix_int ptr, byval k as integer) as _gsl_vector_int_view
declare function gsl_matrix_int_superdiagonal (byval m as gsl_matrix_int ptr, byval k as integer) as _gsl_vector_int_view
declare function gsl_matrix_int_view_array (byval base as integer ptr, byval n1 as integer, byval n2 as integer) as _gsl_matrix_int_view
declare function gsl_matrix_int_view_array_with_tda (byval base as integer ptr, byval n1 as integer, byval n2 as integer, byval tda as integer) as _gsl_matrix_int_view
declare function gsl_matrix_int_view_vector (byval v as gsl_vector_int ptr, byval n1 as integer, byval n2 as integer) as _gsl_matrix_int_view
declare function gsl_matrix_int_view_vector_with_tda (byval v as gsl_vector_int ptr, byval n1 as integer, byval n2 as integer, byval tda as integer) as _gsl_matrix_int_view
declare function gsl_matrix_int_const_submatrix (byval m as gsl_matrix_int ptr, byval i as integer, byval j as integer, byval n1 as integer, byval n2 as integer) as _gsl_matrix_int_const_view
declare function gsl_matrix_int_const_row (byval m as gsl_matrix_int ptr, byval i as integer) as _gsl_vector_int_const_view
declare function gsl_matrix_int_const_column (byval m as gsl_matrix_int ptr, byval j as integer) as _gsl_vector_int_const_view
declare function gsl_matrix_int_const_diagonal (byval m as gsl_matrix_int ptr) as _gsl_vector_int_const_view
declare function gsl_matrix_int_const_subdiagonal (byval m as gsl_matrix_int ptr, byval k as integer) as _gsl_vector_int_const_view
declare function gsl_matrix_int_const_superdiagonal (byval m as gsl_matrix_int ptr, byval k as integer) as _gsl_vector_int_const_view
declare function gsl_matrix_int_const_view_array (byval base as integer ptr, byval n1 as integer, byval n2 as integer) as _gsl_matrix_int_const_view
declare function gsl_matrix_int_const_view_array_with_tda (byval base as integer ptr, byval n1 as integer, byval n2 as integer, byval tda as integer) as _gsl_matrix_int_const_view
declare function gsl_matrix_int_const_view_vector (byval v as gsl_vector_int ptr, byval n1 as integer, byval n2 as integer) as _gsl_matrix_int_const_view
declare function gsl_matrix_int_const_view_vector_with_tda (byval v as gsl_vector_int ptr, byval n1 as integer, byval n2 as integer, byval tda as integer) as _gsl_matrix_int_const_view
declare function gsl_matrix_int_get (byval m as gsl_matrix_int ptr, byval i as integer, byval j as integer) as integer
declare sub gsl_matrix_int_set (byval m as gsl_matrix_int ptr, byval i as integer, byval j as integer, byval x as integer)
declare function gsl_matrix_int_ptr (byval m as gsl_matrix_int ptr, byval i as integer, byval j as integer) as integer ptr
declare function gsl_matrix_int_const_ptr (byval m as gsl_matrix_int ptr, byval i as integer, byval j as integer) as integer ptr
declare sub gsl_matrix_int_set_zero (byval m as gsl_matrix_int ptr)
declare sub gsl_matrix_int_set_identity (byval m as gsl_matrix_int ptr)
declare sub gsl_matrix_int_set_all (byval m as gsl_matrix_int ptr, byval x as integer)
declare function gsl_matrix_int_fread (byval stream as FILE ptr, byval m as gsl_matrix_int ptr) as integer
declare function gsl_matrix_int_fwrite (byval stream as FILE ptr, byval m as gsl_matrix_int ptr) as integer
declare function gsl_matrix_int_fscanf (byval stream as FILE ptr, byval m as gsl_matrix_int ptr) as integer
declare function gsl_matrix_int_fprintf (byval stream as FILE ptr, byval m as gsl_matrix_int ptr, byval format as zstring ptr) as integer
declare function gsl_matrix_int_memcpy (byval dest as gsl_matrix_int ptr, byval src as gsl_matrix_int ptr) as integer
declare function gsl_matrix_int_swap (byval m1 as gsl_matrix_int ptr, byval m2 as gsl_matrix_int ptr) as integer
declare function gsl_matrix_int_swap_rows (byval m as gsl_matrix_int ptr, byval i as integer, byval j as integer) as integer
declare function gsl_matrix_int_swap_columns (byval m as gsl_matrix_int ptr, byval i as integer, byval j as integer) as integer
declare function gsl_matrix_int_swap_rowcol (byval m as gsl_matrix_int ptr, byval i as integer, byval j as integer) as integer
declare function gsl_matrix_int_transpose (byval m as gsl_matrix_int ptr) as integer
declare function gsl_matrix_int_transpose_memcpy (byval dest as gsl_matrix_int ptr, byval src as gsl_matrix_int ptr) as integer
declare function gsl_matrix_int_max (byval m as gsl_matrix_int ptr) as integer
declare function gsl_matrix_int_min (byval m as gsl_matrix_int ptr) as integer
declare sub gsl_matrix_int_minmax (byval m as gsl_matrix_int ptr, byval min_out as integer ptr, byval max_out as integer ptr)
declare sub gsl_matrix_int_max_index (byval m as gsl_matrix_int ptr, byval imax as integer ptr, byval jmax as integer ptr)
declare sub gsl_matrix_int_min_index (byval m as gsl_matrix_int ptr, byval imin as integer ptr, byval jmin as integer ptr)
declare sub gsl_matrix_int_minmax_index (byval m as gsl_matrix_int ptr, byval imin as integer ptr, byval jmin as integer ptr, byval imax as integer ptr, byval jmax as integer ptr)
declare function gsl_matrix_int_isnull (byval m as gsl_matrix_int ptr) as integer
declare function gsl_matrix_int_add (byval a as gsl_matrix_int ptr, byval b as gsl_matrix_int ptr) as integer
declare function gsl_matrix_int_sub (byval a as gsl_matrix_int ptr, byval b as gsl_matrix_int ptr) as integer
declare function gsl_matrix_int_mul_elements (byval a as gsl_matrix_int ptr, byval b as gsl_matrix_int ptr) as integer
declare function gsl_matrix_int_div_elements (byval a as gsl_matrix_int ptr, byval b as gsl_matrix_int ptr) as integer
declare function gsl_matrix_int_scale (byval a as gsl_matrix_int ptr, byval x as double) as integer
declare function gsl_matrix_int_add_constant (byval a as gsl_matrix_int ptr, byval x as double) as integer
declare function gsl_matrix_int_add_diagonal (byval a as gsl_matrix_int ptr, byval x as double) as integer
declare function gsl_matrix_int_get_row (byval v as gsl_vector_int ptr, byval m as gsl_matrix_int ptr, byval i as integer) as integer
declare function gsl_matrix_int_get_col (byval v as gsl_vector_int ptr, byval m as gsl_matrix_int ptr, byval j as integer) as integer
declare function gsl_matrix_int_set_row (byval m as gsl_matrix_int ptr, byval i as integer, byval v as gsl_vector_int ptr) as integer
declare function gsl_matrix_int_set_col (byval m as gsl_matrix_int ptr, byval j as integer, byval v as gsl_vector_int ptr) as integer
end extern

#endif
