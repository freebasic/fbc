''
''
'' gsl_vector_int -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_vector_int_bi__
#define __gsl_vector_int_bi__

#include once "gsl_types.bi"
#include once "gsl_errno.bi"
#include once "gsl_check_range.bi"
#include once "gsl_block_int.bi"

type gsl_vector_int
	size as integer
	stride as integer
	data as integer ptr
	block as gsl_block_int ptr
	owner as integer
end type

type _gsl_vector_int_view
	vector as gsl_vector_int
end type

type gsl_vector_int_view as _gsl_vector_int_view

type _gsl_vector_int_const_view
	vector as gsl_vector_int
end type

type gsl_vector_int_const_view as _gsl_vector_int_const_view

extern "c"
declare function gsl_vector_int_alloc (byval n as integer) as gsl_vector_int ptr
declare function gsl_vector_int_calloc (byval n as integer) as gsl_vector_int ptr
declare function gsl_vector_int_alloc_from_block (byval b as gsl_block_int ptr, byval offset as integer, byval n as integer, byval stride as integer) as gsl_vector_int ptr
declare function gsl_vector_int_alloc_from_vector (byval v as gsl_vector_int ptr, byval offset as integer, byval n as integer, byval stride as integer) as gsl_vector_int ptr
declare sub gsl_vector_int_free (byval v as gsl_vector_int ptr)
declare function gsl_vector_int_view_array (byval v as integer ptr, byval n as integer) as _gsl_vector_int_view
declare function gsl_vector_int_view_array_with_stride (byval base as integer ptr, byval stride as integer, byval n as integer) as _gsl_vector_int_view
declare function gsl_vector_int_const_view_array (byval v as integer ptr, byval n as integer) as _gsl_vector_int_const_view
declare function gsl_vector_int_const_view_array_with_stride (byval base as integer ptr, byval stride as integer, byval n as integer) as _gsl_vector_int_const_view
declare function gsl_vector_int_subvector (byval v as gsl_vector_int ptr, byval i as integer, byval n as integer) as _gsl_vector_int_view
declare function gsl_vector_int_subvector_with_stride (byval v as gsl_vector_int ptr, byval i as integer, byval stride as integer, byval n as integer) as _gsl_vector_int_view
declare function gsl_vector_int_const_subvector (byval v as gsl_vector_int ptr, byval i as integer, byval n as integer) as _gsl_vector_int_const_view
declare function gsl_vector_int_const_subvector_with_stride (byval v as gsl_vector_int ptr, byval i as integer, byval stride as integer, byval n as integer) as _gsl_vector_int_const_view
declare function gsl_vector_int_get (byval v as gsl_vector_int ptr, byval i as integer) as integer
declare sub gsl_vector_int_set (byval v as gsl_vector_int ptr, byval i as integer, byval x as integer)
declare function gsl_vector_int_ptr (byval v as gsl_vector_int ptr, byval i as integer) as integer ptr
declare function gsl_vector_int_const_ptr (byval v as gsl_vector_int ptr, byval i as integer) as integer ptr
declare sub gsl_vector_int_set_zero (byval v as gsl_vector_int ptr)
declare sub gsl_vector_int_set_all (byval v as gsl_vector_int ptr, byval x as integer)
declare function gsl_vector_int_set_basis (byval v as gsl_vector_int ptr, byval i as integer) as integer
declare function gsl_vector_int_fread (byval stream as FILE ptr, byval v as gsl_vector_int ptr) as integer
declare function gsl_vector_int_fwrite (byval stream as FILE ptr, byval v as gsl_vector_int ptr) as integer
declare function gsl_vector_int_fscanf (byval stream as FILE ptr, byval v as gsl_vector_int ptr) as integer
declare function gsl_vector_int_fprintf (byval stream as FILE ptr, byval v as gsl_vector_int ptr, byval format as zstring ptr) as integer
declare function gsl_vector_int_memcpy (byval dest as gsl_vector_int ptr, byval src as gsl_vector_int ptr) as integer
declare function gsl_vector_int_reverse (byval v as gsl_vector_int ptr) as integer
declare function gsl_vector_int_swap (byval v as gsl_vector_int ptr, byval w as gsl_vector_int ptr) as integer
declare function gsl_vector_int_swap_elements (byval v as gsl_vector_int ptr, byval i as integer, byval j as integer) as integer
declare function gsl_vector_int_max (byval v as gsl_vector_int ptr) as integer
declare function gsl_vector_int_min (byval v as gsl_vector_int ptr) as integer
declare sub gsl_vector_int_minmax (byval v as gsl_vector_int ptr, byval min_out as integer ptr, byval max_out as integer ptr)
declare function gsl_vector_int_max_index (byval v as gsl_vector_int ptr) as integer
declare function gsl_vector_int_min_index (byval v as gsl_vector_int ptr) as integer
declare sub gsl_vector_int_minmax_index (byval v as gsl_vector_int ptr, byval imin as integer ptr, byval imax as integer ptr)
declare function gsl_vector_int_add (byval a as gsl_vector_int ptr, byval b as gsl_vector_int ptr) as integer
declare function gsl_vector_int_sub (byval a as gsl_vector_int ptr, byval b as gsl_vector_int ptr) as integer
declare function gsl_vector_int_mul (byval a as gsl_vector_int ptr, byval b as gsl_vector_int ptr) as integer
declare function gsl_vector_int_div (byval a as gsl_vector_int ptr, byval b as gsl_vector_int ptr) as integer
declare function gsl_vector_int_scale (byval a as gsl_vector_int ptr, byval x as double) as integer
declare function gsl_vector_int_add_constant (byval a as gsl_vector_int ptr, byval x as double) as integer
declare function gsl_vector_int_isnull (byval v as gsl_vector_int ptr) as integer
end extern

#endif
