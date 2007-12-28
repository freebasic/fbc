''
''
'' gsl_sf_zeta -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_sf_zeta_bi__
#define __gsl_sf_zeta_bi__

#include once "gsl_sf_result.bi"
#include once "gsl_types.bi"

extern "c"
declare function gsl_sf_zeta_int_e (byval n as integer, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_zeta_int (byval n as integer) as double
declare function gsl_sf_zeta_e (byval s as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_zeta (byval s as double) as double
declare function gsl_sf_zetam1_e (byval s as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_zetam1 (byval s as double) as double
declare function gsl_sf_zetam1_int_e (byval s as integer, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_zetam1_int (byval s as integer) as double
declare function gsl_sf_hzeta_e (byval s as double, byval q as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_hzeta (byval s as double, byval q as double) as double
declare function gsl_sf_eta_int_e (byval n as integer, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_eta_int (byval n as integer) as double
declare function gsl_sf_eta_e (byval s as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_eta (byval s as double) as double
end extern

#endif
