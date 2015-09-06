'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
''   ieee-utils/gsl_ieee_utils.h
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

#include once "crt/stdio.bi"

extern "C"

#define __GSL_IEEE_UTILS_H__

enum
	GSL_IEEE_TYPE_NAN = 1
	GSL_IEEE_TYPE_INF = 2
	GSL_IEEE_TYPE_NORMAL = 3
	GSL_IEEE_TYPE_DENORMAL = 4
	GSL_IEEE_TYPE_ZERO = 5
end enum

type gsl_ieee_float_rep
	sign as long
	mantissa as zstring * 24
	exponent as long
	as long type
end type

type gsl_ieee_double_rep
	sign as long
	mantissa as zstring * 53
	exponent as long
	as long type
end type

declare sub gsl_ieee_printf_float(byval x as const single ptr)
declare sub gsl_ieee_printf_double(byval x as const double ptr)
declare sub gsl_ieee_fprintf_float(byval stream as FILE ptr, byval x as const single ptr)
declare sub gsl_ieee_fprintf_double(byval stream as FILE ptr, byval x as const double ptr)
declare sub gsl_ieee_float_to_rep(byval x as const single ptr, byval r as gsl_ieee_float_rep ptr)
declare sub gsl_ieee_double_to_rep(byval x as const double ptr, byval r as gsl_ieee_double_rep ptr)

enum
	GSL_IEEE_SINGLE_PRECISION = 1
	GSL_IEEE_DOUBLE_PRECISION = 2
	GSL_IEEE_EXTENDED_PRECISION = 3
end enum

enum
	GSL_IEEE_ROUND_TO_NEAREST = 1
	GSL_IEEE_ROUND_DOWN = 2
	GSL_IEEE_ROUND_UP = 3
	GSL_IEEE_ROUND_TO_ZERO = 4
end enum

enum
	GSL_IEEE_MASK_INVALID = 1
	GSL_IEEE_MASK_DENORMALIZED = 2
	GSL_IEEE_MASK_DIVISION_BY_ZERO = 4
	GSL_IEEE_MASK_OVERFLOW = 8
	GSL_IEEE_MASK_UNDERFLOW = 16
	GSL_IEEE_MASK_ALL = 31
	GSL_IEEE_TRAP_INEXACT = 32
end enum

declare sub gsl_ieee_env_setup()
declare function gsl_ieee_read_mode_string(byval description as const zstring ptr, byval precision as long ptr, byval rounding as long ptr, byval exception_mask as long ptr) as long
declare function gsl_ieee_set_mode(byval precision as long, byval rounding as long, byval exception_mask as long) as long

end extern
