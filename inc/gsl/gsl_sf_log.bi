''
''
'' gsl_sf_log -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_sf_log_bi__
#define __gsl_sf_log_bi__

#include once "gsl_sf_result.bi"
#include once "gsl_types.bi"

extern "c"
declare function gsl_sf_log_e (byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_log (byval x as double) as double
declare function gsl_sf_log_abs_e (byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_log_abs (byval x as double) as double
declare function gsl_sf_complex_log_e (byval zr as double, byval zi as double, byval lnr as gsl_sf_result ptr, byval theta as gsl_sf_result ptr) as integer
declare function gsl_sf_log_1plusx_e (byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_log_1plusx (byval x as double) as double
declare function gsl_sf_log_1plusx_mx_e (byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_log_1plusx_mx (byval x as double) as double
end extern

#endif
