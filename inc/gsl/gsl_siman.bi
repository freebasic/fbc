''
''
'' gsl_siman -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_siman_bi__
#define __gsl_siman_bi__

#include once "gsl_rng.bi"
#include once "gsl_types.bi"

type gsl_siman_Efunc_t as function cdecl(byval as any ptr) as double
type gsl_siman_step_t as sub cdecl(byval as gsl_rng ptr, byval as any ptr, byval as double)
type gsl_siman_metric_t as function cdecl(byval as any ptr, byval as any ptr) as double
type gsl_siman_print_t as sub cdecl(byval as any ptr)
type gsl_siman_copy_t as sub cdecl(byval as any ptr, byval as any ptr)
type gsl_siman_copy_construct_t as sub cdecl(byval as any ptr)
type gsl_siman_destroy_t as sub cdecl(byval as any ptr)

type gsl_siman_params_t
	n_tries as integer
	iters_fixed_T as integer
	step_size as double
	k as double
	t_initial as double
	mu_t as double
	t_min as double
end type

extern "c"
declare sub gsl_siman_solve (byval r as gsl_rng ptr, byval x0_p as any ptr, byval Ef as gsl_siman_Efunc_t, byval take_step as gsl_siman_step_t, byval distance as gsl_siman_metric_t, byval print_position as gsl_siman_print_t, byval copyfunc as gsl_siman_copy_t, byval copy_constructor as gsl_siman_copy_construct_t, byval destructor as gsl_siman_destroy_t, byval element_size as integer, byval params as gsl_siman_params_t)
declare sub gsl_siman_solve_many (byval r as gsl_rng ptr, byval x0_p as any ptr, byval Ef as gsl_siman_Efunc_t, byval take_step as gsl_siman_step_t, byval distance as gsl_siman_metric_t, byval print_position as gsl_siman_print_t, byval element_size as integer, byval params as gsl_siman_params_t)
end extern

#endif
