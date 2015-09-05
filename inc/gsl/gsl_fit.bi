'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
''   fit/gsl_fit.h
''
''   Copyright (C) 2000, 2007 Brian Gough
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

extern "C"

#define __GSL_FIT_H__
declare function gsl_fit_linear(byval x as const double ptr, byval xstride as const uinteger, byval y as const double ptr, byval ystride as const uinteger, byval n as const uinteger, byval c0 as double ptr, byval c1 as double ptr, byval cov00 as double ptr, byval cov01 as double ptr, byval cov11 as double ptr, byval sumsq as double ptr) as long
declare function gsl_fit_wlinear(byval x as const double ptr, byval xstride as const uinteger, byval w as const double ptr, byval wstride as const uinteger, byval y as const double ptr, byval ystride as const uinteger, byval n as const uinteger, byval c0 as double ptr, byval c1 as double ptr, byval cov00 as double ptr, byval cov01 as double ptr, byval cov11 as double ptr, byval chisq as double ptr) as long
declare function gsl_fit_linear_est(byval x as const double, byval c0 as const double, byval c1 as const double, byval cov00 as const double, byval cov01 as const double, byval cov11 as const double, byval y as double ptr, byval y_err as double ptr) as long
declare function gsl_fit_mul(byval x as const double ptr, byval xstride as const uinteger, byval y as const double ptr, byval ystride as const uinteger, byval n as const uinteger, byval c1 as double ptr, byval cov11 as double ptr, byval sumsq as double ptr) as long
declare function gsl_fit_wmul(byval x as const double ptr, byval xstride as const uinteger, byval w as const double ptr, byval wstride as const uinteger, byval y as const double ptr, byval ystride as const uinteger, byval n as const uinteger, byval c1 as double ptr, byval cov11 as double ptr, byval sumsq as double ptr) as long
declare function gsl_fit_mul_est(byval x as const double, byval c1 as const double, byval cov11 as const double, byval y as double ptr, byval y_err as double ptr) as long

end extern
