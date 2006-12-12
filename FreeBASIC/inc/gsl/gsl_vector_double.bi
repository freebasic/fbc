''
''
'' gsl_vector_double -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_vector_double_bi__
#define __gsl_vector_double_bi__

#include once "gsl_types.bi"
#include once "gsl_errno.bi"
#include once "gsl_check_range.bi"
#include once "gsl_block_double.bi"

type gsl_vector
	size as integer
	stride as integer
	data as double ptr
	block as gsl_block ptr
	owner as integer
end type

type _gsl_vector_view
	vector as gsl_vector
end type

type gsl_vector_view as _gsl_vector_view

type _gsl_vector_const_view
	vector as gsl_vector
end type

type gsl_vector_const_view as _gsl_vector_const_view

extern "c"
declare function gsl_vector_alloc (byval n as integer) as gsl_vector ptr
declare function gsl_vector_calloc (byval n as integer) as gsl_vector ptr
declare function gsl_vector_alloc_from_block (byval b as gsl_block ptr, byval offset as integer, byval n as integer, byval stride as integer) as gsl_vector ptr
declare function gsl_vector_alloc_from_vector (byval v as gsl_vector ptr, byval offset as integer, byval n as integer, byval stride as integer) as gsl_vector ptr
declare sub gsl_vector_free (byval v as gsl_vector ptr)
declare function gsl_vector_view_array (byval v as double ptr, byval n as integer) as _gsl_vector_view
declare function gsl_vector_view_array_with_stride (byval base as double ptr, byval stride as integer, byval n as integer) as _gsl_vector_view
declare function gsl_vector_const_view_array (byval v as double ptr, byval n as integer) as _gsl_vector_const_view
declare function gsl_vector_const_view_array_with_stride (byval base as double ptr, byval stride as integer, byval n as integer) as _gsl_vector_const_view
declare function gsl_vector_subvector (byval v as gsl_vector ptr, byval i as integer, byval n as integer) as _gsl_vector_view
declare function gsl_vector_subvector_with_stride (byval v as gsl_vector ptr, byval i as integer, byval stride as integer, byval n as integer) as _gsl_vector_view
declare function gsl_vector_const_subvector (byval v as gsl_vector ptr, byval i as integer, byval n as integer) as _gsl_vector_const_view
declare function gsl_vector_const_subvector_with_stride (byval v as gsl_vector ptr, byval i as integer, byval stride as integer, byval n as integer) as _gsl_vector_const_view
declare function gsl_vector_get (byval v as gsl_vector ptr, byval i as integer) as double
declare sub gsl_vector_set (byval v as gsl_vector ptr, byval i as integer, byval x as double)
declare function gsl_vector_ptr (byval v as gsl_vector ptr, byval i as integer) as double ptr
declare function gsl_vector_const_ptr (byval v as gsl_vector ptr, byval i as integer) as double ptr
declare sub gsl_vector_set_zero (byval v as gsl_vector ptr)
declare sub gsl_vector_set_all (byval v as gsl_vector ptr, byval x as double)
declare function gsl_vector_set_basis (byval v as gsl_vector ptr, byval i as integer) as integer
declare function gsl_vector_fread (byval stream as FILE ptr, byval v as gsl_vector ptr) as integer
declare function gsl_vector_fwrite (byval stream as FILE ptr, byval v as gsl_vector ptr) as integer
declare function gsl_vector_fscanf (byval stream as FILE ptr, byval v as gsl_vector ptr) as integer
declare function gsl_vector_fprintf (byval stream as FILE ptr, byval v as gsl_vector ptr, byval format as zstring ptr) as integer
declare function gsl_vector_memcpy (byval dest as gsl_vector ptr, byval src as gsl_vector ptr) as integer
declare function gsl_vector_reverse (byval v as gsl_vector ptr) as integer
declare function gsl_vector_swap (byval v as gsl_vector ptr, byval w as gsl_vector ptr) as integer
declare function gsl_vector_swap_elements (byval v as gsl_vector ptr, byval i as integer, byval j as integer) as integer
declare function gsl_vector_max (byval v as gsl_vector ptr) as double
declare function gsl_vector_min (byval v as gsl_vector ptr) as double
declare sub gsl_vector_minmax (byval v as gsl_vector ptr, byval min_out as double ptr, byval max_out as double ptr)
declare function gsl_vector_max_index (byval v as gsl_vector ptr) as integer
declare function gsl_vector_min_index (byval v as gsl_vector ptr) as integer
declare sub gsl_vector_minmax_index (byval v as gsl_vector ptr, byval imin as integer ptr, byval imax as integer ptr)
declare function gsl_vector_add (byval a as gsl_vector ptr, byval b as gsl_vector ptr) as integer
declare function gsl_vector_sub (byval a as gsl_vector ptr, byval b as gsl_vector ptr) as integer
declare function gsl_vector_mul (byval a as gsl_vector ptr, byval b as gsl_vector ptr) as integer
declare function gsl_vector_div (byval a as gsl_vector ptr, byval b as gsl_vector ptr) as integer
declare function gsl_vector_scale (byval a as gsl_vector ptr, byval x as double) as integer
declare function gsl_vector_add_constant (byval a as gsl_vector ptr, byval x as double) as integer
declare function gsl_vector_isnull (byval v as gsl_vector ptr) as integer
end extern

#endif
