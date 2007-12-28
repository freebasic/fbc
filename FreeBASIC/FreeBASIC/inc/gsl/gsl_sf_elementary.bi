''
''
'' gsl_sf_elementary -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_sf_elementary_bi__
#define __gsl_sf_elementary_bi__

#include once "gsl_sf_result.bi"
#include once "gsl_types.bi"

extern "c"
declare function gsl_sf_multiply_e (byval x as double, byval y as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_multiply (byval x as double, byval y as double) as double
declare function gsl_sf_multiply_err_e (byval x as double, byval dx as double, byval y as double, byval dy as double, byval result as gsl_sf_result ptr) as integer
end extern

#endif
