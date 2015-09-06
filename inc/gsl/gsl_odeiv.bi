'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
''   ode-initval/gsl_odeiv.h
''
''   Copyright (C) 1996, 1997, 1998, 1999, 2000 Gerard Jungman
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

#include once "crt/long.bi"
#include once "crt/stdio.bi"
#include once "crt/stdlib.bi"
#include once "gsl/gsl_types.bi"

extern "C"

#define __GSL_ODEIV_H__

type gsl_odeiv_system
	function as function(byval t as double, byval y as const double ptr, byval dydt as double ptr, byval params as any ptr) as long
	jacobian as function(byval t as double, byval y as const double ptr, byval dfdy as double ptr, byval dfdt as double ptr, byval params as any ptr) as long
	dimension as uinteger
	params as any ptr
end type

type gsl_odeiv_step_type
	name as const zstring ptr
	can_use_dydt_in as long
	gives_exact_dydt_out as long
	alloc as function(byval dim as uinteger) as any ptr
	apply as function(byval state as any ptr, byval dim as uinteger, byval t as double, byval h as double, byval y as double ptr, byval yerr as double ptr, byval dydt_in as const double ptr, byval dydt_out as double ptr, byval dydt as const gsl_odeiv_system ptr) as long
	reset as function(byval state as any ptr, byval dim as uinteger) as long
	order as function(byval state as any ptr) as ulong
	free as sub(byval state as any ptr)
end type

type gsl_odeiv_step
	as const gsl_odeiv_step_type ptr type
	dimension as uinteger
	state as any ptr
end type

extern gsl_odeiv_step_rk2 as const gsl_odeiv_step_type ptr
extern gsl_odeiv_step_rk4 as const gsl_odeiv_step_type ptr
extern gsl_odeiv_step_rkf45 as const gsl_odeiv_step_type ptr
extern gsl_odeiv_step_rkck as const gsl_odeiv_step_type ptr
extern gsl_odeiv_step_rk8pd as const gsl_odeiv_step_type ptr
extern gsl_odeiv_step_rk2imp as const gsl_odeiv_step_type ptr
extern gsl_odeiv_step_rk2simp as const gsl_odeiv_step_type ptr
extern gsl_odeiv_step_rk4imp as const gsl_odeiv_step_type ptr
extern gsl_odeiv_step_bsimp as const gsl_odeiv_step_type ptr
extern gsl_odeiv_step_gear1 as const gsl_odeiv_step_type ptr
extern gsl_odeiv_step_gear2 as const gsl_odeiv_step_type ptr

declare function gsl_odeiv_step_alloc(byval T as const gsl_odeiv_step_type ptr, byval dim as uinteger) as gsl_odeiv_step ptr
declare function gsl_odeiv_step_reset(byval s as gsl_odeiv_step ptr) as long
declare sub gsl_odeiv_step_free(byval s as gsl_odeiv_step ptr)
declare function gsl_odeiv_step_name(byval s as const gsl_odeiv_step ptr) as const zstring ptr
declare function gsl_odeiv_step_order(byval s as const gsl_odeiv_step ptr) as ulong
declare function gsl_odeiv_step_apply(byval s as gsl_odeiv_step ptr, byval t as double, byval h as double, byval y as double ptr, byval yerr as double ptr, byval dydt_in as const double ptr, byval dydt_out as double ptr, byval dydt as const gsl_odeiv_system ptr) as long

type gsl_odeiv_control_type
	name as const zstring ptr
	alloc as function() as any ptr
	init as function(byval state as any ptr, byval eps_abs as double, byval eps_rel as double, byval a_y as double, byval a_dydt as double) as long
	hadjust as function(byval state as any ptr, byval dim as uinteger, byval ord as ulong, byval y as const double ptr, byval yerr as const double ptr, byval yp as const double ptr, byval h as double ptr) as long
	free as sub(byval state as any ptr)
end type

type gsl_odeiv_control
	as const gsl_odeiv_control_type ptr type
	state as any ptr
end type

const GSL_ODEIV_HADJ_INC = 1
const GSL_ODEIV_HADJ_NIL = 0
const GSL_ODEIV_HADJ_DEC = -1

declare function gsl_odeiv_control_alloc(byval T as const gsl_odeiv_control_type ptr) as gsl_odeiv_control ptr
declare function gsl_odeiv_control_init(byval c as gsl_odeiv_control ptr, byval eps_abs as double, byval eps_rel as double, byval a_y as double, byval a_dydt as double) as long
declare sub gsl_odeiv_control_free(byval c as gsl_odeiv_control ptr)
declare function gsl_odeiv_control_hadjust(byval c as gsl_odeiv_control ptr, byval s as gsl_odeiv_step ptr, byval y as const double ptr, byval yerr as const double ptr, byval dydt as const double ptr, byval h as double ptr) as long
declare function gsl_odeiv_control_name(byval c as const gsl_odeiv_control ptr) as const zstring ptr
declare function gsl_odeiv_control_standard_new(byval eps_abs as double, byval eps_rel as double, byval a_y as double, byval a_dydt as double) as gsl_odeiv_control ptr
declare function gsl_odeiv_control_y_new(byval eps_abs as double, byval eps_rel as double) as gsl_odeiv_control ptr
declare function gsl_odeiv_control_yp_new(byval eps_abs as double, byval eps_rel as double) as gsl_odeiv_control ptr
declare function gsl_odeiv_control_scaled_new(byval eps_abs as double, byval eps_rel as double, byval a_y as double, byval a_dydt as double, byval scale_abs as const double ptr, byval dim as uinteger) as gsl_odeiv_control ptr

type gsl_odeiv_evolve
	dimension as uinteger
	y0 as double ptr
	yerr as double ptr
	dydt_in as double ptr
	dydt_out as double ptr
	last_step as double
	count as culong
	failed_steps as culong
end type

declare function gsl_odeiv_evolve_alloc(byval dim as uinteger) as gsl_odeiv_evolve ptr
declare function gsl_odeiv_evolve_apply(byval e as gsl_odeiv_evolve ptr, byval con as gsl_odeiv_control ptr, byval step as gsl_odeiv_step ptr, byval dydt as const gsl_odeiv_system ptr, byval t as double ptr, byval t1 as double, byval h as double ptr, byval y as double ptr) as long
declare function gsl_odeiv_evolve_reset(byval e as gsl_odeiv_evolve ptr) as long
declare sub gsl_odeiv_evolve_free(byval e as gsl_odeiv_evolve ptr)

end extern
