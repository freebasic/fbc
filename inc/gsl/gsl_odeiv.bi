''
''
'' gsl_odeiv -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_odeiv_bi__
#define __gsl_odeiv_bi__

#include once "gsl_types.bi"

type gsl_odeiv_system
	function as function cdecl(byval as double, byval as double ptr, byval as double ptr, byval as any ptr) as integer
	jacobian as function cdecl(byval as double, byval as double ptr, byval as double ptr, byval as double ptr, byval as any ptr) as integer
	dimension as integer
	params as any ptr
end type

type gsl_odeiv_step_type
	name as byte ptr
	can_use_dydt_in as integer
	gives_exact_dydt_out as integer
	alloc as sub cdecl(byval as integer)
	apply as function cdecl(byval as any ptr, byval as integer, byval as double, byval as double, byval as double ptr, byval as double ptr, byval as double ptr, byval as double ptr, byval as gsl_odeiv_system ptr) as integer
	reset as function cdecl(byval as any ptr, byval as integer) as integer
	order as function cdecl(byval as any ptr) as uinteger
	free as sub cdecl(byval as any ptr)
end type

type gsl_odeiv_step
	type as gsl_odeiv_step_type ptr
	dimension as integer
	state as any ptr
end type

extern "c"
declare function gsl_odeiv_step_alloc (byval T as gsl_odeiv_step_type ptr, byval dim as integer) as gsl_odeiv_step ptr
declare function gsl_odeiv_step_reset (byval s as gsl_odeiv_step ptr) as integer
declare sub gsl_odeiv_step_free (byval s as gsl_odeiv_step ptr)
declare function gsl_odeiv_step_name (byval as gsl_odeiv_step ptr) as zstring ptr
declare function gsl_odeiv_step_order (byval s as gsl_odeiv_step ptr) as uinteger
declare function gsl_odeiv_step_apply (byval as gsl_odeiv_step ptr, byval t as double, byval h as double, byval y as double ptr, byval yerr as double ptr, byval dydt_in as double ptr, byval dydt_out as double ptr, byval dydt as gsl_odeiv_system ptr) as integer
end extern

type gsl_odeiv_control_type
	name as byte ptr
	alloc as sub cdecl()
	init as function cdecl(byval as any ptr, byval as double, byval as double, byval as double, byval as double) as integer
	hadjust as function cdecl(byval as any ptr, byval as integer, byval as uinteger, byval as double ptr, byval as double ptr, byval as double ptr, byval as double ptr) as integer
	free as sub cdecl(byval as any ptr)
end type

type gsl_odeiv_control
	type as gsl_odeiv_control_type ptr
	state as any ptr
end type

#define GSL_ODEIV_HADJ_INC 1
#define GSL_ODEIV_HADJ_NIL 0
#define GSL_ODEIV_HADJ_DEC (-1)

extern "c"
declare function gsl_odeiv_control_alloc (byval T as gsl_odeiv_control_type ptr) as gsl_odeiv_control ptr
declare function gsl_odeiv_control_init (byval c as gsl_odeiv_control ptr, byval eps_abs as double, byval eps_rel as double, byval a_y as double, byval a_dydt as double) as integer
declare sub gsl_odeiv_control_free (byval c as gsl_odeiv_control ptr)
declare function gsl_odeiv_control_hadjust (byval c as gsl_odeiv_control ptr, byval s as gsl_odeiv_step ptr, byval y0 as double ptr, byval yerr as double ptr, byval dydt as double ptr, byval h as double ptr) as integer
declare function gsl_odeiv_control_name (byval c as gsl_odeiv_control ptr) as zstring ptr
declare function gsl_odeiv_control_standard_new (byval eps_abs as double, byval eps_rel as double, byval a_y as double, byval a_dydt as double) as gsl_odeiv_control ptr
declare function gsl_odeiv_control_y_new (byval eps_abs as double, byval eps_rel as double) as gsl_odeiv_control ptr
declare function gsl_odeiv_control_yp_new (byval eps_abs as double, byval eps_rel as double) as gsl_odeiv_control ptr
declare function gsl_odeiv_control_scaled_new (byval eps_abs as double, byval eps_rel as double, byval a_y as double, byval a_dydt as double, byval scale_abs as double ptr, byval dim as integer) as gsl_odeiv_control ptr
end extern

type gsl_odeiv_evolve
	dimension as integer
	y0 as double ptr
	yerr as double ptr
	dydt_in as double ptr
	dydt_out as double ptr
	last_step as double
	count as uinteger
	failed_steps as uinteger
end type

extern "c"
declare function gsl_odeiv_evolve_alloc (byval dim as integer) as gsl_odeiv_evolve ptr
declare function gsl_odeiv_evolve_apply (byval as gsl_odeiv_evolve ptr, byval con as gsl_odeiv_control ptr, byval step as gsl_odeiv_step ptr, byval dydt as gsl_odeiv_system ptr, byval t as double ptr, byval t1 as double, byval h as double ptr, byval y as double ptr) as integer
declare function gsl_odeiv_evolve_reset (byval as gsl_odeiv_evolve ptr) as integer
declare sub gsl_odeiv_evolve_free (byval as gsl_odeiv_evolve ptr)
end extern

#endif
