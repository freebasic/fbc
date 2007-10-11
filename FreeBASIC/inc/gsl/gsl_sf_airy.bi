''
''
'' gsl_sf_airy -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_sf_airy_bi__
#define __gsl_sf_airy_bi__

#include once "gsl_mode.bi"
#include once "gsl_sf_result.bi"
#include once "gsl_types.bi"

extern "c"
declare function gsl_sf_airy_Ai_e (byval x as double, byval mode as gsl_mode_t, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_airy_Ai (byval x as double, byval mode as gsl_mode_t) as double
declare function gsl_sf_airy_Bi_e (byval x as double, byval mode as gsl_mode_t, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_airy_Bi (byval x as double, byval mode as gsl_mode_t) as double
declare function gsl_sf_airy_Ai_scaled_e (byval x as double, byval mode as gsl_mode_t, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_airy_Ai_scaled (byval x as double, byval mode as gsl_mode_t) as double
declare function gsl_sf_airy_Bi_scaled_e (byval x as double, byval mode as gsl_mode_t, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_airy_Bi_scaled (byval x as double, byval mode as gsl_mode_t) as double
declare function gsl_sf_airy_Ai_deriv_e (byval x as double, byval mode as gsl_mode_t, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_airy_Ai_deriv (byval x as double, byval mode as gsl_mode_t) as double
declare function gsl_sf_airy_Bi_deriv_e (byval x as double, byval mode as gsl_mode_t, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_airy_Bi_deriv (byval x as double, byval mode as gsl_mode_t) as double
declare function gsl_sf_airy_Ai_deriv_scaled_e (byval x as double, byval mode as gsl_mode_t, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_airy_Ai_deriv_scaled (byval x as double, byval mode as gsl_mode_t) as double
declare function gsl_sf_airy_Bi_deriv_scaled_e (byval x as double, byval mode as gsl_mode_t, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_airy_Bi_deriv_scaled (byval x as double, byval mode as gsl_mode_t) as double
declare function gsl_sf_airy_zero_Ai_e (byval s as uinteger, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_airy_zero_Ai (byval s as uinteger) as double
declare function gsl_sf_airy_zero_Bi_e (byval s as uinteger, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_airy_zero_Bi (byval s as uinteger) as double
declare function gsl_sf_airy_zero_Ai_deriv_e (byval s as uinteger, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_airy_zero_Ai_deriv (byval s as uinteger) as double
declare function gsl_sf_airy_zero_Bi_deriv_e (byval s as uinteger, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_airy_zero_Bi_deriv (byval s as uinteger) as double
end extern

#endif
