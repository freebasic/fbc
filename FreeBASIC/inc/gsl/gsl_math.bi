''
''
'' gsl_math -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_math_bi__
#define __gsl_math_bi__

#include once "gsl_sys.bi"
#include once "gsl_machine.bi"
#include once "gsl_precision.bi"
#include once "gsl_nan.bi"
#include once "gsl_pow_int.bi"
#include once "gsl_types.bi"

#define M_E 2.71828182845904523536028747135
#define M_LOG2E 1.44269504088896340735992468100
#define M_LOG10E 0.43429448190325182765112891892
#define M_SQRT2 1.41421356237309504880168872421
#define M_SQRT1_2 0.70710678118654752440084436210
#define M_SQRT3 1.73205080756887729352744634151
#define M_PI 3.14159265358979323846264338328
#define M_PI_2 1.57079632679489661923132169164
#define M_PI_4 0.78539816339744830966156608458
#define M_SQRTPI 1.77245385090551602729816748334
#define M_2_SQRTPI 1.12837916709551257389615890312
#define M_1_PI 0.31830988618379067153776752675
#define M_2_PI 0.63661977236758134307553505349
#define M_LN10 2.30258509299404568401799145468
#define M_LN2 0.69314718055994530941723212146
#define M_LNPI 1.14472988584940017414342735135
#define M_EULER 0.57721566490153286060651209008

extern "c"
declare function gsl_max (byval a as double, byval b as double) as double
declare function gsl_min (byval a as double, byval b as double) as double
end extern

type gsl_function_struct
	function as function cdecl(byval as double, byval as any ptr) as double
	params as any ptr
end type

type gsl_function as gsl_function_struct

type gsl_function_fdf_struct
	f as function cdecl(byval as double, byval as any ptr) as double
	df as function cdecl(byval as double, byval as any ptr) as double
	fdf as sub cdecl(byval as double, byval as any ptr, byval as double ptr, byval as double ptr)
	params as any ptr
end type

type gsl_function_fdf as gsl_function_fdf_struct

type gsl_function_vec_struct
	function as function cdecl(byval as double, byval as double ptr, byval as any ptr) as integer
	params as any ptr
end type

type gsl_function_vec as gsl_function_vec_struct

#endif
