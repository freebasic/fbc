''
''
'' gsl_sys -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_sys_bi__
#define __gsl_sys_bi__

#include once "gsl/gsl_types.bi"

declare function gsl_log1p cdecl alias "gsl_log1p" (byval x as double) as double
declare function gsl_expm1 cdecl alias "gsl_expm1" (byval x as double) as double
declare function gsl_hypot cdecl alias "gsl_hypot" (byval x as double, byval y as double) as double
declare function gsl_acosh cdecl alias "gsl_acosh" (byval x as double) as double
declare function gsl_asinh cdecl alias "gsl_asinh" (byval x as double) as double
declare function gsl_atanh cdecl alias "gsl_atanh" (byval x as double) as double
declare function gsl_isnan cdecl alias "gsl_isnan" (byval x as double) as integer
declare function gsl_isinf cdecl alias "gsl_isinf" (byval x as double) as integer
declare function gsl_finite cdecl alias "gsl_finite" (byval x as double) as integer
declare function gsl_nan cdecl alias "gsl_nan" () as double
declare function gsl_posinf cdecl alias "gsl_posinf" () as double
declare function gsl_neginf cdecl alias "gsl_neginf" () as double
declare function gsl_fdiv cdecl alias "gsl_fdiv" (byval x as double, byval y as double) as double
declare function gsl_coerce_double cdecl alias "gsl_coerce_double" (byval x as double) as double
declare function gsl_coerce_float cdecl alias "gsl_coerce_float" (byval x as single) as single
declare function gsl_coerce_long_double cdecl alias "gsl_coerce_long_double" (byval x as double) as double
declare function gsl_ldexp cdecl alias "gsl_ldexp" (byval x as double, byval e as integer) as double
declare function gsl_frexp cdecl alias "gsl_frexp" (byval x as double, byval e as integer ptr) as double
declare function gsl_fcmp cdecl alias "gsl_fcmp" (byval x1 as double, byval x2 as double, byval epsilon as double) as integer

#endif
