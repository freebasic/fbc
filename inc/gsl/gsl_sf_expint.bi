'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
''   specfunc/gsl_sf_expint.h
''
''   Copyright (C) 2007 Brian Gough
''   Copyright (C) 1996, 1997, 1998, 1999, 2000, 2001, 2002 Gerard Jungman
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

#include once "gsl/gsl_sf_result.bi"

extern "C"

#define __GSL_SF_EXPINT_H__
declare function gsl_sf_expint_E1_e(byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_expint_E1(byval x as const double) as double
declare function gsl_sf_expint_E2_e(byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_expint_E2(byval x as const double) as double
declare function gsl_sf_expint_En_e(byval n as const long, byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_expint_En(byval n as const long, byval x as const double) as double
declare function gsl_sf_expint_E1_scaled_e(byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_expint_E1_scaled(byval x as const double) as double
declare function gsl_sf_expint_E2_scaled_e(byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_expint_E2_scaled(byval x as const double) as double
declare function gsl_sf_expint_En_scaled_e(byval n as const long, byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_expint_En_scaled(byval n as const long, byval x as const double) as double
declare function gsl_sf_expint_Ei_e(byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_expint_Ei(byval x as const double) as double
declare function gsl_sf_expint_Ei_scaled_e(byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_expint_Ei_scaled(byval x as const double) as double
declare function gsl_sf_Shi_e(byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_Shi(byval x as const double) as double
declare function gsl_sf_Chi_e(byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_Chi(byval x as const double) as double
declare function gsl_sf_expint_3_e(byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_expint_3(byval x as double) as double
declare function gsl_sf_Si_e(byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_Si(byval x as const double) as double
declare function gsl_sf_Ci_e(byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_Ci(byval x as const double) as double
declare function gsl_sf_atanint_e(byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_atanint(byval x as const double) as double

end extern
