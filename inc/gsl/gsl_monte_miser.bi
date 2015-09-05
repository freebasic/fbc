'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
''   monte/gsl_monte_miser.h
''
''   Copyright (C) 1996, 1997, 1998, 1999, 2000 Michael Booth
''   Copyright (C) 2009 Brian Gough
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

#include once "gsl/gsl_rng.bi"
#include once "gsl/gsl_monte.bi"
#include once "gsl/gsl_monte_plain.bi"

extern "C"

#define __GSL_MONTE_MISER_H__

type gsl_monte_miser_state
	min_calls as uinteger
	min_calls_per_bisection as uinteger
	dither as double
	estimate_frac as double
	alpha as double
	as uinteger dim
	estimate_style as long
	depth as long
	verbose as long
	x as double ptr
	xmid as double ptr
	sigma_l as double ptr
	sigma_r as double ptr
	fmax_l as double ptr
	fmax_r as double ptr
	fmin_l as double ptr
	fmin_r as double ptr
	fsum_l as double ptr
	fsum_r as double ptr
	fsum2_l as double ptr
	fsum2_r as double ptr
	hits_l as uinteger ptr
	hits_r as uinteger ptr
end type

declare function gsl_monte_miser_integrate(byval f as gsl_monte_function ptr, byval xl as const double ptr, byval xh as const double ptr, byval dim as uinteger, byval calls as uinteger, byval r as gsl_rng ptr, byval state as gsl_monte_miser_state ptr, byval result as double ptr, byval abserr as double ptr) as long
declare function gsl_monte_miser_alloc(byval dim as uinteger) as gsl_monte_miser_state ptr
declare function gsl_monte_miser_init(byval state as gsl_monte_miser_state ptr) as long
declare sub gsl_monte_miser_free(byval state as gsl_monte_miser_state ptr)

type gsl_monte_miser_params
	estimate_frac as double
	min_calls as uinteger
	min_calls_per_bisection as uinteger
	alpha as double
	dither as double
end type

declare sub gsl_monte_miser_params_get(byval state as const gsl_monte_miser_state ptr, byval params as gsl_monte_miser_params ptr)
declare sub gsl_monte_miser_params_set(byval state as gsl_monte_miser_state ptr, byval params as const gsl_monte_miser_params ptr)

end extern
