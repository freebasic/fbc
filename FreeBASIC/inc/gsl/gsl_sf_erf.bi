''
''
'' gsl_sf_erf -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_sf_erf_bi__
#define __gsl_sf_erf_bi__

#include once "gsl_sf_result.bi"
#include once "gsl_types.bi"

extern "c"
declare function gsl_sf_erfc_e (byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_erfc (byval x as double) as double
declare function gsl_sf_log_erfc_e (byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_log_erfc (byval x as double) as double
declare function gsl_sf_erf_e (byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_erf (byval x as double) as double
declare function gsl_sf_erf_Z_e (byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_erf_Q_e (byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_erf_Z (byval x as double) as double
declare function gsl_sf_erf_Q (byval x as double) as double
declare function gsl_sf_hazard_e (byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_hazard (byval x as double) as double
end extern

#endif
