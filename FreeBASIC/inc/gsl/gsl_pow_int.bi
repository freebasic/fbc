''
''
'' gsl_pow_int -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_pow_int_bi__
#define __gsl_pow_int_bi__

#include once "gsl/gsl_types.bi"

declare function gsl_pow_2 cdecl alias "gsl_pow_2" (byval x as double) as double
declare function gsl_pow_3 cdecl alias "gsl_pow_3" (byval x as double) as double
declare function gsl_pow_4 cdecl alias "gsl_pow_4" (byval x as double) as double
declare function gsl_pow_5 cdecl alias "gsl_pow_5" (byval x as double) as double
declare function gsl_pow_6 cdecl alias "gsl_pow_6" (byval x as double) as double
declare function gsl_pow_7 cdecl alias "gsl_pow_7" (byval x as double) as double
declare function gsl_pow_8 cdecl alias "gsl_pow_8" (byval x as double) as double
declare function gsl_pow_9 cdecl alias "gsl_pow_9" (byval x as double) as double
declare function gsl_pow_int cdecl alias "gsl_pow_int" (byval x as double, byval n as integer) as double

#endif
