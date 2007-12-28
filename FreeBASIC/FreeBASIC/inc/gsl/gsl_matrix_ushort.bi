''
''
'' gsl_matrix_ushort -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_matrix_ushort_bi__
#define __gsl_matrix_ushort_bi__

#include once "gsl_types.bi"
#include once "gsl_errno.bi"
#include once "gsl_check_range.bi"
#include once "gsl_vector_ushort.bi"

type gsl_matrix_ushort
	size1 as integer
	size2 as integer
	tda as integer
	data as ushort ptr
	block as gsl_block_ushort ptr
	owner as integer
end type

type _gsl_matrix_ushort_view
	matrix as gsl_matrix_ushort
end type

type gsl_matrix_ushort_view as _gsl_matrix_ushort_view

type _gsl_matrix_ushort_const_view
	matrix as gsl_matrix_ushort
end type

type gsl_matrix_ushort_const_view as _gsl_matrix_ushort_const_view

extern "c"
declare function gsl_matrix_ushort_alloc (byval n1 as integer, byval n2 as integer) as gsl_matrix_ushort ptr
declare function gsl_matrix_ushort_calloc (byval n1 as integer, byval n2 as integer) as gsl_matrix_ushort ptr
declare function gsl_matrix_ushort_alloc_from_block (byval b as gsl_block_ushort ptr, byval offset as integer, byval n1 as integer, byval n2 as integer, byval d2 as integer) as gsl_matrix_ushort ptr
declare function gsl_matrix_ushort_alloc_from_matrix (byval m as gsl_matrix_ushort ptr, byval k1 as integer, byval k2 as integer, byval n1 as integer, byval n2 as integer) as gsl_matrix_ushort ptr
declare function gsl_vector_ushort_alloc_row_from_matrix (byval m as gsl_matrix_ushort ptr, byval i as integer) as gsl_vector_ushort ptr
declare function gsl_vector_ushort_alloc_col_from_matrix (byval m as gsl_matrix_ushort ptr, byval j as integer) as gsl_vector_ushort ptr
declare sub gsl_matrix_ushort_free (byval m as gsl_matrix_ushort ptr)
declare function gsl_matrix_ushort_submatrix (byval m as gsl_matrix_ushort ptr, byval i as integer, byval j as integer, byval n1 as integer, byval n2 as integer) as _gsl_matrix_ushort_view
declare function gsl_matrix_ushort_row (byval m as gsl_matrix_ushort ptr, byval i as integer) as _gsl_vector_ushort_view
declare function gsl_matrix_ushort_column (byval m as gsl_matrix_ushort ptr, byval j as integer) as _gsl_vector_ushort_view
declare function gsl_matrix_ushort_diagonal (byval m as gsl_matrix_ushort ptr) as _gsl_vector_ushort_view
declare function gsl_matrix_ushort_subdiagonal (byval m as gsl_matrix_ushort ptr, byval k as integer) as _gsl_vector_ushort_view
declare function gsl_matrix_ushort_superdiagonal (byval m as gsl_matrix_ushort ptr, byval k as integer) as _gsl_vector_ushort_view
declare function gsl_matrix_ushort_view_array (byval base as ushort ptr, byval n1 as integer, byval n2 as integer) as _gsl_matrix_ushort_view
declare function gsl_matrix_ushort_view_array_with_tda (byval base as ushort ptr, byval n1 as integer, byval n2 as integer, byval tda as integer) as _gsl_matrix_ushort_view
declare function gsl_matrix_ushort_view_vector (byval v as gsl_vector_ushort ptr, byval n1 as integer, byval n2 as integer) as _gsl_matrix_ushort_view
declare function gsl_matrix_ushort_view_vector_with_tda (byval v as gsl_vector_ushort ptr, byval n1 as integer, byval n2 as integer, byval tda as integer) as _gsl_matrix_ushort_view
declare function gsl_matrix_ushort_const_submatrix (byval m as gsl_matrix_ushort ptr, byval i as integer, byval j as integer, byval n1 as integer, byval n2 as integer) as _gsl_matrix_ushort_const_view
declare function gsl_matrix_ushort_const_row (byval m as gsl_matrix_ushort ptr, byval i as integer) as _gsl_vector_ushort_const_view
declare function gsl_matrix_ushort_const_column (byval m as gsl_matrix_ushort ptr, byval j as integer) as _gsl_vector_ushort_const_view
declare function gsl_matrix_ushort_const_diagonal (byval m as gsl_matrix_ushort ptr) as _gsl_vector_ushort_const_view
declare function gsl_matrix_ushort_const_subdiagonal (byval m as gsl_matrix_ushort ptr, byval k as integer) as _gsl_vector_ushort_const_view
declare function gsl_matrix_ushort_const_superdiagonal (byval m as gsl_matrix_ushort ptr, byval k as integer) as _gsl_vector_ushort_const_view
declare function gsl_matrix_ushort_const_view_array (byval base as ushort ptr, byval n1 as integer, byval n2 as integer) as _gsl_matrix_ushort_const_view
declare function gsl_matrix_ushort_const_view_array_with_tda (byval base as ushort ptr, byval n1 as integer, byval n2 as integer, byval tda as integer) as _gsl_matrix_ushort_const_view
declare function gsl_matrix_ushort_const_view_vector (byval v as gsl_vector_ushort ptr, byval n1 as integer, byval n2 as integer) as _gsl_matrix_ushort_const_view
declare function gsl_matrix_ushort_const_view_vector_with_tda (byval v as gsl_vector_ushort ptr, byval n1 as integer, byval n2 as integer, byval tda as integer) as _gsl_matrix_ushort_const_view
declare function gsl_matrix_ushort_get (byval m as gsl_matrix_ushort ptr, byval i as integer, byval j as integer) as ushort
declare sub gsl_matrix_ushort_set (byval m as gsl_matrix_ushort ptr, byval i as integer, byval j as integer, byval x as ushort)
declare function gsl_matrix_ushort_ptr (byval m as gsl_matrix_ushort ptr, byval i as integer, byval j as integer) as ushort ptr
declare function gsl_matrix_ushort_const_ptr (byval m as gsl_matrix_ushort ptr, byval i as integer, byval j as integer) as ushort ptr
declare sub gsl_matrix_ushort_set_zero (byval m as gsl_matrix_ushort ptr)
declare sub gsl_matrix_ushort_set_identity (byval m as gsl_matrix_ushort ptr)
declare sub gsl_matrix_ushort_set_all (byval m as gsl_matrix_ushort ptr, byval x as ushort)
declare function gsl_matrix_ushort_fread (byval stream as FILE ptr, byval m as gsl_matrix_ushort ptr) as integer
declare function gsl_matrix_ushort_fwrite (byval stream as FILE ptr, byval m as gsl_matrix_ushort ptr) as integer
declare function gsl_matrix_ushort_fscanf (byval stream as FILE ptr, byval m as gsl_matrix_ushort ptr) as integer
declare function gsl_matrix_ushort_fprintf (byval stream as FILE ptr, byval m as gsl_matrix_ushort ptr, byval format as zstring ptr) as integer
declare function gsl_matrix_ushort_memcpy (byval dest as gsl_matrix_ushort ptr, byval src as gsl_matrix_ushort ptr) as integer
declare function gsl_matrix_ushort_swap (byval m1 as gsl_matrix_ushort ptr, byval m2 as gsl_matrix_ushort ptr) as integer
declare function gsl_matrix_ushort_swap_rows (byval m as gsl_matrix_ushort ptr, byval i as integer, byval j as integer) as integer
declare function gsl_matrix_ushort_swap_columns (byval m as gsl_matrix_ushort ptr, byval i as integer, byval j as integer) as integer
declare function gsl_matrix_ushort_swap_rowcol (byval m as gsl_matrix_ushort ptr, byval i as integer, byval j as integer) as integer
declare function gsl_matrix_ushort_transpose (byval m as gsl_matrix_ushort ptr) as integer
declare function gsl_matrix_ushort_transpose_memcpy (byval dest as gsl_matrix_ushort ptr, byval src as gsl_matrix_ushort ptr) as integer
declare function gsl_matrix_ushort_max (byval m as gsl_matrix_ushort ptr) as ushort
declare function gsl_matrix_ushort_min (byval m as gsl_matrix_ushort ptr) as ushort
declare sub gsl_matrix_ushort_minmax (byval m as gsl_matrix_ushort ptr, byval min_out as ushort ptr, byval max_out as ushort ptr)
declare sub gsl_matrix_ushort_max_index (byval m as gsl_matrix_ushort ptr, byval imax as integer ptr, byval jmax as integer ptr)
declare sub gsl_matrix_ushort_min_index (byval m as gsl_matrix_ushort ptr, byval imin as integer ptr, byval jmin as integer ptr)
declare sub gsl_matrix_ushort_minmax_index (byval m as gsl_matrix_ushort ptr, byval imin as integer ptr, byval jmin as integer ptr, byval imax as integer ptr, byval jmax as integer ptr)
declare function gsl_matrix_ushort_isnull (byval m as gsl_matrix_ushort ptr) as integer
declare function gsl_matrix_ushort_add (byval a as gsl_matrix_ushort ptr, byval b as gsl_matrix_ushort ptr) as integer
declare function gsl_matrix_ushort_sub (byval a as gsl_matrix_ushort ptr, byval b as gsl_matrix_ushort ptr) as integer
declare function gsl_matrix_ushort_mul_elements (byval a as gsl_matrix_ushort ptr, byval b as gsl_matrix_ushort ptr) as integer
declare function gsl_matrix_ushort_div_elements (byval a as gsl_matrix_ushort ptr, byval b as gsl_matrix_ushort ptr) as integer
declare function gsl_matrix_ushort_scale (byval a as gsl_matrix_ushort ptr, byval x as double) as integer
declare function gsl_matrix_ushort_add_constant (byval a as gsl_matrix_ushort ptr, byval x as double) as integer
declare function gsl_matrix_ushort_add_diagonal (byval a as gsl_matrix_ushort ptr, byval x as double) as integer
declare function gsl_matrix_ushort_get_row (byval v as gsl_vector_ushort ptr, byval m as gsl_matrix_ushort ptr, byval i as integer) as integer
declare function gsl_matrix_ushort_get_col (byval v as gsl_vector_ushort ptr, byval m as gsl_matrix_ushort ptr, byval j as integer) as integer
declare function gsl_matrix_ushort_set_row (byval m as gsl_matrix_ushort ptr, byval i as integer, byval v as gsl_vector_ushort ptr) as integer
declare function gsl_matrix_ushort_set_col (byval m as gsl_matrix_ushort ptr, byval j as integer, byval v as gsl_vector_ushort ptr) as integer
end extern

#endif
