''
''
'' gsl_sf_trig -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_sf_trig_bi__
#define __gsl_sf_trig_bi__

#include once "gsl_sf_result.bi"
#include once "gsl_types.bi"

extern "c"
declare function gsl_sf_sin_e (byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_sin (byval x as double) as double
declare function gsl_sf_cos_e (byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_cos (byval x as double) as double
declare function gsl_sf_hypot_e (byval x as double, byval y as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_hypot (byval x as double, byval y as double) as double
declare function gsl_sf_complex_sin_e (byval zr as double, byval zi as double, byval szr as gsl_sf_result ptr, byval szi as gsl_sf_result ptr) as integer
declare function gsl_sf_complex_cos_e (byval zr as double, byval zi as double, byval czr as gsl_sf_result ptr, byval czi as gsl_sf_result ptr) as integer
declare function gsl_sf_complex_logsin_e (byval zr as double, byval zi as double, byval lszr as gsl_sf_result ptr, byval lszi as gsl_sf_result ptr) as integer
declare function gsl_sf_sinc_e (byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_sinc (byval x as double) as double
declare function gsl_sf_lnsinh_e (byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_lnsinh (byval x as double) as double
declare function gsl_sf_lncosh_e (byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_lncosh (byval x as double) as double
declare function gsl_sf_polar_to_rect (byval r as double, byval theta as double, byval x as gsl_sf_result ptr, byval y as gsl_sf_result ptr) as integer
declare function gsl_sf_rect_to_polar (byval x as double, byval y as double, byval r as gsl_sf_result ptr, byval theta as gsl_sf_result ptr) as integer
declare function gsl_sf_sin_err_e (byval x as double, byval dx as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_cos_err_e (byval x as double, byval dx as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_angle_restrict_symm_e (byval theta as double ptr) as integer
declare function gsl_sf_angle_restrict_symm (byval theta as double) as double
declare function gsl_sf_angle_restrict_pos_e (byval theta as double ptr) as integer
declare function gsl_sf_angle_restrict_pos (byval theta as double) as double
declare function gsl_sf_angle_restrict_symm_err_e (byval theta as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_angle_restrict_pos_err_e (byval theta as double, byval result as gsl_sf_result ptr) as integer
end extern

#endif
