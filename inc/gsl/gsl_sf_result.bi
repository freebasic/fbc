''
''
'' gsl_sf_result -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_sf_result_bi__
#define __gsl_sf_result_bi__

#include once "gsl_types.bi"

type gsl_sf_result_struct
	val as double
	err as double
end type

type gsl_sf_result as gsl_sf_result_struct

type gsl_sf_result_e10_struct
	val as double
	err as double
	e10 as integer
end type

type gsl_sf_result_e10 as gsl_sf_result_e10_struct

extern "c"
declare function gsl_sf_result_smash_e (byval re as gsl_sf_result_e10 ptr, byval r as gsl_sf_result ptr) as integer
end extern

#endif
