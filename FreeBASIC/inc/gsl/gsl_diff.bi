''
''
'' gsl_diff -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_diff_bi__
#define __gsl_diff_bi__

#include once "gsl/gsl_math.bi"
#include once "gsl/gsl_types.bi"

declare function gsl_diff_central cdecl alias "gsl_diff_central" (byval f as gsl_function ptr, byval x as double, byval result as double ptr, byval abserr as double ptr) as integer
declare function gsl_diff_backward cdecl alias "gsl_diff_backward" (byval f as gsl_function ptr, byval x as double, byval result as double ptr, byval abserr as double ptr) as integer
declare function gsl_diff_forward cdecl alias "gsl_diff_forward" (byval f as gsl_function ptr, byval x as double, byval result as double ptr, byval abserr as double ptr) as integer

#endif
