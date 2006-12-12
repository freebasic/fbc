''
''
'' gsl_vector_ulong -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_vector_ulong_bi__
#define __gsl_vector_ulong_bi__

#include once "gsl_types.bi"
#include once "gsl_errno.bi"
#include once "gsl_check_range.bi"
#include once "gsl_block_ulong.bi"

type gsl_vector_ulong
	size as integer
	stride as integer
	data as uinteger ptr
	block as gsl_block_ulong ptr
	owner as integer
end type

type _gsl_vector_ulong_view
	vector as gsl_vector_ulong
end type

type gsl_vector_ulong_view as _gsl_vector_ulong_view

type _gsl_vector_ulong_const_view
	vector as gsl_vector_ulong
end type

type gsl_vector_ulong_const_view as _gsl_vector_ulong_const_view

extern "c"
declare function gsl_vector_ulong_alloc (byval n as integer) as gsl_vector_ulong ptr
declare function gsl_vector_ulong_calloc (byval n as integer) as gsl_vector_ulong ptr
declare function gsl_vector_ulong_alloc_from_block (byval b as gsl_block_ulong ptr, byval offset as integer, byval n as integer, byval stride as integer) as gsl_vector_ulong ptr
declare function gsl_vector_ulong_alloc_from_vector (byval v as gsl_vector_ulong ptr, byval offset as integer, byval n as integer, byval stride as integer) as gsl_vector_ulong ptr
declare sub gsl_vector_ulong_free (byval v as gsl_vector_ulong ptr)
declare function gsl_vector_ulong_view_array (byval v as uinteger ptr, byval n as integer) as _gsl_vector_ulong_view
declare function gsl_vector_ulong_view_array_with_stride (byval base as uinteger ptr, byval stride as integer, byval n as integer) as _gsl_vector_ulong_view
declare function gsl_vector_ulong_const_view_array (byval v as uinteger ptr, byval n as integer) as _gsl_vector_ulong_const_view
declare function gsl_vector_ulong_const_view_array_with_stride (byval base as uinteger ptr, byval stride as integer, byval n as integer) as _gsl_vector_ulong_const_view
declare function gsl_vector_ulong_subvector (byval v as gsl_vector_ulong ptr, byval i as integer, byval n as integer) as _gsl_vector_ulong_view
declare function gsl_vector_ulong_subvector_with_stride (byval v as gsl_vector_ulong ptr, byval i as integer, byval stride as integer, byval n as integer) as _gsl_vector_ulong_view
declare function gsl_vector_ulong_const_subvector (byval v as gsl_vector_ulong ptr, byval i as integer, byval n as integer) as _gsl_vector_ulong_const_view
declare function gsl_vector_ulong_const_subvector_with_stride (byval v as gsl_vector_ulong ptr, byval i as integer, byval stride as integer, byval n as integer) as _gsl_vector_ulong_const_view
declare function gsl_vector_ulong_get (byval v as gsl_vector_ulong ptr, byval i as integer) as uinteger
declare sub gsl_vector_ulong_set (byval v as gsl_vector_ulong ptr, byval i as integer, byval x as uinteger)
declare function gsl_vector_ulong_ptr (byval v as gsl_vector_ulong ptr, byval i as integer) as uinteger ptr
declare function gsl_vector_ulong_const_ptr (byval v as gsl_vector_ulong ptr, byval i as integer) as uinteger ptr
declare sub gsl_vector_ulong_set_zero (byval v as gsl_vector_ulong ptr)
declare sub gsl_vector_ulong_set_all (byval v as gsl_vector_ulong ptr, byval x as uinteger)
declare function gsl_vector_ulong_set_basis (byval v as gsl_vector_ulong ptr, byval i as integer) as integer
declare function gsl_vector_ulong_fread (byval stream as FILE ptr, byval v as gsl_vector_ulong ptr) as integer
declare function gsl_vector_ulong_fwrite (byval stream as FILE ptr, byval v as gsl_vector_ulong ptr) as integer
declare function gsl_vector_ulong_fscanf (byval stream as FILE ptr, byval v as gsl_vector_ulong ptr) as integer
declare function gsl_vector_ulong_fprintf (byval stream as FILE ptr, byval v as gsl_vector_ulong ptr, byval format as zstring ptr) as integer
declare function gsl_vector_ulong_memcpy (byval dest as gsl_vector_ulong ptr, byval src as gsl_vector_ulong ptr) as integer
declare function gsl_vector_ulong_reverse (byval v as gsl_vector_ulong ptr) as integer
declare function gsl_vector_ulong_swap (byval v as gsl_vector_ulong ptr, byval w as gsl_vector_ulong ptr) as integer
declare function gsl_vector_ulong_swap_elements (byval v as gsl_vector_ulong ptr, byval i as integer, byval j as integer) as integer
declare function gsl_vector_ulong_max (byval v as gsl_vector_ulong ptr) as uinteger
declare function gsl_vector_ulong_min (byval v as gsl_vector_ulong ptr) as uinteger
declare sub gsl_vector_ulong_minmax (byval v as gsl_vector_ulong ptr, byval min_out as uinteger ptr, byval max_out as uinteger ptr)
declare function gsl_vector_ulong_max_index (byval v as gsl_vector_ulong ptr) as integer
declare function gsl_vector_ulong_min_index (byval v as gsl_vector_ulong ptr) as integer
declare sub gsl_vector_ulong_minmax_index (byval v as gsl_vector_ulong ptr, byval imin as integer ptr, byval imax as integer ptr)
declare function gsl_vector_ulong_add (byval a as gsl_vector_ulong ptr, byval b as gsl_vector_ulong ptr) as integer
declare function gsl_vector_ulong_sub (byval a as gsl_vector_ulong ptr, byval b as gsl_vector_ulong ptr) as integer
declare function gsl_vector_ulong_mul (byval a as gsl_vector_ulong ptr, byval b as gsl_vector_ulong ptr) as integer
declare function gsl_vector_ulong_div (byval a as gsl_vector_ulong ptr, byval b as gsl_vector_ulong ptr) as integer
declare function gsl_vector_ulong_scale (byval a as gsl_vector_ulong ptr, byval x as double) as integer
declare function gsl_vector_ulong_add_constant (byval a as gsl_vector_ulong ptr, byval x as double) as integer
declare function gsl_vector_ulong_isnull (byval v as gsl_vector_ulong ptr) as integer
end extern

#endif
