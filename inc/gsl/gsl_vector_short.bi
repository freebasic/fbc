''
''
'' gsl_vector_short -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_vector_short_bi__
#define __gsl_vector_short_bi__

#include once "gsl_types.bi"
#include once "gsl_errno.bi"
#include once "gsl_check_range.bi"
#include once "gsl_block_short.bi"

type gsl_vector_short
	size as integer
	stride as integer
	data as short ptr
	block as gsl_block_short ptr
	owner as integer
end type

type _gsl_vector_short_view
	vector as gsl_vector_short
end type

type gsl_vector_short_view as _gsl_vector_short_view

type _gsl_vector_short_const_view
	vector as gsl_vector_short
end type

type gsl_vector_short_const_view as _gsl_vector_short_const_view

extern "c"
declare function gsl_vector_short_alloc (byval n as integer) as gsl_vector_short ptr
declare function gsl_vector_short_calloc (byval n as integer) as gsl_vector_short ptr
declare function gsl_vector_short_alloc_from_block (byval b as gsl_block_short ptr, byval offset as integer, byval n as integer, byval stride as integer) as gsl_vector_short ptr
declare function gsl_vector_short_alloc_from_vector (byval v as gsl_vector_short ptr, byval offset as integer, byval n as integer, byval stride as integer) as gsl_vector_short ptr
declare sub gsl_vector_short_free (byval v as gsl_vector_short ptr)
declare function gsl_vector_short_view_array (byval v as short ptr, byval n as integer) as _gsl_vector_short_view
declare function gsl_vector_short_view_array_with_stride (byval base as short ptr, byval stride as integer, byval n as integer) as _gsl_vector_short_view
declare function gsl_vector_short_const_view_array (byval v as short ptr, byval n as integer) as _gsl_vector_short_const_view
declare function gsl_vector_short_const_view_array_with_stride (byval base as short ptr, byval stride as integer, byval n as integer) as _gsl_vector_short_const_view
declare function gsl_vector_short_subvector (byval v as gsl_vector_short ptr, byval i as integer, byval n as integer) as _gsl_vector_short_view
declare function gsl_vector_short_subvector_with_stride (byval v as gsl_vector_short ptr, byval i as integer, byval stride as integer, byval n as integer) as _gsl_vector_short_view
declare function gsl_vector_short_const_subvector (byval v as gsl_vector_short ptr, byval i as integer, byval n as integer) as _gsl_vector_short_const_view
declare function gsl_vector_short_const_subvector_with_stride (byval v as gsl_vector_short ptr, byval i as integer, byval stride as integer, byval n as integer) as _gsl_vector_short_const_view
declare function gsl_vector_short_get (byval v as gsl_vector_short ptr, byval i as integer) as short
declare sub gsl_vector_short_set (byval v as gsl_vector_short ptr, byval i as integer, byval x as short)
declare function gsl_vector_short_ptr (byval v as gsl_vector_short ptr, byval i as integer) as short ptr
declare function gsl_vector_short_const_ptr (byval v as gsl_vector_short ptr, byval i as integer) as short ptr
declare sub gsl_vector_short_set_zero (byval v as gsl_vector_short ptr)
declare sub gsl_vector_short_set_all (byval v as gsl_vector_short ptr, byval x as short)
declare function gsl_vector_short_set_basis (byval v as gsl_vector_short ptr, byval i as integer) as integer
declare function gsl_vector_short_fread (byval stream as FILE ptr, byval v as gsl_vector_short ptr) as integer
declare function gsl_vector_short_fwrite (byval stream as FILE ptr, byval v as gsl_vector_short ptr) as integer
declare function gsl_vector_short_fscanf (byval stream as FILE ptr, byval v as gsl_vector_short ptr) as integer
declare function gsl_vector_short_fprintf (byval stream as FILE ptr, byval v as gsl_vector_short ptr, byval format as zstring ptr) as integer
declare function gsl_vector_short_memcpy (byval dest as gsl_vector_short ptr, byval src as gsl_vector_short ptr) as integer
declare function gsl_vector_short_reverse (byval v as gsl_vector_short ptr) as integer
declare function gsl_vector_short_swap (byval v as gsl_vector_short ptr, byval w as gsl_vector_short ptr) as integer
declare function gsl_vector_short_swap_elements (byval v as gsl_vector_short ptr, byval i as integer, byval j as integer) as integer
declare function gsl_vector_short_max (byval v as gsl_vector_short ptr) as short
declare function gsl_vector_short_min (byval v as gsl_vector_short ptr) as short
declare sub gsl_vector_short_minmax (byval v as gsl_vector_short ptr, byval min_out as short ptr, byval max_out as short ptr)
declare function gsl_vector_short_max_index (byval v as gsl_vector_short ptr) as integer
declare function gsl_vector_short_min_index (byval v as gsl_vector_short ptr) as integer
declare sub gsl_vector_short_minmax_index (byval v as gsl_vector_short ptr, byval imin as integer ptr, byval imax as integer ptr)
declare function gsl_vector_short_add (byval a as gsl_vector_short ptr, byval b as gsl_vector_short ptr) as integer
declare function gsl_vector_short_sub (byval a as gsl_vector_short ptr, byval b as gsl_vector_short ptr) as integer
declare function gsl_vector_short_mul (byval a as gsl_vector_short ptr, byval b as gsl_vector_short ptr) as integer
declare function gsl_vector_short_div (byval a as gsl_vector_short ptr, byval b as gsl_vector_short ptr) as integer
declare function gsl_vector_short_scale (byval a as gsl_vector_short ptr, byval x as double) as integer
declare function gsl_vector_short_add_constant (byval a as gsl_vector_short ptr, byval x as double) as integer
declare function gsl_vector_short_isnull (byval v as gsl_vector_short ptr) as integer
end extern

#endif
