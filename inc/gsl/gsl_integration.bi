'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
''   integration/gsl_integration.h
''
''   Copyright (C) 1996, 1997, 1998, 1999, 2000, 2007 Brian Gough
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
#include once "gsl/gsl_math.bi"

extern "C"

#define __GSL_INTEGRATION_H__

type gsl_integration_workspace
	limit as uinteger
	size as uinteger
	nrmax as uinteger
	i as uinteger
	maximum_level as uinteger
	alist as double ptr
	blist as double ptr
	rlist as double ptr
	elist as double ptr
	order as uinteger ptr
	level as uinteger ptr
end type

declare function gsl_integration_workspace_alloc(byval n as const uinteger) as gsl_integration_workspace ptr
declare sub gsl_integration_workspace_free(byval w as gsl_integration_workspace ptr)

type gsl_integration_qaws_table
	alpha as double
	beta as double
	mu as long
	nu as long
	ri(0 to 24) as double
	rj(0 to 24) as double
	rg(0 to 24) as double
	rh(0 to 24) as double
end type

declare function gsl_integration_qaws_table_alloc(byval alpha as double, byval beta as double, byval mu as long, byval nu as long) as gsl_integration_qaws_table ptr
declare function gsl_integration_qaws_table_set(byval t as gsl_integration_qaws_table ptr, byval alpha as double, byval beta as double, byval mu as long, byval nu as long) as long
declare sub gsl_integration_qaws_table_free(byval t as gsl_integration_qaws_table ptr)

type gsl_integration_qawo_enum as long
enum
	GSL_INTEG_COSINE
	GSL_INTEG_SINE
end enum

type gsl_integration_qawo_table
	n as uinteger
	omega as double
	L as double
	par as double
	sine as gsl_integration_qawo_enum
	chebmo as double ptr
end type

declare function gsl_integration_qawo_table_alloc(byval omega as double, byval L as double, byval sine as gsl_integration_qawo_enum, byval n as uinteger) as gsl_integration_qawo_table ptr
declare function gsl_integration_qawo_table_set(byval t as gsl_integration_qawo_table ptr, byval omega as double, byval L as double, byval sine as gsl_integration_qawo_enum) as long
declare function gsl_integration_qawo_table_set_length(byval t as gsl_integration_qawo_table ptr, byval L as double) as long
declare sub gsl_integration_qawo_table_free(byval t as gsl_integration_qawo_table ptr)
declare sub gsl_integration_qk15(byval f as const gsl_function ptr, byval a as double, byval b as double, byval result as double ptr, byval abserr as double ptr, byval resabs as double ptr, byval resasc as double ptr)
declare sub gsl_integration_qk21(byval f as const gsl_function ptr, byval a as double, byval b as double, byval result as double ptr, byval abserr as double ptr, byval resabs as double ptr, byval resasc as double ptr)
declare sub gsl_integration_qk31(byval f as const gsl_function ptr, byval a as double, byval b as double, byval result as double ptr, byval abserr as double ptr, byval resabs as double ptr, byval resasc as double ptr)
declare sub gsl_integration_qk41(byval f as const gsl_function ptr, byval a as double, byval b as double, byval result as double ptr, byval abserr as double ptr, byval resabs as double ptr, byval resasc as double ptr)
declare sub gsl_integration_qk51(byval f as const gsl_function ptr, byval a as double, byval b as double, byval result as double ptr, byval abserr as double ptr, byval resabs as double ptr, byval resasc as double ptr)
declare sub gsl_integration_qk61(byval f as const gsl_function ptr, byval a as double, byval b as double, byval result as double ptr, byval abserr as double ptr, byval resabs as double ptr, byval resasc as double ptr)
declare sub gsl_integration_qcheb(byval f as gsl_function ptr, byval a as double, byval b as double, byval cheb12 as double ptr, byval cheb24 as double ptr)

enum
	GSL_INTEG_GAUSS15 = 1
	GSL_INTEG_GAUSS21 = 2
	GSL_INTEG_GAUSS31 = 3
	GSL_INTEG_GAUSS41 = 4
	GSL_INTEG_GAUSS51 = 5
	GSL_INTEG_GAUSS61 = 6
end enum

