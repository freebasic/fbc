'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
''   specfunc/gsl_sf_exp.h
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
#include once "gsl/gsl_precision.bi"

extern "C"

#define __GSL_SF_EXP_H__
declare function gsl_sf_exp_e(byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_exp(byval x as const double) as double
declare function gsl_sf_exp_e10_e(byval x as const double, byval result as gsl_sf_result_e10 ptr) as long
declare function gsl_sf_exp_mult_e(byval x as const double, byval y as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_exp_mult(byval x as const double, byval y as const double) as double
declare function gsl_sf_exp_mult_e10_e(byval x as const double, byval y as const double, byval result as gsl_sf_result_e10 ptr) as long
declare function gsl_sf_expm1_e(byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_expm1(byval x as const double) as double
declare function gsl_sf_exprel_e(byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_exprel(byval x as const double) as double
declare function gsl_sf_exprel_2_e(byval x as double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_exprel_2(byval x as const double) as double
declare function gsl_sf_exprel_n_e(byval n as const long, byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_exprel_n(byval n as const long, byval x as const double) as double
declare function gsl_sf_exprel_n_CF_e(byval n as const double, byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_exp_err_e(byval x as const double, byval dx as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_exp_err_e10_e(byval x as const double, byval dx as const double, byval result as gsl_sf_result_e10 ptr) as long
declare function gsl_sf_exp_mult_err_e(byval x as const double, byval dx as const double, byval y as const double, byval dy as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_exp_mult_err_e10_e(byval x as const double, byval dx as const double, byval y as const double, byval dy as const double, byval result as gsl_sf_result_e10 ptr) as long

end extern
