'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
''   specfunc/gsl_sf_bessel.h
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

#include once "crt/stdlib.bi"
#include once "gsl/gsl_mode.bi"
#include once "gsl/gsl_precision.bi"
#include once "gsl/gsl_sf_result.bi"

'' The following symbols have been renamed:
''     procedure gsl_sf_bessel_j0_e => gsl_sf_bessel_j0_e_
''     procedure gsl_sf_bessel_j0 => gsl_sf_bessel_j0_
''     procedure gsl_sf_bessel_j1_e => gsl_sf_bessel_j1_e_
''     procedure gsl_sf_bessel_j1 => gsl_sf_bessel_j1_
''     procedure gsl_sf_bessel_y0_e => gsl_sf_bessel_y0_e_
''     procedure gsl_sf_bessel_y0 => gsl_sf_bessel_y0_
''     procedure gsl_sf_bessel_y1_e => gsl_sf_bessel_y1_e_
''     procedure gsl_sf_bessel_y1 => gsl_sf_bessel_y1_
''     procedure gsl_sf_bessel_i0_scaled_e => gsl_sf_bessel_i0_scaled_e_
''     procedure gsl_sf_bessel_i0_scaled => gsl_sf_bessel_i0_scaled_
''     procedure gsl_sf_bessel_i1_scaled_e => gsl_sf_bessel_i1_scaled_e_
''     procedure gsl_sf_bessel_i1_scaled => gsl_sf_bessel_i1_scaled_
''     procedure gsl_sf_bessel_k0_scaled_e => gsl_sf_bessel_k0_scaled_e_
''     procedure gsl_sf_bessel_k0_scaled => gsl_sf_bessel_k0_scaled_
''     procedure gsl_sf_bessel_k1_scaled_e => gsl_sf_bessel_k1_scaled_e_
''     procedure gsl_sf_bessel_k1_scaled => gsl_sf_bessel_k1_scaled_

extern "C"

