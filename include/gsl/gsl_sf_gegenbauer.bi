''
''
'' gsl_sf_gegenbauer -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_sf_gegenbauer_bi__
#define __gsl_sf_gegenbauer_bi__

#include once "gsl_sf_result.bi"
#include once "gsl_types.bi"

extern "c"
declare function gsl_sf_gegenpoly_1_e (byval lambda as double, byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_gegenpoly_2_e (byval lambda as double, byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_gegenpoly_3_e (byval lambda as double, byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_gegenpoly_1 (byval lambda as double, byval x as double) as double
declare function gsl_sf_gegenpoly_2 (byval lambda as double, byval x as double) as double
declare function gsl_sf_gegenpoly_3 (byval lambda as double, byval x as double) as double
declare function gsl_sf_gegenpoly_n_e (byval n as integer, byval lambda as double, byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_gegenpoly_n (byval n as integer, byval lambda as double, byval x as double) as double
declare function gsl_sf_gegenpoly_array (byval nmax as integer, byval lambda as double, byval x as double, byval result_array as double ptr) as integer
end extern

#endif
