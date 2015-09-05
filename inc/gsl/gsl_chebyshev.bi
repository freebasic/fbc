'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
''   cheb/gsl_chebyshev.h
''
''   Copyright (C) 1996, 1997, 1998, 1999, 2000 Gerard Jungman
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

#include once "gsl/gsl_math.bi"
#include once "gsl/gsl_mode.bi"

extern "C"

#define __GSL_CHEBYSHEV_H__

type gsl_cheb_series_struct
	c as double ptr
	order as uinteger
	a as double
	b as double
	order_sp as uinteger
	f as double ptr
end type

type gsl_cheb_series as gsl_cheb_series_struct
declare function gsl_cheb_alloc(byval order as const uinteger) as gsl_cheb_series ptr
declare sub gsl_cheb_free(byval cs as gsl_cheb_series ptr)
declare function gsl_cheb_init(byval cs as gsl_cheb_series ptr, byval func as const gsl_function ptr, byval a as const double, byval b as const double) as long
declare function gsl_cheb_order(byval cs as const gsl_cheb_series ptr) as uinteger
declare function gsl_cheb_size(byval cs as const gsl_cheb_series ptr) as uinteger
declare function gsl_cheb_coeffs(byval cs as const gsl_cheb_series ptr) as double ptr
declare function gsl_cheb_eval(byval cs as const gsl_cheb_series ptr, byval x as const double) as double
declare function gsl_cheb_eval_err(byval cs as const gsl_cheb_series ptr, byval x as const double, byval result as double ptr, byval abserr as double ptr) as long
declare function gsl_cheb_eval_n(byval cs as const gsl_cheb_series ptr, byval order as const uinteger, byval x as const double) as double
declare function gsl_cheb_eval_n_err(byval cs as const gsl_cheb_series ptr, byval order as const uinteger, byval x as const double, byval result as double ptr, byval abserr as double ptr) as long
declare function gsl_cheb_eval_mode(byval cs as const gsl_cheb_series ptr, byval x as const double, byval mode as gsl_mode_t) as double
declare function gsl_cheb_eval_mode_e(byval cs as const gsl_cheb_series ptr, byval x as const double, byval mode as gsl_mode_t, byval result as double ptr, byval abserr as double ptr) as long
declare function gsl_cheb_calc_deriv(byval deriv as gsl_cheb_series ptr, byval cs as const gsl_cheb_series ptr) as long
declare function gsl_cheb_calc_integ(byval integ as gsl_cheb_series ptr, byval cs as const gsl_cheb_series ptr) as long

end extern
