''
''
'' gsl_sf_ellint -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_sf_ellint_bi__
#define __gsl_sf_ellint_bi__

#include once "gsl/gsl_mode.bi"
#include once "gsl/gsl_sf_result.bi"
#include once "gsl/gsl_types.bi"

declare function gsl_sf_ellint_Kcomp_e cdecl alias "gsl_sf_ellint_Kcomp_e" (byval k as double, byval mode as gsl_mode_t, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_ellint_Kcomp cdecl alias "gsl_sf_ellint_Kcomp" (byval k as double, byval mode as gsl_mode_t) as double
declare function gsl_sf_ellint_Ecomp_e cdecl alias "gsl_sf_ellint_Ecomp_e" (byval k as double, byval mode as gsl_mode_t, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_ellint_Ecomp cdecl alias "gsl_sf_ellint_Ecomp" (byval k as double, byval mode as gsl_mode_t) as double
declare function gsl_sf_ellint_F_e cdecl alias "gsl_sf_ellint_F_e" (byval phi as double, byval k as double, byval mode as gsl_mode_t, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_ellint_F cdecl alias "gsl_sf_ellint_F" (byval phi as double, byval k as double, byval mode as gsl_mode_t) as double
declare function gsl_sf_ellint_E_e cdecl alias "gsl_sf_ellint_E_e" (byval phi as double, byval k as double, byval mode as gsl_mode_t, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_ellint_E cdecl alias "gsl_sf_ellint_E" (byval phi as double, byval k as double, byval mode as gsl_mode_t) as double
declare function gsl_sf_ellint_P_e cdecl alias "gsl_sf_ellint_P_e" (byval phi as double, byval k as double, byval n as double, byval mode as gsl_mode_t, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_ellint_P cdecl alias "gsl_sf_ellint_P" (byval phi as double, byval k as double, byval n as double, byval mode as gsl_mode_t) as double
declare function gsl_sf_ellint_D_e cdecl alias "gsl_sf_ellint_D_e" (byval phi as double, byval k as double, byval n as double, byval mode as gsl_mode_t, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_ellint_D cdecl alias "gsl_sf_ellint_D" (byval phi as double, byval k as double, byval n as double, byval mode as gsl_mode_t) as double
declare function gsl_sf_ellint_RC_e cdecl alias "gsl_sf_ellint_RC_e" (byval x as double, byval y as double, byval mode as gsl_mode_t, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_ellint_RC cdecl alias "gsl_sf_ellint_RC" (byval x as double, byval y as double, byval mode as gsl_mode_t) as double
declare function gsl_sf_ellint_RD_e cdecl alias "gsl_sf_ellint_RD_e" (byval x as double, byval y as double, byval z as double, byval mode as gsl_mode_t, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_ellint_RD cdecl alias "gsl_sf_ellint_RD" (byval x as double, byval y as double, byval z as double, byval mode as gsl_mode_t) as double
declare function gsl_sf_ellint_RF_e cdecl alias "gsl_sf_ellint_RF_e" (byval x as double, byval y as double, byval z as double, byval mode as gsl_mode_t, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_ellint_RF cdecl alias "gsl_sf_ellint_RF" (byval x as double, byval y as double, byval z as double, byval mode as gsl_mode_t) as double
declare function gsl_sf_ellint_RJ_e cdecl alias "gsl_sf_ellint_RJ_e" (byval x as double, byval y as double, byval z as double, byval p as double, byval mode as gsl_mode_t, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_ellint_RJ cdecl alias "gsl_sf_ellint_RJ" (byval x as double, byval y as double, byval z as double, byval p as double, byval mode as gsl_mode_t) as double

#endif
