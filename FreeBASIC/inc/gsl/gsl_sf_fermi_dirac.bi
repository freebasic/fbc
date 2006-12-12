''
''
'' gsl_sf_fermi_dirac -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_sf_fermi_dirac_bi__
#define __gsl_sf_fermi_dirac_bi__

#include once "gsl_sf_result.bi"
#include once "gsl_types.bi"

extern "c"
declare function gsl_sf_fermi_dirac_m1_e (byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_fermi_dirac_m1 (byval x as double) as double
declare function gsl_sf_fermi_dirac_0_e (byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_fermi_dirac_0 (byval x as double) as double
declare function gsl_sf_fermi_dirac_1_e (byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_fermi_dirac_1 (byval x as double) as double
declare function gsl_sf_fermi_dirac_2_e (byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_fermi_dirac_2 (byval x as double) as double
declare function gsl_sf_fermi_dirac_int_e (byval j as integer, byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_fermi_dirac_int (byval j as integer, byval x as double) as double
declare function gsl_sf_fermi_dirac_mhalf_e (byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_fermi_dirac_mhalf (byval x as double) as double
declare function gsl_sf_fermi_dirac_half_e (byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_fermi_dirac_half (byval x as double) as double
declare function gsl_sf_fermi_dirac_3half_e (byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_fermi_dirac_3half (byval x as double) as double
declare function gsl_sf_fermi_dirac_inc_0_e (byval x as double, byval b as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_fermi_dirac_inc_0 (byval x as double, byval b as double) as double
end extern

#endif
