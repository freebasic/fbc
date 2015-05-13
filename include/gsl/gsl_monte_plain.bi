''
''
'' gsl_monte_plain -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_monte_plain_bi__
#define __gsl_monte_plain_bi__

#include once "gsl_monte.bi"
#include once "gsl_rng.bi"
#include once "gsl_types.bi"

type gsl_monte_plain_state
	dim as integer
	x as double ptr
end type

extern "c"
declare function gsl_monte_plain_integrate (byval f as gsl_monte_function ptr, byval xl as double ptr, byval xu as double ptr, byval dim as integer, byval calls as integer, byval r as gsl_rng ptr, byval state as gsl_monte_plain_state ptr, byval result as double ptr, byval abserr as double ptr) as integer
declare function gsl_monte_plain_alloc (byval dim as integer) as gsl_monte_plain_state ptr
declare function gsl_monte_plain_init (byval state as gsl_monte_plain_state ptr) as integer
declare sub gsl_monte_plain_free (byval state as gsl_monte_plain_state ptr)
end extern

#endif
