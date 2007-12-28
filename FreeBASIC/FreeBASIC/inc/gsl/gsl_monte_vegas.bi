''
''
'' gsl_monte_vegas -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_monte_vegas_bi__
#define __gsl_monte_vegas_bi__

#include once "gsl_rng.bi"
#include once "gsl_monte.bi"
#include once "gsl_types.bi"

enum 
	GSL_VEGAS_MODE_IMPORTANCE = 1
	GSL_VEGAS_MODE_IMPORTANCE_ONLY = 0
	GSL_VEGAS_MODE_STRATIFIED = -1
end enum

type gsl_monte_vegas_state
	dim as integer
	bins_max as integer
	bins as uinteger
	boxes as uinteger
	xi as double ptr
	xin as double ptr
	delx as double ptr
	weight as double ptr
	vol as double
	x as double ptr
	bin as integer ptr
	box as integer ptr
	d as double ptr
	alpha as double
	mode as integer
	verbose as integer
	iterations as uinteger
	stage as integer
	jac as double
	wtd_int_sum as double
	sum_wgts as double
	chi_sum as double
	chisq as double
	result as double
	sigma as double
	it_start as uinteger
	it_num as uinteger
	samples as uinteger
	calls_per_box as uinteger
	ostream as FILE ptr
end type

extern "c"
declare function gsl_monte_vegas_integrate (byval f as gsl_monte_function ptr, byval xl as double ptr, byval xu as double ptr, byval dim as integer, byval calls as integer, byval r as gsl_rng ptr, byval state as gsl_monte_vegas_state ptr, byval result as double ptr, byval abserr as double ptr) as integer
declare function gsl_monte_vegas_alloc (byval dim as integer) as gsl_monte_vegas_state ptr
declare function gsl_monte_vegas_init (byval state as gsl_monte_vegas_state ptr) as integer
declare sub gsl_monte_vegas_free (byval state as gsl_monte_vegas_state ptr)
end extern

#endif
