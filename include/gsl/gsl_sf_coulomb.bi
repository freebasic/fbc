''
''
'' gsl_sf_coulomb -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_sf_coulomb_bi__
#define __gsl_sf_coulomb_bi__

#include once "gsl_mode.bi"
#include once "gsl_sf_result.bi"
#include once "gsl_types.bi"

extern "c"
declare function gsl_sf_hydrogenicR_1_e (byval Z as double, byval r as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_hydrogenicR_1 (byval Z as double, byval r as double) as double
declare function gsl_sf_hydrogenicR_e (byval n as integer, byval l as integer, byval Z as double, byval r as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_hydrogenicR (byval n as integer, byval l as integer, byval Z as double, byval r as double) as double
declare function gsl_sf_coulomb_wave_FG_e (byval eta as double, byval x as double, byval lam_F as double, byval k_lam_G as integer, byval F as gsl_sf_result ptr, byval Fp as gsl_sf_result ptr, byval G as gsl_sf_result ptr, byval Gp as gsl_sf_result ptr, byval exp_F as double ptr, byval exp_G as double ptr) as integer
declare function gsl_sf_coulomb_wave_F_array (byval lam_min as double, byval kmax as integer, byval eta as double, byval x as double, byval fc_array as double ptr, byval F_exponent as double ptr) as integer
declare function gsl_sf_coulomb_wave_FG_array (byval lam_min as double, byval kmax as integer, byval eta as double, byval x as double, byval fc_array as double ptr, byval gc_array as double ptr, byval F_exponent as double ptr, byval G_exponent as double ptr) as integer
declare function gsl_sf_coulomb_wave_FGp_array (byval lam_min as double, byval kmax as integer, byval eta as double, byval x as double, byval fc_array as double ptr, byval fcp_array as double ptr, byval gc_array as double ptr, byval gcp_array as double ptr, byval F_exponent as double ptr, byval G_exponent as double ptr) as integer
declare function gsl_sf_coulomb_wave_sphF_array (byval lam_min as double, byval kmax as integer, byval eta as double, byval x as double, byval fc_array as double ptr, byval F_exponent as double ptr) as integer
declare function gsl_sf_coulomb_CL_e (byval L as double, byval eta as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_coulomb_CL_array (byval Lmin as double, byval kmax as integer, byval eta as double, byval cl as double ptr) as integer
end extern

#endif
