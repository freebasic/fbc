''
''
'' gsl_monte_miser -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_monte_miser_bi__
#define __gsl_monte_miser_bi__

#include once "gsl_rng.bi"
#include once "gsl_monte.bi"
#include once "gsl_monte_plain.bi"
#include once "gsl_types.bi"

type gsl_monte_miser_state
	min_calls as integer
	min_calls_per_bisection as integer
	dither as double
	estimate_frac as double
	alpha as double
	dim as integer
	estimate_style as integer
	depth as integer
	verbose as integer
	x as double ptr
	xmid as double ptr
	sigma_l as double ptr
	sigma_r as double ptr
	fmax_l as double ptr
	fmax_r as double ptr
	fmin_l as double ptr
	fmin_r as double ptr
	fsum_l as double ptr
	fsum_r as double ptr
	fsum2_l as double ptr
	fsum2_r as double ptr
	hits_l as integer ptr
	hits_r as integer ptr
end type

extern "c"
declare function gsl_monte_miser_integrate (byval f as gsl_monte_function ptr, byval xl as double ptr, byval xh as double ptr, byval dim as integer, byval calls as integer, byval r as gsl_rng ptr, byval state as gsl_monte_miser_state ptr, byval result as double ptr, byval abserr as double ptr) as integer
declare function gsl_monte_miser_alloc (byval dim as integer) as gsl_monte_miser_state ptr
declare function gsl_monte_miser_init (byval state as gsl_monte_miser_state ptr) as integer
declare sub gsl_monte_miser_free (byval state as gsl_monte_miser_state ptr)
end extern

#endif