declare sub gsl_integration_qk(byval n as const long, byval xgk as const double ptr, byval wg as const double ptr, byval wgk as const double ptr, byval fv1 as double ptr, byval fv2 as double ptr, byval f as const gsl_function ptr, byval a as double, byval b as double, byval result as double ptr, byval abserr as double ptr, byval resabs as double ptr, byval resasc as double ptr)
declare function gsl_integration_qng(byval f as const gsl_function ptr, byval a as double, byval b as double, byval epsabs as double, byval epsrel as double, byval result as double ptr, byval abserr as double ptr, byval neval as uinteger ptr) as long
declare function gsl_integration_qag(byval f as const gsl_function ptr, byval a as double, byval b as double, byval epsabs as double, byval epsrel as double, byval limit as uinteger, byval key as long, byval workspace as gsl_integration_workspace ptr, byval result as double ptr, byval abserr as double ptr) as long
declare function gsl_integration_qagi(byval f as gsl_function ptr, byval epsabs as double, byval epsrel as double, byval limit as uinteger, byval workspace as gsl_integration_workspace ptr, byval result as double ptr, byval abserr as double ptr) as long
declare function gsl_integration_qagiu(byval f as gsl_function ptr, byval a as double, byval epsabs as double, byval epsrel as double, byval limit as uinteger, byval workspace as gsl_integration_workspace ptr, byval result as double ptr, byval abserr as double ptr) as long
declare function gsl_integration_qagil(byval f as gsl_function ptr, byval b as double, byval epsabs as double, byval epsrel as double, byval limit as uinteger, byval workspace as gsl_integration_workspace ptr, byval result as double ptr, byval abserr as double ptr) as long
declare function gsl_integration_qags(byval f as const gsl_function ptr, byval a as double, byval b as double, byval epsabs as double, byval epsrel as double, byval limit as uinteger, byval workspace as gsl_integration_workspace ptr, byval result as double ptr, byval abserr as double ptr) as long
declare function gsl_integration_qagp(byval f as const gsl_function ptr, byval pts as double ptr, byval npts as uinteger, byval epsabs as double, byval epsrel as double, byval limit as uinteger, byval workspace as gsl_integration_workspace ptr, byval result as double ptr, byval abserr as double ptr) as long
declare function gsl_integration_qawc(byval f as gsl_function ptr, byval a as const double, byval b as const double, byval c as const double, byval epsabs as const double, byval epsrel as const double, byval limit as const uinteger, byval workspace as gsl_integration_workspace ptr, byval result as double ptr, byval abserr as double ptr) as long
declare function gsl_integration_qaws(byval f as gsl_function ptr, byval a as const double, byval b as const double, byval t as gsl_integration_qaws_table ptr, byval epsabs as const double, byval epsrel as const double, byval limit as const uinteger, byval workspace as gsl_integration_workspace ptr, byval result as double ptr, byval abserr as double ptr) as long
declare function gsl_integration_qawo(byval f as gsl_function ptr, byval a as const double, byval epsabs as const double, byval epsrel as const double, byval limit as const uinteger, byval workspace as gsl_integration_workspace ptr, byval wf as gsl_integration_qawo_table ptr, byval result as double ptr, byval abserr as double ptr) as long
declare function gsl_integration_qawf(byval f as gsl_function ptr, byval a as const double, byval epsabs as const double, byval limit as const uinteger, byval workspace as gsl_integration_workspace ptr, byval cycle_workspace as gsl_integration_workspace ptr, byval wf as gsl_integration_qawo_table ptr, byval result as double ptr, byval abserr as double ptr) as long

type gsl_integration_glfixed_table
	n as uinteger
	x as double ptr
	w as double ptr
	precomputed as long
end type

declare function gsl_integration_glfixed_table_alloc(byval n as uinteger) as gsl_integration_glfixed_table ptr
declare sub gsl_integration_glfixed_table_free(byval t as gsl_integration_glfixed_table ptr)
declare function gsl_integration_glfixed(byval f as const gsl_function ptr, byval a as double, byval b as double, byval t as const gsl_integration_glfixed_table ptr) as double
declare function gsl_integration_glfixed_point(byval a as double, byval b as double, byval i as uinteger, byval xi as double ptr, byval wi as double ptr, byval t as const gsl_integration_glfixed_table ptr) as long

type gsl_integration_cquad_ival
	a as double
	b as double
	c(0 to 63) as double
	fx(0 to 32) as double
	igral as double
	err as double
	depth as long
	rdepth as long
	ndiv as long
end type

type gsl_integration_cquad_workspace
	size as uinteger
	ivals as gsl_integration_cquad_ival ptr
	heap as uinteger ptr
end type

declare function gsl_integration_cquad_workspace_alloc(byval n as const uinteger) as gsl_integration_cquad_workspace ptr
declare sub gsl_integration_cquad_workspace_free(byval w as gsl_integration_cquad_workspace ptr)
declare function gsl_integration_cquad(byval f as const gsl_function ptr, byval a as double, byval b as double, byval epsabs as double, byval epsrel as double, byval ws as gsl_integration_cquad_workspace ptr, byval result as double ptr, byval abserr as double ptr, byval nevals as uinteger ptr) as long

end extern
