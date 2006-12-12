''
''
'' gsl_vector_long -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_vector_long_bi__
#define __gsl_vector_long_bi__

#include once "gsl_types.bi"
#include once "gsl_errno.bi"
#include once "gsl_check_range.bi"
#include once "gsl_block_long.bi"

type gsl_vector_long
	size as integer
	stride as integer
	data as integer ptr
	block as gsl_block_long ptr
	owner as integer
end type

type _gsl_vector_long_view
	vector as gsl_vector_long
end type

type gsl_vector_long_view as _gsl_vector_long_view

type _gsl_vector_long_const_view
	vector as gsl_vector_long
end type

type gsl_vector_long_const_view as _gsl_vector_long_const_view

extern "c"
declare function gsl_vector_long_alloc (byval n as integer) as gsl_vector_long ptr
declare function gsl_vector_long_calloc (byval n as integer) as gsl_vector_long ptr
declare function gsl_vector_long_alloc_from_block (byval b as gsl_block_long ptr, byval offset as integer, byval n as integer, byval stride as integer) as gsl_vector_long ptr
declare function gsl_vector_long_alloc_from_vector (byval v as gsl_vector_long ptr, byval offset as integer, byval n as integer, byval stride as integer) as gsl_vector_long ptr
declare sub gsl_vector_long_free (byval v as gsl_vector_long ptr)
declare function gsl_vector_long_view_array (byval v as integer ptr, byval n as integer) as _gsl_vector_long_view
declare function gsl_vector_long_view_array_with_stride (byval base as integer ptr, byval stride as integer, byval n as integer) as _gsl_vector_long_view
declare function gsl_vector_long_const_view_array (byval v as integer ptr, byval n as integer) as _gsl_vector_long_const_view
declare function gsl_vector_long_const_view_array_with_stride (byval base as integer ptr, byval stride as integer, byval n as integer) as _gsl_vector_long_const_view
declare function gsl_vector_long_subvector (byval v as gsl_vector_long ptr, byval i as integer, byval n as integer) as _gsl_vector_long_view
declare function gsl_vector_long_subvector_with_stride (byval v as gsl_vector_long ptr, byval i as integer, byval stride as integer, byval n as integer) as _gsl_vector_long_view
declare function gsl_vector_long_const_subvector (byval v as gsl_vector_long ptr, byval i as integer, byval n as integer) as _gsl_vector_long_const_view
declare function gsl_vector_long_const_subvector_with_stride (byval v as gsl_vector_long ptr, byval i as integer, byval stride as integer, byval n as integer) as _gsl_vector_long_const_view
declare function gsl_vector_long_get (byval v as gsl_vector_long ptr, byval i as integer) as integer
declare sub gsl_vector_long_set (byval v as gsl_vector_long ptr, byval i as integer, byval x as integer)
declare function gsl_vector_long_ptr (byval v as gsl_vector_long ptr, byval i as integer) as integer ptr
declare function gsl_vector_long_const_ptr (byval v as gsl_vector_long ptr, byval i as integer) as integer ptr
declare sub gsl_vector_long_set_zero (byval v as gsl_vector_long ptr)
declare sub gsl_vector_long_set_all (byval v as gsl_vector_long ptr, byval x as integer)
declare function gsl_vector_long_set_basis (byval v as gsl_vector_long ptr, byval i as integer) as integer
declare function gsl_vector_long_fread (byval stream as FILE ptr, byval v as gsl_vector_long ptr) as integer
declare function gsl_vector_long_fwrite (byval stream as FILE ptr, byval v as gsl_vector_long ptr) as integer
declare function gsl_vector_long_fscanf (byval stream as FILE ptr, byval v as gsl_vector_long ptr) as integer
declare function gsl_vector_long_fprintf (byval stream as FILE ptr, byval v as gsl_vector_long ptr, byval format as zstring ptr) as integer
declare function gsl_vector_long_memcpy (byval dest as gsl_vector_long ptr, byval src as gsl_vector_long ptr) as integer
declare function gsl_vector_long_reverse (byval v as gsl_vector_long ptr) as integer
declare function gsl_vector_long_swap (byval v as gsl_vector_long ptr, byval w as gsl_vector_long ptr) as integer
declare function gsl_vector_long_swap_elements (byval v as gsl_vector_long ptr, byval i as integer, byval j as integer) as integer
declare function gsl_vector_long_max (byval v as gsl_vector_long ptr) as integer
declare function gsl_vector_long_min (byval v as gsl_vector_long ptr) as integer
declare sub gsl_vector_long_minmax (byval v as gsl_vector_long ptr, byval min_out as integer ptr, byval max_out as integer ptr)
declare function gsl_vector_long_max_index (byval v as gsl_vector_long ptr) as integer
declare function gsl_vector_long_min_index (byval v as gsl_vector_long ptr) as integer
declare sub gsl_vector_long_minmax_index (byval v as gsl_vector_long ptr, byval imin as integer ptr, byval imax as integer ptr)
declare function gsl_vector_long_add (byval a as gsl_vector_long ptr, byval b as gsl_vector_long ptr) as integer
declare function gsl_vector_long_sub (byval a as gsl_vector_long ptr, byval b as gsl_vector_long ptr) as integer
declare function gsl_vector_long_mul (byval a as gsl_vector_long ptr, byval b as gsl_vector_long ptr) as integer
declare function gsl_vector_long_div (byval a as gsl_vector_long ptr, byval b as gsl_vector_long ptr) as integer
declare function gsl_vector_long_scale (byval a as gsl_vector_long ptr, byval x as double) as integer
declare function gsl_vector_long_add_constant (byval a as gsl_vector_long ptr, byval x as double) as integer
declare function gsl_vector_long_isnull (byval v as gsl_vector_long ptr) as integer
end extern

#endif
