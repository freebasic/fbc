'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
''   specfunc/gsl_sf_legendre.h
''
''   Copyright (C) 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2004 Gerard Jungman
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

#define __GSL_SF_LEGENDRE_H__
declare function gsl_sf_legendre_Pl_e(byval l as const long, byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_legendre_Pl(byval l as const long, byval x as const double) as double
declare function gsl_sf_legendre_Pl_array(byval lmax as const long, byval x as const double, byval result_array as double ptr) as long
declare function gsl_sf_legendre_Pl_deriv_array(byval lmax as const long, byval x as const double, byval result_array as double ptr, byval result_deriv_array as double ptr) as long
declare function gsl_sf_legendre_P1_e(byval x as double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_legendre_P2_e(byval x as double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_legendre_P3_e(byval x as double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_legendre_P1(byval x as const double) as double
declare function gsl_sf_legendre_P2(byval x as const double) as double
declare function gsl_sf_legendre_P3(byval x as const double) as double
declare function gsl_sf_legendre_Q0_e(byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_legendre_Q0(byval x as const double) as double
declare function gsl_sf_legendre_Q1_e(byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_legendre_Q1(byval x as const double) as double
declare function gsl_sf_legendre_Ql_e(byval l as const long, byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_legendre_Ql(byval l as const long, byval x as const double) as double
declare function gsl_sf_legendre_Plm_e(byval l as const long, byval m as const long, byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_legendre_Plm(byval l as const long, byval m as const long, byval x as const double) as double
declare function gsl_sf_legendre_Plm_array(byval lmax as const long, byval m as const long, byval x as const double, byval result_array as double ptr) as long
declare function gsl_sf_legendre_Plm_deriv_array(byval lmax as const long, byval m as const long, byval x as const double, byval result_array as double ptr, byval result_deriv_array as double ptr) as long
declare function gsl_sf_legendre_sphPlm_e(byval l as const long, byval m as long, byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_legendre_sphPlm(byval l as const long, byval m as const long, byval x as const double) as double
declare function gsl_sf_legendre_sphPlm_array(byval lmax as const long, byval m as long, byval x as const double, byval result_array as double ptr) as long
declare function gsl_sf_legendre_sphPlm_deriv_array(byval lmax as const long, byval m as const long, byval x as const double, byval result_array as double ptr, byval result_deriv_array as double ptr) as long
declare function gsl_sf_legendre_array_size(byval lmax as const long, byval m as const long) as long
declare function gsl_sf_conicalP_half_e(byval lambda as const double, byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_conicalP_half(byval lambda as const double, byval x as const double) as double
declare function gsl_sf_conicalP_mhalf_e(byval lambda as const double, byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_conicalP_mhalf(byval lambda as const double, byval x as const double) as double
declare function gsl_sf_conicalP_0_e(byval lambda as const double, byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_conicalP_0(byval lambda as const double, byval x as const double) as double
declare function gsl_sf_conicalP_1_e(byval lambda as const double, byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_conicalP_1(byval lambda as const double, byval x as const double) as double
declare function gsl_sf_conicalP_sph_reg_e(byval l as const long, byval lambda as const double, byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_conicalP_sph_reg(byval l as const long, byval lambda as const double, byval x as const double) as double
declare function gsl_sf_conicalP_cyl_reg_e(byval m as const long, byval lambda as const double, byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_conicalP_cyl_reg(byval m as const long, byval lambda as const double, byval x as const double) as double
declare function gsl_sf_legendre_H3d_0_e(byval lambda as const double, byval eta as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_legendre_H3d_0(byval lambda as const double, byval eta as const double) as double
declare function gsl_sf_legendre_H3d_1_e(byval lambda as const double, byval eta as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_legendre_H3d_1(byval lambda as const double, byval eta as const double) as double
declare function gsl_sf_legendre_H3d_e(byval l as const long, byval lambda as const double, byval eta as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_legendre_H3d(byval l as const long, byval lambda as const double, byval eta as const double) as double
declare function gsl_sf_legendre_H3d_array(byval lmax as const long, byval lambda as const double, byval eta as const double, byval result_array as double ptr) as long

end extern
