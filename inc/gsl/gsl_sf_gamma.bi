'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
''   specfunc/gsl_sf_gamma.h
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

#define __GSL_SF_GAMMA_H__
declare function gsl_sf_lngamma_e(byval x as double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_lngamma(byval x as const double) as double
declare function gsl_sf_lngamma_sgn_e(byval x as double, byval result_lg as gsl_sf_result ptr, byval sgn as double ptr) as long
declare function gsl_sf_gamma_e(byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_gamma(byval x as const double) as double
declare function gsl_sf_gammastar_e(byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_gammastar(byval x as const double) as double
declare function gsl_sf_gammainv_e(byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_gammainv(byval x as const double) as double
declare function gsl_sf_lngamma_complex_e(byval zr as double, byval zi as double, byval lnr as gsl_sf_result ptr, byval arg as gsl_sf_result ptr) as long
declare function gsl_sf_taylorcoeff_e(byval n as const long, byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_taylorcoeff(byval n as const long, byval x as const double) as double
declare function gsl_sf_fact_e(byval n as const ulong, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_fact(byval n as const ulong) as double
declare function gsl_sf_doublefact_e(byval n as const ulong, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_doublefact(byval n as const ulong) as double
declare function gsl_sf_lnfact_e(byval n as const ulong, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_lnfact(byval n as const ulong) as double
declare function gsl_sf_lndoublefact_e(byval n as const ulong, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_lndoublefact(byval n as const ulong) as double
declare function gsl_sf_lnchoose_e(byval n as ulong, byval m as ulong, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_lnchoose(byval n as ulong, byval m as ulong) as double
declare function gsl_sf_choose_e(byval n as ulong, byval m as ulong, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_choose(byval n as ulong, byval m as ulong) as double
declare function gsl_sf_lnpoch_e(byval a as const double, byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_lnpoch(byval a as const double, byval x as const double) as double
declare function gsl_sf_lnpoch_sgn_e(byval a as const double, byval x as const double, byval result as gsl_sf_result ptr, byval sgn as double ptr) as long
declare function gsl_sf_poch_e(byval a as const double, byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_poch(byval a as const double, byval x as const double) as double
declare function gsl_sf_pochrel_e(byval a as const double, byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_pochrel(byval a as const double, byval x as const double) as double
declare function gsl_sf_gamma_inc_Q_e(byval a as const double, byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_gamma_inc_Q(byval a as const double, byval x as const double) as double
declare function gsl_sf_gamma_inc_P_e(byval a as const double, byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_gamma_inc_P(byval a as const double, byval x as const double) as double
declare function gsl_sf_gamma_inc_e(byval a as const double, byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_gamma_inc(byval a as const double, byval x as const double) as double
declare function gsl_sf_lnbeta_e(byval a as const double, byval b as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_lnbeta(byval a as const double, byval b as const double) as double
declare function gsl_sf_lnbeta_sgn_e(byval x as const double, byval y as const double, byval result as gsl_sf_result ptr, byval sgn as double ptr) as long
declare function gsl_sf_beta_e(byval a as const double, byval b as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_beta(byval a as const double, byval b as const double) as double
declare function gsl_sf_beta_inc_e(byval a as const double, byval b as const double, byval x as const double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_beta_inc(byval a as const double, byval b as const double, byval x as const double) as double

const GSL_SF_GAMMA_XMAX = 171.0
const GSL_SF_FACT_NMAX = 170
const GSL_SF_DOUBLEFACT_NMAX = 297

end extern
