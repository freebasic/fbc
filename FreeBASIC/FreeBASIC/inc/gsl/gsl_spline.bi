''
''
'' gsl_spline -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_spline_bi__
#define __gsl_spline_bi__

#include once "gsl_interp.bi"
#include once "gsl_types.bi"

type gsl_spline
	interp as gsl_interp ptr
	x as double ptr
	y as double ptr
	size as integer
end type

extern "c"
declare function gsl_spline_alloc (byval T as gsl_interp_type ptr, byval size as integer) as gsl_spline ptr
declare function gsl_spline_init (byval spline as gsl_spline ptr, byval xa as double ptr, byval ya as double ptr, byval size as integer) as integer
declare function gsl_spline_eval_e (byval spline as gsl_spline ptr, byval x as double, byval a as gsl_interp_accel ptr, byval y as double ptr) as integer
declare function gsl_spline_eval (byval spline as gsl_spline ptr, byval x as double, byval a as gsl_interp_accel ptr) as double
declare function gsl_spline_eval_deriv_e (byval spline as gsl_spline ptr, byval x as double, byval a as gsl_interp_accel ptr, byval y as double ptr) as integer
declare function gsl_spline_eval_deriv (byval spline as gsl_spline ptr, byval x as double, byval a as gsl_interp_accel ptr) as double
declare function gsl_spline_eval_deriv2_e (byval spline as gsl_spline ptr, byval x as double, byval a as gsl_interp_accel ptr, byval y as double ptr) as integer
declare function gsl_spline_eval_deriv2 (byval spline as gsl_spline ptr, byval x as double, byval a as gsl_interp_accel ptr) as double
declare function gsl_spline_eval_integ_e (byval spline as gsl_spline ptr, byval a as double, byval b as double, byval acc as gsl_interp_accel ptr, byval y as double ptr) as integer
declare function gsl_spline_eval_integ (byval spline as gsl_spline ptr, byval a as double, byval b as double, byval acc as gsl_interp_accel ptr) as double
declare sub gsl_spline_free (byval spline as gsl_spline ptr)
end extern

#endif
