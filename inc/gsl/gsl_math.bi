'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
''   gsl_math.h
''
''   Copyright (C) 1996, 1997, 1998, 1999, 2000, 2004, 2007 Gerard Jungman, Brian Gough
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

#include once "crt/math.bi"
#include once "gsl/gsl_sys.bi"
#include once "gsl/gsl_inline.bi"
#include once "gsl/gsl_machine.bi"
#include once "gsl/gsl_precision.bi"
#include once "gsl/gsl_nan.bi"
#include once "gsl/gsl_pow_int.bi"
#include once "gsl/gsl_minmax.bi"

extern "C"

#define __GSL_MATH_H__
#ifndef M_E
	const M_E = 2.71828182845904523536028747135
#endif
#ifndef M_LOG2E
	const M_LOG2E = 1.44269504088896340735992468100
#endif
#ifndef M_LOG10E
	const M_LOG10E = 0.43429448190325182765112891892
#endif
#ifndef M_SQRT2
	const M_SQRT2 = 1.41421356237309504880168872421
#endif
#ifndef M_SQRT1_2
	const M_SQRT1_2 = 0.70710678118654752440084436210
#endif
#ifndef M_SQRT3
	const M_SQRT3 = 1.73205080756887729352744634151
#endif
#ifndef M_PI
	const M_PI = 3.14159265358979323846264338328
#endif
#ifndef M_PI_2
	const M_PI_2 = 1.57079632679489661923132169164
#endif
#ifndef M_PI_4
	const M_PI_4 = 0.78539816339744830961566084582
#endif
#ifndef M_SQRTPI
	const M_SQRTPI = 1.77245385090551602729816748334
#endif
#ifndef M_2_SQRTPI
	const M_2_SQRTPI = 1.12837916709551257389615890312
#endif
#ifndef M_1_PI
	const M_1_PI = 0.31830988618379067153776752675
#endif
#ifndef M_2_PI
	const M_2_PI = 0.63661977236758134307553505349
#endif
#ifndef M_LN10
	const M_LN10 = 2.30258509299404568401799145468
#endif
#ifndef M_LN2
	const M_LN2 = 0.69314718055994530941723212146
#endif
#ifndef M_LNPI
	const M_LNPI = 1.14472988584940017414342735135
#endif
#ifndef M_EULER
	const M_EULER = 0.57721566490153286060651209008
#endif
#define GSL_IS_ODD(n) ((n) and 1)
#define GSL_IS_EVEN(n) (GSL_IS_ODD(n) = 0)
#define GSL_SIGN(x) iif((x) >= 0.0, 1, -1)
#define GSL_IS_REAL(x) gsl_finite(x)

type gsl_function_struct
	function as function(byval x as double, byval params as any ptr) as double
	params as any ptr
end type

type gsl_function as gsl_function_struct
#define GSL_FN_EVAL(F, x) (F)->function(x, (F)->params)

type gsl_function_fdf_struct
	f as function(byval x as double, byval params as any ptr) as double
	df as function(byval x as double, byval params as any ptr) as double
	fdf as sub(byval x as double, byval params as any ptr, byval f as double ptr, byval df as double ptr)
	params as any ptr
end type

type gsl_function_fdf as gsl_function_fdf_struct
#define GSL_FN_FDF_EVAL_F(FDF, x) (FDF)->f(x, (FDF)->params)
#define GSL_FN_FDF_EVAL_DF(FDF, x) (FDF)->df(x, (FDF)->params)
#define GSL_FN_FDF_EVAL_F_DF(FDF_, x, y, dy) (FDF_)->fdf(x, (FDF_)->params, (y), (dy))

type gsl_function_vec_struct
	function as function(byval x as double, byval y as double ptr, byval params as any ptr) as long
	params as any ptr
end type

type gsl_function_vec as gsl_function_vec_struct
#define GSL_FN_VEC_EVAL(F, x, y) (F)->function(x, y, (F)->params)

end extern
