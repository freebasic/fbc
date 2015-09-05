'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
''   roots/gsl_roots.h
''
''   Copyright (C) 1996, 1997, 1998, 1999, 2000, 2007 Reid Priedhorsky, Brian Gough
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
#include once "gsl/gsl_types.bi"
#include once "gsl/gsl_math.bi"

extern "C"

#define __GSL_ROOTS_H__

type gsl_root_fsolver_type
	name as const zstring ptr
	size as uinteger
	set as function(byval state as any ptr, byval f as gsl_function ptr, byval root as double ptr, byval x_lower as double, byval x_upper as double) as long
	iterate as function(byval state as any ptr, byval f as gsl_function ptr, byval root as double ptr, byval x_lower as double ptr, byval x_upper as double ptr) as long
end type

type gsl_root_fsolver
	as const gsl_root_fsolver_type ptr type
	function as gsl_function ptr
	root as double
	x_lower as double
	x_upper as double
	state as any ptr
end type

type gsl_root_fdfsolver_type
	name as const zstring ptr
	size as uinteger
	set as function(byval state as any ptr, byval f as gsl_function_fdf ptr, byval root as double ptr) as long
	iterate as function(byval state as any ptr, byval f as gsl_function_fdf ptr, byval root as double ptr) as long
end type

type gsl_root_fdfsolver
	as const gsl_root_fdfsolver_type ptr type
	fdf as gsl_function_fdf ptr
	root as double
	state as any ptr
end type

declare function gsl_root_fsolver_alloc(byval T as const gsl_root_fsolver_type ptr) as gsl_root_fsolver ptr
declare sub gsl_root_fsolver_free(byval s as gsl_root_fsolver ptr)
declare function gsl_root_fsolver_set(byval s as gsl_root_fsolver ptr, byval f as gsl_function ptr, byval x_lower as double, byval x_upper as double) as long
declare function gsl_root_fsolver_iterate(byval s as gsl_root_fsolver ptr) as long
declare function gsl_root_fsolver_name(byval s as const gsl_root_fsolver ptr) as const zstring ptr
declare function gsl_root_fsolver_root(byval s as const gsl_root_fsolver ptr) as double
declare function gsl_root_fsolver_x_lower(byval s as const gsl_root_fsolver ptr) as double
declare function gsl_root_fsolver_x_upper(byval s as const gsl_root_fsolver ptr) as double
declare function gsl_root_fdfsolver_alloc(byval T as const gsl_root_fdfsolver_type ptr) as gsl_root_fdfsolver ptr
declare function gsl_root_fdfsolver_set(byval s as gsl_root_fdfsolver ptr, byval fdf as gsl_function_fdf ptr, byval root as double) as long
declare function gsl_root_fdfsolver_iterate(byval s as gsl_root_fdfsolver ptr) as long
declare sub gsl_root_fdfsolver_free(byval s as gsl_root_fdfsolver ptr)
declare function gsl_root_fdfsolver_name(byval s as const gsl_root_fdfsolver ptr) as const zstring ptr
declare function gsl_root_fdfsolver_root(byval s as const gsl_root_fdfsolver ptr) as double
declare function gsl_root_test_interval(byval x_lower as double, byval x_upper as double, byval epsabs as double, byval epsrel as double) as long
declare function gsl_root_test_residual(byval f as double, byval epsabs as double) as long
declare function gsl_root_test_delta(byval x1 as double, byval x0 as double, byval epsabs as double, byval epsrel as double) as long

extern gsl_root_fsolver_bisection as const gsl_root_fsolver_type ptr
extern gsl_root_fsolver_brent as const gsl_root_fsolver_type ptr
extern gsl_root_fsolver_falsepos as const gsl_root_fsolver_type ptr
extern gsl_root_fdfsolver_newton as const gsl_root_fdfsolver_type ptr
extern gsl_root_fdfsolver_secant as const gsl_root_fdfsolver_type ptr
extern gsl_root_fdfsolver_steffenson as const gsl_root_fdfsolver_type ptr

end extern
