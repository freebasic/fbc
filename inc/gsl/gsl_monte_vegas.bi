'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
''   monte/gsl_monte_vegas.h
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

#include once "crt/stdlib.bi"
#include once "gsl/gsl_rng.bi"
#include once "gsl/gsl_monte.bi"

extern "C"

#define __GSL_MONTE_VEGAS_H__

enum
	GSL_VEGAS_MODE_IMPORTANCE = 1
	GSL_VEGAS_MODE_IMPORTANCE_ONLY = 0
	GSL_VEGAS_MODE_STRATIFIED = -1
end enum

type gsl_monte_vegas_state
	as uinteger dim
	bins_max as uinteger
	bins as ulong
	boxes as ulong
	xi as double ptr
	xin as double ptr
	delx as double ptr
	weight as double ptr
	vol as double
	x as double ptr
	bin as long ptr
	box as long ptr
	d as double ptr
	alpha as double
	mode as long
	verbose as long
	iterations as ulong
	stage as long
	jac as double
	wtd_int_sum as double
	sum_wgts as double
	chi_sum as double
	chisq as double
	result as double
	sigma as double
	it_start as ulong
	it_num as ulong
	samples as ulong
	calls_per_box as ulong
	ostream as FILE ptr
end type

declare function gsl_monte_vegas_integrate(byval f as gsl_monte_function ptr, byval xl as double ptr, byval xu as double ptr, byval dim as uinteger, byval calls as uinteger, byval r as gsl_rng ptr, byval state as gsl_monte_vegas_state ptr, byval result as double ptr, byval abserr as double ptr) as long
declare function gsl_monte_vegas_alloc(byval dim as uinteger) as gsl_monte_vegas_state ptr
declare function gsl_monte_vegas_init(byval state as gsl_monte_vegas_state ptr) as long
declare sub gsl_monte_vegas_free(byval state as gsl_monte_vegas_state ptr)
declare function gsl_monte_vegas_chisq(byval state as const gsl_monte_vegas_state ptr) as double
declare sub gsl_monte_vegas_runval(byval state as const gsl_monte_vegas_state ptr, byval result as double ptr, byval sigma as double ptr)

type gsl_monte_vegas_params
	alpha as double
	iterations as uinteger
	stage as long
	mode as long
	verbose as long
	ostream as FILE ptr
end type

declare sub gsl_monte_vegas_params_get(byval state as const gsl_monte_vegas_state ptr, byval params as gsl_monte_vegas_params ptr)
declare sub gsl_monte_vegas_params_set(byval state as gsl_monte_vegas_state ptr, byval params as const gsl_monte_vegas_params ptr)

end extern
