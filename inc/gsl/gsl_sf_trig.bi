'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
''   specfunc/gsl_sf_trig.h
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

#define __GSL_SF_TRIG_H__
declare function gsl_sf_sin_e(byval x as double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_sin(byval x as const double) as double
declare function gsl_sf_cos_e(byval x as double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_cos(byval x as const double) as double
declare function gsl_sf_hypot_e(byval x as const double, byval y as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_hypot(byval x as const double, byval y as const double) as double
declare function gsl_sf_complex_sin_e(byval zr as const double, byval zi as const double, byval szr as gsl_sf_result ptr, byval szi as gsl_sf_result ptr) as long
declare function gsl_sf_complex_cos_e(byval zr as const double, byval zi as const double, byval czr as gsl_sf_result ptr, byval czi as gsl_sf_result ptr) as long
declare function gsl_sf_complex_logsin_e(byval zr as const double, byval zi as const double, byval lszr as gsl_sf_result ptr, byval lszi as gsl_sf_result ptr) as long
declare function gsl_sf_sinc_e(byval x as double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_sinc(byval x as const double) as double
declare function gsl_sf_lnsinh_e(byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_lnsinh(byval x as const double) as double
declare function gsl_sf_lncosh_e(byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_lncosh(byval x as const double) as double
declare function gsl_sf_polar_to_rect(byval r as const double, byval theta as const double, byval x as gsl_sf_result ptr, byval y as gsl_sf_result ptr) as long
declare function gsl_sf_rect_to_polar(byval x as const double, byval y as const double, byval r as gsl_sf_result ptr, byval theta as gsl_sf_result ptr) as long
declare function gsl_sf_sin_err_e(byval x as const double, byval dx as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_cos_err_e(byval x as const double, byval dx as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_angle_restrict_symm_e(byval theta as double ptr) as long
declare function gsl_sf_angle_restrict_symm(byval theta as const double) as double
declare function gsl_sf_angle_restrict_pos_e(byval theta as double ptr) as long
declare function gsl_sf_angle_restrict_pos(byval theta as const double) as double
declare function gsl_sf_angle_restrict_symm_err_e(byval theta as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_angle_restrict_pos_err_e(byval theta as const double, byval result as gsl_sf_result ptr) as long

end extern
