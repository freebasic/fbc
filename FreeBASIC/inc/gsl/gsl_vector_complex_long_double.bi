''
''
'' gsl_vector_complex_long_double -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_vector_complex_long_double_bi__
#define __gsl_vector_complex_long_double_bi__

#include once "gsl/gsl_types.bi"
#include once "gsl/gsl_errno.bi"
#include once "gsl/gsl_complex.bi"
#include once "gsl/gsl_check_range.bi"
#include once "gsl/gsl_vector_long_double.bi"
#include once "gsl/gsl_vector_complex.bi"
#include once "gsl/gsl_block_complex_long_double.bi"

type gsl_vector_complex_long_double
	size as integer
	stride as integer
	data as double ptr
	block as gsl_block_complex_long_double ptr
	owner as integer
end type

type _gsl_vector_complex_long_double_view
	vector as gsl_vector_complex_long_double
end type

type gsl_vector_complex_long_double_view as _gsl_vector_complex_long_double_view

type _gsl_vector_complex_long_double_const_view
	vector as gsl_vector_complex_long_double
end type

type gsl_vector_complex_long_double_const_view as _gsl_vector_complex_long_double_const_view

declare function gsl_vector_complex_long_double_alloc cdecl alias "gsl_vector_complex_long_double_alloc" (byval n as integer) as gsl_vector_complex_long_double ptr
declare function gsl_vector_complex_long_double_calloc cdecl alias "gsl_vector_complex_long_double_calloc" (byval n as integer) as gsl_vector_complex_long_double ptr
declare function gsl_vector_complex_long_double_alloc_from_block cdecl alias "gsl_vector_complex_long_double_alloc_from_block" (byval b as gsl_block_complex_long_double ptr, byval offset as integer, byval n as integer, byval stride as integer) as gsl_vector_complex_long_double ptr
declare function gsl_vector_complex_long_double_alloc_from_vector cdecl alias "gsl_vector_complex_long_double_alloc_from_vector" (byval v as gsl_vector_complex_long_double ptr, byval offset as integer, byval n as integer, byval stride as integer) as gsl_vector_complex_long_double ptr
declare sub gsl_vector_complex_long_double_free cdecl alias "gsl_vector_complex_long_double_free" (byval v as gsl_vector_complex_long_double ptr)
declare function gsl_vector_complex_long_double_view_array cdecl alias "gsl_vector_complex_long_double_view_array" (byval base as double ptr, byval n as integer) as _gsl_vector_complex_long_double_view
declare function gsl_vector_complex_long_double_view_array_with_stride cdecl alias "gsl_vector_complex_long_double_view_array_with_stride" (byval base as double ptr, byval stride as integer, byval n as integer) as _gsl_vector_complex_long_double_view
declare function gsl_vector_complex_long_double_const_view_array cdecl alias "gsl_vector_complex_long_double_const_view_array" (byval base as double ptr, byval n as integer) as _gsl_vector_complex_long_double_const_view
declare function gsl_vector_complex_long_double_const_view_array_with_stride cdecl alias "gsl_vector_complex_long_double_const_view_array_with_stride" (byval base as double ptr, byval stride as integer, byval n as integer) as _gsl_vector_complex_long_double_const_view
declare function gsl_vector_complex_long_double_subvector cdecl alias "gsl_vector_complex_long_double_subvector" (byval base as gsl_vector_complex_long_double ptr, byval i as integer, byval n as integer) as _gsl_vector_complex_long_double_view
declare function gsl_vector_complex_long_double_subvector_with_stride cdecl alias "gsl_vector_complex_long_double_subvector_with_stride" (byval v as gsl_vector_complex_long_double ptr, byval i as integer, byval stride as integer, byval n as integer) as _gsl_vector_complex_long_double_view
declare function gsl_vector_complex_long_double_const_subvector cdecl alias "gsl_vector_complex_long_double_const_subvector" (byval base as gsl_vector_complex_long_double ptr, byval i as integer, byval n as integer) as _gsl_vector_complex_long_double_const_view
declare function gsl_vector_complex_long_double_const_subvector_with_stride cdecl alias "gsl_vector_complex_long_double_const_subvector_with_stride" (byval v as gsl_vector_complex_long_double ptr, byval i as integer, byval stride as integer, byval n as integer) as _gsl_vector_complex_long_double_const_view
declare function gsl_vector_complex_long_double_real cdecl alias "gsl_vector_complex_long_double_real" (byval v as gsl_vector_complex_long_double ptr) as _gsl_vector_long_double_view
declare function gsl_vector_complex_long_double_imag cdecl alias "gsl_vector_complex_long_double_imag" (byval v as gsl_vector_complex_long_double ptr) as _gsl_vector_long_double_view
declare function gsl_vector_complex_long_double_const_real cdecl alias "gsl_vector_complex_long_double_const_real" (byval v as gsl_vector_complex_long_double ptr) as _gsl_vector_long_double_const_view
declare function gsl_vector_complex_long_double_const_imag cdecl alias "gsl_vector_complex_long_double_const_imag" (byval v as gsl_vector_complex_long_double ptr) as _gsl_vector_long_double_const_view
declare function gsl_vector_complex_long_double_get cdecl alias "gsl_vector_complex_long_double_get" (byval v as gsl_vector_complex_long_double ptr, byval i as integer) as gsl_complex_long_double
declare sub gsl_vector_complex_long_double_set cdecl alias "gsl_vector_complex_long_double_set" (byval v as gsl_vector_complex_long_double ptr, byval i as integer, byval z as gsl_complex_long_double)
declare function gsl_vector_complex_long_double_ptr cdecl alias "gsl_vector_complex_long_double_ptr" (byval v as gsl_vector_complex_long_double ptr, byval i as integer) as gsl_complex_long_double ptr
declare function gsl_vector_complex_long_double_const_ptr cdecl alias "gsl_vector_complex_long_double_const_ptr" (byval v as gsl_vector_complex_long_double ptr, byval i as integer) as gsl_complex_long_double ptr
declare sub gsl_vector_complex_long_double_set_zero cdecl alias "gsl_vector_complex_long_double_set_zero" (byval v as gsl_vector_complex_long_double ptr)
declare sub gsl_vector_complex_long_double_set_all cdecl alias "gsl_vector_complex_long_double_set_all" (byval v as gsl_vector_complex_long_double ptr, byval z as gsl_complex_long_double)
declare function gsl_vector_complex_long_double_set_basis cdecl alias "gsl_vector_complex_long_double_set_basis" (byval v as gsl_vector_complex_long_double ptr, byval i as integer) as integer
declare function gsl_vector_complex_long_double_fread cdecl alias "gsl_vector_complex_long_double_fread" (byval stream as FILE ptr, byval v as gsl_vector_complex_long_double ptr) as integer
declare function gsl_vector_complex_long_double_fwrite cdecl alias "gsl_vector_complex_long_double_fwrite" (byval stream as FILE ptr, byval v as gsl_vector_complex_long_double ptr) as integer
declare function gsl_vector_complex_long_double_fscanf cdecl alias "gsl_vector_complex_long_double_fscanf" (byval stream as FILE ptr, byval v as gsl_vector_complex_long_double ptr) as integer
declare function gsl_vector_complex_long_double_fprintf cdecl alias "gsl_vector_complex_long_double_fprintf" (byval stream as FILE ptr, byval v as gsl_vector_complex_long_double ptr, byval format as string) as integer
declare function gsl_vector_complex_long_double_memcpy cdecl alias "gsl_vector_complex_long_double_memcpy" (byval dest as gsl_vector_complex_long_double ptr, byval src as gsl_vector_complex_long_double ptr) as integer
declare function gsl_vector_complex_long_double_reverse cdecl alias "gsl_vector_complex_long_double_reverse" (byval v as gsl_vector_complex_long_double ptr) as integer
declare function gsl_vector_complex_long_double_swap cdecl alias "gsl_vector_complex_long_double_swap" (byval v as gsl_vector_complex_long_double ptr, byval w as gsl_vector_complex_long_double ptr) as integer
declare function gsl_vector_complex_long_double_swap_elements cdecl alias "gsl_vector_complex_long_double_swap_elements" (byval v as gsl_vector_complex_long_double ptr, byval i as integer, byval j as integer) as integer
declare function gsl_vector_complex_long_double_isnull cdecl alias "gsl_vector_complex_long_double_isnull" (byval v as gsl_vector_complex_long_double ptr) as integer

#endif
