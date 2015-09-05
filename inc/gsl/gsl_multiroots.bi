'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
''   multiroots/gsl_multiroots.h
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
#include once "gsl/gsl_types.bi"
#include once "gsl/gsl_math.bi"
#include once "gsl/gsl_vector.bi"
#include once "gsl/gsl_matrix.bi"

extern "C"

#define __GSL_MULTIROOTS_H__

type gsl_multiroot_function_struct
	f as function(byval x as const gsl_vector ptr, byval params as any ptr, byval f as gsl_vector ptr) as long
	n as uinteger
	params as any ptr
end type

type gsl_multiroot_function as gsl_multiroot_function_struct
#define GSL_MULTIROOT_FN_EVAL(F_, x, y) (F_)->f(x, (F_)->params, (y))
declare function gsl_multiroot_fdjacobian(byval F as gsl_multiroot_function ptr, byval x as const gsl_vector ptr, byval f as const gsl_vector ptr, byval epsrel as double, byval jacobian as gsl_matrix ptr) as long

type gsl_multiroot_fsolver_type
	name as const zstring ptr
	size as uinteger
	alloc as function(byval state as any ptr, byval n as uinteger) as long
	set as function(byval state as any ptr, byval function as gsl_multiroot_function ptr, byval x as gsl_vector ptr, byval f as gsl_vector ptr, byval dx as gsl_vector ptr) as long
	iterate as function(byval state as any ptr, byval function as gsl_multiroot_function ptr, byval x as gsl_vector ptr, byval f as gsl_vector ptr, byval dx as gsl_vector ptr) as long
	free as sub(byval state as any ptr)
end type

type gsl_multiroot_fsolver
	as const gsl_multiroot_fsolver_type ptr type
	function as gsl_multiroot_function ptr
	x as gsl_vector ptr
	f as gsl_vector ptr
	dx as gsl_vector ptr
	state as any ptr
end type

declare function gsl_multiroot_fsolver_alloc(byval T as const gsl_multiroot_fsolver_type ptr, byval n as uinteger) as gsl_multiroot_fsolver ptr
declare sub gsl_multiroot_fsolver_free(byval s as gsl_multiroot_fsolver ptr)
declare function gsl_multiroot_fsolver_set(byval s as gsl_multiroot_fsolver ptr, byval f as gsl_multiroot_function ptr, byval x as const gsl_vector ptr) as long
declare function gsl_multiroot_fsolver_iterate(byval s as gsl_multiroot_fsolver ptr) as long
declare function gsl_multiroot_fsolver_name(byval s as const gsl_multiroot_fsolver ptr) as const zstring ptr
declare function gsl_multiroot_fsolver_root(byval s as const gsl_multiroot_fsolver ptr) as gsl_vector ptr
declare function gsl_multiroot_fsolver_dx(byval s as const gsl_multiroot_fsolver ptr) as gsl_vector ptr
declare function gsl_multiroot_fsolver_f(byval s as const gsl_multiroot_fsolver ptr) as gsl_vector ptr

type gsl_multiroot_function_fdf_struct
	f as function(byval x as const gsl_vector ptr, byval params as any ptr, byval f as gsl_vector ptr) as long
	df as function(byval x as const gsl_vector ptr, byval params as any ptr, byval df as gsl_matrix ptr) as long
	fdf as function(byval x as const gsl_vector ptr, byval params as any ptr, byval f as gsl_vector ptr, byval df as gsl_matrix ptr) as long
	n as uinteger
	params as any ptr
end type

type gsl_multiroot_function_fdf as gsl_multiroot_function_fdf_struct
#define GSL_MULTIROOT_FN_EVAL_F(F_, x, y) (F_)->f(x, (F_)->params, (y))
#define GSL_MULTIROOT_FN_EVAL_DF(F, x, dy) (F)->df(x, (F)->params, (dy))
#define GSL_MULTIROOT_FN_EVAL_F_DF(F, x, y, dy) (F)->fdf(x, (F)->params, (y), (dy))

type gsl_multiroot_fdfsolver_type
	name as const zstring ptr
	size as uinteger
	alloc as function(byval state as any ptr, byval n as uinteger) as long
	set as function(byval state as any ptr, byval fdf as gsl_multiroot_function_fdf ptr, byval x as gsl_vector ptr, byval f as gsl_vector ptr, byval J as gsl_matrix ptr, byval dx as gsl_vector ptr) as long
	iterate as function(byval state as any ptr, byval fdf as gsl_multiroot_function_fdf ptr, byval x as gsl_vector ptr, byval f as gsl_vector ptr, byval J as gsl_matrix ptr, byval dx as gsl_vector ptr) as long
	free as sub(byval state as any ptr)
end type

type gsl_multiroot_fdfsolver
	as const gsl_multiroot_fdfsolver_type ptr type
	fdf as gsl_multiroot_function_fdf ptr
	x as gsl_vector ptr
	f as gsl_vector ptr
	J as gsl_matrix ptr
	dx as gsl_vector ptr
	state as any ptr
end type

declare function gsl_multiroot_fdfsolver_alloc(byval T as const gsl_multiroot_fdfsolver_type ptr, byval n as uinteger) as gsl_multiroot_fdfsolver ptr
declare function gsl_multiroot_fdfsolver_set(byval s as gsl_multiroot_fdfsolver ptr, byval fdf as gsl_multiroot_function_fdf ptr, byval x as const gsl_vector ptr) as long
declare function gsl_multiroot_fdfsolver_iterate(byval s as gsl_multiroot_fdfsolver ptr) as long
declare sub gsl_multiroot_fdfsolver_free(byval s as gsl_multiroot_fdfsolver ptr)
declare function gsl_multiroot_fdfsolver_name(byval s as const gsl_multiroot_fdfsolver ptr) as const zstring ptr
declare function gsl_multiroot_fdfsolver_root(byval s as const gsl_multiroot_fdfsolver ptr) as gsl_vector ptr
declare function gsl_multiroot_fdfsolver_dx(byval s as const gsl_multiroot_fdfsolver ptr) as gsl_vector ptr
declare function gsl_multiroot_fdfsolver_f(byval s as const gsl_multiroot_fdfsolver ptr) as gsl_vector ptr
declare function gsl_multiroot_test_delta(byval dx as const gsl_vector ptr, byval x as const gsl_vector ptr, byval epsabs as double, byval epsrel as double) as long
declare function gsl_multiroot_test_residual(byval f as const gsl_vector ptr, byval epsabs as double) as long

extern gsl_multiroot_fsolver_dnewton as const gsl_multiroot_fsolver_type ptr
extern gsl_multiroot_fsolver_broyden as const gsl_multiroot_fsolver_type ptr
extern gsl_multiroot_fsolver_hybrid as const gsl_multiroot_fsolver_type ptr
extern gsl_multiroot_fsolver_hybrids as const gsl_multiroot_fsolver_type ptr
extern gsl_multiroot_fdfsolver_newton as const gsl_multiroot_fdfsolver_type ptr
extern gsl_multiroot_fdfsolver_gnewton as const gsl_multiroot_fdfsolver_type ptr
extern gsl_multiroot_fdfsolver_hybridj as const gsl_multiroot_fdfsolver_type ptr
extern gsl_multiroot_fdfsolver_hybridsj as const gsl_multiroot_fdfsolver_type ptr

end extern
