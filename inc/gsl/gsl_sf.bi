'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
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
#include once "gsl/gsl_sf_airy.bi"
#include once "gsl/gsl_sf_bessel.bi"
#include once "gsl/gsl_sf_clausen.bi"
#include once "gsl/gsl_sf_coupling.bi"
#include once "gsl/gsl_sf_coulomb.bi"
#include once "gsl/gsl_sf_dawson.bi"
#include once "gsl/gsl_sf_debye.bi"
#include once "gsl/gsl_sf_dilog.bi"
#include once "gsl/gsl_sf_elementary.bi"
#include once "gsl/gsl_sf_ellint.bi"
#include once "gsl/gsl_sf_elljac.bi"
#include once "gsl/gsl_sf_erf.bi"
#include once "gsl/gsl_sf_exp.bi"
#include once "gsl/gsl_sf_expint.bi"
#include once "gsl/gsl_sf_fermi_dirac.bi"
#include once "gsl/gsl_sf_gamma.bi"
#include once "gsl/gsl_sf_gegenbauer.bi"
#include once "gsl/gsl_sf_hyperg.bi"
#include once "gsl/gsl_sf_laguerre.bi"
#include once "gsl/gsl_sf_lambert.bi"
#include once "gsl/gsl_sf_legendre.bi"
#include once "gsl/gsl_sf_log.bi"
#include once "gsl/gsl_sf_mathieu.bi"
#include once "gsl/gsl_sf_pow_int.bi"
#include once "gsl/gsl_sf_psi.bi"
#include once "gsl/gsl_sf_synchrotron.bi"
#include once "gsl/gsl_sf_transport.bi"
#include once "gsl/gsl_sf_trig.bi"
#include once "gsl/gsl_sf_zeta.bi"

#define __GSL_SF_H__
