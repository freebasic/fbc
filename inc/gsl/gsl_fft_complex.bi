'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
''   fft/gsl_fft_complex.h
''
''   Copyright (C) 1996, 1997, 1998, 1999, 2000, 2007 Brian Gough
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

#include once "crt/stddef.bi"
#include once "gsl/gsl_math.bi"
#include once "gsl/gsl_complex.bi"
#include once "gsl/gsl_fft.bi"

extern "C"

#define __GSL_FFT_COMPLEX_H__
declare function gsl_fft_complex_radix2_forward(byval data as gsl_complex_packed_array, byval stride as const uinteger, byval n as const uinteger) as long
declare function gsl_fft_complex_radix2_backward(byval data as gsl_complex_packed_array, byval stride as const uinteger, byval n as const uinteger) as long
declare function gsl_fft_complex_radix2_inverse(byval data as gsl_complex_packed_array, byval stride as const uinteger, byval n as const uinteger) as long
declare function gsl_fft_complex_radix2_transform(byval data as gsl_complex_packed_array, byval stride as const uinteger, byval n as const uinteger, byval sign as const gsl_fft_direction) as long
declare function gsl_fft_complex_radix2_dif_forward(byval data as gsl_complex_packed_array, byval stride as const uinteger, byval n as const uinteger) as long
declare function gsl_fft_complex_radix2_dif_backward(byval data as gsl_complex_packed_array, byval stride as const uinteger, byval n as const uinteger) as long
declare function gsl_fft_complex_radix2_dif_inverse(byval data as gsl_complex_packed_array, byval stride as const uinteger, byval n as const uinteger) as long
declare function gsl_fft_complex_radix2_dif_transform(byval data as gsl_complex_packed_array, byval stride as const uinteger, byval n as const uinteger, byval sign as const gsl_fft_direction) as long

type gsl_fft_complex_wavetable
	n as uinteger
	nf as uinteger
	factor(0 to 63) as uinteger
	twiddle(0 to 63) as gsl_complex ptr
	trig as gsl_complex ptr
end type

type gsl_fft_complex_workspace
	n as uinteger
	scratch as double ptr
end type

declare function gsl_fft_complex_wavetable_alloc(byval n as uinteger) as gsl_fft_complex_wavetable ptr
declare sub gsl_fft_complex_wavetable_free(byval wavetable as gsl_fft_complex_wavetable ptr)
declare function gsl_fft_complex_workspace_alloc(byval n as uinteger) as gsl_fft_complex_workspace ptr
declare sub gsl_fft_complex_workspace_free(byval workspace as gsl_fft_complex_workspace ptr)
declare function gsl_fft_complex_memcpy(byval dest as gsl_fft_complex_wavetable ptr, byval src as gsl_fft_complex_wavetable ptr) as long
declare function gsl_fft_complex_forward(byval data as gsl_complex_packed_array, byval stride as const uinteger, byval n as const uinteger, byval wavetable as const gsl_fft_complex_wavetable ptr, byval work as gsl_fft_complex_workspace ptr) as long
declare function gsl_fft_complex_backward(byval data as gsl_complex_packed_array, byval stride as const uinteger, byval n as const uinteger, byval wavetable as const gsl_fft_complex_wavetable ptr, byval work as gsl_fft_complex_workspace ptr) as long
declare function gsl_fft_complex_inverse(byval data as gsl_complex_packed_array, byval stride as const uinteger, byval n as const uinteger, byval wavetable as const gsl_fft_complex_wavetable ptr, byval work as gsl_fft_complex_workspace ptr) as long
declare function gsl_fft_complex_transform(byval data as gsl_complex_packed_array, byval stride as const uinteger, byval n as const uinteger, byval wavetable as const gsl_fft_complex_wavetable ptr, byval work as gsl_fft_complex_workspace ptr, byval sign as const gsl_fft_direction) as long

end extern
