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

#include once "crt/long.bi"

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

#define NAN_ (0.0F/0.0F)
#define HUGE_VALF (1.0F/0.0F)
#define HUGE_VALL (1.0L/0.0L)
#define INFINITY (1.0F/0.0F)
#define FP_NAN &h0100
#define FP_NORMAL &h0400
#define FP_INFINITE (&h0100 or &h0400)
#define FP_ZERO &h4000
#define FP_SUBNORMAL (&h0400 or &h4000)

extern "c"
declare function sin_ alias "sin" (byval as double) as double
declare function cos_ alias "cos" (byval as double) as double
declare function tan_ alias "tan" (byval as double) as double
declare function asin_ alias "asin" (byval as double) as double
declare function acos_ alias "acos" (byval as double) as double
declare function atan_ alias "atan" (byval as double) as double
declare function atan2_ alias "atan2" (byval as double, byval as double) as double
declare function exp_ alias "exp" (byval as double) as double
declare function log_ alias "log" (byval as double) as double
declare function sinh (byval as double) as double
declare function cosh (byval as double) as double
declare function tanh (byval as double) as double
declare function log10 (byval as double) as double
declare function pow (byval as double, byval as double) as double
declare function sqrt (byval as double) as double
declare function ceil (byval as double) as double
declare function floor (byval as double) as double
declare function fabs (byval as double) as double
declare function ldexp (byval as double, byval as long) as double
declare function frexp (byval as double, byval as long ptr) as double
declare function modf (byval as double, byval as double ptr) as double
declare function fmod (byval as double, byval as double) as double
declare function sinf (byval as single) as single
declare function sinl (byval as double) as double
declare function cosf (byval as single) as single
declare function cosl (byval as double) as double
declare function tanf (byval as single) as single
declare function tanl (byval as double) as double
declare function asinf (byval as single) as single
declare function asinl (byval as double) as double
declare function acosf (byval as single) as single
declare function acosl (byval as double) as double
declare function atanf (byval as single) as single
declare function atanl (byval as double) as double
declare function atan2f (byval as single, byval as single) as single
declare function atan2l (byval as double, byval as double) as double
declare function sinhf (byval x as single) as single
declare function sinhl (byval as double) as double
declare function coshf (byval x as single) as single
declare function coshl (byval as double) as double
declare function tanhf (byval x as single) as single
declare function tanhl (byval as double) as double
declare function expf (byval x as single) as single
declare function expl (byval as double) as double
declare function exp2 (byval as double) as double
declare function exp2f (byval as single) as single
declare function exp2l (byval as double) as double
declare function frexpf (byval as single, byval as long ptr) as single
declare function frexpl (byval as double, byval as long ptr) as double
declare function ilogb (byval as double) as long
declare function ilogbf (byval as single) as long
declare function ilogbl (byval as double) as long
declare function ldexpf (byval as single, byval as long) as single
declare function ldexpl (byval as double, byval as long) as double
declare function logf (byval as single) as single
declare function logl (byval as double) as double
declare function log10f (byval as single) as single
declare function log10l (byval as double) as double
declare function log1p (byval as double) as double
declare function log1pf (byval as single) as single
declare function log1pl (byval as double) as double
declare function log2 (byval as double) as double
declare function log2f (byval as single) as single
declare function log2l (byval as double) as double
declare function logb (byval x as double) as double
declare function logbf (byval x as single) as single
declare function logbl (byval x as double) as double
declare function modff (byval as single, byval as single ptr) as single
declare function modfl (byval as double, byval as double ptr) as double
declare function scalbn (byval as double, byval as long) as double
declare function scalbnf (byval as single, byval as long) as single
declare function scalbnl (byval as double, byval as long) as double
declare function scalbln (byval as double, byval as clong) as double
declare function scalblnf (byval as single, byval as clong) as single
declare function scalblnl (byval as double, byval as clong) as double
declare function cbrt (byval as double) as double
declare function cbrtf (byval as single) as single
declare function cbrtl (byval as double) as double
declare function fabsf (byval x as single) as single
declare function fabsl (byval x as double) as double
declare function hypot (byval as double, byval as double) as double
declare function hypotf (byval x as single, byval y as single) as single
declare function hypotl (byval as double, byval as double) as double
declare function powf (byval x as single, byval y as single) as single
declare function powl (byval as double, byval as double) as double
declare function sqrtf (byval as single) as single
declare function sqrtl (byval as double) as double
declare function erf (byval as double) as double
declare function erff (byval as single) as single
declare function erfc (byval as double) as double
declare function erfcf (byval as single) as single
declare function lgamma (byval as double) as double
declare function lgammaf (byval as single) as single
declare function lgammal (byval as double) as double
declare function tgamma (byval as double) as double
declare function tgammaf (byval as single) as single
declare function tgammal (byval as double) as double
declare function ceilf (byval as single) as single
declare function ceill (byval as double) as double
declare function floorf (byval as single) as single
declare function floorl (byval as double) as double
declare function nearbyint (byval as double) as double
declare function nearbyintf (byval as single) as single
declare function nearbyintl (byval as double) as double
declare function rint (byval x as double) as double
declare function rintf (byval x as single) as single
declare function rintl (byval x as double) as double
declare function lrint (byval x as double) as clong
declare function lrintf (byval x as single) as clong
declare function lrintl (byval x as double) as clong
declare function llrint (byval x as double) as longint
declare function llrintf (byval x as single) as longint
declare function llrintl (byval x as double) as longint
declare function round (byval as double) as double
declare function roundf (byval as single) as single
declare function roundl (byval as double) as double
declare function lround (byval as double) as clong
declare function lroundf (byval as single) as clong
declare function lroundl (byval as double) as clong
declare function llround (byval as double) as longint
declare function llroundf (byval as single) as longint
declare function llroundl (byval as double) as longint
declare function trunc (byval as double) as double
declare function truncf (byval as single) as single
declare function truncl (byval as double) as double
declare function fmodf (byval as single, byval as single) as single
declare function fmodl (byval as double, byval as double) as double
declare function remainder (byval as double, byval as double) as double
declare function remainderf (byval as single, byval as single) as single
declare function remainderl (byval as double, byval as double) as double
declare function remquo (byval as double, byval as double, byval as long ptr) as double
declare function remquof (byval as single, byval as single, byval as long ptr) as single
declare function remquol (byval as double, byval as double, byval as long ptr) as double
declare function copysign (byval as double, byval as double) as double
declare function copysignf (byval as single, byval as single) as single
declare function copysignl (byval as double, byval as double) as double
declare function nan (byval tagp as zstring ptr) as double
declare function nanf (byval tagp as zstring ptr) as single
declare function nanl (byval tagp as zstring ptr) as double
declare function nextafter (byval as double, byval as double) as double
declare function nextafterf (byval as single, byval as single) as single
declare function fdim (byval x as double, byval y as double) as double
declare function fdimf (byval x as single, byval y as single) as single
declare function fdiml (byval x as double, byval y as double) as double
declare function fmax (byval as double, byval as double) as double
declare function fmaxf (byval as single, byval as single) as single
declare function fmaxl (byval as double, byval as double) as double
declare function fmin (byval as double, byval as double) as double
declare function fminf (byval as single, byval as single) as single
declare function fminl (byval as double, byval as double) as double
declare function fma (byval as double, byval as double, byval as double) as double
declare function fmaf (byval as single, byval as single, byval as single) as single
declare function fmal (byval as double, byval as double, byval as double) as double
end extern

