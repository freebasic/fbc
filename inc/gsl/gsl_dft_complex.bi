'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
''   fft/gsl_dft_complex.h
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

#define __GSL_DFT_COMPLEX_H__
declare function gsl_dft_complex_forward(byval data as const double ptr, byval stride as const uinteger, byval n as const uinteger, byval result as double ptr) as long
declare function gsl_dft_complex_backward(byval data as const double ptr, byval stride as const uinteger, byval n as const uinteger, byval result as double ptr) as long
declare function gsl_dft_complex_inverse(byval data as const double ptr, byval stride as const uinteger, byval n as const uinteger, byval result as double ptr) as long
declare function gsl_dft_complex_transform(byval data as const double ptr, byval stride as const uinteger, byval n as const uinteger, byval result as double ptr, byval sign as const gsl_fft_direction) as long

end extern
