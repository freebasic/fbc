''
''
'' gsl_sf_exp -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_sf_exp_bi__
#define __gsl_sf_exp_bi__

#include once "gsl/gsl_sf_result.bi"
#include once "gsl/gsl_precision.bi"
#include once "gsl/gsl_types.bi"

declare function gsl_sf_exp_e cdecl alias "gsl_sf_exp_e" (byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_exp cdecl alias "gsl_sf_exp" (byval x as double) as double
declare function gsl_sf_exp_e10_e cdecl alias "gsl_sf_exp_e10_e" (byval x as double, byval result as gsl_sf_result_e10 ptr) as integer
declare function gsl_sf_exp_mult_e cdecl alias "gsl_sf_exp_mult_e" (byval x as double, byval y as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_exp_mult cdecl alias "gsl_sf_exp_mult" (byval x as double, byval y as double) as double
declare function gsl_sf_exp_mult_e10_e cdecl alias "gsl_sf_exp_mult_e10_e" (byval x as double, byval y as double, byval result as gsl_sf_result_e10 ptr) as integer
declare function gsl_sf_expm1_e cdecl alias "gsl_sf_expm1_e" (byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_expm1 cdecl alias "gsl_sf_expm1" (byval x as double) as double
declare function gsl_sf_exprel_e cdecl alias "gsl_sf_exprel_e" (byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_exprel cdecl alias "gsl_sf_exprel" (byval x as double) as double
declare function gsl_sf_exprel_2_e cdecl alias "gsl_sf_exprel_2_e" (byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_exprel_2 cdecl alias "gsl_sf_exprel_2" (byval x as double) as double
declare function gsl_sf_exprel_n_e cdecl alias "gsl_sf_exprel_n_e" (byval n as integer, byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_exprel_n cdecl alias "gsl_sf_exprel_n" (byval n as integer, byval x as double) as double
declare function gsl_sf_exp_err_e cdecl alias "gsl_sf_exp_err_e" (byval x as double, byval dx as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_exp_err_e10_e cdecl alias "gsl_sf_exp_err_e10_e" (byval x as double, byval dx as double, byval result as gsl_sf_result_e10 ptr) as integer
declare function gsl_sf_exp_mult_err_e cdecl alias "gsl_sf_exp_mult_err_e" (byval x as double, byval dx as double, byval y as double, byval dy as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_exp_mult_err_e10_e cdecl alias "gsl_sf_exp_mult_err_e10_e" (byval x as double, byval dx as double, byval y as double, byval dy as double, byval result as gsl_sf_result_e10 ptr) as integer

#endif
