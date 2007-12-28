''
''
'' gsl_sf_hyperg -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_sf_hyperg_bi__
#define __gsl_sf_hyperg_bi__

#include once "gsl_sf_result.bi"
#include once "gsl_types.bi"

extern "c"
declare function gsl_sf_hyperg_0F1_e (byval c as double, byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_hyperg_0F1 (byval c as double, byval x as double) as double
declare function gsl_sf_hyperg_1F1_int_e (byval m as integer, byval n as integer, byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_hyperg_1F1_int (byval m as integer, byval n as integer, byval x as double) as double
declare function gsl_sf_hyperg_1F1_e (byval a as double, byval b as double, byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_hyperg_1F1 (byval a as double, byval b as double, byval x as double) as double
declare function gsl_sf_hyperg_U_int_e (byval m as integer, byval n as integer, byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_hyperg_U_int (byval m as integer, byval n as integer, byval x as double) as double
declare function gsl_sf_hyperg_U_int_e10_e (byval m as integer, byval n as integer, byval x as double, byval result as gsl_sf_result_e10 ptr) as integer
declare function gsl_sf_hyperg_U_e (byval a as double, byval b as double, byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_hyperg_U (byval a as double, byval b as double, byval x as double) as double
declare function gsl_sf_hyperg_U_e10_e (byval a as double, byval b as double, byval x as double, byval result as gsl_sf_result_e10 ptr) as integer
declare function gsl_sf_hyperg_2F1_e (byval a as double, byval b as double, byval c as double, byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_hyperg_2F1 (byval a as double, byval b as double, byval c as double, byval x as double) as double
declare function gsl_sf_hyperg_2F1_conj_e (byval aR as double, byval aI as double, byval c as double, byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_hyperg_2F1_conj (byval aR as double, byval aI as double, byval c as double, byval x as double) as double
declare function gsl_sf_hyperg_2F1_renorm_e (byval a as double, byval b as double, byval c as double, byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_hyperg_2F1_renorm (byval a as double, byval b as double, byval c as double, byval x as double) as double
declare function gsl_sf_hyperg_2F1_conj_renorm_e (byval aR as double, byval aI as double, byval c as double, byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_hyperg_2F1_conj_renorm (byval aR as double, byval aI as double, byval c as double, byval x as double) as double
declare function gsl_sf_hyperg_2F0_e (byval a as double, byval b as double, byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_hyperg_2F0 (byval a as double, byval b as double, byval x as double) as double
end extern

#endif
