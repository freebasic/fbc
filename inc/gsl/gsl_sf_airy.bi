'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
''   specfunc/gsl_sf_airy.h
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

#include once "gsl/gsl_mode.bi"
#include once "gsl/gsl_sf_result.bi"

extern "C"

#define __GSL_SF_AIRY_H__
declare function gsl_sf_airy_Ai_e(byval x as const double, byval mode as const gsl_mode_t, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_airy_Ai(byval x as const double, byval mode as gsl_mode_t) as double
declare function gsl_sf_airy_Bi_e(byval x as const double, byval mode as gsl_mode_t, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_airy_Bi(byval x as const double, byval mode as gsl_mode_t) as double
declare function gsl_sf_airy_Ai_scaled_e(byval x as const double, byval mode as gsl_mode_t, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_airy_Ai_scaled(byval x as const double, byval mode as gsl_mode_t) as double
declare function gsl_sf_airy_Bi_scaled_e(byval x as const double, byval mode as gsl_mode_t, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_airy_Bi_scaled(byval x as const double, byval mode as gsl_mode_t) as double
declare function gsl_sf_airy_Ai_deriv_e(byval x as const double, byval mode as gsl_mode_t, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_airy_Ai_deriv(byval x as const double, byval mode as gsl_mode_t) as double
declare function gsl_sf_airy_Bi_deriv_e(byval x as const double, byval mode as gsl_mode_t, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_airy_Bi_deriv(byval x as const double, byval mode as gsl_mode_t) as double
declare function gsl_sf_airy_Ai_deriv_scaled_e(byval x as const double, byval mode as gsl_mode_t, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_airy_Ai_deriv_scaled(byval x as const double, byval mode as gsl_mode_t) as double
declare function gsl_sf_airy_Bi_deriv_scaled_e(byval x as const double, byval mode as gsl_mode_t, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_airy_Bi_deriv_scaled(byval x as const double, byval mode as gsl_mode_t) as double
declare function gsl_sf_airy_zero_Ai_e(byval s as ulong, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_airy_zero_Ai(byval s as ulong) as double
declare function gsl_sf_airy_zero_Bi_e(byval s as ulong, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_airy_zero_Bi(byval s as ulong) as double
declare function gsl_sf_airy_zero_Ai_deriv_e(byval s as ulong, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_airy_zero_Ai_deriv(byval s as ulong) as double
declare function gsl_sf_airy_zero_Bi_deriv_e(byval s as ulong, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_airy_zero_Bi_deriv(byval s as ulong) as double

end extern
