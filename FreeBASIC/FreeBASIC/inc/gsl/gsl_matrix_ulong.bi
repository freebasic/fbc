''
''
'' gsl_matrix_ulong -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_matrix_ulong_bi__
#define __gsl_matrix_ulong_bi__

#include once "gsl_types.bi"
#include once "gsl_errno.bi"
#include once "gsl_check_range.bi"
#include once "gsl_vector_ulong.bi"

type gsl_matrix_ulong
	size1 as integer
	size2 as integer
	tda as integer
	data as uinteger ptr
	block as gsl_block_ulong ptr
	owner as integer
end type

type _gsl_matrix_ulong_view
	matrix as gsl_matrix_ulong
end type

type gsl_matrix_ulong_view as _gsl_matrix_ulong_view

type _gsl_matrix_ulong_const_view
	matrix as gsl_matrix_ulong
end type

type gsl_matrix_ulong_const_view as _gsl_matrix_ulong_const_view

extern "c"
declare function gsl_matrix_ulong_alloc (byval n1 as integer, byval n2 as integer) as gsl_matrix_ulong ptr
declare function gsl_matrix_ulong_calloc (byval n1 as integer, byval n2 as integer) as gsl_matrix_ulong ptr
declare function gsl_matrix_ulong_alloc_from_block (byval b as gsl_block_ulong ptr, byval offset as integer, byval n1 as integer, byval n2 as integer, byval d2 as integer) as gsl_matrix_ulong ptr
declare function gsl_matrix_ulong_alloc_from_matrix (byval m as gsl_matrix_ulong ptr, byval k1 as integer, byval k2 as integer, byval n1 as integer, byval n2 as integer) as gsl_matrix_ulong ptr
declare function gsl_vector_ulong_alloc_row_from_matrix (byval m as gsl_matrix_ulong ptr, byval i as integer) as gsl_vector_ulong ptr
declare function gsl_vector_ulong_alloc_col_from_matrix (byval m as gsl_matrix_ulong ptr, byval j as integer) as gsl_vector_ulong ptr
declare sub gsl_matrix_ulong_free (byval m as gsl_matrix_ulong ptr)
declare function gsl_matrix_ulong_submatrix (byval m as gsl_matrix_ulong ptr, byval i as integer, byval j as integer, byval n1 as integer, byval n2 as integer) as _gsl_matrix_ulong_view
declare function gsl_matrix_ulong_row (byval m as gsl_matrix_ulong ptr, byval i as integer) as _gsl_vector_ulong_view
declare function gsl_matrix_ulong_column (byval m as gsl_matrix_ulong ptr, byval j as integer) as _gsl_vector_ulong_view
declare function gsl_matrix_ulong_diagonal (byval m as gsl_matrix_ulong ptr) as _gsl_vector_ulong_view
declare function gsl_matrix_ulong_subdiagonal (byval m as gsl_matrix_ulong ptr, byval k as integer) as _gsl_vector_ulong_view
declare function gsl_matrix_ulong_superdiagonal (byval m as gsl_matrix_ulong ptr, byval k as integer) as _gsl_vector_ulong_view
declare function gsl_matrix_ulong_view_array (byval base as uinteger ptr, byval n1 as integer, byval n2 as integer) as _gsl_matrix_ulong_view
declare function gsl_matrix_ulong_view_array_with_tda (byval base as uinteger ptr, byval n1 as integer, byval n2 as integer, byval tda as integer) as _gsl_matrix_ulong_view
declare function gsl_matrix_ulong_view_vector (byval v as gsl_vector_ulong ptr, byval n1 as integer, byval n2 as integer) as _gsl_matrix_ulong_view
declare function gsl_matrix_ulong_view_vector_with_tda (byval v as gsl_vector_ulong ptr, byval n1 as integer, byval n2 as integer, byval tda as integer) as _gsl_matrix_ulong_view
declare function gsl_matrix_ulong_const_submatrix (byval m as gsl_matrix_ulong ptr, byval i as integer, byval j as integer, byval n1 as integer, byval n2 as integer) as _gsl_matrix_ulong_const_view
declare function gsl_matrix_ulong_const_row (byval m as gsl_matrix_ulong ptr, byval i as integer) as _gsl_vector_ulong_const_view
declare function gsl_matrix_ulong_const_column (byval m as gsl_matrix_ulong ptr, byval j as integer) as _gsl_vector_ulong_const_view
declare function gsl_matrix_ulong_const_diagonal (byval m as gsl_matrix_ulong ptr) as _gsl_vector_ulong_const_view
declare function gsl_matrix_ulong_const_subdiagonal (byval m as gsl_matrix_ulong ptr, byval k as integer) as _gsl_vector_ulong_const_view
declare function gsl_matrix_ulong_const_superdiagonal (byval m as gsl_matrix_ulong ptr, byval k as integer) as _gsl_vector_ulong_const_view
declare function gsl_matrix_ulong_const_view_array (byval base as uinteger ptr, byval n1 as integer, byval n2 as integer) as _gsl_matrix_ulong_const_view
declare function gsl_matrix_ulong_const_view_array_with_tda (byval base as uinteger ptr, byval n1 as integer, byval n2 as integer, byval tda as integer) as _gsl_matrix_ulong_const_view
declare function gsl_matrix_ulong_const_view_vector (byval v as gsl_vector_ulong ptr, byval n1 as integer, byval n2 as integer) as _gsl_matrix_ulong_const_view
declare function gsl_matrix_ulong_const_view_vector_with_tda (byval v as gsl_vector_ulong ptr, byval n1 as integer, byval n2 as integer, byval tda as integer) as _gsl_matrix_ulong_const_view
declare function gsl_matrix_ulong_get (byval m as gsl_matrix_ulong ptr, byval i as integer, byval j as integer) as uinteger
declare sub gsl_matrix_ulong_set (byval m as gsl_matrix_ulong ptr, byval i as integer, byval j as integer, byval x as uinteger)
declare function gsl_matrix_ulong_ptr (byval m as gsl_matrix_ulong ptr, byval i as integer, byval j as integer) as uinteger ptr
declare function gsl_matrix_ulong_const_ptr (byval m as gsl_matrix_ulong ptr, byval i as integer, byval j as integer) as uinteger ptr
declare sub gsl_matrix_ulong_set_zero (byval m as gsl_matrix_ulong ptr)
declare sub gsl_matrix_ulong_set_identity (byval m as gsl_matrix_ulong ptr)
declare sub gsl_matrix_ulong_set_all (byval m as gsl_matrix_ulong ptr, byval x as uinteger)
declare function gsl_matrix_ulong_fread (byval stream as FILE ptr, byval m as gsl_matrix_ulong ptr) as integer
declare function gsl_matrix_ulong_fwrite (byval stream as FILE ptr, byval m as gsl_matrix_ulong ptr) as integer
declare function gsl_matrix_ulong_fscanf (byval stream as FILE ptr, byval m as gsl_matrix_ulong ptr) as integer
declare function gsl_matrix_ulong_fprintf (byval stream as FILE ptr, byval m as gsl_matrix_ulong ptr, byval format as zstring ptr) as integer
declare function gsl_matrix_ulong_memcpy (byval dest as gsl_matrix_ulong ptr, byval src as gsl_matrix_ulong ptr) as integer
declare function gsl_matrix_ulong_swap (byval m1 as gsl_matrix_ulong ptr, byval m2 as gsl_matrix_ulong ptr) as integer
declare function gsl_matrix_ulong_swap_rows (byval m as gsl_matrix_ulong ptr, byval i as integer, byval j as integer) as integer
declare function gsl_matrix_ulong_swap_columns (byval m as gsl_matrix_ulong ptr, byval i as integer, byval j as integer) as integer
declare function gsl_matrix_ulong_swap_rowcol (byval m as gsl_matrix_ulong ptr, byval i as integer, byval j as integer) as integer
declare function gsl_matrix_ulong_transpose (byval m as gsl_matrix_ulong ptr) as integer
declare function gsl_matrix_ulong_transpose_memcpy (byval dest as gsl_matrix_ulong ptr, byval src as gsl_matrix_ulong ptr) as integer
declare function gsl_matrix_ulong_max (byval m as gsl_matrix_ulong ptr) as uinteger
declare function gsl_matrix_ulong_min (byval m as gsl_matrix_ulong ptr) as uinteger
declare sub gsl_matrix_ulong_minmax (byval m as gsl_matrix_ulong ptr, byval min_out as uinteger ptr, byval max_out as uinteger ptr)
declare sub gsl_matrix_ulong_max_index (byval m as gsl_matrix_ulong ptr, byval imax as integer ptr, byval jmax as integer ptr)
declare sub gsl_matrix_ulong_min_index (byval m as gsl_matrix_ulong ptr, byval imin as integer ptr, byval jmin as integer ptr)
declare sub gsl_matrix_ulong_minmax_index (byval m as gsl_matrix_ulong ptr, byval imin as integer ptr, byval jmin as integer ptr, byval imax as integer ptr, byval jmax as integer ptr)
declare function gsl_matrix_ulong_isnull (byval m as gsl_matrix_ulong ptr) as integer
declare function gsl_matrix_ulong_add (byval a as gsl_matrix_ulong ptr, byval b as gsl_matrix_ulong ptr) as integer
declare function gsl_matrix_ulong_sub (byval a as gsl_matrix_ulong ptr, byval b as gsl_matrix_ulong ptr) as integer
declare function gsl_matrix_ulong_mul_elements (byval a as gsl_matrix_ulong ptr, byval b as gsl_matrix_ulong ptr) as integer
declare function gsl_matrix_ulong_div_elements (byval a as gsl_matrix_ulong ptr, byval b as gsl_matrix_ulong ptr) as integer
declare function gsl_matrix_ulong_scale (byval a as gsl_matrix_ulong ptr, byval x as double) as integer
declare function gsl_matrix_ulong_add_constant (byval a as gsl_matrix_ulong ptr, byval x as double) as integer
declare function gsl_matrix_ulong_add_diagonal (byval a as gsl_matrix_ulong ptr, byval x as double) as integer
declare function gsl_matrix_ulong_get_row (byval v as gsl_vector_ulong ptr, byval m as gsl_matrix_ulong ptr, byval i as integer) as integer
declare function gsl_matrix_ulong_get_col (byval v as gsl_vector_ulong ptr, byval m as gsl_matrix_ulong ptr, byval j as integer) as integer
declare function gsl_matrix_ulong_set_row (byval m as gsl_matrix_ulong ptr, byval i as integer, byval v as gsl_vector_ulong ptr) as integer
declare function gsl_matrix_ulong_set_col (byval m as gsl_matrix_ulong ptr, byval j as integer, byval v as gsl_vector_ulong ptr) as integer
end extern

#endif
