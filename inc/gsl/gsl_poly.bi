'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
''   poly/gsl_poly.h
''
''   Copyright (C) 1996, 1997, 1998, 1999, 2000, 2004, 2007 Brian Gough
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
#include once "gsl/gsl_inline.bi"
#include once "gsl/gsl_complex.bi"

extern "C"

#define __GSL_POLY_H__
declare function gsl_poly_eval(byval c as const double ptr, byval len as const long, byval x as const double) as double
declare function gsl_poly_complex_eval(byval c as const double ptr, byval len as const long, byval z as const gsl_complex) as gsl_complex
declare function gsl_complex_poly_complex_eval(byval c as const gsl_complex ptr, byval len as const long, byval z as const gsl_complex) as gsl_complex
declare function gsl_poly_eval_derivs(byval c as const double ptr, byval lenc as const uinteger, byval x as const double, byval res as double ptr, byval lenres as const uinteger) as long
declare function gsl_poly_dd_init(byval dd as double ptr, byval x as const double ptr, byval y as const double ptr, byval size as uinteger) as long
declare function gsl_poly_dd_eval(byval dd as const double ptr, byval xa as const double ptr, byval size as const uinteger, byval x as const double) as double
declare function gsl_poly_dd_taylor(byval c as double ptr, byval xp as double, byval dd as const double ptr, byval x as const double ptr, byval size as uinteger, byval w as double ptr) as long
declare function gsl_poly_dd_hermite_init(byval dd as double ptr, byval z as double ptr, byval xa as const double ptr, byval ya as const double ptr, byval dya as const double ptr, byval size as const uinteger) as long
declare function gsl_poly_solve_quadratic(byval a as double, byval b as double, byval c as double, byval x0 as double ptr, byval x1 as double ptr) as long
declare function gsl_poly_complex_solve_quadratic(byval a as double, byval b as double, byval c as double, byval z0 as gsl_complex ptr, byval z1 as gsl_complex ptr) as long
declare function gsl_poly_solve_cubic(byval a as double, byval b as double, byval c as double, byval x0 as double ptr, byval x1 as double ptr, byval x2 as double ptr) as long
declare function gsl_poly_complex_solve_cubic(byval a as double, byval b as double, byval c as double, byval z0 as gsl_complex ptr, byval z1 as gsl_complex ptr, byval z2 as gsl_complex ptr) as long

type gsl_poly_complex_workspace
	nc as uinteger
	matrix as double ptr
end type

declare function gsl_poly_complex_workspace_alloc(byval n as uinteger) as gsl_poly_complex_workspace ptr
declare sub gsl_poly_complex_workspace_free(byval w as gsl_poly_complex_workspace ptr)
declare function gsl_poly_complex_solve(byval a as const double ptr, byval n as uinteger, byval w as gsl_poly_complex_workspace ptr, byval z as gsl_complex_packed_ptr) as long

end extern
