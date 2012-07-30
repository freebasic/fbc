''
''
'' gsl_sf_gamma -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_sf_gamma_bi__
#define __gsl_sf_gamma_bi__

#include once "gsl_sf_result.bi"
#include once "gsl_types.bi"

extern "c"
declare function gsl_sf_lngamma_e (byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_lngamma (byval x as double) as double
declare function gsl_sf_lngamma_sgn_e (byval x as double, byval result_lg as gsl_sf_result ptr, byval sgn as double ptr) as integer
declare function gsl_sf_gamma_e (byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_gamma (byval x as double) as double
declare function gsl_sf_gammastar_e (byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_gammastar (byval x as double) as double
declare function gsl_sf_gammainv_e (byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_gammainv (byval x as double) as double
declare function gsl_sf_lngamma_complex_e (byval zr as double, byval zi as double, byval lnr as gsl_sf_result ptr, byval arg as gsl_sf_result ptr) as integer
declare function gsl_sf_taylorcoeff_e (byval n as integer, byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_taylorcoeff (byval n as integer, byval x as double) as double
declare function gsl_sf_fact_e (byval n as uinteger, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_fact (byval n as uinteger) as double
declare function gsl_sf_doublefact_e (byval n as uinteger, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_doublefact (byval n as uinteger) as double
declare function gsl_sf_lnfact_e (byval n as uinteger, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_lnfact (byval n as uinteger) as double
declare function gsl_sf_lndoublefact_e (byval n as uinteger, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_lndoublefact (byval n as uinteger) as double
declare function gsl_sf_lnchoose_e (byval n as uinteger, byval m as uinteger, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_lnchoose (byval n as uinteger, byval m as uinteger) as double
declare function gsl_sf_choose_e (byval n as uinteger, byval m as uinteger, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_choose (byval n as uinteger, byval m as uinteger) as double
declare function gsl_sf_lnpoch_e (byval a as double, byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_lnpoch (byval a as double, byval x as double) as double
declare function gsl_sf_lnpoch_sgn_e (byval a as double, byval x as double, byval result as gsl_sf_result ptr, byval sgn as double ptr) as integer
declare function gsl_sf_poch_e (byval a as double, byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_poch (byval a as double, byval x as double) as double
declare function gsl_sf_pochrel_e (byval a as double, byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_pochrel (byval a as double, byval x as double) as double
declare function gsl_sf_gamma_inc_Q_e (byval a as double, byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_gamma_inc_Q (byval a as double, byval x as double) as double
declare function gsl_sf_gamma_inc_P_e (byval a as double, byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_gamma_inc_P (byval a as double, byval x as double) as double
declare function gsl_sf_gamma_inc_e (byval a as double, byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_gamma_inc (byval a as double, byval x as double) as double
declare function gsl_sf_lnbeta_e (byval a as double, byval b as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_lnbeta (byval a as double, byval b as double) as double
declare function gsl_sf_beta_e (byval a as double, byval b as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_beta (byval a as double, byval b as double) as double
declare function gsl_sf_beta_inc_e (byval a as double, byval b as double, byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_beta_inc (byval a as double, byval b as double, byval x as double) as double
end extern

#define GSL_SF_GAMMA_XMAX 171.0

#endif
