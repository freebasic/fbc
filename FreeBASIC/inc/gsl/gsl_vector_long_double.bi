''
''
'' gsl_vector_long_double -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_vector_long_double_bi__
#define __gsl_vector_long_double_bi__

#include once "gsl_types.bi"
#include once "gsl_errno.bi"
#include once "gsl_check_range.bi"
#include once "gsl_block_long_double.bi"

type gsl_vector_long_double
	size as integer
	stride as integer
	data as double ptr
	block as gsl_block_long_double ptr
	owner as integer
end type

type _gsl_vector_long_double_view
	vector as gsl_vector_long_double
end type

type gsl_vector_long_double_view as _gsl_vector_long_double_view

type _gsl_vector_long_double_const_view
	vector as gsl_vector_long_double
end type

type gsl_vector_long_double_const_view as _gsl_vector_long_double_const_view

extern "c"
declare function gsl_vector_long_double_alloc (byval n as integer) as gsl_vector_long_double ptr
declare function gsl_vector_long_double_calloc (byval n as integer) as gsl_vector_long_double ptr
declare function gsl_vector_long_double_alloc_from_block (byval b as gsl_block_long_double ptr, byval offset as integer, byval n as integer, byval stride as integer) as gsl_vector_long_double ptr
declare function gsl_vector_long_double_alloc_from_vector (byval v as gsl_vector_long_double ptr, byval offset as integer, byval n as integer, byval stride as integer) as gsl_vector_long_double ptr
declare sub gsl_vector_long_double_free (byval v as gsl_vector_long_double ptr)
declare function gsl_vector_long_double_view_array (byval v as double ptr, byval n as integer) as _gsl_vector_long_double_view
declare function gsl_vector_long_double_view_array_with_stride (byval base as double ptr, byval stride as integer, byval n as integer) as _gsl_vector_long_double_view
declare function gsl_vector_long_double_const_view_array (byval v as double ptr, byval n as integer) as _gsl_vector_long_double_const_view
declare function gsl_vector_long_double_const_view_array_with_stride (byval base as double ptr, byval stride as integer, byval n as integer) as _gsl_vector_long_double_const_view
declare function gsl_vector_long_double_subvector (byval v as gsl_vector_long_double ptr, byval i as integer, byval n as integer) as _gsl_vector_long_double_view
declare function gsl_vector_long_double_subvector_with_stride (byval v as gsl_vector_long_double ptr, byval i as integer, byval stride as integer, byval n as integer) as _gsl_vector_long_double_view
declare function gsl_vector_long_double_const_subvector (byval v as gsl_vector_long_double ptr, byval i as integer, byval n as integer) as _gsl_vector_long_double_const_view
declare function gsl_vector_long_double_const_subvector_with_stride (byval v as gsl_vector_long_double ptr, byval i as integer, byval stride as integer, byval n as integer) as _gsl_vector_long_double_const_view
declare function gsl_vector_long_double_get (byval v as gsl_vector_long_double ptr, byval i as integer) as double
declare sub gsl_vector_long_double_set (byval v as gsl_vector_long_double ptr, byval i as integer, byval x as double)
declare function gsl_vector_long_double_ptr (byval v as gsl_vector_long_double ptr, byval i as integer) as double ptr
declare function gsl_vector_long_double_const_ptr (byval v as gsl_vector_long_double ptr, byval i as integer) as double ptr
declare sub gsl_vector_long_double_set_zero (byval v as gsl_vector_long_double ptr)
declare sub gsl_vector_long_double_set_all (byval v as gsl_vector_long_double ptr, byval x as double)
declare function gsl_vector_long_double_set_basis (byval v as gsl_vector_long_double ptr, byval i as integer) as integer
declare function gsl_vector_long_double_fread (byval stream as FILE ptr, byval v as gsl_vector_long_double ptr) as integer
declare function gsl_vector_long_double_fwrite (byval stream as FILE ptr, byval v as gsl_vector_long_double ptr) as integer
declare function gsl_vector_long_double_fscanf (byval stream as FILE ptr, byval v as gsl_vector_long_double ptr) as integer
declare function gsl_vector_long_double_fprintf (byval stream as FILE ptr, byval v as gsl_vector_long_double ptr, byval format as zstring ptr) as integer
declare function gsl_vector_long_double_memcpy (byval dest as gsl_vector_long_double ptr, byval src as gsl_vector_long_double ptr) as integer
declare function gsl_vector_long_double_reverse (byval v as gsl_vector_long_double ptr) as integer
declare function gsl_vector_long_double_swap (byval v as gsl_vector_long_double ptr, byval w as gsl_vector_long_double ptr) as integer
declare function gsl_vector_long_double_swap_elements (byval v as gsl_vector_long_double ptr, byval i as integer, byval j as integer) as integer
declare function gsl_vector_long_double_max (byval v as gsl_vector_long_double ptr) as double
declare function gsl_vector_long_double_min (byval v as gsl_vector_long_double ptr) as double
declare sub gsl_vector_long_double_minmax (byval v as gsl_vector_long_double ptr, byval min_out as double ptr, byval max_out as double ptr)
declare function gsl_vector_long_double_max_index (byval v as gsl_vector_long_double ptr) as integer
declare function gsl_vector_long_double_min_index (byval v as gsl_vector_long_double ptr) as integer
declare sub gsl_vector_long_double_minmax_index (byval v as gsl_vector_long_double ptr, byval imin as integer ptr, byval imax as integer ptr)
declare function gsl_vector_long_double_add (byval a as gsl_vector_long_double ptr, byval b as gsl_vector_long_double ptr) as integer
declare function gsl_vector_long_double_sub (byval a as gsl_vector_long_double ptr, byval b as gsl_vector_long_double ptr) as integer
declare function gsl_vector_long_double_mul (byval a as gsl_vector_long_double ptr, byval b as gsl_vector_long_double ptr) as integer
declare function gsl_vector_long_double_div (byval a as gsl_vector_long_double ptr, byval b as gsl_vector_long_double ptr) as integer
declare function gsl_vector_long_double_scale (byval a as gsl_vector_long_double ptr, byval x as double) as integer
declare function gsl_vector_long_double_add_constant (byval a as gsl_vector_long_double ptr, byval x as double) as integer
declare function gsl_vector_long_double_isnull (byval v as gsl_vector_long_double ptr) as integer
end extern

#endif
