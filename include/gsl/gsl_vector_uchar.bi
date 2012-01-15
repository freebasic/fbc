''
''
'' gsl_vector_uchar -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_vector_uchar_bi__
#define __gsl_vector_uchar_bi__

#include once "gsl_types.bi"
#include once "gsl_errno.bi"
#include once "gsl_check_range.bi"
#include once "gsl_block_uchar.bi"

type gsl_vector_uchar
	size as integer
	stride as integer
	data as ubyte ptr
	block as gsl_block_uchar ptr
	owner as integer
end type

type _gsl_vector_uchar_view
	vector as gsl_vector_uchar
end type

type gsl_vector_uchar_view as _gsl_vector_uchar_view

type _gsl_vector_uchar_const_view
	vector as gsl_vector_uchar
end type

type gsl_vector_uchar_const_view as _gsl_vector_uchar_const_view

extern "c"
declare function gsl_vector_uchar_alloc (byval n as integer) as gsl_vector_uchar ptr
declare function gsl_vector_uchar_calloc (byval n as integer) as gsl_vector_uchar ptr
declare function gsl_vector_uchar_alloc_from_block (byval b as gsl_block_uchar ptr, byval offset as integer, byval n as integer, byval stride as integer) as gsl_vector_uchar ptr
declare function gsl_vector_uchar_alloc_from_vector (byval v as gsl_vector_uchar ptr, byval offset as integer, byval n as integer, byval stride as integer) as gsl_vector_uchar ptr
declare sub gsl_vector_uchar_free (byval v as gsl_vector_uchar ptr)
declare function gsl_vector_uchar_view_array (byval v as ubyte ptr, byval n as integer) as _gsl_vector_uchar_view
declare function gsl_vector_uchar_view_array_with_stride (byval base as ubyte ptr, byval stride as integer, byval n as integer) as _gsl_vector_uchar_view
declare function gsl_vector_uchar_const_view_array (byval v as ubyte ptr, byval n as integer) as _gsl_vector_uchar_const_view
declare function gsl_vector_uchar_const_view_array_with_stride (byval base as ubyte ptr, byval stride as integer, byval n as integer) as _gsl_vector_uchar_const_view
declare function gsl_vector_uchar_subvector (byval v as gsl_vector_uchar ptr, byval i as integer, byval n as integer) as _gsl_vector_uchar_view
declare function gsl_vector_uchar_subvector_with_stride (byval v as gsl_vector_uchar ptr, byval i as integer, byval stride as integer, byval n as integer) as _gsl_vector_uchar_view
declare function gsl_vector_uchar_const_subvector (byval v as gsl_vector_uchar ptr, byval i as integer, byval n as integer) as _gsl_vector_uchar_const_view
declare function gsl_vector_uchar_const_subvector_with_stride (byval v as gsl_vector_uchar ptr, byval i as integer, byval stride as integer, byval n as integer) as _gsl_vector_uchar_const_view
declare function gsl_vector_uchar_get (byval v as gsl_vector_uchar ptr, byval i as integer) as ubyte
declare sub gsl_vector_uchar_set (byval v as gsl_vector_uchar ptr, byval i as integer, byval x as ubyte)
declare function gsl_vector_uchar_ptr (byval v as gsl_vector_uchar ptr, byval i as integer) as ubyte ptr
declare function gsl_vector_uchar_const_ptr (byval v as gsl_vector_uchar ptr, byval i as integer) as ubyte ptr
declare sub gsl_vector_uchar_set_zero (byval v as gsl_vector_uchar ptr)
declare sub gsl_vector_uchar_set_all (byval v as gsl_vector_uchar ptr, byval x as ubyte)
declare function gsl_vector_uchar_set_basis (byval v as gsl_vector_uchar ptr, byval i as integer) as integer
declare function gsl_vector_uchar_fread (byval stream as FILE ptr, byval v as gsl_vector_uchar ptr) as integer
declare function gsl_vector_uchar_fwrite (byval stream as FILE ptr, byval v as gsl_vector_uchar ptr) as integer
declare function gsl_vector_uchar_fscanf (byval stream as FILE ptr, byval v as gsl_vector_uchar ptr) as integer
declare function gsl_vector_uchar_fprintf (byval stream as FILE ptr, byval v as gsl_vector_uchar ptr, byval format as zstring ptr) as integer
declare function gsl_vector_uchar_memcpy (byval dest as gsl_vector_uchar ptr, byval src as gsl_vector_uchar ptr) as integer
declare function gsl_vector_uchar_reverse (byval v as gsl_vector_uchar ptr) as integer
declare function gsl_vector_uchar_swap (byval v as gsl_vector_uchar ptr, byval w as gsl_vector_uchar ptr) as integer
declare function gsl_vector_uchar_swap_elements (byval v as gsl_vector_uchar ptr, byval i as integer, byval j as integer) as integer
declare function gsl_vector_uchar_max (byval v as gsl_vector_uchar ptr) as ubyte
declare function gsl_vector_uchar_min (byval v as gsl_vector_uchar ptr) as ubyte
declare sub gsl_vector_uchar_minmax (byval v as gsl_vector_uchar ptr, byval min_out as ubyte ptr, byval max_out as ubyte ptr)
declare function gsl_vector_uchar_max_index (byval v as gsl_vector_uchar ptr) as integer
declare function gsl_vector_uchar_min_index (byval v as gsl_vector_uchar ptr) as integer
declare sub gsl_vector_uchar_minmax_index (byval v as gsl_vector_uchar ptr, byval imin as integer ptr, byval imax as integer ptr)
declare function gsl_vector_uchar_add (byval a as gsl_vector_uchar ptr, byval b as gsl_vector_uchar ptr) as integer
declare function gsl_vector_uchar_sub (byval a as gsl_vector_uchar ptr, byval b as gsl_vector_uchar ptr) as integer
declare function gsl_vector_uchar_mul (byval a as gsl_vector_uchar ptr, byval b as gsl_vector_uchar ptr) as integer
declare function gsl_vector_uchar_div (byval a as gsl_vector_uchar ptr, byval b as gsl_vector_uchar ptr) as integer
declare function gsl_vector_uchar_scale (byval a as gsl_vector_uchar ptr, byval x as double) as integer
declare function gsl_vector_uchar_add_constant (byval a as gsl_vector_uchar ptr, byval x as double) as integer
declare function gsl_vector_uchar_isnull (byval v as gsl_vector_uchar ptr) as integer
end extern

#endif
