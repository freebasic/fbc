''
''
'' gsl_vector_complex_double -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_vector_complex_double_bi__
#define __gsl_vector_complex_double_bi__

#include once "gsl/gsl_types.bi"
#include once "gsl/gsl_errno.bi"
#include once "gsl/gsl_complex.bi"
#include once "gsl/gsl_check_range.bi"
#include once "gsl/gsl_vector_double.bi"
#include once "gsl/gsl_vector_complex.bi"
#include once "gsl/gsl_block_complex_double.bi"

type gsl_vector_complex
	size as integer
	stride as integer
	data as double ptr
	block as gsl_block_complex ptr
	owner as integer
end type

type _gsl_vector_complex_view
	vector as gsl_vector_complex
end type

type gsl_vector_complex_view as _gsl_vector_complex_view

type _gsl_vector_complex_const_view
	vector as gsl_vector_complex
end type

type gsl_vector_complex_const_view as _gsl_vector_complex_const_view

declare function gsl_vector_complex_alloc cdecl alias "gsl_vector_complex_alloc" (byval n as integer) as gsl_vector_complex ptr
declare function gsl_vector_complex_calloc cdecl alias "gsl_vector_complex_calloc" (byval n as integer) as gsl_vector_complex ptr
declare function gsl_vector_complex_alloc_from_block cdecl alias "gsl_vector_complex_alloc_from_block" (byval b as gsl_block_complex ptr, byval offset as integer, byval n as integer, byval stride as integer) as gsl_vector_complex ptr
declare function gsl_vector_complex_alloc_from_vector cdecl alias "gsl_vector_complex_alloc_from_vector" (byval v as gsl_vector_complex ptr, byval offset as integer, byval n as integer, byval stride as integer) as gsl_vector_complex ptr
declare sub gsl_vector_complex_free cdecl alias "gsl_vector_complex_free" (byval v as gsl_vector_complex ptr)
declare function gsl_vector_complex_view_array cdecl alias "gsl_vector_complex_view_array" (byval base as double ptr, byval n as integer) as _gsl_vector_complex_view
declare function gsl_vector_complex_view_array_with_stride cdecl alias "gsl_vector_complex_view_array_with_stride" (byval base as double ptr, byval stride as integer, byval n as integer) as _gsl_vector_complex_view
declare function gsl_vector_complex_const_view_array cdecl alias "gsl_vector_complex_const_view_array" (byval base as double ptr, byval n as integer) as _gsl_vector_complex_const_view
declare function gsl_vector_complex_const_view_array_with_stride cdecl alias "gsl_vector_complex_const_view_array_with_stride" (byval base as double ptr, byval stride as integer, byval n as integer) as _gsl_vector_complex_const_view
declare function gsl_vector_complex_subvector cdecl alias "gsl_vector_complex_subvector" (byval base as gsl_vector_complex ptr, byval i as integer, byval n as integer) as _gsl_vector_complex_view
declare function gsl_vector_complex_subvector_with_stride cdecl alias "gsl_vector_complex_subvector_with_stride" (byval v as gsl_vector_complex ptr, byval i as integer, byval stride as integer, byval n as integer) as _gsl_vector_complex_view
declare function gsl_vector_complex_const_subvector cdecl alias "gsl_vector_complex_const_subvector" (byval base as gsl_vector_complex ptr, byval i as integer, byval n as integer) as _gsl_vector_complex_const_view
declare function gsl_vector_complex_const_subvector_with_stride cdecl alias "gsl_vector_complex_const_subvector_with_stride" (byval v as gsl_vector_complex ptr, byval i as integer, byval stride as integer, byval n as integer) as _gsl_vector_complex_const_view
declare function gsl_vector_complex_real cdecl alias "gsl_vector_complex_real" (byval v as gsl_vector_complex ptr) as _gsl_vector_view
declare function gsl_vector_complex_imag cdecl alias "gsl_vector_complex_imag" (byval v as gsl_vector_complex ptr) as _gsl_vector_view
declare function gsl_vector_complex_const_real cdecl alias "gsl_vector_complex_const_real" (byval v as gsl_vector_complex ptr) as _gsl_vector_const_view
declare function gsl_vector_complex_const_imag cdecl alias "gsl_vector_complex_const_imag" (byval v as gsl_vector_complex ptr) as _gsl_vector_const_view
declare function gsl_vector_complex_get cdecl alias "gsl_vector_complex_get" (byval v as gsl_vector_complex ptr, byval i as integer) as gsl_complex
declare sub gsl_vector_complex_set cdecl alias "gsl_vector_complex_set" (byval v as gsl_vector_complex ptr, byval i as integer, byval z as gsl_complex)
declare function gsl_vector_complex_ptr cdecl alias "gsl_vector_complex_ptr" (byval v as gsl_vector_complex ptr, byval i as integer) as gsl_complex ptr
declare function gsl_vector_complex_const_ptr cdecl alias "gsl_vector_complex_const_ptr" (byval v as gsl_vector_complex ptr, byval i as integer) as gsl_complex ptr
declare sub gsl_vector_complex_set_zero cdecl alias "gsl_vector_complex_set_zero" (byval v as gsl_vector_complex ptr)
declare sub gsl_vector_complex_set_all cdecl alias "gsl_vector_complex_set_all" (byval v as gsl_vector_complex ptr, byval z as gsl_complex)
declare function gsl_vector_complex_set_basis cdecl alias "gsl_vector_complex_set_basis" (byval v as gsl_vector_complex ptr, byval i as integer) as integer
declare function gsl_vector_complex_fread cdecl alias "gsl_vector_complex_fread" (byval stream as FILE ptr, byval v as gsl_vector_complex ptr) as integer
declare function gsl_vector_complex_fwrite cdecl alias "gsl_vector_complex_fwrite" (byval stream as FILE ptr, byval v as gsl_vector_complex ptr) as integer
declare function gsl_vector_complex_fscanf cdecl alias "gsl_vector_complex_fscanf" (byval stream as FILE ptr, byval v as gsl_vector_complex ptr) as integer
declare function gsl_vector_complex_fprintf cdecl alias "gsl_vector_complex_fprintf" (byval stream as FILE ptr, byval v as gsl_vector_complex ptr, byval format as string) as integer
declare function gsl_vector_complex_memcpy cdecl alias "gsl_vector_complex_memcpy" (byval dest as gsl_vector_complex ptr, byval src as gsl_vector_complex ptr) as integer
declare function gsl_vector_complex_reverse cdecl alias "gsl_vector_complex_reverse" (byval v as gsl_vector_complex ptr) as integer
declare function gsl_vector_complex_swap cdecl alias "gsl_vector_complex_swap" (byval v as gsl_vector_complex ptr, byval w as gsl_vector_complex ptr) as integer
declare function gsl_vector_complex_swap_elements cdecl alias "gsl_vector_complex_swap_elements" (byval v as gsl_vector_complex ptr, byval i as integer, byval j as integer) as integer
declare function gsl_vector_complex_isnull cdecl alias "gsl_vector_complex_isnull" (byval v as gsl_vector_complex ptr) as integer

#endif
