'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
''   bspline/gsl_bspline.h
''
''   Copyright (C) 2006 Patrick Alken
''   Copyright (C) 2008 Rhys Ulerich
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
#include once "gsl/gsl_math.bi"
#include once "gsl/gsl_vector.bi"
#include once "gsl/gsl_matrix.bi"

extern "C"

#define __GSL_BSPLINE_H__

type gsl_bspline_workspace
	k as uinteger
	km1 as uinteger
	l as uinteger
	nbreak as uinteger
	n as uinteger
	knots as gsl_vector ptr
	deltal as gsl_vector ptr
	deltar as gsl_vector ptr
	B as gsl_vector ptr
end type

type gsl_bspline_deriv_workspace
	k as uinteger
	A as gsl_matrix ptr
	dB as gsl_matrix ptr
end type

declare function gsl_bspline_alloc(byval k as const uinteger, byval nbreak as const uinteger) as gsl_bspline_workspace ptr
declare sub gsl_bspline_free(byval w as gsl_bspline_workspace ptr)
declare function gsl_bspline_ncoeffs(byval w as gsl_bspline_workspace ptr) as uinteger
declare function gsl_bspline_order(byval w as gsl_bspline_workspace ptr) as uinteger
declare function gsl_bspline_nbreak(byval w as gsl_bspline_workspace ptr) as uinteger
declare function gsl_bspline_breakpoint(byval i as uinteger, byval w as gsl_bspline_workspace ptr) as double
declare function gsl_bspline_greville_abscissa(byval i as uinteger, byval w as gsl_bspline_workspace ptr) as double
declare function gsl_bspline_knots(byval breakpts as const gsl_vector ptr, byval w as gsl_bspline_workspace ptr) as long
declare function gsl_bspline_knots_uniform(byval a as const double, byval b as const double, byval w as gsl_bspline_workspace ptr) as long
declare function gsl_bspline_knots_greville(byval abscissae as const gsl_vector ptr, byval w as gsl_bspline_workspace ptr, byval abserr as double ptr) as long
declare function gsl_bspline_eval(byval x as const double, byval B as gsl_vector ptr, byval w as gsl_bspline_workspace ptr) as long
declare function gsl_bspline_eval_nonzero(byval x as const double, byval Bk as gsl_vector ptr, byval istart as uinteger ptr, byval iend as uinteger ptr, byval w as gsl_bspline_workspace ptr) as long
declare function gsl_bspline_deriv_alloc(byval k as const uinteger) as gsl_bspline_deriv_workspace ptr
declare sub gsl_bspline_deriv_free(byval w as gsl_bspline_deriv_workspace ptr)
declare function gsl_bspline_deriv_eval(byval x as const double, byval nderiv as const uinteger, byval dB as gsl_matrix ptr, byval w as gsl_bspline_workspace ptr, byval dw as gsl_bspline_deriv_workspace ptr) as long
declare function gsl_bspline_deriv_eval_nonzero(byval x as const double, byval nderiv as const uinteger, byval dB as gsl_matrix ptr, byval istart as uinteger ptr, byval iend as uinteger ptr, byval w as gsl_bspline_workspace ptr, byval dw as gsl_bspline_deriv_workspace ptr) as long

end extern
