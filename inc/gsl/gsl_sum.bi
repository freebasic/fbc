'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
''   sum/gsl_sum.h
''
''   Copyright (C) 1996, 1997, 1998, 1999, 2000, 2007 Gerard Jungman, Brian Gough
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

extern "C"

#define __GSL_SUM_H__

type gsl_sum_levin_u_workspace
	size as uinteger
	i as uinteger
	terms_used as uinteger
	sum_plain as double
	q_num as double ptr
	q_den as double ptr
	dq_num as double ptr
	dq_den as double ptr
	dsum as double ptr
end type

declare function gsl_sum_levin_u_alloc(byval n as uinteger) as gsl_sum_levin_u_workspace ptr
declare sub gsl_sum_levin_u_free(byval w as gsl_sum_levin_u_workspace ptr)
declare function gsl_sum_levin_u_accel(byval array as const double ptr, byval n as const uinteger, byval w as gsl_sum_levin_u_workspace ptr, byval sum_accel as double ptr, byval abserr as double ptr) as long
declare function gsl_sum_levin_u_minmax(byval array as const double ptr, byval n as const uinteger, byval min_terms as const uinteger, byval max_terms as const uinteger, byval w as gsl_sum_levin_u_workspace ptr, byval sum_accel as double ptr, byval abserr as double ptr) as long
declare function gsl_sum_levin_u_step(byval term as const double, byval n as const uinteger, byval nmax as const uinteger, byval w as gsl_sum_levin_u_workspace ptr, byval sum_accel as double ptr) as long

type gsl_sum_levin_utrunc_workspace
	size as uinteger
	i as uinteger
	terms_used as uinteger
	sum_plain as double
	q_num as double ptr
	q_den as double ptr
	dsum as double ptr
end type

declare function gsl_sum_levin_utrunc_alloc(byval n as uinteger) as gsl_sum_levin_utrunc_workspace ptr
declare sub gsl_sum_levin_utrunc_free(byval w as gsl_sum_levin_utrunc_workspace ptr)
declare function gsl_sum_levin_utrunc_accel(byval array as const double ptr, byval n as const uinteger, byval w as gsl_sum_levin_utrunc_workspace ptr, byval sum_accel as double ptr, byval abserr_trunc as double ptr) as long
declare function gsl_sum_levin_utrunc_minmax(byval array as const double ptr, byval n as const uinteger, byval min_terms as const uinteger, byval max_terms as const uinteger, byval w as gsl_sum_levin_utrunc_workspace ptr, byval sum_accel as double ptr, byval abserr_trunc as double ptr) as long
declare function gsl_sum_levin_utrunc_step(byval term as const double, byval n as const uinteger, byval w as gsl_sum_levin_utrunc_workspace ptr, byval sum_accel as double ptr) as long

end extern