#define __GSL_SF_BESSEL_H__
declare function gsl_sf_bessel_J0_e(byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_bessel_J0(byval x as const double) as double
declare function gsl_sf_bessel_J1_e(byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_bessel_J1(byval x as const double) as double
declare function gsl_sf_bessel_Jn_e(byval n as long, byval x as double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_bessel_Jn(byval n as const long, byval x as const double) as double
declare function gsl_sf_bessel_Jn_array(byval nmin as long, byval nmax as long, byval x as double, byval result_array as double ptr) as long
declare function gsl_sf_bessel_Y0_e(byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_bessel_Y0(byval x as const double) as double
declare function gsl_sf_bessel_Y1_e(byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_bessel_Y1(byval x as const double) as double
declare function gsl_sf_bessel_Yn_e(byval n as long, byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_bessel_Yn(byval n as const long, byval x as const double) as double
declare function gsl_sf_bessel_Yn_array(byval nmin as const long, byval nmax as const long, byval x as const double, byval result_array as double ptr) as long
declare function gsl_sf_bessel_I0_e(byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_bessel_I0(byval x as const double) as double
declare function gsl_sf_bessel_I1_e(byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_bessel_I1(byval x as const double) as double
declare function gsl_sf_bessel_In_e(byval n as const long, byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_bessel_In(byval n as const long, byval x as const double) as double
declare function gsl_sf_bessel_In_array(byval nmin as const long, byval nmax as const long, byval x as const double, byval result_array as double ptr) as long
declare function gsl_sf_bessel_I0_scaled_e(byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_bessel_I0_scaled(byval x as const double) as double
declare function gsl_sf_bessel_I1_scaled_e(byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_bessel_I1_scaled(byval x as const double) as double
declare function gsl_sf_bessel_In_scaled_e(byval n as long, byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_bessel_In_scaled(byval n as const long, byval x as const double) as double
declare function gsl_sf_bessel_In_scaled_array(byval nmin as const long, byval nmax as const long, byval x as const double, byval result_array as double ptr) as long
declare function gsl_sf_bessel_K0_e(byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_bessel_K0(byval x as const double) as double
declare function gsl_sf_bessel_K1_e(byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_bessel_K1(byval x as const double) as double
declare function gsl_sf_bessel_Kn_e(byval n as const long, byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_bessel_Kn(byval n as const long, byval x as const double) as double
declare function gsl_sf_bessel_Kn_array(byval nmin as const long, byval nmax as const long, byval x as const double, byval result_array as double ptr) as long
declare function gsl_sf_bessel_K0_scaled_e(byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_bessel_K0_scaled(byval x as const double) as double
declare function gsl_sf_bessel_K1_scaled_e(byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_bessel_K1_scaled(byval x as const double) as double
declare function gsl_sf_bessel_Kn_scaled_e(byval n as long, byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_bessel_Kn_scaled(byval n as const long, byval x as const double) as double
declare function gsl_sf_bessel_Kn_scaled_array(byval nmin as const long, byval nmax as const long, byval x as const double, byval result_array as double ptr) as long
declare function gsl_sf_bessel_j0_e_ alias "gsl_sf_bessel_j0_e"(byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_bessel_j0_ alias "gsl_sf_bessel_j0"(byval x as const double) as double
declare function gsl_sf_bessel_j1_e_ alias "gsl_sf_bessel_j1_e"(byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_bessel_j1_ alias "gsl_sf_bessel_j1"(byval x as const double) as double
declare function gsl_sf_bessel_j2_e(byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_bessel_j2(byval x as const double) as double
declare function gsl_sf_bessel_jl_e(byval l as const long, byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_bessel_jl(byval l as const long, byval x as const double) as double
declare function gsl_sf_bessel_jl_array(byval lmax as const long, byval x as const double, byval result_array as double ptr) as long
declare function gsl_sf_bessel_jl_steed_array(byval lmax as const long, byval x as const double, byval jl_x_array as double ptr) as long
declare function gsl_sf_bessel_y0_e_ alias "gsl_sf_bessel_y0_e"(byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_bessel_y0_ alias "gsl_sf_bessel_y0"(byval x as const double) as double
declare function gsl_sf_bessel_y1_e_ alias "gsl_sf_bessel_y1_e"(byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_bessel_y1_ alias "gsl_sf_bessel_y1"(byval x as const double) as double
declare function gsl_sf_bessel_y2_e(byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_bessel_y2(byval x as const double) as double
declare function gsl_sf_bessel_yl_e(byval l as long, byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_bessel_yl(byval l as const long, byval x as const double) as double
declare function gsl_sf_bessel_yl_array(byval lmax as const long, byval x as const double, byval result_array as double ptr) as long
declare function gsl_sf_bessel_i0_scaled_e_ alias "gsl_sf_bessel_i0_scaled_e"(byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_bessel_i0_scaled_ alias "gsl_sf_bessel_i0_scaled"(byval x as const double) as double
declare function gsl_sf_bessel_i1_scaled_e_ alias "gsl_sf_bessel_i1_scaled_e"(byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_bessel_i1_scaled_ alias "gsl_sf_bessel_i1_scaled"(byval x as const double) as double
declare function gsl_sf_bessel_i2_scaled_e(byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_bessel_i2_scaled(byval x as const double) as double
declare function gsl_sf_bessel_il_scaled_e(byval l as const long, byval x as double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_bessel_il_scaled(byval l as const long, byval x as const double) as double
declare function gsl_sf_bessel_il_scaled_array(byval lmax as const long, byval x as const double, byval result_array as double ptr) as long
declare function gsl_sf_bessel_k0_scaled_e_ alias "gsl_sf_bessel_k0_scaled_e"(byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_bessel_k0_scaled_ alias "gsl_sf_bessel_k0_scaled"(byval x as const double) as double
declare function gsl_sf_bessel_k1_scaled_e_ alias "gsl_sf_bessel_k1_scaled_e"(byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_bessel_k1_scaled_ alias "gsl_sf_bessel_k1_scaled"(byval x as const double) as double
declare function gsl_sf_bessel_k2_scaled_e(byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_bessel_k2_scaled(byval x as const double) as double
declare function gsl_sf_bessel_kl_scaled_e(byval l as long, byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_bessel_kl_scaled(byval l as const long, byval x as const double) as double
declare function gsl_sf_bessel_kl_scaled_array(byval lmax as const long, byval x as const double, byval result_array as double ptr) as long
declare function gsl_sf_bessel_Jnu_e(byval nu as const double, byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_bessel_Jnu(byval nu as const double, byval x as const double) as double
declare function gsl_sf_bessel_Ynu_e(byval nu as double, byval x as double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_bessel_Ynu(byval nu as const double, byval x as const double) as double
declare function gsl_sf_bessel_sequence_Jnu_e(byval nu as double, byval mode as gsl_mode_t, byval size as uinteger, byval v as double ptr) as long
declare function gsl_sf_bessel_Inu_scaled_e(byval nu as double, byval x as double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_bessel_Inu_scaled(byval nu as double, byval x as double) as double
declare function gsl_sf_bessel_Inu_e(byval nu as double, byval x as double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_bessel_Inu(byval nu as double, byval x as double) as double
declare function gsl_sf_bessel_Knu_scaled_e(byval nu as const double, byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_bessel_Knu_scaled(byval nu as const double, byval x as const double) as double
declare function gsl_sf_bessel_Knu_scaled_e10_e(byval nu as const double, byval x as const double, byval result as gsl_sf_result_e10 ptr) as long
declare function gsl_sf_bessel_Knu_e(byval nu as const double, byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_bessel_Knu(byval nu as const double, byval x as const double) as double
declare function gsl_sf_bessel_lnKnu_e(byval nu as const double, byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_bessel_lnKnu(byval nu as const double, byval x as const double) as double
declare function gsl_sf_bessel_zero_J0_e(byval s as ulong, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_bessel_zero_J0(byval s as ulong) as double
declare function gsl_sf_bessel_zero_J1_e(byval s as ulong, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_bessel_zero_J1(byval s as ulong) as double
declare function gsl_sf_bessel_zero_Jnu_e(byval nu as double, byval s as ulong, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_bessel_zero_Jnu(byval nu as double, byval s as ulong) as double

end extern
