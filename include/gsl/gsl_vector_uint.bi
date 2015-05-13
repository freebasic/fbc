''
''
'' gsl_vector_uint -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_vector_uint_bi__
#define __gsl_vector_uint_bi__

#include once "gsl_types.bi"
#include once "gsl_errno.bi"
#include once "gsl_check_range.bi"
#include once "gsl_block_uint.bi"

type gsl_vector_uint
	size as integer
	stride as integer
	data as uinteger ptr
	block as gsl_block_uint ptr
	owner as integer
end type

type _gsl_vector_uint_view
	vector as gsl_vector_uint
end type

type gsl_vector_uint_view as _gsl_vector_uint_view

type _gsl_vector_uint_const_view
	vector as gsl_vector_uint
end type

type gsl_vector_uint_const_view as _gsl_vector_uint_const_view

extern "c"
declare function gsl_vector_uint_alloc (byval n as integer) as gsl_vector_uint ptr
declare function gsl_vector_uint_calloc (byval n as integer) as gsl_vector_uint ptr
declare function gsl_vector_uint_alloc_from_block (byval b as gsl_block_uint ptr, byval offset as integer, byval n as integer, byval stride as integer) as gsl_vector_uint ptr
declare function gsl_vector_uint_alloc_from_vector (byval v as gsl_vector_uint ptr, byval offset as integer, byval n as integer, byval stride as integer) as gsl_vector_uint ptr
declare sub gsl_vector_uint_free (byval v as gsl_vector_uint ptr)
declare function gsl_vector_uint_view_array (byval v as uinteger ptr, byval n as integer) as _gsl_vector_uint_view
declare function gsl_vector_uint_view_array_with_stride (byval base as uinteger ptr, byval stride as integer, byval n as integer) as _gsl_vector_uint_view
declare function gsl_vector_uint_const_view_array (byval v as uinteger ptr, byval n as integer) as _gsl_vector_uint_const_view
declare function gsl_vector_uint_const_view_array_with_stride (byval base as uinteger ptr, byval stride as integer, byval n as integer) as _gsl_vector_uint_const_view
declare function gsl_vector_uint_subvector (byval v as gsl_vector_uint ptr, byval i as integer, byval n as integer) as _gsl_vector_uint_view
declare function gsl_vector_uint_subvector_with_stride (byval v as gsl_vector_uint ptr, byval i as integer, byval stride as integer, byval n as integer) as _gsl_vector_uint_view
declare function gsl_vector_uint_const_subvector (byval v as gsl_vector_uint ptr, byval i as integer, byval n as integer) as _gsl_vector_uint_const_view
declare function gsl_vector_uint_const_subvector_with_stride (byval v as gsl_vector_uint ptr, byval i as integer, byval stride as integer, byval n as integer) as _gsl_vector_uint_const_view
declare function gsl_vector_uint_get (byval v as gsl_vector_uint ptr, byval i as integer) as uinteger
declare sub gsl_vector_uint_set (byval v as gsl_vector_uint ptr, byval i as integer, byval x as uinteger)
declare function gsl_vector_uint_ptr (byval v as gsl_vector_uint ptr, byval i as integer) as uinteger ptr
declare function gsl_vector_uint_const_ptr (byval v as gsl_vector_uint ptr, byval i as integer) as uinteger ptr
declare sub gsl_vector_uint_set_zero (byval v as gsl_vector_uint ptr)
declare sub gsl_vector_uint_set_all (byval v as gsl_vector_uint ptr, byval x as uinteger)
declare function gsl_vector_uint_set_basis (byval v as gsl_vector_uint ptr, byval i as integer) as integer
declare function gsl_vector_uint_fread (byval stream as FILE ptr, byval v as gsl_vector_uint ptr) as integer
declare function gsl_vector_uint_fwrite (byval stream as FILE ptr, byval v as gsl_vector_uint ptr) as integer
declare function gsl_vector_uint_fscanf (byval stream as FILE ptr, byval v as gsl_vector_uint ptr) as integer
declare function gsl_vector_uint_fprintf (byval stream as FILE ptr, byval v as gsl_vector_uint ptr, byval format as zstring ptr) as integer
declare function gsl_vector_uint_memcpy (byval dest as gsl_vector_uint ptr, byval src as gsl_vector_uint ptr) as integer
declare function gsl_vector_uint_reverse (byval v as gsl_vector_uint ptr) as integer
declare function gsl_vector_uint_swap (byval v as gsl_vector_uint ptr, byval w as gsl_vector_uint ptr) as integer
declare function gsl_vector_uint_swap_elements (byval v as gsl_vector_uint ptr, byval i as integer, byval j as integer) as integer
declare function gsl_vector_uint_max (byval v as gsl_vector_uint ptr) as uinteger
declare function gsl_vector_uint_min (byval v as gsl_vector_uint ptr) as uinteger
declare sub gsl_vector_uint_minmax (byval v as gsl_vector_uint ptr, byval min_out as uinteger ptr, byval max_out as uinteger ptr)
declare function gsl_vector_uint_max_index (byval v as gsl_vector_uint ptr) as integer
declare function gsl_vector_uint_min_index (byval v as gsl_vector_uint ptr) as integer
declare sub gsl_vector_uint_minmax_index (byval v as gsl_vector_uint ptr, byval imin as integer ptr, byval imax as integer ptr)
declare function gsl_vector_uint_add (byval a as gsl_vector_uint ptr, byval b as gsl_vector_uint ptr) as integer
declare function gsl_vector_uint_sub (byval a as gsl_vector_uint ptr, byval b as gsl_vector_uint ptr) as integer
declare function gsl_vector_uint_mul (byval a as gsl_vector_uint ptr, byval b as gsl_vector_uint ptr) as integer
declare function gsl_vector_uint_div (byval a as gsl_vector_uint ptr, byval b as gsl_vector_uint ptr) as integer
declare function gsl_vector_uint_scale (byval a as gsl_vector_uint ptr, byval x as double) as integer
declare function gsl_vector_uint_add_constant (byval a as gsl_vector_uint ptr, byval x as double) as integer
declare function gsl_vector_uint_isnull (byval v as gsl_vector_uint ptr) as integer
end extern

#endif
