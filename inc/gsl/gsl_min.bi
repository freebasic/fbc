'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
''   min/gsl_min.h
''
''   Copyright (C) 1996, 1997, 1998, 1999, 2000, 2007, 2009 Brian Gough
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

#define __GSL_MIN_H__

type gsl_min_fminimizer_type
	name as const zstring ptr
	size as uinteger
	set as function(byval state as any ptr, byval f as gsl_function ptr, byval x_minimum as double, byval f_minimum as double, byval x_lower as double, byval f_lower as double, byval x_upper as double, byval f_upper as double) as long
	iterate as function(byval state as any ptr, byval f as gsl_function ptr, byval x_minimum as double ptr, byval f_minimum as double ptr, byval x_lower as double ptr, byval f_lower as double ptr, byval x_upper as double ptr, byval f_upper as double ptr) as long
end type

type gsl_min_fminimizer
	as const gsl_min_fminimizer_type ptr type
	function as gsl_function ptr
	x_minimum as double
	x_lower as double
	x_upper as double
	f_minimum as double
	f_lower as double
	f_upper as double
	state as any ptr
end type

declare function gsl_min_fminimizer_alloc(byval T as const gsl_min_fminimizer_type ptr) as gsl_min_fminimizer ptr
declare sub gsl_min_fminimizer_free(byval s as gsl_min_fminimizer ptr)
declare function gsl_min_fminimizer_set(byval s as gsl_min_fminimizer ptr, byval f as gsl_function ptr, byval x_minimum as double, byval x_lower as double, byval x_upper as double) as long
declare function gsl_min_fminimizer_set_with_values(byval s as gsl_min_fminimizer ptr, byval f as gsl_function ptr, byval x_minimum as double, byval f_minimum as double, byval x_lower as double, byval f_lower as double, byval x_upper as double, byval f_upper as double) as long
declare function gsl_min_fminimizer_iterate(byval s as gsl_min_fminimizer ptr) as long
declare function gsl_min_fminimizer_name(byval s as const gsl_min_fminimizer ptr) as const zstring ptr
declare function gsl_min_fminimizer_x_minimum(byval s as const gsl_min_fminimizer ptr) as double
declare function gsl_min_fminimizer_x_lower(byval s as const gsl_min_fminimizer ptr) as double
declare function gsl_min_fminimizer_x_upper(byval s as const gsl_min_fminimizer ptr) as double
declare function gsl_min_fminimizer_f_minimum(byval s as const gsl_min_fminimizer ptr) as double
declare function gsl_min_fminimizer_f_lower(byval s as const gsl_min_fminimizer ptr) as double
declare function gsl_min_fminimizer_f_upper(byval s as const gsl_min_fminimizer ptr) as double
declare function gsl_min_fminimizer_minimum(byval s as const gsl_min_fminimizer ptr) as double
declare function gsl_min_test_interval(byval x_lower as double, byval x_upper as double, byval epsabs as double, byval epsrel as double) as long

extern gsl_min_fminimizer_goldensection as const gsl_min_fminimizer_type ptr
extern gsl_min_fminimizer_brent as const gsl_min_fminimizer_type ptr
extern gsl_min_fminimizer_quad_golden as const gsl_min_fminimizer_type ptr
type gsl_min_bracketing_function as function(byval f as gsl_function ptr, byval x_minimum as double ptr, byval f_minimum as double ptr, byval x_lower as double ptr, byval f_lower as double ptr, byval x_upper as double ptr, byval f_upper as double ptr, byval eval_max as uinteger) as long
declare function gsl_min_find_bracket(byval f as gsl_function ptr, byval x_minimum as double ptr, byval f_minimum as double ptr, byval x_lower as double ptr, byval f_lower as double ptr, byval x_upper as double ptr, byval f_upper as double ptr, byval eval_max as uinteger) as long

end extern
