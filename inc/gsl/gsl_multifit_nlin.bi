'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
''   multifit_nlin/gsl_multifit_nlin.h
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

#define __GSL_MULTIFIT_NLIN_H__
declare function gsl_multifit_gradient(byval J as const gsl_matrix ptr, byval f as const gsl_vector ptr, byval g as gsl_vector ptr) as long
declare function gsl_multifit_covar(byval J as const gsl_matrix ptr, byval epsrel as double, byval covar as gsl_matrix ptr) as long

type gsl_multifit_function_struct
	f as function(byval x as const gsl_vector ptr, byval params as any ptr, byval f as gsl_vector ptr) as long
	n as uinteger
	p as uinteger
	params as any ptr
end type

type gsl_multifit_function as gsl_multifit_function_struct
#define GSL_MULTIFIT_FN_EVAL(F_, x, y) (F_)->f(x, (F_)->params, (y))

type gsl_multifit_fsolver_type
	name as const zstring ptr
	size as uinteger
	alloc as function(byval state as any ptr, byval n as uinteger, byval p as uinteger) as long
	set as function(byval state as any ptr, byval function as gsl_multifit_function ptr, byval x as gsl_vector ptr, byval f as gsl_vector ptr, byval dx as gsl_vector ptr) as long
	iterate as function(byval state as any ptr, byval function as gsl_multifit_function ptr, byval x as gsl_vector ptr, byval f as gsl_vector ptr, byval dx as gsl_vector ptr) as long
	free as sub(byval state as any ptr)
end type

type gsl_multifit_fsolver
	as const gsl_multifit_fsolver_type ptr type
	function as gsl_multifit_function ptr
	x as gsl_vector ptr
	f as gsl_vector ptr
	dx as gsl_vector ptr
	state as any ptr
end type

declare function gsl_multifit_fsolver_alloc(byval T as const gsl_multifit_fsolver_type ptr, byval n as uinteger, byval p as uinteger) as gsl_multifit_fsolver ptr
declare sub gsl_multifit_fsolver_free(byval s as gsl_multifit_fsolver ptr)
declare function gsl_multifit_fsolver_set(byval s as gsl_multifit_fsolver ptr, byval f as gsl_multifit_function ptr, byval x as const gsl_vector ptr) as long
declare function gsl_multifit_fsolver_iterate(byval s as gsl_multifit_fsolver ptr) as long
declare function gsl_multifit_fsolver_driver(byval s as gsl_multifit_fsolver ptr, byval maxiter as const uinteger, byval epsabs as const double, byval epsrel as const double) as long
declare function gsl_multifit_fsolver_name(byval s as const gsl_multifit_fsolver ptr) as const zstring ptr
declare function gsl_multifit_fsolver_position(byval s as const gsl_multifit_fsolver ptr) as gsl_vector ptr

type gsl_multifit_function_fdf_struct
	f as function(byval x as const gsl_vector ptr, byval params as any ptr, byval f as gsl_vector ptr) as long
	df as function(byval x as const gsl_vector ptr, byval params as any ptr, byval df as gsl_matrix ptr) as long
	fdf as function(byval x as const gsl_vector ptr, byval params as any ptr, byval f as gsl_vector ptr, byval df as gsl_matrix ptr) as long
	n as uinteger
	p as uinteger
	params as any ptr
end type

type gsl_multifit_function_fdf as gsl_multifit_function_fdf_struct
#define GSL_MULTIFIT_FN_EVAL_F(F_, x, y) (F_)->f(x, (F_)->params, (y))
#define GSL_MULTIFIT_FN_EVAL_DF(F, x, dy) (F)->df(x, (F)->params, (dy))
#define GSL_MULTIFIT_FN_EVAL_F_DF(F, x, y, dy) (F)->fdf(x, (F)->params, (y), (dy))

type gsl_multifit_fdfsolver_type
	name as const zstring ptr
	size as uinteger
	alloc as function(byval state as any ptr, byval n as uinteger, byval p as uinteger) as long
	set as function(byval state as any ptr, byval fdf as gsl_multifit_function_fdf ptr, byval x as gsl_vector ptr, byval f as gsl_vector ptr, byval J as gsl_matrix ptr, byval dx as gsl_vector ptr) as long
	iterate as function(byval state as any ptr, byval fdf as gsl_multifit_function_fdf ptr, byval x as gsl_vector ptr, byval f as gsl_vector ptr, byval J as gsl_matrix ptr, byval dx as gsl_vector ptr) as long
	free as sub(byval state as any ptr)
end type

type gsl_multifit_fdfsolver
	as const gsl_multifit_fdfsolver_type ptr type
	fdf as gsl_multifit_function_fdf ptr
	x as gsl_vector ptr
	f as gsl_vector ptr
	J as gsl_matrix ptr
	dx as gsl_vector ptr
	state as any ptr
end type

declare function gsl_multifit_fdfsolver_alloc(byval T as const gsl_multifit_fdfsolver_type ptr, byval n as uinteger, byval p as uinteger) as gsl_multifit_fdfsolver ptr
declare function gsl_multifit_fdfsolver_set(byval s as gsl_multifit_fdfsolver ptr, byval fdf as gsl_multifit_function_fdf ptr, byval x as const gsl_vector ptr) as long
declare function gsl_multifit_fdfsolver_iterate(byval s as gsl_multifit_fdfsolver ptr) as long
declare function gsl_multifit_fdfsolver_driver(byval s as gsl_multifit_fdfsolver ptr, byval maxiter as const uinteger, byval epsabs as const double, byval epsrel as const double) as long
declare sub gsl_multifit_fdfsolver_free(byval s as gsl_multifit_fdfsolver ptr)
declare function gsl_multifit_fdfsolver_name(byval s as const gsl_multifit_fdfsolver ptr) as const zstring ptr
declare function gsl_multifit_fdfsolver_position(byval s as const gsl_multifit_fdfsolver ptr) as gsl_vector ptr
declare function gsl_multifit_test_delta(byval dx as const gsl_vector ptr, byval x as const gsl_vector ptr, byval epsabs as double, byval epsrel as double) as long
declare function gsl_multifit_test_gradient(byval g as const gsl_vector ptr, byval epsabs as double) as long
declare function gsl_multifit_fdfsolver_dif_df(byval x as const gsl_vector ptr, byval fdf as gsl_multifit_function_fdf ptr, byval f as const gsl_vector ptr, byval J as gsl_matrix ptr) as long
declare function gsl_multifit_fdfsolver_dif_fdf(byval x as const gsl_vector ptr, byval fdf as gsl_multifit_function_fdf ptr, byval f as gsl_vector ptr, byval J as gsl_matrix ptr) as long
extern gsl_multifit_fdfsolver_lmder as const gsl_multifit_fdfsolver_type ptr
extern gsl_multifit_fdfsolver_lmsder as const gsl_multifit_fdfsolver_type ptr

end extern
