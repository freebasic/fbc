''
''
'' gsl_sf_bessel -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_sf_bessel_bi__
#define __gsl_sf_bessel_bi__

#include once "gsl/gsl_mode.bi"
#include once "gsl/gsl_precision.bi"
#include once "gsl/gsl_sf_result.bi"
#include once "gsl/gsl_types.bi"

declare function gsl_sf_bessel_J0_e cdecl alias "gsl_sf_bessel_J0_e" (byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_bessel_J0 cdecl alias "gsl_sf_bessel_J0" (byval x as double) as double
declare function gsl_sf_bessel_J1_e cdecl alias "gsl_sf_bessel_J1_e" (byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_bessel_J1 cdecl alias "gsl_sf_bessel_J1" (byval x as double) as double
declare function gsl_sf_bessel_Jn_e cdecl alias "gsl_sf_bessel_Jn_e" (byval n as integer, byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_bessel_Jn cdecl alias "gsl_sf_bessel_Jn" (byval n as integer, byval x as double) as double
declare function gsl_sf_bessel_Jn_array cdecl alias "gsl_sf_bessel_Jn_array" (byval nmin as integer, byval nmax as integer, byval x as double, byval result_array as double ptr) as integer
declare function gsl_sf_bessel_Y0_e cdecl alias "gsl_sf_bessel_Y0_e" (byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_bessel_Y0 cdecl alias "gsl_sf_bessel_Y0" (byval x as double) as double
declare function gsl_sf_bessel_Y1_e cdecl alias "gsl_sf_bessel_Y1_e" (byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_bessel_Y1 cdecl alias "gsl_sf_bessel_Y1" (byval x as double) as double
declare function gsl_sf_bessel_Yn_e cdecl alias "gsl_sf_bessel_Yn_e" (byval n as integer, byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_bessel_Yn cdecl alias "gsl_sf_bessel_Yn" (byval n as integer, byval x as double) as double
declare function gsl_sf_bessel_Yn_array cdecl alias "gsl_sf_bessel_Yn_array" (byval nmin as integer, byval nmax as integer, byval x as double, byval result_array as double ptr) as integer
declare function gsl_sf_bessel_I0_e cdecl alias "gsl_sf_bessel_I0_e" (byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_bessel_I0 cdecl alias "gsl_sf_bessel_I0" (byval x as double) as double
declare function gsl_sf_bessel_I1_e cdecl alias "gsl_sf_bessel_I1_e" (byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_bessel_I1 cdecl alias "gsl_sf_bessel_I1" (byval x as double) as double
declare function gsl_sf_bessel_In_e cdecl alias "gsl_sf_bessel_In_e" (byval n as integer, byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_bessel_In cdecl alias "gsl_sf_bessel_In" (byval n as integer, byval x as double) as double
declare function gsl_sf_bessel_In_array cdecl alias "gsl_sf_bessel_In_array" (byval nmin as integer, byval nmax as integer, byval x as double, byval result_array as double ptr) as integer
declare function gsl_sf_bessel_I0_scaled_e cdecl alias "gsl_sf_bessel_I0_scaled_e" (byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_bessel_I0_scaled cdecl alias "gsl_sf_bessel_I0_scaled" (byval x as double) as double
declare function gsl_sf_bessel_I1_scaled_e cdecl alias "gsl_sf_bessel_I1_scaled_e" (byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_bessel_I1_scaled cdecl alias "gsl_sf_bessel_I1_scaled" (byval x as double) as double
declare function gsl_sf_bessel_In_scaled_e cdecl alias "gsl_sf_bessel_In_scaled_e" (byval n as integer, byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_bessel_In_scaled cdecl alias "gsl_sf_bessel_In_scaled" (byval n as integer, byval x as double) as double
declare function gsl_sf_bessel_In_scaled_array cdecl alias "gsl_sf_bessel_In_scaled_array" (byval nmin as integer, byval nmax as integer, byval x as double, byval result_array as double ptr) as integer
declare function gsl_sf_bessel_K0_e cdecl alias "gsl_sf_bessel_K0_e" (byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_bessel_K0 cdecl alias "gsl_sf_bessel_K0" (byval x as double) as double
declare function gsl_sf_bessel_K1_e cdecl alias "gsl_sf_bessel_K1_e" (byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_bessel_K1 cdecl alias "gsl_sf_bessel_K1" (byval x as double) as double
declare function gsl_sf_bessel_Kn_e cdecl alias "gsl_sf_bessel_Kn_e" (byval n as integer, byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_bessel_Kn cdecl alias "gsl_sf_bessel_Kn" (byval n as integer, byval x as double) as double
declare function gsl_sf_bessel_Kn_array cdecl alias "gsl_sf_bessel_Kn_array" (byval nmin as integer, byval nmax as integer, byval x as double, byval result_array as double ptr) as integer
declare function gsl_sf_bessel_K0_scaled_e cdecl alias "gsl_sf_bessel_K0_scaled_e" (byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_bessel_K0_scaled cdecl alias "gsl_sf_bessel_K0_scaled" (byval x as double) as double
declare function gsl_sf_bessel_K1_scaled_e cdecl alias "gsl_sf_bessel_K1_scaled_e" (byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_bessel_K1_scaled cdecl alias "gsl_sf_bessel_K1_scaled" (byval x as double) as double
declare function gsl_sf_bessel_Kn_scaled_e cdecl alias "gsl_sf_bessel_Kn_scaled_e" (byval n as integer, byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_bessel_Kn_scaled cdecl alias "gsl_sf_bessel_Kn_scaled" (byval n as integer, byval x as double) as double
declare function gsl_sf_bessel_Kn_scaled_array cdecl alias "gsl_sf_bessel_Kn_scaled_array" (byval nmin as integer, byval nmax as integer, byval x as double, byval result_array as double ptr) as integer
declare function gsl_sf_bessel_j0_e_ cdecl alias "gsl_sf_bessel_j0_e" (byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_bessel_j0_ cdecl alias "gsl_sf_bessel_j0" (byval x as double) as double
declare function gsl_sf_bessel_j1_e_ cdecl alias "gsl_sf_bessel_j1_e" (byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_bessel_j1_ cdecl alias "gsl_sf_bessel_j1" (byval x as double) as double
declare function gsl_sf_bessel_j2_e cdecl alias "gsl_sf_bessel_j2_e" (byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_bessel_j2 cdecl alias "gsl_sf_bessel_j2" (byval x as double) as double
declare function gsl_sf_bessel_jl_e cdecl alias "gsl_sf_bessel_jl_e" (byval l as integer, byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_bessel_jl cdecl alias "gsl_sf_bessel_jl" (byval l as integer, byval x as double) as double
declare function gsl_sf_bessel_jl_array cdecl alias "gsl_sf_bessel_jl_array" (byval lmax as integer, byval x as double, byval result_array as double ptr) as integer
declare function gsl_sf_bessel_jl_steed_array cdecl alias "gsl_sf_bessel_jl_steed_array" (byval lmax as integer, byval x as double, byval jl_x_array as double ptr) as integer
declare function gsl_sf_bessel_y0_e_ cdecl alias "gsl_sf_bessel_y0_e" (byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_bessel_y0_ cdecl alias "gsl_sf_bessel_y0" (byval x as double) as double
declare function gsl_sf_bessel_y1_e_ cdecl alias "gsl_sf_bessel_y1_e" (byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_bessel_y1_ cdecl alias "gsl_sf_bessel_y1" (byval x as double) as double
declare function gsl_sf_bessel_y2_e cdecl alias "gsl_sf_bessel_y2_e" (byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_bessel_y2 cdecl alias "gsl_sf_bessel_y2" (byval x as double) as double
declare function gsl_sf_bessel_yl_e cdecl alias "gsl_sf_bessel_yl_e" (byval l as integer, byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_bessel_yl cdecl alias "gsl_sf_bessel_yl" (byval l as integer, byval x as double) as double
declare function gsl_sf_bessel_yl_array cdecl alias "gsl_sf_bessel_yl_array" (byval lmax as integer, byval x as double, byval result_array as double ptr) as integer
declare function gsl_sf_bessel_i0_scaled_e_ cdecl alias "gsl_sf_bessel_i0_scaled_e" (byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_bessel_i0_scaled_ cdecl alias "gsl_sf_bessel_i0_scaled" (byval x as double) as double
declare function gsl_sf_bessel_i1_scaled_e_ cdecl alias "gsl_sf_bessel_i1_scaled_e" (byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_bessel_i1_scaled_ cdecl alias "gsl_sf_bessel_i1_scaled" (byval x as double) as double
declare function gsl_sf_bessel_i2_scaled_e cdecl alias "gsl_sf_bessel_i2_scaled_e" (byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_bessel_i2_scaled cdecl alias "gsl_sf_bessel_i2_scaled" (byval x as double) as double
declare function gsl_sf_bessel_il_scaled_e cdecl alias "gsl_sf_bessel_il_scaled_e" (byval l as integer, byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_bessel_il_scaled cdecl alias "gsl_sf_bessel_il_scaled" (byval l as integer, byval x as double) as double
declare function gsl_sf_bessel_il_scaled_array cdecl alias "gsl_sf_bessel_il_scaled_array" (byval lmax as integer, byval x as double, byval result_array as double ptr) as integer
declare function gsl_sf_bessel_k0_scaled_e_ cdecl alias "gsl_sf_bessel_k0_scaled_e" (byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_bessel_k0_scaled_ cdecl alias "gsl_sf_bessel_k0_scaled" (byval x as double) as double
declare function gsl_sf_bessel_k1_scaled_e_ cdecl alias "gsl_sf_bessel_k1_scaled_e" (byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_bessel_k1_scaled_ cdecl alias "gsl_sf_bessel_k1_scaled" (byval x as double) as double
declare function gsl_sf_bessel_k2_scaled_e cdecl alias "gsl_sf_bessel_k2_scaled_e" (byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_bessel_k2_scaled cdecl alias "gsl_sf_bessel_k2_scaled" (byval x as double) as double
declare function gsl_sf_bessel_kl_scaled_e cdecl alias "gsl_sf_bessel_kl_scaled_e" (byval l as integer, byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_bessel_kl_scaled cdecl alias "gsl_sf_bessel_kl_scaled" (byval l as integer, byval x as double) as double
declare function gsl_sf_bessel_kl_scaled_array cdecl alias "gsl_sf_bessel_kl_scaled_array" (byval lmax as integer, byval x as double, byval result_array as double ptr) as integer
declare function gsl_sf_bessel_Jnu_e cdecl alias "gsl_sf_bessel_Jnu_e" (byval nu as double, byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_bessel_Jnu cdecl alias "gsl_sf_bessel_Jnu" (byval nu as double, byval x as double) as double
declare function gsl_sf_bessel_Ynu_e cdecl alias "gsl_sf_bessel_Ynu_e" (byval nu as double, byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_bessel_Ynu cdecl alias "gsl_sf_bessel_Ynu" (byval nu as double, byval x as double) as double
declare function gsl_sf_bessel_sequence_Jnu_e cdecl alias "gsl_sf_bessel_sequence_Jnu_e" (byval nu as double, byval mode as gsl_mode_t, byval size as integer, byval v as double ptr) as integer
declare function gsl_sf_bessel_Inu_scaled_e cdecl alias "gsl_sf_bessel_Inu_scaled_e" (byval nu as double, byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_bessel_Inu_scaled cdecl alias "gsl_sf_bessel_Inu_scaled" (byval nu as double, byval x as double) as double
declare function gsl_sf_bessel_Inu_e cdecl alias "gsl_sf_bessel_Inu_e" (byval nu as double, byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_bessel_Inu cdecl alias "gsl_sf_bessel_Inu" (byval nu as double, byval x as double) as double
declare function gsl_sf_bessel_Knu_scaled_e cdecl alias "gsl_sf_bessel_Knu_scaled_e" (byval nu as double, byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_bessel_Knu_scaled cdecl alias "gsl_sf_bessel_Knu_scaled" (byval nu as double, byval x as double) as double
declare function gsl_sf_bessel_Knu_e cdecl alias "gsl_sf_bessel_Knu_e" (byval nu as double, byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_bessel_Knu cdecl alias "gsl_sf_bessel_Knu" (byval nu as double, byval x as double) as double
declare function gsl_sf_bessel_lnKnu_e cdecl alias "gsl_sf_bessel_lnKnu_e" (byval nu as double, byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_bessel_lnKnu cdecl alias "gsl_sf_bessel_lnKnu" (byval nu as double, byval x as double) as double
declare function gsl_sf_bessel_zero_J0_e cdecl alias "gsl_sf_bessel_zero_J0_e" (byval s as uinteger, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_bessel_zero_J0 cdecl alias "gsl_sf_bessel_zero_J0" (byval s as uinteger) as double
declare function gsl_sf_bessel_zero_J1_e cdecl alias "gsl_sf_bessel_zero_J1_e" (byval s as uinteger, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_bessel_zero_J1 cdecl alias "gsl_sf_bessel_zero_J1" (byval s as uinteger) as double
declare function gsl_sf_bessel_zero_Jnu_e cdecl alias "gsl_sf_bessel_zero_Jnu_e" (byval nu as double, byval s as uinteger, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_bessel_zero_Jnu cdecl alias "gsl_sf_bessel_zero_Jnu" (byval nu as double, byval s as uinteger) as double

#endif
