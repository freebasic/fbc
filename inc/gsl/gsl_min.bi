''
''
'' gsl_min -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_min_bi__
#define __gsl_min_bi__

#include once "gsl_types.bi"
#include once "gsl_math.bi"

type gsl_min_fminimizer_type
	name as byte ptr
	size as integer
	set as function cdecl(byval as any ptr, byval as gsl_function ptr, byval as double, byval as double, byval as double, byval as double, byval as double, byval as double) as integer
	iterate as function cdecl(byval as any ptr, byval as gsl_function ptr, byval as double ptr, byval as double ptr, byval as double ptr, byval as double ptr, byval as double ptr, byval as double ptr) as integer
end type

type gsl_min_fminimizer
	type as gsl_min_fminimizer_type ptr
	function as gsl_function ptr
	x_minimum as double
	x_lower as double
	x_upper as double
	f_minimum as double
	f_lower as double
	f_upper as double
	state as any ptr
end type

extern "c"
declare function gsl_min_fminimizer_alloc (byval T as gsl_min_fminimizer_type ptr) as gsl_min_fminimizer ptr
declare sub gsl_min_fminimizer_free (byval s as gsl_min_fminimizer ptr)
declare function gsl_min_fminimizer_set (byval s as gsl_min_fminimizer ptr, byval f as gsl_function ptr, byval x_minimum as double, byval x_lower as double, byval x_upper as double) as integer
declare function gsl_min_fminimizer_set_with_values (byval s as gsl_min_fminimizer ptr, byval f as gsl_function ptr, byval x_minimum as double, byval f_minimum as double, byval x_lower as double, byval f_lower as double, byval x_upper as double, byval f_upper as double) as integer
declare function gsl_min_fminimizer_iterate (byval s as gsl_min_fminimizer ptr) as integer
declare function gsl_min_fminimizer_name (byval s as gsl_min_fminimizer ptr) as zstring ptr
declare function gsl_min_fminimizer_x_minimum (byval s as gsl_min_fminimizer ptr) as double
declare function gsl_min_fminimizer_x_lower (byval s as gsl_min_fminimizer ptr) as double
declare function gsl_min_fminimizer_x_upper (byval s as gsl_min_fminimizer ptr) as double
declare function gsl_min_fminimizer_f_minimum (byval s as gsl_min_fminimizer ptr) as double
declare function gsl_min_fminimizer_f_lower (byval s as gsl_min_fminimizer ptr) as double
declare function gsl_min_fminimizer_f_upper (byval s as gsl_min_fminimizer ptr) as double
declare function gsl_min_fminimizer_minimum (byval s as gsl_min_fminimizer ptr) as double
declare function gsl_min_test_interval (byval x_lower as double, byval x_upper as double, byval epsabs as double, byval epsrel as double) as integer
end extern

type gsl_min_bracketing_function as function cdecl(byval as gsl_function ptr, byval as double ptr, byval as double ptr, byval as double ptr, byval as double ptr, byval as double ptr, byval as double ptr, byval as integer) as integer

extern "c"
declare function gsl_min_find_bracket (byval f as gsl_function ptr, byval x_minimum as double ptr, byval f_minimum as double ptr, byval x_lower as double ptr, byval f_lower as double ptr, byval x_upper as double ptr, byval f_upper as double ptr, byval eval_max as integer) as integer
end extern

#endif
