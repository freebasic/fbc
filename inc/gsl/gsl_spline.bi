'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
''   interpolation/gsl_spline.h
''
''   Copyright (C) 2001, 2007 Brian Gough
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
#include once "gsl/gsl_interp.bi"

extern "C"

#define __GSL_SPLINE_H__

type gsl_spline
	interp as gsl_interp ptr
	x as double ptr
	y as double ptr
	size as uinteger
end type

declare function gsl_spline_alloc(byval T as const gsl_interp_type ptr, byval size as uinteger) as gsl_spline ptr
declare function gsl_spline_init(byval spline as gsl_spline ptr, byval xa as const double ptr, byval ya as const double ptr, byval size as uinteger) as long
declare function gsl_spline_name(byval spline as const gsl_spline ptr) as const zstring ptr
declare function gsl_spline_min_size(byval spline as const gsl_spline ptr) as ulong
declare function gsl_spline_eval_e(byval spline as const gsl_spline ptr, byval x as double, byval a as gsl_interp_accel ptr, byval y as double ptr) as long
declare function gsl_spline_eval(byval spline as const gsl_spline ptr, byval x as double, byval a as gsl_interp_accel ptr) as double
declare function gsl_spline_eval_deriv_e(byval spline as const gsl_spline ptr, byval x as double, byval a as gsl_interp_accel ptr, byval y as double ptr) as long
declare function gsl_spline_eval_deriv(byval spline as const gsl_spline ptr, byval x as double, byval a as gsl_interp_accel ptr) as double
declare function gsl_spline_eval_deriv2_e(byval spline as const gsl_spline ptr, byval x as double, byval a as gsl_interp_accel ptr, byval y as double ptr) as long
declare function gsl_spline_eval_deriv2(byval spline as const gsl_spline ptr, byval x as double, byval a as gsl_interp_accel ptr) as double
declare function gsl_spline_eval_integ_e(byval spline as const gsl_spline ptr, byval a as double, byval b as double, byval acc as gsl_interp_accel ptr, byval y as double ptr) as long
declare function gsl_spline_eval_integ(byval spline as const gsl_spline ptr, byval a as double, byval b as double, byval acc as gsl_interp_accel ptr) as double
declare sub gsl_spline_free(byval spline as gsl_spline ptr)

end extern
