''
''
'' gsl_sum -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_sum_bi__
#define __gsl_sum_bi__

#include once "gsl_types.bi"

type gsl_sum_levin_u_workspace
	size as integer
	i as integer
	terms_used as integer
	sum_plain as double
	q_num as double ptr
	q_den as double ptr
	dq_num as double ptr
	dq_den as double ptr
	dsum as double ptr
end type

extern "c"
declare function gsl_sum_levin_u_alloc (byval n as integer) as gsl_sum_levin_u_workspace ptr
declare sub gsl_sum_levin_u_free (byval w as gsl_sum_levin_u_workspace ptr)
declare function gsl_sum_levin_u_accel (byval array as double ptr, byval n as integer, byval w as gsl_sum_levin_u_workspace ptr, byval sum_accel as double ptr, byval abserr as double ptr) as integer
declare function gsl_sum_levin_u_minmax (byval array as double ptr, byval n as integer, byval min_terms as integer, byval max_terms as integer, byval w as gsl_sum_levin_u_workspace ptr, byval sum_accel as double ptr, byval abserr as double ptr) as integer
declare function gsl_sum_levin_u_step (byval term as double, byval n as integer, byval nmax as integer, byval w as gsl_sum_levin_u_workspace ptr, byval sum_accel as double ptr) as integer
end extern

type gsl_sum_levin_utrunc_workspace
	size as integer
	i as integer
	terms_used as integer
	sum_plain as double
	q_num as double ptr
	q_den as double ptr
	dsum as double ptr
end type

extern "c"
declare function gsl_sum_levin_utrunc_alloc (byval n as integer) as gsl_sum_levin_utrunc_workspace ptr
declare sub gsl_sum_levin_utrunc_free (byval w as gsl_sum_levin_utrunc_workspace ptr)
declare function gsl_sum_levin_utrunc_accel (byval array as double ptr, byval n as integer, byval w as gsl_sum_levin_utrunc_workspace ptr, byval sum_accel as double ptr, byval abserr_trunc as double ptr) as integer
declare function gsl_sum_levin_utrunc_minmax (byval array as double ptr, byval n as integer, byval min_terms as integer, byval max_terms as integer, byval w as gsl_sum_levin_utrunc_workspace ptr, byval sum_accel as double ptr, byval abserr_trunc as double ptr) as integer
declare function gsl_sum_levin_utrunc_step (byval term as double, byval n as integer, byval w as gsl_sum_levin_utrunc_workspace ptr, byval sum_accel as double ptr) as integer
end extern

#endif
