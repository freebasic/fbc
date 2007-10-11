''
''
'' gsl_wavelet -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_wavelet_bi__
#define __gsl_wavelet_bi__

#include once "gsl_types.bi"
#include once "gsl_errno.bi"

enum gsl_wavelet_direction
	forward = 1
	backward = -1
end enum


type gsl_wavelet_type
	name as byte ptr
	init as function cdecl(byval as double ptr ptr, byval as double ptr ptr, byval as double ptr ptr, byval as double ptr ptr, byval as integer ptr, byval as integer ptr, byval as integer) as integer
end type

type gsl_wavelet
	type as gsl_wavelet_type ptr
	h1 as double ptr
	g1 as double ptr
	h2 as double ptr
	g2 as double ptr
	nc as integer
	offset as integer
end type

type gsl_wavelet_workspace
	scratch as double ptr
	n as integer
end type

extern "c"
declare function gsl_wavelet_alloc (byval T as gsl_wavelet_type ptr, byval k as integer) as gsl_wavelet ptr
declare sub gsl_wavelet_free (byval w as gsl_wavelet ptr)
declare function gsl_wavelet_name (byval w as gsl_wavelet ptr) as zstring ptr
declare function gsl_wavelet_workspace_alloc (byval n as integer) as gsl_wavelet_workspace ptr
declare sub gsl_wavelet_workspace_free (byval work as gsl_wavelet_workspace ptr)
declare function gsl_wavelet_transform (byval w as gsl_wavelet ptr, byval data as double ptr, byval stride as integer, byval n as integer, byval dir as gsl_wavelet_direction, byval work as gsl_wavelet_workspace ptr) as integer
declare function gsl_wavelet_transform_forward (byval w as gsl_wavelet ptr, byval data as double ptr, byval stride as integer, byval n as integer, byval work as gsl_wavelet_workspace ptr) as integer
declare function gsl_wavelet_transform_inverse (byval w as gsl_wavelet ptr, byval data as double ptr, byval stride as integer, byval n as integer, byval work as gsl_wavelet_workspace ptr) as integer
end extern

#endif
