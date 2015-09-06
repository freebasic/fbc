'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
''   wavelet/gsl_wavelet.h
''
''   Copyright (C) 2004 Ivo Alxneit
''
''   This program is free software; you can redistribute it and/or modify
''   it under the terms of the GNU General Public License as published by
''   the Free Software Foundation; either version 3 of the License, or (at
''   your option) any later version.
''
''   This program is distributed in the hope that it will be useful, but
''   WITHOUT ANY WARRANTY; without even the implied warranty of
''   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
''   General Public License for more details.
''
''   You should have received a copy of the GNU General Public License
''   along with this program; if not, write to the Free Software
''   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "crt/stdlib.bi"
#include once "gsl/gsl_types.bi"
#include once "gsl/gsl_errno.bi"

extern "C"

#define __GSL_WAVELET_H__

type gsl_wavelet_direction as long
enum
	gsl_wavelet_forward = 1
	gsl_wavelet_backward = -1
end enum

type gsl_wavelet_type
	name as const zstring ptr
	init as function(byval h1 as const double ptr ptr, byval g1 as const double ptr ptr, byval h2 as const double ptr ptr, byval g2 as const double ptr ptr, byval nc as uinteger ptr, byval offset as uinteger ptr, byval member as uinteger) as long
end type

type gsl_wavelet
	as const gsl_wavelet_type ptr type
	h1 as const double ptr
	g1 as const double ptr
	h2 as const double ptr
	g2 as const double ptr
	nc as uinteger
	offset as uinteger
end type

type gsl_wavelet_workspace
	scratch as double ptr
	n as uinteger
end type

extern gsl_wavelet_daubechies as const gsl_wavelet_type ptr
extern gsl_wavelet_daubechies_centered as const gsl_wavelet_type ptr
extern gsl_wavelet_haar as const gsl_wavelet_type ptr
extern gsl_wavelet_haar_centered as const gsl_wavelet_type ptr
extern gsl_wavelet_bspline as const gsl_wavelet_type ptr
extern gsl_wavelet_bspline_centered as const gsl_wavelet_type ptr

declare function gsl_wavelet_alloc(byval T as const gsl_wavelet_type ptr, byval k as uinteger) as gsl_wavelet ptr
declare sub gsl_wavelet_free(byval w as gsl_wavelet ptr)
declare function gsl_wavelet_name(byval w as const gsl_wavelet ptr) as const zstring ptr
declare function gsl_wavelet_workspace_alloc(byval n as uinteger) as gsl_wavelet_workspace ptr
declare sub gsl_wavelet_workspace_free(byval work as gsl_wavelet_workspace ptr)
declare function gsl_wavelet_transform(byval w as const gsl_wavelet ptr, byval data as double ptr, byval stride as uinteger, byval n as uinteger, byval dir as gsl_wavelet_direction, byval work as gsl_wavelet_workspace ptr) as long
declare function gsl_wavelet_transform_forward(byval w as const gsl_wavelet ptr, byval data as double ptr, byval stride as uinteger, byval n as uinteger, byval work as gsl_wavelet_workspace ptr) as long
declare function gsl_wavelet_transform_inverse(byval w as const gsl_wavelet ptr, byval data as double ptr, byval stride as uinteger, byval n as uinteger, byval work as gsl_wavelet_workspace ptr) as long

end extern
