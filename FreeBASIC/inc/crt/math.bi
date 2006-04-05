''
''
'' math -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __crt_math_bi__
#define __crt_math_bi__

#define _DOMAIN 1
#define _SING 2
#define _OVERFLOW 3
#define _UNDERFLOW 4
#define _TLOSS 5
#define _PLOSS 6
#define M_E 2.7182818284590452354
#define M_LOG2E 1.4426950408889634074
#define M_LOG10E 0.43429448190325182765
#define M_LN2 0.69314718055994530942
#define M_LN10 2.30258509299404568402
#define M_PI 3.14159265358979323846
#define M_PI_2 1.57079632679489661923
#define M_PI_4 0.78539816339744830962
#define M_1_PI 0.31830988618379067154
#define M_2_PI 0.63661977236758134308
#define M_2_SQRTPI 1.12837916709551257390
#define M_SQRT2 1.41421356237309504880
#define M_SQRT1_2 0.70710678118654752440
#define __MINGW_FPCLASS_DEFINED 1
#define _FPCLASS_SNAN &h0001
#define _FPCLASS_QNAN &h0002
#define _FPCLASS_NINF &h0004
#define _FPCLASS_NN &h0008
#define _FPCLASS_ND &h0010
#define _FPCLASS_NZ &h0020
#define _FPCLASS_PZ &h0040
#define _FPCLASS_PD &h0080
#define _FPCLASS_PN &h0100
#define _FPCLASS_PINF &h0200
extern import _imp___HUGE alias "_imp___HUGE" as double ptr

type _exception
	type as integer
	name as zstring ptr
	arg1 as double
	arg2 as double
	retval as double
end type

declare function sin_ cdecl alias "sin" (byval as double) as double
declare function cos_ cdecl alias "cos" (byval as double) as double
declare function tan_ cdecl alias "tan" (byval as double) as double
declare function sinh cdecl alias "sinh" (byval as double) as double
declare function cosh cdecl alias "cosh" (byval as double) as double
declare function tanh cdecl alias "tanh" (byval as double) as double
declare function asin_ cdecl alias "asin" (byval as double) as double
declare function acos_ cdecl alias "acos" (byval as double) as double
declare function atan_ cdecl alias "atan" (byval as double) as double
declare function atan2_ cdecl alias "atan2" (byval as double, byval as double) as double
declare function exp_ cdecl alias "exp" (byval as double) as double
declare function log_ cdecl alias "log" (byval as double) as double
declare function log10 cdecl alias "log10" (byval as double) as double
declare function pow cdecl alias "pow" (byval as double, byval as double) as double
declare function sqrt cdecl alias "sqrt" (byval as double) as double
declare function ceil cdecl alias "ceil" (byval as double) as double
declare function floor cdecl alias "floor" (byval as double) as double
declare function fabs cdecl alias "fabs" (byval as double) as double
declare function ldexp cdecl alias "ldexp" (byval as double, byval as integer) as double
declare function frexp cdecl alias "frexp" (byval as double, byval as integer ptr) as double
declare function modf cdecl alias "modf" (byval as double, byval as double ptr) as double
declare function fmod cdecl alias "fmod" (byval as double, byval as double) as double

type _complex
	x as double
	y as double
end type

declare function _cabs cdecl alias "_cabs" (byval as _complex) as double
declare function _hypot cdecl alias "_hypot" (byval as double, byval as double) as double
declare function _j0 cdecl alias "_j0" (byval as double) as double
declare function _j1 cdecl alias "_j1" (byval as double) as double
declare function _jn cdecl alias "_jn" (byval as integer, byval as double) as double
declare function _y0 cdecl alias "_y0" (byval as double) as double
declare function _y1 cdecl alias "_y1" (byval as double) as double
declare function _yn cdecl alias "_yn" (byval as integer, byval as double) as double
declare function _matherr cdecl alias "_matherr" (byval as _exception ptr) as integer
declare function _chgsign cdecl alias "_chgsign" (byval as double) as double
declare function _copysign cdecl alias "_copysign" (byval as double, byval as double) as double
declare function _logb cdecl alias "_logb" (byval as double) as double
declare function _nextafter cdecl alias "_nextafter" (byval as double, byval as double) as double
declare function _scalb cdecl alias "_scalb" (byval as double, byval as integer) as double
declare function _finite cdecl alias "_finite" (byval as double) as integer
declare function _fpclass cdecl alias "_fpclass" (byval as double) as integer
declare function _isnan cdecl alias "_isnan" (byval as double) as integer

