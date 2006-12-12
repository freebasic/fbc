''
''
'' gsl_sf_expint -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_sf_expint_bi__
#define __gsl_sf_expint_bi__

#include once "gsl_sf_result.bi"
#include once "gsl_types.bi"

extern "c"
declare function gsl_sf_expint_E1_e (byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_expint_E1 (byval x as double) as double
declare function gsl_sf_expint_E2_e (byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_expint_E2 (byval x as double) as double
declare function gsl_sf_expint_E1_scaled_e (byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_expint_E1_scaled (byval x as double) as double
declare function gsl_sf_expint_E2_scaled_e (byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_expint_E2_scaled (byval x as double) as double
declare function gsl_sf_expint_Ei_e (byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_expint_Ei (byval x as double) as double
declare function gsl_sf_expint_Ei_scaled_e (byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_expint_Ei_scaled (byval x as double) as double
declare function gsl_sf_Shi_e (byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_Shi (byval x as double) as double
declare function gsl_sf_Chi_e (byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_Chi (byval x as double) as double
declare function gsl_sf_expint_3_e (byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_expint_3 (byval x as double) as double
declare function gsl_sf_Si_e (byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_Si (byval x as double) as double
declare function gsl_sf_Ci_e (byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_Ci (byval x as double) as double
declare function gsl_sf_atanint_e (byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_atanint (byval x as double) as double
end extern

#endif
