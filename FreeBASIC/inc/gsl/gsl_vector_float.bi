''
''
'' gsl_vector_float -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_vector_float_bi__
#define __gsl_vector_float_bi__

#include once "gsl_types.bi"
#include once "gsl_errno.bi"
#include once "gsl_check_range.bi"
#include once "gsl_block_float.bi"

type gsl_vector_float
	size as integer
	stride as integer
	data as single ptr
	block as gsl_block_float ptr
	owner as integer
end type

type _gsl_vector_float_view
	vector as gsl_vector_float
end type

type gsl_vector_float_view as _gsl_vector_float_view

type _gsl_vector_float_const_view
	vector as gsl_vector_float
end type

type gsl_vector_float_const_view as _gsl_vector_float_const_view

extern "c"
declare function gsl_vector_float_alloc (byval n as integer) as gsl_vector_float ptr
declare function gsl_vector_float_calloc (byval n as integer) as gsl_vector_float ptr
declare function gsl_vector_float_alloc_from_block (byval b as gsl_block_float ptr, byval offset as integer, byval n as integer, byval stride as integer) as gsl_vector_float ptr
declare function gsl_vector_float_alloc_from_vector (byval v as gsl_vector_float ptr, byval offset as integer, byval n as integer, byval stride as integer) as gsl_vector_float ptr
declare sub gsl_vector_float_free (byval v as gsl_vector_float ptr)
declare function gsl_vector_float_view_array (byval v as single ptr, byval n as integer) as _gsl_vector_float_view
declare function gsl_vector_float_view_array_with_stride (byval base as single ptr, byval stride as integer, byval n as integer) as _gsl_vector_float_view
declare function gsl_vector_float_const_view_array (byval v as single ptr, byval n as integer) as _gsl_vector_float_const_view
declare function gsl_vector_float_const_view_array_with_stride (byval base as single ptr, byval stride as integer, byval n as integer) as _gsl_vector_float_const_view
declare function gsl_vector_float_subvector (byval v as gsl_vector_float ptr, byval i as integer, byval n as integer) as _gsl_vector_float_view
declare function gsl_vector_float_subvector_with_stride (byval v as gsl_vector_float ptr, byval i as integer, byval stride as integer, byval n as integer) as _gsl_vector_float_view
declare function gsl_vector_float_const_subvector (byval v as gsl_vector_float ptr, byval i as integer, byval n as integer) as _gsl_vector_float_const_view
declare function gsl_vector_float_const_subvector_with_stride (byval v as gsl_vector_float ptr, byval i as integer, byval stride as integer, byval n as integer) as _gsl_vector_float_const_view
declare function gsl_vector_float_get (byval v as gsl_vector_float ptr, byval i as integer) as single
declare sub gsl_vector_float_set (byval v as gsl_vector_float ptr, byval i as integer, byval x as single)
declare function gsl_vector_float_ptr (byval v as gsl_vector_float ptr, byval i as integer) as single ptr
declare function gsl_vector_float_const_ptr (byval v as gsl_vector_float ptr, byval i as integer) as single ptr
declare sub gsl_vector_float_set_zero (byval v as gsl_vector_float ptr)
declare sub gsl_vector_float_set_all (byval v as gsl_vector_float ptr, byval x as single)
declare function gsl_vector_float_set_basis (byval v as gsl_vector_float ptr, byval i as integer) as integer
declare function gsl_vector_float_fread (byval stream as FILE ptr, byval v as gsl_vector_float ptr) as integer
declare function gsl_vector_float_fwrite (byval stream as FILE ptr, byval v as gsl_vector_float ptr) as integer
declare function gsl_vector_float_fscanf (byval stream as FILE ptr, byval v as gsl_vector_float ptr) as integer
declare function gsl_vector_float_fprintf (byval stream as FILE ptr, byval v as gsl_vector_float ptr, byval format as zstring ptr) as integer
declare function gsl_vector_float_memcpy (byval dest as gsl_vector_float ptr, byval src as gsl_vector_float ptr) as integer
declare function gsl_vector_float_reverse (byval v as gsl_vector_float ptr) as integer
declare function gsl_vector_float_swap (byval v as gsl_vector_float ptr, byval w as gsl_vector_float ptr) as integer
declare function gsl_vector_float_swap_elements (byval v as gsl_vector_float ptr, byval i as integer, byval j as integer) as integer
declare function gsl_vector_float_max (byval v as gsl_vector_float ptr) as single
declare function gsl_vector_float_min (byval v as gsl_vector_float ptr) as single
declare sub gsl_vector_float_minmax (byval v as gsl_vector_float ptr, byval min_out as single ptr, byval max_out as single ptr)
declare function gsl_vector_float_max_index (byval v as gsl_vector_float ptr) as integer
declare function gsl_vector_float_min_index (byval v as gsl_vector_float ptr) as integer
declare sub gsl_vector_float_minmax_index (byval v as gsl_vector_float ptr, byval imin as integer ptr, byval imax as integer ptr)
declare function gsl_vector_float_add (byval a as gsl_vector_float ptr, byval b as gsl_vector_float ptr) as integer
declare function gsl_vector_float_sub (byval a as gsl_vector_float ptr, byval b as gsl_vector_float ptr) as integer
declare function gsl_vector_float_mul (byval a as gsl_vector_float ptr, byval b as gsl_vector_float ptr) as integer
declare function gsl_vector_float_div (byval a as gsl_vector_float ptr, byval b as gsl_vector_float ptr) as integer
declare function gsl_vector_float_scale (byval a as gsl_vector_float ptr, byval x as double) as integer
declare function gsl_vector_float_add_constant (byval a as gsl_vector_float ptr, byval x as double) as integer
declare function gsl_vector_float_isnull (byval v as gsl_vector_float ptr) as integer
end extern

#endif
