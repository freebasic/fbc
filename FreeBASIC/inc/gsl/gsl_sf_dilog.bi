''
''
'' gsl_sf_dilog -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_sf_dilog_bi__
#define __gsl_sf_dilog_bi__

#include once "gsl/gsl_sf_result.bi"
#include once "gsl/gsl_types.bi"

declare function gsl_sf_dilog_e cdecl alias "gsl_sf_dilog_e" (byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_dilog cdecl alias "gsl_sf_dilog" (byval x as double) as double
declare function gsl_sf_complex_dilog_xy_e cdecl alias "gsl_sf_complex_dilog_xy_e" (byval x as double, byval y as double, byval result_re as gsl_sf_result ptr, byval result_im as gsl_sf_result ptr) as integer
declare function gsl_sf_complex_dilog_e cdecl alias "gsl_sf_complex_dilog_e" (byval r as double, byval theta as double, byval result_re as gsl_sf_result ptr, byval result_im as gsl_sf_result ptr) as integer
declare function gsl_sf_complex_spence_xy_e cdecl alias "gsl_sf_complex_spence_xy_e" (byval x as double, byval y as double, byval real_sp as gsl_sf_result ptr, byval imag_sp as gsl_sf_result ptr) as integer

#endif
