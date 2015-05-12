''
''
'' gsl_sf_debye -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_sf_debye_bi__
#define __gsl_sf_debye_bi__

#include once "gsl_sf_result.bi"
#include once "gsl_types.bi"

extern "c"
declare function gsl_sf_debye_1_e (byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_debye_1 (byval x as double) as double
declare function gsl_sf_debye_2_e (byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_debye_2 (byval x as double) as double
declare function gsl_sf_debye_3_e (byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_debye_3 (byval x as double) as double
declare function gsl_sf_debye_4_e (byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_debye_4 (byval x as double) as double
end extern

#endif
