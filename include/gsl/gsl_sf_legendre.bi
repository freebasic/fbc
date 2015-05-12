''
''
'' gsl_sf_legendre -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_sf_legendre_bi__
#define __gsl_sf_legendre_bi__

#include once "gsl_sf_result.bi"
#include once "gsl_types.bi"

extern "c"
declare function gsl_sf_legendre_Pl_e (byval l as integer, byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_legendre_Pl (byval l as integer, byval x as double) as double
declare function gsl_sf_legendre_Pl_array (byval lmax as integer, byval x as double, byval result_array as double ptr) as integer
declare function gsl_sf_legendre_Pl_deriv_array (byval lmax as integer, byval x as double, byval result_array as double ptr, byval result_deriv_array as double ptr) as integer
declare function gsl_sf_legendre_P1_e (byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_legendre_P2_e (byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_legendre_P3_e (byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_legendre_P1 (byval x as double) as double
declare function gsl_sf_legendre_P2 (byval x as double) as double
declare function gsl_sf_legendre_P3 (byval x as double) as double
declare function gsl_sf_legendre_Q0_e (byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_legendre_Q0 (byval x as double) as double
declare function gsl_sf_legendre_Q1_e (byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_legendre_Q1 (byval x as double) as double
declare function gsl_sf_legendre_Ql_e (byval l as integer, byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_legendre_Ql (byval l as integer, byval x as double) as double
declare function gsl_sf_legendre_Plm_e (byval l as integer, byval m as integer, byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_legendre_Plm (byval l as integer, byval m as integer, byval x as double) as double
declare function gsl_sf_legendre_Plm_array (byval lmax as integer, byval m as integer, byval x as double, byval result_array as double ptr) as integer
declare function gsl_sf_legendre_Plm_deriv_array (byval lmax as integer, byval m as integer, byval x as double, byval result_array as double ptr, byval result_deriv_array as double ptr) as integer
declare function gsl_sf_legendre_sphPlm_e (byval l as integer, byval m as integer, byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_legendre_sphPlm (byval l as integer, byval m as integer, byval x as double) as double
declare function gsl_sf_legendre_sphPlm_array (byval lmax as integer, byval m as integer, byval x as double, byval result_array as double ptr) as integer
declare function gsl_sf_legendre_sphPlm_deriv_array (byval lmax as integer, byval m as integer, byval x as double, byval result_array as double ptr, byval result_deriv_array as double ptr) as integer
declare function gsl_sf_legendre_array_size (byval lmax as integer, byval m as integer) as integer
declare function gsl_sf_conicalP_half_e (byval lambda as double, byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_conicalP_half (byval lambda as double, byval x as double) as double
declare function gsl_sf_conicalP_mhalf_e (byval lambda as double, byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_conicalP_mhalf (byval lambda as double, byval x as double) as double
declare function gsl_sf_conicalP_0_e (byval lambda as double, byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_conicalP_0 (byval lambda as double, byval x as double) as double
declare function gsl_sf_conicalP_1_e (byval lambda as double, byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_conicalP_1 (byval lambda as double, byval x as double) as double
declare function gsl_sf_conicalP_sph_reg_e (byval l as integer, byval lambda as double, byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_conicalP_sph_reg (byval l as integer, byval lambda as double, byval x as double) as double
declare function gsl_sf_conicalP_cyl_reg_e (byval m as integer, byval lambda as double, byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_conicalP_cyl_reg (byval m as integer, byval lambda as double, byval x as double) as double
declare function gsl_sf_legendre_H3d_0_e (byval lambda as double, byval eta as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_legendre_H3d_0 (byval lambda as double, byval eta as double) as double
declare function gsl_sf_legendre_H3d_1_e (byval lambda as double, byval eta as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_legendre_H3d_1 (byval lambda as double, byval eta as double) as double
declare function gsl_sf_legendre_H3d_e (byval l as integer, byval lambda as double, byval eta as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_legendre_H3d (byval l as integer, byval lambda as double, byval eta as double) as double
declare function gsl_sf_legendre_H3d_array (byval lmax as integer, byval lambda as double, byval eta as double, byval result_array as double ptr) as integer
end extern

#endif
