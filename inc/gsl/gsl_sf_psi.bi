''
''
'' gsl_sf_psi -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_sf_psi_bi__
#define __gsl_sf_psi_bi__

#include once "gsl_sf_result.bi"
#include once "gsl_types.bi"

extern "c"
declare function gsl_sf_psi_int_e (byval n as integer, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_psi_int (byval n as integer) as double
declare function gsl_sf_psi_e (byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_psi (byval x as double) as double
declare function gsl_sf_psi_1piy_e (byval y as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_psi_1piy (byval y as double) as double
declare function gsl_sf_psi_1_int_e (byval n as integer, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_psi_1_int (byval n as integer) as double
declare function gsl_sf_psi_1_e (byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_psi_1 (byval x as double) as double
declare function gsl_sf_psi_n_e (byval n as integer, byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_psi_n (byval n as integer, byval x as double) as double
end extern

#endif