#define NAN_ (0.0F/0.0F)
#define HUGE_VALF (1.0F/0.0F)
#define HUGE_VALL (1.0L/0.0L)
#define INFINITY (1.0F/0.0F)
#define FP_NAN &h0100
#define FP_NORMAL &h0400
#define FP_INFINITE (&h0100 or &h0400)
#define FP_ZERO &h4000
#define FP_SUBNORMAL (&h0400 or &h4000)

declare function __fpclassifyf cdecl alias "__fpclassifyf" (byval as single) as integer
declare function __fpclassify cdecl alias "__fpclassify" (byval as double) as integer
declare function __fpclassifyl cdecl alias "__fpclassifyl" (byval x as double) as integer
declare function __isnan cdecl alias "__isnan" (byval _x as double) as integer
declare function __isnanf cdecl alias "__isnanf" (byval _x as single) as integer
declare function __isnanl cdecl alias "__isnanl" (byval _x as double) as integer
declare function __signbit cdecl alias "__signbit" (byval x as double) as integer
declare function __signbitf cdecl alias "__signbitf" (byval x as single) as integer
declare function __signbitl cdecl alias "__signbitl" (byval x as double) as integer
declare function sinf cdecl alias "sinf" (byval as single) as single
declare function sinl cdecl alias "sinl" (byval as double) as double
declare function cosf cdecl alias "cosf" (byval as single) as single
declare function cosl cdecl alias "cosl" (byval as double) as double
declare function tanf cdecl alias "tanf" (byval as single) as single
declare function tanl cdecl alias "tanl" (byval as double) as double
declare function asinf cdecl alias "asinf" (byval as single) as single
declare function asinl cdecl alias "asinl" (byval as double) as double
declare function acosf cdecl alias "acosf" (byval as single) as single
declare function acosl cdecl alias "acosl" (byval as double) as double
declare function atanf cdecl alias "atanf" (byval as single) as single
declare function atanl cdecl alias "atanl" (byval as double) as double
declare function atan2f cdecl alias "atan2f" (byval as single, byval as single) as single
declare function atan2l cdecl alias "atan2l" (byval as double, byval as double) as double
declare function sinhf cdecl alias "sinhf" (byval x as single) as single
declare function sinhl cdecl alias "sinhl" (byval as double) as double
declare function coshf cdecl alias "coshf" (byval x as single) as single
declare function coshl cdecl alias "coshl" (byval as double) as double
declare function tanhf cdecl alias "tanhf" (byval x as single) as single
declare function tanhl cdecl alias "tanhl" (byval as double) as double
declare function expf cdecl alias "expf" (byval x as single) as single
declare function expl cdecl alias "expl" (byval as double) as double
declare function exp2 cdecl alias "exp2" (byval as double) as double
declare function exp2f cdecl alias "exp2f" (byval as single) as single
declare function exp2l cdecl alias "exp2l" (byval as double) as double
declare function frexpf cdecl alias "frexpf" (byval x as single, byval expn as integer ptr) as single
declare function frexpl cdecl alias "frexpl" (byval as double, byval as integer ptr) as double
declare function ilogb cdecl alias "ilogb" (byval as double) as integer
declare function ilogbf cdecl alias "ilogbf" (byval as single) as integer
declare function ilogbl cdecl alias "ilogbl" (byval as double) as integer
declare function ldexpf cdecl alias "ldexpf" (byval x as single, byval expn as integer) as single
declare function ldexpl cdecl alias "ldexpl" (byval as double, byval as integer) as double
declare function logf cdecl alias "logf" (byval as single) as single
declare function logl cdecl alias "logl" (byval as double) as double
declare function log10f cdecl alias "log10f" (byval as single) as single
declare function log10l cdecl alias "log10l" (byval as double) as double
declare function log1p cdecl alias "log1p" (byval as double) as double
declare function log1pf cdecl alias "log1pf" (byval as single) as single
declare function log1pl cdecl alias "log1pl" (byval as double) as double
declare function log2 cdecl alias "log2" (byval as double) as double
declare function log2f cdecl alias "log2f" (byval as single) as single
declare function log2l cdecl alias "log2l" (byval as double) as double
declare function logb cdecl alias "logb" (byval x as double) as double
declare function logbf cdecl alias "logbf" (byval x as single) as single
declare function logbl cdecl alias "logbl" (byval x as double) as double
declare function modff cdecl alias "modff" (byval as single, byval as single ptr) as single
declare function modfl cdecl alias "modfl" (byval as double, byval as double ptr) as double
declare function scalbn cdecl alias "scalbn" (byval as double, byval as integer) as double
declare function scalbnf cdecl alias "scalbnf" (byval as single, byval as integer) as single
declare function scalbnl cdecl alias "scalbnl" (byval as double, byval as integer) as double
declare function scalbln cdecl alias "scalbln" (byval as double, byval as integer) as double
declare function scalblnf cdecl alias "scalblnf" (byval as single, byval as integer) as single
declare function scalblnl cdecl alias "scalblnl" (byval as double, byval as integer) as double
declare function cbrt cdecl alias "cbrt" (byval as double) as double
declare function cbrtf cdecl alias "cbrtf" (byval as single) as single
declare function cbrtl cdecl alias "cbrtl" (byval as double) as double
declare function fabsf cdecl alias "fabsf" (byval x as single) as single
declare function fabsl cdecl alias "fabsl" (byval x as double) as double
declare function hypot cdecl alias "hypot" (byval as double, byval as double) as double
declare function hypotf cdecl alias "hypotf" (byval x as single, byval y as single) as single
declare function hypotl cdecl alias "hypotl" (byval as double, byval as double) as double
declare function powf cdecl alias "powf" (byval x as single, byval y as single) as single
declare function powl cdecl alias "powl" (byval as double, byval as double) as double
declare function sqrtf cdecl alias "sqrtf" (byval as single) as single
declare function sqrtl cdecl alias "sqrtl" (byval as double) as double
declare function erf cdecl alias "erf" (byval as double) as double
declare function erff cdecl alias "erff" (byval as single) as single
declare function erfc cdecl alias "erfc" (byval as double) as double
declare function erfcf cdecl alias "erfcf" (byval as single) as single
declare function lgamma cdecl alias "lgamma" (byval as double) as double
declare function lgammaf cdecl alias "lgammaf" (byval as single) as single
declare function lgammal cdecl alias "lgammal" (byval as double) as double
declare function tgamma cdecl alias "tgamma" (byval as double) as double
declare function tgammaf cdecl alias "tgammaf" (byval as single) as single
declare function tgammal cdecl alias "tgammal" (byval as double) as double
declare function ceilf cdecl alias "ceilf" (byval as single) as single
declare function ceill cdecl alias "ceill" (byval as double) as double
declare function floorf cdecl alias "floorf" (byval as single) as single
declare function floorl cdecl alias "floorl" (byval as double) as double
declare function nearbyint cdecl alias "nearbyint" (byval as double) as double
declare function nearbyintf cdecl alias "nearbyintf" (byval as single) as single
declare function nearbyintl cdecl alias "nearbyintl" (byval as double) as double
declare function rint cdecl alias "rint" (byval x as double) as double
declare function rintf cdecl alias "rintf" (byval x as single) as single
declare function rintl cdecl alias "rintl" (byval x as double) as double
declare function lrint cdecl alias "lrint" (byval x as double) as integer
declare function lrintf cdecl alias "lrintf" (byval x as single) as integer
declare function lrintl cdecl alias "lrintl" (byval x as double) as integer
declare function llrint cdecl alias "llrint" (byval x as double) as longint
declare function llrintf cdecl alias "llrintf" (byval x as single) as longint
declare function llrintl cdecl alias "llrintl" (byval x as double) as longint
declare function round cdecl alias "round" (byval as double) as double
declare function roundf cdecl alias "roundf" (byval as single) as single
declare function roundl cdecl alias "roundl" (byval as double) as double
declare function lround cdecl alias "lround" (byval as double) as integer
declare function lroundf cdecl alias "lroundf" (byval as single) as integer
declare function lroundl cdecl alias "lroundl" (byval as double) as integer
declare function llround cdecl alias "llround" (byval as double) as longint
declare function llroundf cdecl alias "llroundf" (byval as single) as longint
declare function llroundl cdecl alias "llroundl" (byval as double) as longint
declare function trunc cdecl alias "trunc" (byval as double) as double
declare function truncf cdecl alias "truncf" (byval as single) as single
declare function truncl cdecl alias "truncl" (byval as double) as double
declare function fmodf cdecl alias "fmodf" (byval as single, byval as single) as single
declare function fmodl cdecl alias "fmodl" (byval as double, byval as double) as double
declare function remainder cdecl alias "remainder" (byval as double, byval as double) as double
declare function remainderf cdecl alias "remainderf" (byval as single, byval as single) as single
declare function remainderl cdecl alias "remainderl" (byval as double, byval as double) as double
declare function remquo cdecl alias "remquo" (byval as double, byval as double, byval as integer ptr) as double
declare function remquof cdecl alias "remquof" (byval as single, byval as single, byval as integer ptr) as single
declare function remquol cdecl alias "remquol" (byval as double, byval as double, byval as integer ptr) as double
declare function copysign cdecl alias "copysign" (byval as double, byval as double) as double
declare function copysignf cdecl alias "copysignf" (byval as single, byval as single) as single
declare function copysignl cdecl alias "copysignl" (byval as double, byval as double) as double
declare function nan cdecl alias "nan" (byval tagp as zstring ptr) as double
declare function nanf cdecl alias "nanf" (byval tagp as zstring ptr) as single
declare function nanl cdecl alias "nanl" (byval tagp as zstring ptr) as double
declare function nextafter cdecl alias "nextafter" (byval as double, byval as double) as double
declare function nextafterf cdecl alias "nextafterf" (byval as single, byval as single) as single
declare function fdim cdecl alias "fdim" (byval x as double, byval y as double) as double
declare function fdimf cdecl alias "fdimf" (byval x as single, byval y as single) as single
declare function fdiml cdecl alias "fdiml" (byval x as double, byval y as double) as double
declare function fmax cdecl alias "fmax" (byval as double, byval as double) as double
declare function fmaxf cdecl alias "fmaxf" (byval as single, byval as single) as single
declare function fmaxl cdecl alias "fmaxl" (byval as double, byval as double) as double
declare function fmin cdecl alias "fmin" (byval as double, byval as double) as double
declare function fminf cdecl alias "fminf" (byval as single, byval as single) as single
declare function fminl cdecl alias "fminl" (byval as double, byval as double) as double
declare function fma cdecl alias "fma" (byval as double, byval as double, byval as double) as double
declare function fmaf cdecl alias "fmaf" (byval as single, byval as single, byval as single) as single
declare function fmal cdecl alias "fmal" (byval as double, byval as double, byval as double) as double

#endif
