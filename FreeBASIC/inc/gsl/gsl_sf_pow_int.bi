''
''
'' gsl_sf_pow_int -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_sf_pow_int_bi__
#define __gsl_sf_pow_int_bi__

#include once "gsl/gsl_sf_result.bi"
#include once "gsl/gsl_types.bi"

declare function gsl_sf_pow_int_e cdecl alias "gsl_sf_pow_int_e" (byval x as double, byval n as integer, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_pow_int cdecl alias "gsl_sf_pow_int" (byval x as double, byval n as integer) as double

#endif
