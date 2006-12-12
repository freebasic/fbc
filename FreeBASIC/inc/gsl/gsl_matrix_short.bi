''
''
'' gsl_matrix_short -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_matrix_short_bi__
#define __gsl_matrix_short_bi__

#include once "gsl_types.bi"
#include once "gsl_errno.bi"
#include once "gsl_check_range.bi"
#include once "gsl_vector_short.bi"

type gsl_matrix_short
	size1 as integer
	size2 as integer
	tda as integer
	data as short ptr
	block as gsl_block_short ptr
	owner as integer
end type

type _gsl_matrix_short_view
	matrix as gsl_matrix_short
end type

type gsl_matrix_short_view as _gsl_matrix_short_view

type _gsl_matrix_short_const_view
	matrix as gsl_matrix_short
end type

type gsl_matrix_short_const_view as _gsl_matrix_short_const_view

extern "c"
declare function gsl_matrix_short_alloc (byval n1 as integer, byval n2 as integer) as gsl_matrix_short ptr
declare function gsl_matrix_short_calloc (byval n1 as integer, byval n2 as integer) as gsl_matrix_short ptr
declare function gsl_matrix_short_alloc_from_block (byval b as gsl_block_short ptr, byval offset as integer, byval n1 as integer, byval n2 as integer, byval d2 as integer) as gsl_matrix_short ptr
declare function gsl_matrix_short_alloc_from_matrix (byval m as gsl_matrix_short ptr, byval k1 as integer, byval k2 as integer, byval n1 as integer, byval n2 as integer) as gsl_matrix_short ptr
declare function gsl_vector_short_alloc_row_from_matrix (byval m as gsl_matrix_short ptr, byval i as integer) as gsl_vector_short ptr
declare function gsl_vector_short_alloc_col_from_matrix (byval m as gsl_matrix_short ptr, byval j as integer) as gsl_vector_short ptr
declare sub gsl_matrix_short_free (byval m as gsl_matrix_short ptr)
declare function gsl_matrix_short_submatrix (byval m as gsl_matrix_short ptr, byval i as integer, byval j as integer, byval n1 as integer, byval n2 as integer) as _gsl_matrix_short_view
declare function gsl_matrix_short_row (byval m as gsl_matrix_short ptr, byval i as integer) as _gsl_vector_short_view
declare function gsl_matrix_short_column (byval m as gsl_matrix_short ptr, byval j as integer) as _gsl_vector_short_view
declare function gsl_matrix_short_diagonal (byval m as gsl_matrix_short ptr) as _gsl_vector_short_view
declare function gsl_matrix_short_subdiagonal (byval m as gsl_matrix_short ptr, byval k as integer) as _gsl_vector_short_view
declare function gsl_matrix_short_superdiagonal (byval m as gsl_matrix_short ptr, byval k as integer) as _gsl_vector_short_view
declare function gsl_matrix_short_view_array (byval base as short ptr, byval n1 as integer, byval n2 as integer) as _gsl_matrix_short_view
declare function gsl_matrix_short_view_array_with_tda (byval base as short ptr, byval n1 as integer, byval n2 as integer, byval tda as integer) as _gsl_matrix_short_view
declare function gsl_matrix_short_view_vector (byval v as gsl_vector_short ptr, byval n1 as integer, byval n2 as integer) as _gsl_matrix_short_view
declare function gsl_matrix_short_view_vector_with_tda (byval v as gsl_vector_short ptr, byval n1 as integer, byval n2 as integer, byval tda as integer) as _gsl_matrix_short_view
declare function gsl_matrix_short_const_submatrix (byval m as gsl_matrix_short ptr, byval i as integer, byval j as integer, byval n1 as integer, byval n2 as integer) as _gsl_matrix_short_const_view
declare function gsl_matrix_short_const_row (byval m as gsl_matrix_short ptr, byval i as integer) as _gsl_vector_short_const_view
declare function gsl_matrix_short_const_column (byval m as gsl_matrix_short ptr, byval j as integer) as _gsl_vector_short_const_view
declare function gsl_matrix_short_const_diagonal (byval m as gsl_matrix_short ptr) as _gsl_vector_short_const_view
declare function gsl_matrix_short_const_subdiagonal (byval m as gsl_matrix_short ptr, byval k as integer) as _gsl_vector_short_const_view
declare function gsl_matrix_short_const_superdiagonal (byval m as gsl_matrix_short ptr, byval k as integer) as _gsl_vector_short_const_view
declare function gsl_matrix_short_const_view_array (byval base as short ptr, byval n1 as integer, byval n2 as integer) as _gsl_matrix_short_const_view
declare function gsl_matrix_short_const_view_array_with_tda (byval base as short ptr, byval n1 as integer, byval n2 as integer, byval tda as integer) as _gsl_matrix_short_const_view
declare function gsl_matrix_short_const_view_vector (byval v as gsl_vector_short ptr, byval n1 as integer, byval n2 as integer) as _gsl_matrix_short_const_view
declare function gsl_matrix_short_const_view_vector_with_tda (byval v as gsl_vector_short ptr, byval n1 as integer, byval n2 as integer, byval tda as integer) as _gsl_matrix_short_const_view
declare function gsl_matrix_short_get (byval m as gsl_matrix_short ptr, byval i as integer, byval j as integer) as short
declare sub gsl_matrix_short_set (byval m as gsl_matrix_short ptr, byval i as integer, byval j as integer, byval x as short)
declare function gsl_matrix_short_ptr (byval m as gsl_matrix_short ptr, byval i as integer, byval j as integer) as short ptr
declare function gsl_matrix_short_const_ptr (byval m as gsl_matrix_short ptr, byval i as integer, byval j as integer) as short ptr
declare sub gsl_matrix_short_set_zero (byval m as gsl_matrix_short ptr)
declare sub gsl_matrix_short_set_identity (byval m as gsl_matrix_short ptr)
declare sub gsl_matrix_short_set_all (byval m as gsl_matrix_short ptr, byval x as short)
declare function gsl_matrix_short_fread (byval stream as FILE ptr, byval m as gsl_matrix_short ptr) as integer
declare function gsl_matrix_short_fwrite (byval stream as FILE ptr, byval m as gsl_matrix_short ptr) as integer
declare function gsl_matrix_short_fscanf (byval stream as FILE ptr, byval m as gsl_matrix_short ptr) as integer
declare function gsl_matrix_short_fprintf (byval stream as FILE ptr, byval m as gsl_matrix_short ptr, byval format as zstring ptr) as integer
declare function gsl_matrix_short_memcpy (byval dest as gsl_matrix_short ptr, byval src as gsl_matrix_short ptr) as integer
declare function gsl_matrix_short_swap (byval m1 as gsl_matrix_short ptr, byval m2 as gsl_matrix_short ptr) as integer
declare function gsl_matrix_short_swap_rows (byval m as gsl_matrix_short ptr, byval i as integer, byval j as integer) as integer
declare function gsl_matrix_short_swap_columns (byval m as gsl_matrix_short ptr, byval i as integer, byval j as integer) as integer
declare function gsl_matrix_short_swap_rowcol (byval m as gsl_matrix_short ptr, byval i as integer, byval j as integer) as integer
declare function gsl_matrix_short_transpose (byval m as gsl_matrix_short ptr) as integer
declare function gsl_matrix_short_transpose_memcpy (byval dest as gsl_matrix_short ptr, byval src as gsl_matrix_short ptr) as integer
declare function gsl_matrix_short_max (byval m as gsl_matrix_short ptr) as short
declare function gsl_matrix_short_min (byval m as gsl_matrix_short ptr) as short
declare sub gsl_matrix_short_minmax (byval m as gsl_matrix_short ptr, byval min_out as short ptr, byval max_out as short ptr)
declare sub gsl_matrix_short_max_index (byval m as gsl_matrix_short ptr, byval imax as integer ptr, byval jmax as integer ptr)
declare sub gsl_matrix_short_min_index (byval m as gsl_matrix_short ptr, byval imin as integer ptr, byval jmin as integer ptr)
declare sub gsl_matrix_short_minmax_index (byval m as gsl_matrix_short ptr, byval imin as integer ptr, byval jmin as integer ptr, byval imax as integer ptr, byval jmax as integer ptr)
declare function gsl_matrix_short_isnull (byval m as gsl_matrix_short ptr) as integer
declare function gsl_matrix_short_add (byval a as gsl_matrix_short ptr, byval b as gsl_matrix_short ptr) as integer
declare function gsl_matrix_short_sub (byval a as gsl_matrix_short ptr, byval b as gsl_matrix_short ptr) as integer
declare function gsl_matrix_short_mul_elements (byval a as gsl_matrix_short ptr, byval b as gsl_matrix_short ptr) as integer
declare function gsl_matrix_short_div_elements (byval a as gsl_matrix_short ptr, byval b as gsl_matrix_short ptr) as integer
declare function gsl_matrix_short_scale (byval a as gsl_matrix_short ptr, byval x as double) as integer
declare function gsl_matrix_short_add_constant (byval a as gsl_matrix_short ptr, byval x as double) as integer
declare function gsl_matrix_short_add_diagonal (byval a as gsl_matrix_short ptr, byval x as double) as integer
declare function gsl_matrix_short_get_row (byval v as gsl_vector_short ptr, byval m as gsl_matrix_short ptr, byval i as integer) as integer
declare function gsl_matrix_short_get_col (byval v as gsl_vector_short ptr, byval m as gsl_matrix_short ptr, byval j as integer) as integer
declare function gsl_matrix_short_set_row (byval m as gsl_matrix_short ptr, byval i as integer, byval v as gsl_vector_short ptr) as integer
declare function gsl_matrix_short_set_col (byval m as gsl_matrix_short ptr, byval j as integer, byval v as gsl_vector_short ptr) as integer
end extern

#endif
