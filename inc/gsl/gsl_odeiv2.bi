'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
''   ode-initval/odeiv2.h
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

#define __GSL_ODEIV2_H__

type gsl_odeiv2_system
	function as function(byval t as double, byval y as const double ptr, byval dydt as double ptr, byval params as any ptr) as long
	jacobian as function(byval t as double, byval y as const double ptr, byval dfdy as double ptr, byval dfdt as double ptr, byval params as any ptr) as long
	dimension as uinteger
	params as any ptr
end type

#define GSL_ODEIV_FN_EVAL(S, t, y, f) (S)->function(t, y, f, (S)->params)
#define GSL_ODEIV_JA_EVAL(S, t, y, dfdy, dfdt) (S)->jacobian(t, y, dfdy, dfdt, (S)->params)
type gsl_odeiv2_step as gsl_odeiv2_step_struct
type gsl_odeiv2_control as gsl_odeiv2_control_struct
type gsl_odeiv2_evolve as gsl_odeiv2_evolve_struct
type gsl_odeiv2_driver as gsl_odeiv2_driver_struct

type gsl_odeiv2_step_type
	name as const zstring ptr
	can_use_dydt_in as long
	gives_exact_dydt_out as long
	alloc as function(byval dim as uinteger) as any ptr
	apply as function(byval state as any ptr, byval dim as uinteger, byval t as double, byval h as double, byval y as double ptr, byval yerr as double ptr, byval dydt_in as const double ptr, byval dydt_out as double ptr, byval dydt as const gsl_odeiv2_system ptr) as long
	set_driver as function(byval state as any ptr, byval d as const gsl_odeiv2_driver ptr) as long
	reset as function(byval state as any ptr, byval dim as uinteger) as long
	order as function(byval state as any ptr) as ulong
	free as sub(byval state as any ptr)
end type

type gsl_odeiv2_step_struct
	as const gsl_odeiv2_step_type ptr type
	dimension as uinteger
	state as any ptr
end type

extern gsl_odeiv2_step_rk2 as const gsl_odeiv2_step_type ptr
extern gsl_odeiv2_step_rk4 as const gsl_odeiv2_step_type ptr
extern gsl_odeiv2_step_rkf45 as const gsl_odeiv2_step_type ptr
extern gsl_odeiv2_step_rkck as const gsl_odeiv2_step_type ptr
extern gsl_odeiv2_step_rk8pd as const gsl_odeiv2_step_type ptr
extern gsl_odeiv2_step_rk2imp as const gsl_odeiv2_step_type ptr
extern gsl_odeiv2_step_rk4imp as const gsl_odeiv2_step_type ptr
extern gsl_odeiv2_step_bsimp as const gsl_odeiv2_step_type ptr
extern gsl_odeiv2_step_rk1imp as const gsl_odeiv2_step_type ptr
extern gsl_odeiv2_step_msadams as const gsl_odeiv2_step_type ptr
extern gsl_odeiv2_step_msbdf as const gsl_odeiv2_step_type ptr

declare function gsl_odeiv2_step_alloc(byval T as const gsl_odeiv2_step_type ptr, byval dim as uinteger) as gsl_odeiv2_step ptr
declare function gsl_odeiv2_step_reset(byval s as gsl_odeiv2_step ptr) as long
declare sub gsl_odeiv2_step_free(byval s as gsl_odeiv2_step ptr)
declare function gsl_odeiv2_step_name(byval s as const gsl_odeiv2_step ptr) as const zstring ptr
declare function gsl_odeiv2_step_order(byval s as const gsl_odeiv2_step ptr) as ulong
declare function gsl_odeiv2_step_apply(byval s as gsl_odeiv2_step ptr, byval t as double, byval h as double, byval y as double ptr, byval yerr as double ptr, byval dydt_in as const double ptr, byval dydt_out as double ptr, byval dydt as const gsl_odeiv2_system ptr) as long
declare function gsl_odeiv2_step_set_driver(byval s as gsl_odeiv2_step ptr, byval d as const gsl_odeiv2_driver ptr) as long

type gsl_odeiv2_control_type
	name as const zstring ptr
	alloc as function() as any ptr
	init as function(byval state as any ptr, byval eps_abs as double, byval eps_rel as double, byval a_y as double, byval a_dydt as double) as long
	hadjust as function(byval state as any ptr, byval dim as uinteger, byval ord as ulong, byval y as const double ptr, byval yerr as const double ptr, byval yp as const double ptr, byval h as double ptr) as long
	errlevel as function(byval state as any ptr, byval y as const double, byval dydt as const double, byval h as const double, byval ind as const uinteger, byval errlev as double ptr) as long
	set_driver as function(byval state as any ptr, byval d as const gsl_odeiv2_driver ptr) as long
	free as sub(byval state as any ptr)
end type

type gsl_odeiv2_control_struct
	as const gsl_odeiv2_control_type ptr type
	state as any ptr
end type

const GSL_ODEIV_HADJ_INC = 1
const GSL_ODEIV_HADJ_NIL = 0
const GSL_ODEIV_HADJ_DEC = -1

