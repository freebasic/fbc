'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
''   specfunc/gsl_sf_psi.h
''
''   Copyright (C) 1996, 1997, 1998, 1999, 2000, 2004 Gerard Jungman
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

#define __GSL_SF_PSI_H__
declare function gsl_sf_psi_int_e(byval n as const long, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_psi_int(byval n as const long) as double
declare function gsl_sf_psi_e(byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_psi(byval x as const double) as double
declare function gsl_sf_psi_1piy_e(byval y as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_psi_1piy(byval y as const double) as double
declare function gsl_sf_complex_psi_e(byval x as const double, byval y as const double, byval result_re as gsl_sf_result ptr, byval result_im as gsl_sf_result ptr) as long
declare function gsl_sf_psi_1_int_e(byval n as const long, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_psi_1_int(byval n as const long) as double
declare function gsl_sf_psi_1_e(byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_psi_1(byval x as const double) as double
declare function gsl_sf_psi_n_e(byval n as const long, byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_psi_n(byval n as const long, byval x as const double) as double

end extern
