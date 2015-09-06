'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
''   complex/gsl_complex.h
''
''   Copyright (C) 1996, 1997, 1998, 1999, 2000, 2007 Gerard Jungman, Brian Gough
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

#include once "crt/longdouble.bi"

#define __GSL_COMPLEX_H__
type gsl_complex_packed as double ptr
type gsl_complex_packed_float as single ptr
type gsl_complex_packed_long_double as clongdouble ptr
type gsl_const_complex_packed as const double ptr
type gsl_const_complex_packed_float as const single ptr
type gsl_const_complex_packed_long_double as const clongdouble ptr
type gsl_complex_packed_array as double ptr
type gsl_complex_packed_array_float as single ptr
type gsl_complex_packed_array_long_double as clongdouble ptr
type gsl_const_complex_packed_array as const double ptr
type gsl_const_complex_packed_array_float as const single ptr
type gsl_const_complex_packed_array_long_double as const clongdouble ptr
type gsl_complex_packed_ptr as double ptr
type gsl_complex_packed_float_ptr as single ptr
type gsl_complex_packed_long_double_ptr as clongdouble ptr
type gsl_const_complex_packed_ptr as const double ptr
type gsl_const_complex_packed_float_ptr as const single ptr
type gsl_const_complex_packed_long_double_ptr as const clongdouble ptr

type gsl_complex_long_double
	dat(0 to 1) as clongdouble
end type

type gsl_complex
	dat(0 to 1) as double
end type

type gsl_complex_float
	dat(0 to 1) as single
end type

#define GSL_REAL(z) (z).dat[0]
#define GSL_IMAG(z) (z).dat[1]
#define GSL_COMPLEX_P(zp) (zp)->dat
#define GSL_COMPLEX_P_REAL(zp) (zp)->dat[0]
#define GSL_COMPLEX_P_IMAG(zp) (zp)->dat[1]
#define GSL_COMPLEX_EQ(z1, z2) (((z1).dat[0] = (z2).dat[0]) andalso ((z1).dat[1] = (z2).dat[1]))
#macro GSL_SET_COMPLEX(zp, x, y)
	scope
		(zp)->dat[0] = (x)
		(zp)->dat[1] = (y)
	end scope
#endmacro
#define GSL_SET_REAL(zp, x) scope : (zp)->dat[0] = (x) : end scope
#define GSL_SET_IMAG(zp, y) scope : (zp)->dat[1] = (y) : end scope
#macro GSL_SET_COMPLEX_PACKED(zp, n, x, y)
	scope
		(*((zp) + (2 * (n)))) = (x)
		(*((zp) + ((2 * (n)) + 1))) = (y)
	end scope
#endmacro
