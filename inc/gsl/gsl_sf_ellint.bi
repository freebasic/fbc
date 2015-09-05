'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
''   specfunc/gsl_sf_ellint.h
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

#define __GSL_SF_ELLINT_H__
declare function gsl_sf_ellint_Kcomp_e(byval k as double, byval mode as gsl_mode_t, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_ellint_Kcomp(byval k as double, byval mode as gsl_mode_t) as double
declare function gsl_sf_ellint_Ecomp_e(byval k as double, byval mode as gsl_mode_t, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_ellint_Ecomp(byval k as double, byval mode as gsl_mode_t) as double
declare function gsl_sf_ellint_Pcomp_e(byval k as double, byval n as double, byval mode as gsl_mode_t, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_ellint_Pcomp(byval k as double, byval n as double, byval mode as gsl_mode_t) as double
declare function gsl_sf_ellint_Dcomp_e(byval k as double, byval mode as gsl_mode_t, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_ellint_Dcomp(byval k as double, byval mode as gsl_mode_t) as double
declare function gsl_sf_ellint_F_e(byval phi as double, byval k as double, byval mode as gsl_mode_t, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_ellint_F(byval phi as double, byval k as double, byval mode as gsl_mode_t) as double
declare function gsl_sf_ellint_E_e(byval phi as double, byval k as double, byval mode as gsl_mode_t, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_ellint_E(byval phi as double, byval k as double, byval mode as gsl_mode_t) as double
declare function gsl_sf_ellint_P_e(byval phi as double, byval k as double, byval n as double, byval mode as gsl_mode_t, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_ellint_P(byval phi as double, byval k as double, byval n as double, byval mode as gsl_mode_t) as double
declare function gsl_sf_ellint_D_e(byval phi as double, byval k as double, byval n as double, byval mode as gsl_mode_t, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_ellint_D(byval phi as double, byval k as double, byval n as double, byval mode as gsl_mode_t) as double
declare function gsl_sf_ellint_RC_e(byval x as double, byval y as double, byval mode as gsl_mode_t, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_ellint_RC(byval x as double, byval y as double, byval mode as gsl_mode_t) as double
declare function gsl_sf_ellint_RD_e(byval x as double, byval y as double, byval z as double, byval mode as gsl_mode_t, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_ellint_RD(byval x as double, byval y as double, byval z as double, byval mode as gsl_mode_t) as double
declare function gsl_sf_ellint_RF_e(byval x as double, byval y as double, byval z as double, byval mode as gsl_mode_t, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_ellint_RF(byval x as double, byval y as double, byval z as double, byval mode as gsl_mode_t) as double
declare function gsl_sf_ellint_RJ_e(byval x as double, byval y as double, byval z as double, byval p as double, byval mode as gsl_mode_t, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_ellint_RJ(byval x as double, byval y as double, byval z as double, byval p as double, byval mode as gsl_mode_t) as double

end extern
