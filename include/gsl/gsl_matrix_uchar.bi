''
''
'' gsl_matrix_uchar -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_matrix_uchar_bi__
#define __gsl_matrix_uchar_bi__

#include once "gsl_types.bi"
#include once "gsl_errno.bi"
#include once "gsl_check_range.bi"
#include once "gsl_vector_uchar.bi"

type gsl_matrix_uchar
	size1 as integer
	size2 as integer
	tda as integer
	data as ubyte ptr
	block as gsl_block_uchar ptr
	owner as integer
end type

type _gsl_matrix_uchar_view
	matrix as gsl_matrix_uchar
end type

type gsl_matrix_uchar_view as _gsl_matrix_uchar_view

type _gsl_matrix_uchar_const_view
	matrix as gsl_matrix_uchar
end type

type gsl_matrix_uchar_const_view as _gsl_matrix_uchar_const_view

extern "c"
declare function gsl_matrix_uchar_alloc (byval n1 as integer, byval n2 as integer) as gsl_matrix_uchar ptr
declare function gsl_matrix_uchar_calloc (byval n1 as integer, byval n2 as integer) as gsl_matrix_uchar ptr
declare function gsl_matrix_uchar_alloc_from_block (byval b as gsl_block_uchar ptr, byval offset as integer, byval n1 as integer, byval n2 as integer, byval d2 as integer) as gsl_matrix_uchar ptr
declare function gsl_matrix_uchar_alloc_from_matrix (byval m as gsl_matrix_uchar ptr, byval k1 as integer, byval k2 as integer, byval n1 as integer, byval n2 as integer) as gsl_matrix_uchar ptr
declare function gsl_vector_uchar_alloc_row_from_matrix (byval m as gsl_matrix_uchar ptr, byval i as integer) as gsl_vector_uchar ptr
declare function gsl_vector_uchar_alloc_col_from_matrix (byval m as gsl_matrix_uchar ptr, byval j as integer) as gsl_vector_uchar ptr
declare sub gsl_matrix_uchar_free (byval m as gsl_matrix_uchar ptr)
declare function gsl_matrix_uchar_submatrix (byval m as gsl_matrix_uchar ptr, byval i as integer, byval j as integer, byval n1 as integer, byval n2 as integer) as _gsl_matrix_uchar_view
declare function gsl_matrix_uchar_row (byval m as gsl_matrix_uchar ptr, byval i as integer) as _gsl_vector_uchar_view
declare function gsl_matrix_uchar_column (byval m as gsl_matrix_uchar ptr, byval j as integer) as _gsl_vector_uchar_view
declare function gsl_matrix_uchar_diagonal (byval m as gsl_matrix_uchar ptr) as _gsl_vector_uchar_view
declare function gsl_matrix_uchar_subdiagonal (byval m as gsl_matrix_uchar ptr, byval k as integer) as _gsl_vector_uchar_view
declare function gsl_matrix_uchar_superdiagonal (byval m as gsl_matrix_uchar ptr, byval k as integer) as _gsl_vector_uchar_view
declare function gsl_matrix_uchar_view_array (byval base as ubyte ptr, byval n1 as integer, byval n2 as integer) as _gsl_matrix_uchar_view
declare function gsl_matrix_uchar_view_array_with_tda (byval base as ubyte ptr, byval n1 as integer, byval n2 as integer, byval tda as integer) as _gsl_matrix_uchar_view
declare function gsl_matrix_uchar_view_vector (byval v as gsl_vector_uchar ptr, byval n1 as integer, byval n2 as integer) as _gsl_matrix_uchar_view
declare function gsl_matrix_uchar_view_vector_with_tda (byval v as gsl_vector_uchar ptr, byval n1 as integer, byval n2 as integer, byval tda as integer) as _gsl_matrix_uchar_view
declare function gsl_matrix_uchar_const_submatrix (byval m as gsl_matrix_uchar ptr, byval i as integer, byval j as integer, byval n1 as integer, byval n2 as integer) as _gsl_matrix_uchar_const_view
declare function gsl_matrix_uchar_const_row (byval m as gsl_matrix_uchar ptr, byval i as integer) as _gsl_vector_uchar_const_view
declare function gsl_matrix_uchar_const_column (byval m as gsl_matrix_uchar ptr, byval j as integer) as _gsl_vector_uchar_const_view
declare function gsl_matrix_uchar_const_diagonal (byval m as gsl_matrix_uchar ptr) as _gsl_vector_uchar_const_view
declare function gsl_matrix_uchar_const_subdiagonal (byval m as gsl_matrix_uchar ptr, byval k as integer) as _gsl_vector_uchar_const_view
declare function gsl_matrix_uchar_const_superdiagonal (byval m as gsl_matrix_uchar ptr, byval k as integer) as _gsl_vector_uchar_const_view
declare function gsl_matrix_uchar_const_view_array (byval base as ubyte ptr, byval n1 as integer, byval n2 as integer) as _gsl_matrix_uchar_const_view
declare function gsl_matrix_uchar_const_view_array_with_tda (byval base as ubyte ptr, byval n1 as integer, byval n2 as integer, byval tda as integer) as _gsl_matrix_uchar_const_view
declare function gsl_matrix_uchar_const_view_vector (byval v as gsl_vector_uchar ptr, byval n1 as integer, byval n2 as integer) as _gsl_matrix_uchar_const_view
declare function gsl_matrix_uchar_const_view_vector_with_tda (byval v as gsl_vector_uchar ptr, byval n1 as integer, byval n2 as integer, byval tda as integer) as _gsl_matrix_uchar_const_view
declare function gsl_matrix_uchar_get (byval m as gsl_matrix_uchar ptr, byval i as integer, byval j as integer) as ubyte
declare sub gsl_matrix_uchar_set (byval m as gsl_matrix_uchar ptr, byval i as integer, byval j as integer, byval x as ubyte)
declare function gsl_matrix_uchar_ptr (byval m as gsl_matrix_uchar ptr, byval i as integer, byval j as integer) as ubyte ptr
declare function gsl_matrix_uchar_const_ptr (byval m as gsl_matrix_uchar ptr, byval i as integer, byval j as integer) as ubyte ptr
declare sub gsl_matrix_uchar_set_zero (byval m as gsl_matrix_uchar ptr)
declare sub gsl_matrix_uchar_set_identity (byval m as gsl_matrix_uchar ptr)
declare sub gsl_matrix_uchar_set_all (byval m as gsl_matrix_uchar ptr, byval x as ubyte)
declare function gsl_matrix_uchar_fread (byval stream as FILE ptr, byval m as gsl_matrix_uchar ptr) as integer
declare function gsl_matrix_uchar_fwrite (byval stream as FILE ptr, byval m as gsl_matrix_uchar ptr) as integer
declare function gsl_matrix_uchar_fscanf (byval stream as FILE ptr, byval m as gsl_matrix_uchar ptr) as integer
declare function gsl_matrix_uchar_fprintf (byval stream as FILE ptr, byval m as gsl_matrix_uchar ptr, byval format as zstring ptr) as integer
declare function gsl_matrix_uchar_memcpy (byval dest as gsl_matrix_uchar ptr, byval src as gsl_matrix_uchar ptr) as integer
declare function gsl_matrix_uchar_swap (byval m1 as gsl_matrix_uchar ptr, byval m2 as gsl_matrix_uchar ptr) as integer
declare function gsl_matrix_uchar_swap_rows (byval m as gsl_matrix_uchar ptr, byval i as integer, byval j as integer) as integer
declare function gsl_matrix_uchar_swap_columns (byval m as gsl_matrix_uchar ptr, byval i as integer, byval j as integer) as integer
declare function gsl_matrix_uchar_swap_rowcol (byval m as gsl_matrix_uchar ptr, byval i as integer, byval j as integer) as integer
declare function gsl_matrix_uchar_transpose (byval m as gsl_matrix_uchar ptr) as integer
declare function gsl_matrix_uchar_transpose_memcpy (byval dest as gsl_matrix_uchar ptr, byval src as gsl_matrix_uchar ptr) as integer
declare function gsl_matrix_uchar_max (byval m as gsl_matrix_uchar ptr) as ubyte
declare function gsl_matrix_uchar_min (byval m as gsl_matrix_uchar ptr) as ubyte
declare sub gsl_matrix_uchar_minmax (byval m as gsl_matrix_uchar ptr, byval min_out as ubyte ptr, byval max_out as ubyte ptr)
declare sub gsl_matrix_uchar_max_index (byval m as gsl_matrix_uchar ptr, byval imax as integer ptr, byval jmax as integer ptr)
declare sub gsl_matrix_uchar_min_index (byval m as gsl_matrix_uchar ptr, byval imin as integer ptr, byval jmin as integer ptr)
declare sub gsl_matrix_uchar_minmax_index (byval m as gsl_matrix_uchar ptr, byval imin as integer ptr, byval jmin as integer ptr, byval imax as integer ptr, byval jmax as integer ptr)
declare function gsl_matrix_uchar_isnull (byval m as gsl_matrix_uchar ptr) as integer
declare function gsl_matrix_uchar_add (byval a as gsl_matrix_uchar ptr, byval b as gsl_matrix_uchar ptr) as integer
declare function gsl_matrix_uchar_sub (byval a as gsl_matrix_uchar ptr, byval b as gsl_matrix_uchar ptr) as integer
declare function gsl_matrix_uchar_mul_elements (byval a as gsl_matrix_uchar ptr, byval b as gsl_matrix_uchar ptr) as integer
declare function gsl_matrix_uchar_div_elements (byval a as gsl_matrix_uchar ptr, byval b as gsl_matrix_uchar ptr) as integer
declare function gsl_matrix_uchar_scale (byval a as gsl_matrix_uchar ptr, byval x as double) as integer
declare function gsl_matrix_uchar_add_constant (byval a as gsl_matrix_uchar ptr, byval x as double) as integer
declare function gsl_matrix_uchar_add_diagonal (byval a as gsl_matrix_uchar ptr, byval x as double) as integer
declare function gsl_matrix_uchar_get_row (byval v as gsl_vector_uchar ptr, byval m as gsl_matrix_uchar ptr, byval i as integer) as integer
declare function gsl_matrix_uchar_get_col (byval v as gsl_vector_uchar ptr, byval m as gsl_matrix_uchar ptr, byval j as integer) as integer
declare function gsl_matrix_uchar_set_row (byval m as gsl_matrix_uchar ptr, byval i as integer, byval v as gsl_vector_uchar ptr) as integer
declare function gsl_matrix_uchar_set_col (byval m as gsl_matrix_uchar ptr, byval j as integer, byval v as gsl_vector_uchar ptr) as integer
end extern

#endif
