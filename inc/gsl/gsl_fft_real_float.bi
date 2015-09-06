'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
''   fft/gsl_fft_real_float.h
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

#define __GSL_FFT_REAL_FLOAT_H__
declare function gsl_fft_real_float_radix2_transform(byval data as single ptr, byval stride as const uinteger, byval n as const uinteger) as long

type gsl_fft_real_wavetable_float
	n as uinteger
	nf as uinteger
	factor(0 to 63) as uinteger
	twiddle(0 to 63) as gsl_complex_float ptr
	trig as gsl_complex_float ptr
end type

type gsl_fft_real_workspace_float
	n as uinteger
	scratch as single ptr
end type

declare function gsl_fft_real_wavetable_float_alloc(byval n as uinteger) as gsl_fft_real_wavetable_float ptr
declare sub gsl_fft_real_wavetable_float_free(byval wavetable as gsl_fft_real_wavetable_float ptr)
declare function gsl_fft_real_workspace_float_alloc(byval n as uinteger) as gsl_fft_real_workspace_float ptr
declare sub gsl_fft_real_workspace_float_free(byval workspace as gsl_fft_real_workspace_float ptr)
declare function gsl_fft_real_float_transform(byval data as single ptr, byval stride as const uinteger, byval n as const uinteger, byval wavetable as const gsl_fft_real_wavetable_float ptr, byval work as gsl_fft_real_workspace_float ptr) as long
declare function gsl_fft_real_float_unpack(byval real_float_coefficient as const single ptr, byval complex_coefficient as single ptr, byval stride as const uinteger, byval n as const uinteger) as long

end extern
