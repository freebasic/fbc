''
''
'' gsl_ieee_utils -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_ieee_utils_bi__
#define __gsl_ieee_utils_bi__

#include once "gsl_types.bi"

enum 
	GSL_IEEE_TYPE_NAN = 1
	GSL_IEEE_TYPE_INF = 2
	GSL_IEEE_TYPE_NORMAL = 3
	GSL_IEEE_TYPE_DENORMAL = 4
	GSL_IEEE_TYPE_ZERO = 5
end enum

type gsl_ieee_float_rep
	sign as integer
	mantissa as zstring * 24
	exponent as integer
	type as integer
end type

type gsl_ieee_double_rep
	sign as integer
	mantissa as zstring * 53
	exponent as integer
	type as integer
end type

extern "c"
declare sub gsl_ieee_printf_float (byval x as single ptr)
declare sub gsl_ieee_printf_double (byval x as double ptr)
declare sub gsl_ieee_fprintf_float (byval stream as FILE ptr, byval x as single ptr)
declare sub gsl_ieee_fprintf_double (byval stream as FILE ptr, byval x as double ptr)
declare sub gsl_ieee_float_to_rep (byval x as single ptr, byval r as gsl_ieee_float_rep ptr)
declare sub gsl_ieee_double_to_rep (byval x as double ptr, byval r as gsl_ieee_double_rep ptr)
end extern

enum 
	GSL_IEEE_SINGLE_PRECISION = 1
	GSL_IEEE_DOUBLE_PRECISION = 2
	GSL_IEEE_EXTENDED_PRECISION = 3
end enum

enum 
	GSL_IEEE_ROUND_TO_NEAREST = 1
	GSL_IEEE_ROUND_DOWN = 2
	GSL_IEEE_ROUND_UP = 3
	GSL_IEEE_ROUND_TO_ZERO = 4
end enum

enum 
	GSL_IEEE_MASK_INVALID = 1
	GSL_IEEE_MASK_DENORMALIZED = 2
	GSL_IEEE_MASK_DIVISION_BY_ZERO = 4
	GSL_IEEE_MASK_OVERFLOW = 8
	GSL_IEEE_MASK_UNDERFLOW = 16
	GSL_IEEE_MASK_ALL = 31
	GSL_IEEE_TRAP_INEXACT = 32
end enum

extern "c"
declare sub gsl_ieee_env_setup ()
declare function gsl_ieee_read_mode_string (byval description as zstring ptr, byval precision as integer ptr, byval rounding as integer ptr, byval exception_mask as integer ptr) as integer
declare function gsl_ieee_set_mode (byval precision as integer, byval rounding as integer, byval exception_mask as integer) as integer
end extern

#endif
