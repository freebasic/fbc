''
''
'' gsl_chebyshev -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_chebyshev_bi__
#define __gsl_chebyshev_bi__

#include once "gsl_math.bi"
#include once "gsl_mode.bi"
#include once "gsl_types.bi"

type gsl_cheb_series_struct
	c as double ptr
	order as integer
	a as double
	b as double
	order_sp as integer
	f as double ptr
end type

type gsl_cheb_series as gsl_cheb_series_struct

extern "c"
declare function gsl_cheb_alloc (byval order as integer) as gsl_cheb_series ptr
declare sub gsl_cheb_free (byval cs as gsl_cheb_series ptr)
declare function gsl_cheb_init (byval cs as gsl_cheb_series ptr, byval func as gsl_function ptr, byval a as double, byval b as double) as integer
declare function gsl_cheb_eval (byval cs as gsl_cheb_series ptr, byval x as double) as double
declare function gsl_cheb_eval_err (byval cs as gsl_cheb_series ptr, byval x as double, byval result as double ptr, byval abserr as double ptr) as integer
declare function gsl_cheb_eval_n (byval cs as gsl_cheb_series ptr, byval order as integer, byval x as double) as double
declare function gsl_cheb_eval_n_err (byval cs as gsl_cheb_series ptr, byval order as integer, byval x as double, byval result as double ptr, byval abserr as double ptr) as integer
declare function gsl_cheb_eval_mode (byval cs as gsl_cheb_series ptr, byval x as double, byval mode as gsl_mode_t) as double
declare function gsl_cheb_eval_mode_e (byval cs as gsl_cheb_series ptr, byval x as double, byval mode as gsl_mode_t, byval result as double ptr, byval abserr as double ptr) as integer
declare function gsl_cheb_calc_deriv (byval deriv as gsl_cheb_series ptr, byval cs as gsl_cheb_series ptr) as integer
declare function gsl_cheb_calc_integ (byval integ as gsl_cheb_series ptr, byval cs as gsl_cheb_series ptr) as integer
end extern

#endif
