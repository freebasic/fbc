''
''
'' gsl_matrix_char -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_matrix_char_bi__
#define __gsl_matrix_char_bi__

#include once "gsl_types.bi"
#include once "gsl_errno.bi"
#include once "gsl_check_range.bi"
#include once "gsl_vector_char.bi"

type gsl_matrix_char
	size1 as integer
	size2 as integer
	tda as integer
	data as byte ptr
	block as gsl_block_char ptr
	owner as integer
end type

type _gsl_matrix_char_view
	matrix as gsl_matrix_char
end type

type gsl_matrix_char_view as _gsl_matrix_char_view

type _gsl_matrix_char_const_view
	matrix as gsl_matrix_char
end type

type gsl_matrix_char_const_view as _gsl_matrix_char_const_view

extern "c"
declare function gsl_matrix_char_alloc (byval n1 as integer, byval n2 as integer) as gsl_matrix_char ptr
declare function gsl_matrix_char_calloc (byval n1 as integer, byval n2 as integer) as gsl_matrix_char ptr
declare function gsl_matrix_char_alloc_from_block (byval b as gsl_block_char ptr, byval offset as integer, byval n1 as integer, byval n2 as integer, byval d2 as integer) as gsl_matrix_char ptr
declare function gsl_matrix_char_alloc_from_matrix (byval m as gsl_matrix_char ptr, byval k1 as integer, byval k2 as integer, byval n1 as integer, byval n2 as integer) as gsl_matrix_char ptr
declare function gsl_vector_char_alloc_row_from_matrix (byval m as gsl_matrix_char ptr, byval i as integer) as gsl_vector_char ptr
declare function gsl_vector_char_alloc_col_from_matrix (byval m as gsl_matrix_char ptr, byval j as integer) as gsl_vector_char ptr
declare sub gsl_matrix_char_free (byval m as gsl_matrix_char ptr)
declare function gsl_matrix_char_submatrix (byval m as gsl_matrix_char ptr, byval i as integer, byval j as integer, byval n1 as integer, byval n2 as integer) as _gsl_matrix_char_view
declare function gsl_matrix_char_row (byval m as gsl_matrix_char ptr, byval i as integer) as _gsl_vector_char_view
declare function gsl_matrix_char_column (byval m as gsl_matrix_char ptr, byval j as integer) as _gsl_vector_char_view
declare function gsl_matrix_char_diagonal (byval m as gsl_matrix_char ptr) as _gsl_vector_char_view
declare function gsl_matrix_char_subdiagonal (byval m as gsl_matrix_char ptr, byval k as integer) as _gsl_vector_char_view
declare function gsl_matrix_char_superdiagonal (byval m as gsl_matrix_char ptr, byval k as integer) as _gsl_vector_char_view
declare function gsl_matrix_char_view_array (byval base as zstring ptr, byval n1 as integer, byval n2 as integer) as _gsl_matrix_char_view
declare function gsl_matrix_char_view_array_with_tda (byval base as zstring ptr, byval n1 as integer, byval n2 as integer, byval tda as integer) as _gsl_matrix_char_view
declare function gsl_matrix_char_view_vector (byval v as gsl_vector_char ptr, byval n1 as integer, byval n2 as integer) as _gsl_matrix_char_view
declare function gsl_matrix_char_view_vector_with_tda (byval v as gsl_vector_char ptr, byval n1 as integer, byval n2 as integer, byval tda as integer) as _gsl_matrix_char_view
declare function gsl_matrix_char_const_submatrix (byval m as gsl_matrix_char ptr, byval i as integer, byval j as integer, byval n1 as integer, byval n2 as integer) as _gsl_matrix_char_const_view
declare function gsl_matrix_char_const_row (byval m as gsl_matrix_char ptr, byval i as integer) as _gsl_vector_char_const_view
declare function gsl_matrix_char_const_column (byval m as gsl_matrix_char ptr, byval j as integer) as _gsl_vector_char_const_view
declare function gsl_matrix_char_const_diagonal (byval m as gsl_matrix_char ptr) as _gsl_vector_char_const_view
declare function gsl_matrix_char_const_subdiagonal (byval m as gsl_matrix_char ptr, byval k as integer) as _gsl_vector_char_const_view
declare function gsl_matrix_char_const_superdiagonal (byval m as gsl_matrix_char ptr, byval k as integer) as _gsl_vector_char_const_view
declare function gsl_matrix_char_const_view_array (byval base as zstring ptr, byval n1 as integer, byval n2 as integer) as _gsl_matrix_char_const_view
declare function gsl_matrix_char_const_view_array_with_tda (byval base as zstring ptr, byval n1 as integer, byval n2 as integer, byval tda as integer) as _gsl_matrix_char_const_view
declare function gsl_matrix_char_const_view_vector (byval v as gsl_vector_char ptr, byval n1 as integer, byval n2 as integer) as _gsl_matrix_char_const_view
declare function gsl_matrix_char_const_view_vector_with_tda (byval v as gsl_vector_char ptr, byval n1 as integer, byval n2 as integer, byval tda as integer) as _gsl_matrix_char_const_view
declare function gsl_matrix_char_get (byval m as gsl_matrix_char ptr, byval i as integer, byval j as integer) as byte
declare sub gsl_matrix_char_set (byval m as gsl_matrix_char ptr, byval i as integer, byval j as integer, byval x as byte)
declare function gsl_matrix_char_ptr (byval m as gsl_matrix_char ptr, byval i as integer, byval j as integer) as zstring ptr
declare function gsl_matrix_char_const_ptr (byval m as gsl_matrix_char ptr, byval i as integer, byval j as integer) as zstring ptr
declare sub gsl_matrix_char_set_zero (byval m as gsl_matrix_char ptr)
declare sub gsl_matrix_char_set_identity (byval m as gsl_matrix_char ptr)
declare sub gsl_matrix_char_set_all (byval m as gsl_matrix_char ptr, byval x as byte)
declare function gsl_matrix_char_fread (byval stream as FILE ptr, byval m as gsl_matrix_char ptr) as integer
declare function gsl_matrix_char_fwrite (byval stream as FILE ptr, byval m as gsl_matrix_char ptr) as integer
declare function gsl_matrix_char_fscanf (byval stream as FILE ptr, byval m as gsl_matrix_char ptr) as integer
declare function gsl_matrix_char_fprintf (byval stream as FILE ptr, byval m as gsl_matrix_char ptr, byval format as zstring ptr) as integer
declare function gsl_matrix_char_memcpy (byval dest as gsl_matrix_char ptr, byval src as gsl_matrix_char ptr) as integer
declare function gsl_matrix_char_swap (byval m1 as gsl_matrix_char ptr, byval m2 as gsl_matrix_char ptr) as integer
declare function gsl_matrix_char_swap_rows (byval m as gsl_matrix_char ptr, byval i as integer, byval j as integer) as integer
declare function gsl_matrix_char_swap_columns (byval m as gsl_matrix_char ptr, byval i as integer, byval j as integer) as integer
declare function gsl_matrix_char_swap_rowcol (byval m as gsl_matrix_char ptr, byval i as integer, byval j as integer) as integer
declare function gsl_matrix_char_transpose (byval m as gsl_matrix_char ptr) as integer
declare function gsl_matrix_char_transpose_memcpy (byval dest as gsl_matrix_char ptr, byval src as gsl_matrix_char ptr) as integer
declare function gsl_matrix_char_max (byval m as gsl_matrix_char ptr) as byte
declare function gsl_matrix_char_min (byval m as gsl_matrix_char ptr) as byte
declare sub gsl_matrix_char_minmax (byval m as gsl_matrix_char ptr, byval min_out as zstring ptr, byval max_out as zstring ptr)
declare sub gsl_matrix_char_max_index (byval m as gsl_matrix_char ptr, byval imax as integer ptr, byval jmax as integer ptr)
declare sub gsl_matrix_char_min_index (byval m as gsl_matrix_char ptr, byval imin as integer ptr, byval jmin as integer ptr)
declare sub gsl_matrix_char_minmax_index (byval m as gsl_matrix_char ptr, byval imin as integer ptr, byval jmin as integer ptr, byval imax as integer ptr, byval jmax as integer ptr)
declare function gsl_matrix_char_isnull (byval m as gsl_matrix_char ptr) as integer
declare function gsl_matrix_char_add (byval a as gsl_matrix_char ptr, byval b as gsl_matrix_char ptr) as integer
declare function gsl_matrix_char_sub (byval a as gsl_matrix_char ptr, byval b as gsl_matrix_char ptr) as integer
declare function gsl_matrix_char_mul_elements (byval a as gsl_matrix_char ptr, byval b as gsl_matrix_char ptr) as integer
declare function gsl_matrix_char_div_elements (byval a as gsl_matrix_char ptr, byval b as gsl_matrix_char ptr) as integer
declare function gsl_matrix_char_scale (byval a as gsl_matrix_char ptr, byval x as double) as integer
declare function gsl_matrix_char_add_constant (byval a as gsl_matrix_char ptr, byval x as double) as integer
declare function gsl_matrix_char_add_diagonal (byval a as gsl_matrix_char ptr, byval x as double) as integer
declare function gsl_matrix_char_get_row (byval v as gsl_vector_char ptr, byval m as gsl_matrix_char ptr, byval i as integer) as integer
declare function gsl_matrix_char_get_col (byval v as gsl_vector_char ptr, byval m as gsl_matrix_char ptr, byval j as integer) as integer
declare function gsl_matrix_char_set_row (byval m as gsl_matrix_char ptr, byval i as integer, byval v as gsl_vector_char ptr) as integer
declare function gsl_matrix_char_set_col (byval m as gsl_matrix_char ptr, byval j as integer, byval v as gsl_vector_char ptr) as integer
end extern

#endif
