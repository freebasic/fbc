'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
''   multimin/gsl_multimin.h
''
''   Copyright (C) 1996, 1997, 1998, 1999, 2000 Fabrice Rossi
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
#include once "gsl/gsl_min.bi"

extern "C"

#define __GSL_MULTIMIN_H__

type gsl_multimin_function_struct
	f as function(byval x as const gsl_vector ptr, byval params as any ptr) as double
	n as uinteger
	params as any ptr
end type

type gsl_multimin_function as gsl_multimin_function_struct
#define GSL_MULTIMIN_FN_EVAL(F_, x) (F_)->f(x, (F_)->params)

type gsl_multimin_function_fdf_struct
	f as function(byval x as const gsl_vector ptr, byval params as any ptr) as double
	df as sub(byval x as const gsl_vector ptr, byval params as any ptr, byval df as gsl_vector ptr)
	fdf as sub(byval x as const gsl_vector ptr, byval params as any ptr, byval f as double ptr, byval df as gsl_vector ptr)
	n as uinteger
	params as any ptr
end type

type gsl_multimin_function_fdf as gsl_multimin_function_fdf_struct
#define GSL_MULTIMIN_FN_EVAL_F(F_, x) (F_)->f(x, (F_)->params)
#define GSL_MULTIMIN_FN_EVAL_DF(F, x, g) (F)->df(x, (F)->params, (g))
#define GSL_MULTIMIN_FN_EVAL_F_DF(F, x, y, g) (F)->fdf(x, (F)->params, (y), (g))
declare function gsl_multimin_diff(byval f as const gsl_multimin_function ptr, byval x as const gsl_vector ptr, byval g as gsl_vector ptr) as long

type gsl_multimin_fminimizer_type
	name as const zstring ptr
	size as uinteger
	alloc as function(byval state as any ptr, byval n as uinteger) as long
	set as function(byval state as any ptr, byval f as gsl_multimin_function ptr, byval x as const gsl_vector ptr, byval size as double ptr, byval step_size as const gsl_vector ptr) as long
	iterate as function(byval state as any ptr, byval f as gsl_multimin_function ptr, byval x as gsl_vector ptr, byval size as double ptr, byval fval as double ptr) as long
	free as sub(byval state as any ptr)
end type

type gsl_multimin_fminimizer
	as const gsl_multimin_fminimizer_type ptr type
	f as gsl_multimin_function ptr
	fval as double
	x as gsl_vector ptr
	size as double
	state as any ptr
end type

declare function gsl_multimin_fminimizer_alloc(byval T as const gsl_multimin_fminimizer_type ptr, byval n as uinteger) as gsl_multimin_fminimizer ptr
declare function gsl_multimin_fminimizer_set(byval s as gsl_multimin_fminimizer ptr, byval f as gsl_multimin_function ptr, byval x as const gsl_vector ptr, byval step_size as const gsl_vector ptr) as long
declare sub gsl_multimin_fminimizer_free(byval s as gsl_multimin_fminimizer ptr)
declare function gsl_multimin_fminimizer_name(byval s as const gsl_multimin_fminimizer ptr) as const zstring ptr
declare function gsl_multimin_fminimizer_iterate(byval s as gsl_multimin_fminimizer ptr) as long
declare function gsl_multimin_fminimizer_x(byval s as const gsl_multimin_fminimizer ptr) as gsl_vector ptr
declare function gsl_multimin_fminimizer_minimum(byval s as const gsl_multimin_fminimizer ptr) as double
declare function gsl_multimin_fminimizer_size(byval s as const gsl_multimin_fminimizer ptr) as double
declare function gsl_multimin_test_gradient(byval g as const gsl_vector ptr, byval epsabs as double) as long
declare function gsl_multimin_test_size(byval size as const double, byval epsabs as double) as long

type gsl_multimin_fdfminimizer_type
	name as const zstring ptr
	size as uinteger
	alloc as function(byval state as any ptr, byval n as uinteger) as long
	set as function(byval state as any ptr, byval fdf as gsl_multimin_function_fdf ptr, byval x as const gsl_vector ptr, byval f as double ptr, byval gradient as gsl_vector ptr, byval step_size as double, byval tol as double) as long
	iterate as function(byval state as any ptr, byval fdf as gsl_multimin_function_fdf ptr, byval x as gsl_vector ptr, byval f as double ptr, byval gradient as gsl_vector ptr, byval dx as gsl_vector ptr) as long
	restart as function(byval state as any ptr) as long
	free as sub(byval state as any ptr)
end type

type gsl_multimin_fdfminimizer
	as const gsl_multimin_fdfminimizer_type ptr type
	fdf as gsl_multimin_function_fdf ptr
	f as double
	x as gsl_vector ptr
	gradient as gsl_vector ptr
	dx as gsl_vector ptr
	state as any ptr
end type

declare function gsl_multimin_fdfminimizer_alloc(byval T as const gsl_multimin_fdfminimizer_type ptr, byval n as uinteger) as gsl_multimin_fdfminimizer ptr
declare function gsl_multimin_fdfminimizer_set(byval s as gsl_multimin_fdfminimizer ptr, byval fdf as gsl_multimin_function_fdf ptr, byval x as const gsl_vector ptr, byval step_size as double, byval tol as double) as long
declare sub gsl_multimin_fdfminimizer_free(byval s as gsl_multimin_fdfminimizer ptr)
declare function gsl_multimin_fdfminimizer_name(byval s as const gsl_multimin_fdfminimizer ptr) as const zstring ptr
declare function gsl_multimin_fdfminimizer_iterate(byval s as gsl_multimin_fdfminimizer ptr) as long
declare function gsl_multimin_fdfminimizer_restart(byval s as gsl_multimin_fdfminimizer ptr) as long
declare function gsl_multimin_fdfminimizer_x(byval s as const gsl_multimin_fdfminimizer ptr) as gsl_vector ptr
declare function gsl_multimin_fdfminimizer_dx(byval s as const gsl_multimin_fdfminimizer ptr) as gsl_vector ptr
declare function gsl_multimin_fdfminimizer_gradient(byval s as const gsl_multimin_fdfminimizer ptr) as gsl_vector ptr
declare function gsl_multimin_fdfminimizer_minimum(byval s as const gsl_multimin_fdfminimizer ptr) as double

extern gsl_multimin_fdfminimizer_steepest_descent as const gsl_multimin_fdfminimizer_type ptr
extern gsl_multimin_fdfminimizer_conjugate_pr as const gsl_multimin_fdfminimizer_type ptr
extern gsl_multimin_fdfminimizer_conjugate_fr as const gsl_multimin_fdfminimizer_type ptr
extern gsl_multimin_fdfminimizer_vector_bfgs as const gsl_multimin_fdfminimizer_type ptr
extern gsl_multimin_fdfminimizer_vector_bfgs2 as const gsl_multimin_fdfminimizer_type ptr
extern gsl_multimin_fminimizer_nmsimplex as const gsl_multimin_fminimizer_type ptr
extern gsl_multimin_fminimizer_nmsimplex2 as const gsl_multimin_fminimizer_type ptr
extern gsl_multimin_fminimizer_nmsimplex2rand as const gsl_multimin_fminimizer_type ptr

end extern
