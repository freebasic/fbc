''
''
'' gsl_matrix_uint -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_matrix_uint_bi__
#define __gsl_matrix_uint_bi__

#include once "gsl_types.bi"
#include once "gsl_errno.bi"
#include once "gsl_check_range.bi"
#include once "gsl_vector_uint.bi"

type gsl_matrix_uint
	size1 as integer
	size2 as integer
	tda as integer
	data as uinteger ptr
	block as gsl_block_uint ptr
	owner as integer
end type

type _gsl_matrix_uint_view
	matrix as gsl_matrix_uint
end type

type gsl_matrix_uint_view as _gsl_matrix_uint_view

type _gsl_matrix_uint_const_view
	matrix as gsl_matrix_uint
end type

type gsl_matrix_uint_const_view as _gsl_matrix_uint_const_view

extern "c"
declare function gsl_matrix_uint_alloc (byval n1 as integer, byval n2 as integer) as gsl_matrix_uint ptr
declare function gsl_matrix_uint_calloc (byval n1 as integer, byval n2 as integer) as gsl_matrix_uint ptr
declare function gsl_matrix_uint_alloc_from_block (byval b as gsl_block_uint ptr, byval offset as integer, byval n1 as integer, byval n2 as integer, byval d2 as integer) as gsl_matrix_uint ptr
declare function gsl_matrix_uint_alloc_from_matrix (byval m as gsl_matrix_uint ptr, byval k1 as integer, byval k2 as integer, byval n1 as integer, byval n2 as integer) as gsl_matrix_uint ptr
declare function gsl_vector_uint_alloc_row_from_matrix (byval m as gsl_matrix_uint ptr, byval i as integer) as gsl_vector_uint ptr
declare function gsl_vector_uint_alloc_col_from_matrix (byval m as gsl_matrix_uint ptr, byval j as integer) as gsl_vector_uint ptr
declare sub gsl_matrix_uint_free (byval m as gsl_matrix_uint ptr)
declare function gsl_matrix_uint_submatrix (byval m as gsl_matrix_uint ptr, byval i as integer, byval j as integer, byval n1 as integer, byval n2 as integer) as _gsl_matrix_uint_view
declare function gsl_matrix_uint_row (byval m as gsl_matrix_uint ptr, byval i as integer) as _gsl_vector_uint_view
declare function gsl_matrix_uint_column (byval m as gsl_matrix_uint ptr, byval j as integer) as _gsl_vector_uint_view
declare function gsl_matrix_uint_diagonal (byval m as gsl_matrix_uint ptr) as _gsl_vector_uint_view
declare function gsl_matrix_uint_subdiagonal (byval m as gsl_matrix_uint ptr, byval k as integer) as _gsl_vector_uint_view
declare function gsl_matrix_uint_superdiagonal (byval m as gsl_matrix_uint ptr, byval k as integer) as _gsl_vector_uint_view
declare function gsl_matrix_uint_view_array (byval base as uinteger ptr, byval n1 as integer, byval n2 as integer) as _gsl_matrix_uint_view
declare function gsl_matrix_uint_view_array_with_tda (byval base as uinteger ptr, byval n1 as integer, byval n2 as integer, byval tda as integer) as _gsl_matrix_uint_view
declare function gsl_matrix_uint_view_vector (byval v as gsl_vector_uint ptr, byval n1 as integer, byval n2 as integer) as _gsl_matrix_uint_view
declare function gsl_matrix_uint_view_vector_with_tda (byval v as gsl_vector_uint ptr, byval n1 as integer, byval n2 as integer, byval tda as integer) as _gsl_matrix_uint_view
declare function gsl_matrix_uint_const_submatrix (byval m as gsl_matrix_uint ptr, byval i as integer, byval j as integer, byval n1 as integer, byval n2 as integer) as _gsl_matrix_uint_const_view
declare function gsl_matrix_uint_const_row (byval m as gsl_matrix_uint ptr, byval i as integer) as _gsl_vector_uint_const_view
declare function gsl_matrix_uint_const_column (byval m as gsl_matrix_uint ptr, byval j as integer) as _gsl_vector_uint_const_view
declare function gsl_matrix_uint_const_diagonal (byval m as gsl_matrix_uint ptr) as _gsl_vector_uint_const_view
declare function gsl_matrix_uint_const_subdiagonal (byval m as gsl_matrix_uint ptr, byval k as integer) as _gsl_vector_uint_const_view
declare function gsl_matrix_uint_const_superdiagonal (byval m as gsl_matrix_uint ptr, byval k as integer) as _gsl_vector_uint_const_view
declare function gsl_matrix_uint_const_view_array (byval base as uinteger ptr, byval n1 as integer, byval n2 as integer) as _gsl_matrix_uint_const_view
declare function gsl_matrix_uint_const_view_array_with_tda (byval base as uinteger ptr, byval n1 as integer, byval n2 as integer, byval tda as integer) as _gsl_matrix_uint_const_view
declare function gsl_matrix_uint_const_view_vector (byval v as gsl_vector_uint ptr, byval n1 as integer, byval n2 as integer) as _gsl_matrix_uint_const_view
declare function gsl_matrix_uint_const_view_vector_with_tda (byval v as gsl_vector_uint ptr, byval n1 as integer, byval n2 as integer, byval tda as integer) as _gsl_matrix_uint_const_view
declare function gsl_matrix_uint_get (byval m as gsl_matrix_uint ptr, byval i as integer, byval j as integer) as uinteger
declare sub gsl_matrix_uint_set (byval m as gsl_matrix_uint ptr, byval i as integer, byval j as integer, byval x as uinteger)
declare function gsl_matrix_uint_ptr (byval m as gsl_matrix_uint ptr, byval i as integer, byval j as integer) as uinteger ptr
declare function gsl_matrix_uint_const_ptr (byval m as gsl_matrix_uint ptr, byval i as integer, byval j as integer) as uinteger ptr
declare sub gsl_matrix_uint_set_zero (byval m as gsl_matrix_uint ptr)
declare sub gsl_matrix_uint_set_identity (byval m as gsl_matrix_uint ptr)
declare sub gsl_matrix_uint_set_all (byval m as gsl_matrix_uint ptr, byval x as uinteger)
declare function gsl_matrix_uint_fread (byval stream as FILE ptr, byval m as gsl_matrix_uint ptr) as integer
declare function gsl_matrix_uint_fwrite (byval stream as FILE ptr, byval m as gsl_matrix_uint ptr) as integer
declare function gsl_matrix_uint_fscanf (byval stream as FILE ptr, byval m as gsl_matrix_uint ptr) as integer
declare function gsl_matrix_uint_fprintf (byval stream as FILE ptr, byval m as gsl_matrix_uint ptr, byval format as zstring ptr) as integer
declare function gsl_matrix_uint_memcpy (byval dest as gsl_matrix_uint ptr, byval src as gsl_matrix_uint ptr) as integer
declare function gsl_matrix_uint_swap (byval m1 as gsl_matrix_uint ptr, byval m2 as gsl_matrix_uint ptr) as integer
declare function gsl_matrix_uint_swap_rows (byval m as gsl_matrix_uint ptr, byval i as integer, byval j as integer) as integer
declare function gsl_matrix_uint_swap_columns (byval m as gsl_matrix_uint ptr, byval i as integer, byval j as integer) as integer
declare function gsl_matrix_uint_swap_rowcol (byval m as gsl_matrix_uint ptr, byval i as integer, byval j as integer) as integer
declare function gsl_matrix_uint_transpose (byval m as gsl_matrix_uint ptr) as integer
declare function gsl_matrix_uint_transpose_memcpy (byval dest as gsl_matrix_uint ptr, byval src as gsl_matrix_uint ptr) as integer
declare function gsl_matrix_uint_max (byval m as gsl_matrix_uint ptr) as uinteger
declare function gsl_matrix_uint_min (byval m as gsl_matrix_uint ptr) as uinteger
declare sub gsl_matrix_uint_minmax (byval m as gsl_matrix_uint ptr, byval min_out as uinteger ptr, byval max_out as uinteger ptr)
declare sub gsl_matrix_uint_max_index (byval m as gsl_matrix_uint ptr, byval imax as integer ptr, byval jmax as integer ptr)
declare sub gsl_matrix_uint_min_index (byval m as gsl_matrix_uint ptr, byval imin as integer ptr, byval jmin as integer ptr)
declare sub gsl_matrix_uint_minmax_index (byval m as gsl_matrix_uint ptr, byval imin as integer ptr, byval jmin as integer ptr, byval imax as integer ptr, byval jmax as integer ptr)
declare function gsl_matrix_uint_isnull (byval m as gsl_matrix_uint ptr) as integer
declare function gsl_matrix_uint_add (byval a as gsl_matrix_uint ptr, byval b as gsl_matrix_uint ptr) as integer
declare function gsl_matrix_uint_sub (byval a as gsl_matrix_uint ptr, byval b as gsl_matrix_uint ptr) as integer
declare function gsl_matrix_uint_mul_elements (byval a as gsl_matrix_uint ptr, byval b as gsl_matrix_uint ptr) as integer
declare function gsl_matrix_uint_div_elements (byval a as gsl_matrix_uint ptr, byval b as gsl_matrix_uint ptr) as integer
declare function gsl_matrix_uint_scale (byval a as gsl_matrix_uint ptr, byval x as double) as integer
declare function gsl_matrix_uint_add_constant (byval a as gsl_matrix_uint ptr, byval x as double) as integer
declare function gsl_matrix_uint_add_diagonal (byval a as gsl_matrix_uint ptr, byval x as double) as integer
declare function gsl_matrix_uint_get_row (byval v as gsl_vector_uint ptr, byval m as gsl_matrix_uint ptr, byval i as integer) as integer
declare function gsl_matrix_uint_get_col (byval v as gsl_vector_uint ptr, byval m as gsl_matrix_uint ptr, byval j as integer) as integer
declare function gsl_matrix_uint_set_row (byval m as gsl_matrix_uint ptr, byval i as integer, byval v as gsl_vector_uint ptr) as integer
declare function gsl_matrix_uint_set_col (byval m as gsl_matrix_uint ptr, byval j as integer, byval v as gsl_vector_uint ptr) as integer
end extern

#endif