#ifdef __FB_WIN32__
extern import _HUGE alias "_HUGE" as double ptr

type _exception
	type as long
	name as zstring ptr
	arg1 as double
	arg2 as double
	retval as double
end type

type _complex
	x as double
	y as double
end type

extern "c"
declare function _cabs (byval as _complex) as double
declare function _hypot (byval as double, byval as double) as double
declare function _j0 (byval as double) as double
declare function _j1 (byval as double) as double
declare function _jn (byval as long, byval as double) as double
declare function _y0 (byval as double) as double
declare function _y1 (byval as double) as double
declare function _yn (byval as long, byval as double) as double
declare function _matherr (byval as _exception ptr) as long
declare function _chgsign (byval as double) as double
declare function _copysign (byval as double, byval as double) as double
declare function _logb (byval as double) as double
declare function _nextafter (byval as double, byval as double) as double
declare function _scalb (byval as double, byval as clong) as double
declare function _finite (byval as double) as long
declare function _fpclass (byval as double) as long
declare function _isnan (byval as double) as long
declare function __fpclassifyf (byval as single) as long
declare function __fpclassify (byval as double) as long
declare function __fpclassifyl (byval x as double) as long
declare function __isnan (byval _x as double) as long
declare function __isnanf (byval _x as single) as long
declare function __isnanl (byval _x as double) as long
declare function __signbit (byval x as double) as long
declare function __signbitf (byval x as single) as long
declare function __signbitl (byval x as double) as long
end extern
#endif

#endif
