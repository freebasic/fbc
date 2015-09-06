'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
''   sys/gsl_sys.h
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

extern "C"

#define __GSL_SYS_H__
declare function gsl_log1p(byval x as const double) as double
declare function gsl_expm1(byval x as const double) as double
declare function gsl_hypot(byval x as const double, byval y as const double) as double
declare function gsl_hypot3(byval x as const double, byval y as const double, byval z as const double) as double
declare function gsl_acosh(byval x as const double) as double
declare function gsl_asinh(byval x as const double) as double
declare function gsl_atanh(byval x as const double) as double
declare function gsl_isnan(byval x as const double) as long
declare function gsl_isinf(byval x as const double) as long
declare function gsl_finite(byval x as const double) as long
declare function gsl_nan() as double
declare function gsl_posinf() as double
declare function gsl_neginf() as double
declare function gsl_fdiv(byval x as const double, byval y as const double) as double
declare function gsl_coerce_double(byval x as const double) as double
declare function gsl_coerce_float(byval x as const single) as single
declare function gsl_coerce_long_double(byval x as const clongdouble) as clongdouble
declare function gsl_ldexp(byval x as const double, byval e as const long) as double
declare function gsl_frexp(byval x as const double, byval e as long ptr) as double
declare function gsl_fcmp(byval x1 as const double, byval x2 as const double, byval epsilon as const double) as long

end extern
