''
''
'' gsl_sf_elljac -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_sf_elljac_bi__
#define __gsl_sf_elljac_bi__

#include once "gsl_types.bi"

extern "c"
 declare function gsl_sf_elljac_e (byval u as double, byval m as double, byval sn as double ptr, byval cn as double ptr, byval dn as double ptr) as integer
end extern

#endif
