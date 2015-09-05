'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
''   specfunc/gsl_sf_fermi_dirac.h
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

#define __GSL_SF_FERMI_DIRAC_H__
declare function gsl_sf_fermi_dirac_m1_e(byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_fermi_dirac_m1(byval x as const double) as double
declare function gsl_sf_fermi_dirac_0_e(byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_fermi_dirac_0(byval x as const double) as double
declare function gsl_sf_fermi_dirac_1_e(byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_fermi_dirac_1(byval x as const double) as double
declare function gsl_sf_fermi_dirac_2_e(byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_fermi_dirac_2(byval x as const double) as double
declare function gsl_sf_fermi_dirac_int_e(byval j as const long, byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_fermi_dirac_int(byval j as const long, byval x as const double) as double
declare function gsl_sf_fermi_dirac_mhalf_e(byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_fermi_dirac_mhalf(byval x as const double) as double
declare function gsl_sf_fermi_dirac_half_e(byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_fermi_dirac_half(byval x as const double) as double
declare function gsl_sf_fermi_dirac_3half_e(byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_fermi_dirac_3half(byval x as const double) as double
declare function gsl_sf_fermi_dirac_inc_0_e(byval x as const double, byval b as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_fermi_dirac_inc_0(byval x as const double, byval b as const double) as double

end extern
