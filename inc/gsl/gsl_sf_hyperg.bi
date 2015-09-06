'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
''   specfunc/gsl_sf_hyperg.h
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

#include once "gsl/gsl_sf_result.bi"

extern "C"

#define __GSL_SF_HYPERG_H__
declare function gsl_sf_hyperg_0F1_e(byval c as double, byval x as double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_hyperg_0F1(byval c as const double, byval x as const double) as double
declare function gsl_sf_hyperg_1F1_int_e(byval m as const long, byval n as const long, byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_hyperg_1F1_int(byval m as const long, byval n as const long, byval x as double) as double
declare function gsl_sf_hyperg_1F1_e(byval a as const double, byval b as const double, byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_hyperg_1F1(byval a as double, byval b as double, byval x as double) as double
declare function gsl_sf_hyperg_U_int_e(byval m as const long, byval n as const long, byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_hyperg_U_int(byval m as const long, byval n as const long, byval x as const double) as double
declare function gsl_sf_hyperg_U_int_e10_e(byval m as const long, byval n as const long, byval x as const double, byval result as gsl_sf_result_e10 ptr) as long
declare function gsl_sf_hyperg_U_e(byval a as const double, byval b as const double, byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_hyperg_U(byval a as const double, byval b as const double, byval x as const double) as double
declare function gsl_sf_hyperg_U_e10_e(byval a as const double, byval b as const double, byval x as const double, byval result as gsl_sf_result_e10 ptr) as long
declare function gsl_sf_hyperg_2F1_e(byval a as double, byval b as double, byval c as const double, byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_hyperg_2F1(byval a as double, byval b as double, byval c as double, byval x as double) as double
declare function gsl_sf_hyperg_2F1_conj_e(byval aR as const double, byval aI as const double, byval c as const double, byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_hyperg_2F1_conj(byval aR as double, byval aI as double, byval c as double, byval x as double) as double
declare function gsl_sf_hyperg_2F1_renorm_e(byval a as const double, byval b as const double, byval c as const double, byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_hyperg_2F1_renorm(byval a as double, byval b as double, byval c as double, byval x as double) as double
declare function gsl_sf_hyperg_2F1_conj_renorm_e(byval aR as const double, byval aI as const double, byval c as const double, byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_hyperg_2F1_conj_renorm(byval aR as double, byval aI as double, byval c as double, byval x as double) as double
declare function gsl_sf_hyperg_2F0_e(byval a as const double, byval b as const double, byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_hyperg_2F0(byval a as const double, byval b as const double, byval x as const double) as double

end extern
