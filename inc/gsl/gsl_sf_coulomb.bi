'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
''   specfunc/gsl_sf_coulomb.h
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

#define __GSL_SF_COULOMB_H__
declare function gsl_sf_hydrogenicR_1_e(byval Z as const double, byval r as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_hydrogenicR_1(byval Z as const double, byval r as const double) as double
declare function gsl_sf_hydrogenicR_e(byval n as const long, byval l as const long, byval Z as const double, byval r as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_hydrogenicR(byval n as const long, byval l as const long, byval Z as const double, byval r as const double) as double
declare function gsl_sf_coulomb_wave_FG_e(byval eta as const double, byval x as const double, byval lam_F as const double, byval k_lam_G as const long, byval F as gsl_sf_result ptr, byval Fp as gsl_sf_result ptr, byval G as gsl_sf_result ptr, byval Gp as gsl_sf_result ptr, byval exp_F as double ptr, byval exp_G as double ptr) as long
declare function gsl_sf_coulomb_wave_F_array(byval lam_min as double, byval kmax as long, byval eta as double, byval x as double, byval fc_array as double ptr, byval F_exponent as double ptr) as long
declare function gsl_sf_coulomb_wave_FG_array(byval lam_min as double, byval kmax as long, byval eta as double, byval x as double, byval fc_array as double ptr, byval gc_array as double ptr, byval F_exponent as double ptr, byval G_exponent as double ptr) as long
declare function gsl_sf_coulomb_wave_FGp_array(byval lam_min as double, byval kmax as long, byval eta as double, byval x as double, byval fc_array as double ptr, byval fcp_array as double ptr, byval gc_array as double ptr, byval gcp_array as double ptr, byval F_exponent as double ptr, byval G_exponent as double ptr) as long
declare function gsl_sf_coulomb_wave_sphF_array(byval lam_min as double, byval kmax as long, byval eta as double, byval x as double, byval fc_array as double ptr, byval F_exponent as double ptr) as long
declare function gsl_sf_coulomb_CL_e(byval L as double, byval eta as double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_coulomb_CL_array(byval Lmin as double, byval kmax as long, byval eta as double, byval cl as double ptr) as long

end extern
