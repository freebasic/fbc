''
''
'' gsl_sf_synchrotron -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_sf_synchrotron_bi__
#define __gsl_sf_synchrotron_bi__

#include once "gsl/gsl_sf_result.bi"
#include once "gsl/gsl_types.bi"

declare function gsl_sf_synchrotron_1_e cdecl alias "gsl_sf_synchrotron_1_e" (byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_synchrotron_1 cdecl alias "gsl_sf_synchrotron_1" (byval x as double) as double
declare function gsl_sf_synchrotron_2_e cdecl alias "gsl_sf_synchrotron_2_e" (byval x as double, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_synchrotron_2 cdecl alias "gsl_sf_synchrotron_2" (byval x as double) as double

#endif