declare function gsl_odeiv2_control_alloc(byval T as const gsl_odeiv2_control_type ptr) as gsl_odeiv2_control ptr
declare function gsl_odeiv2_control_init(byval c as gsl_odeiv2_control ptr, byval eps_abs as double, byval eps_rel as double, byval a_y as double, byval a_dydt as double) as long
declare sub gsl_odeiv2_control_free(byval c as gsl_odeiv2_control ptr)
declare function gsl_odeiv2_control_hadjust(byval c as gsl_odeiv2_control ptr, byval s as gsl_odeiv2_step ptr, byval y as const double ptr, byval yerr as const double ptr, byval dydt as const double ptr, byval h as double ptr) as long
declare function gsl_odeiv2_control_name(byval c as const gsl_odeiv2_control ptr) as const zstring ptr
declare function gsl_odeiv2_control_errlevel(byval c as gsl_odeiv2_control ptr, byval y as const double, byval dydt as const double, byval h as const double, byval ind as const uinteger, byval errlev as double ptr) as long
declare function gsl_odeiv2_control_set_driver(byval c as gsl_odeiv2_control ptr, byval d as const gsl_odeiv2_driver ptr) as long
declare function gsl_odeiv2_control_standard_new(byval eps_abs as double, byval eps_rel as double, byval a_y as double, byval a_dydt as double) as gsl_odeiv2_control ptr
declare function gsl_odeiv2_control_y_new(byval eps_abs as double, byval eps_rel as double) as gsl_odeiv2_control ptr
declare function gsl_odeiv2_control_yp_new(byval eps_abs as double, byval eps_rel as double) as gsl_odeiv2_control ptr
declare function gsl_odeiv2_control_scaled_new(byval eps_abs as double, byval eps_rel as double, byval a_y as double, byval a_dydt as double, byval scale_abs as const double ptr, byval dim as uinteger) as gsl_odeiv2_control ptr

type gsl_odeiv2_evolve_struct
	dimension as uinteger
	y0 as double ptr
	yerr as double ptr
	dydt_in as double ptr
	dydt_out as double ptr
	last_step as double
	count as culong
	failed_steps as culong
	driver as const gsl_odeiv2_driver ptr
end type

declare function gsl_odeiv2_evolve_alloc(byval dim as uinteger) as gsl_odeiv2_evolve ptr
declare function gsl_odeiv2_evolve_apply(byval e as gsl_odeiv2_evolve ptr, byval con as gsl_odeiv2_control ptr, byval step as gsl_odeiv2_step ptr, byval dydt as const gsl_odeiv2_system ptr, byval t as double ptr, byval t1 as double, byval h as double ptr, byval y as double ptr) as long
declare function gsl_odeiv2_evolve_apply_fixed_step(byval e as gsl_odeiv2_evolve ptr, byval con as gsl_odeiv2_control ptr, byval step as gsl_odeiv2_step ptr, byval dydt as const gsl_odeiv2_system ptr, byval t as double ptr, byval h0 as const double, byval y as double ptr) as long
declare function gsl_odeiv2_evolve_reset(byval e as gsl_odeiv2_evolve ptr) as long
declare sub gsl_odeiv2_evolve_free(byval e as gsl_odeiv2_evolve ptr)
declare function gsl_odeiv2_evolve_set_driver(byval e as gsl_odeiv2_evolve ptr, byval d as const gsl_odeiv2_driver ptr) as long

type gsl_odeiv2_driver_struct
	sys as const gsl_odeiv2_system ptr
	s as gsl_odeiv2_step ptr
	c as gsl_odeiv2_control ptr
	e as gsl_odeiv2_evolve ptr
	h as double
	hmin as double
	hmax as double
	n as culong
	nmax as culong
end type

declare function gsl_odeiv2_driver_alloc_y_new(byval sys as const gsl_odeiv2_system ptr, byval T as const gsl_odeiv2_step_type ptr, byval hstart as const double, byval epsabs as const double, byval epsrel as const double) as gsl_odeiv2_driver ptr
declare function gsl_odeiv2_driver_alloc_yp_new(byval sys as const gsl_odeiv2_system ptr, byval T as const gsl_odeiv2_step_type ptr, byval hstart as const double, byval epsabs as const double, byval epsrel as const double) as gsl_odeiv2_driver ptr
declare function gsl_odeiv2_driver_alloc_scaled_new(byval sys as const gsl_odeiv2_system ptr, byval T as const gsl_odeiv2_step_type ptr, byval hstart as const double, byval epsabs as const double, byval epsrel as const double, byval a_y as const double, byval a_dydt as const double, byval scale_abs as const double ptr) as gsl_odeiv2_driver ptr
declare function gsl_odeiv2_driver_alloc_standard_new(byval sys as const gsl_odeiv2_system ptr, byval T as const gsl_odeiv2_step_type ptr, byval hstart as const double, byval epsabs as const double, byval epsrel as const double, byval a_y as const double, byval a_dydt as const double) as gsl_odeiv2_driver ptr
declare function gsl_odeiv2_driver_set_hmin(byval d as gsl_odeiv2_driver ptr, byval hmin as const double) as long
declare function gsl_odeiv2_driver_set_hmax(byval d as gsl_odeiv2_driver ptr, byval hmax as const double) as long
declare function gsl_odeiv2_driver_set_nmax(byval d as gsl_odeiv2_driver ptr, byval nmax as const culong) as long
declare function gsl_odeiv2_driver_apply(byval d as gsl_odeiv2_driver ptr, byval t as double ptr, byval t1 as const double, byval y as double ptr) as long
declare function gsl_odeiv2_driver_apply_fixed_step(byval d as gsl_odeiv2_driver ptr, byval t as double ptr, byval h as const double, byval n as const culong, byval y as double ptr) as long
declare function gsl_odeiv2_driver_reset(byval d as gsl_odeiv2_driver ptr) as long
declare function gsl_odeiv2_driver_reset_hstart(byval d as gsl_odeiv2_driver ptr, byval hstart as const double) as long
declare sub gsl_odeiv2_driver_free(byval state as gsl_odeiv2_driver ptr)

end extern
