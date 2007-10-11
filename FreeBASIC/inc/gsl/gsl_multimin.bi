''
''
'' gsl_multimin -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_multimin_bi__
#define __gsl_multimin_bi__

#include once "gsl_types.bi"
#include once "gsl_math.bi"
#include once "gsl_vector.bi"
#include once "gsl_matrix.bi"
#include once "gsl_min.bi"

type gsl_multimin_function_struct
	f as function cdecl(byval as gsl_vector ptr, byval as any ptr) as double
	n as integer
	params as any ptr
end type

type gsl_multimin_function as gsl_multimin_function_struct

type gsl_multimin_function_fdf_struct
	f as function cdecl(byval as gsl_vector ptr, byval as any ptr) as double
	df as sub cdecl(byval as gsl_vector ptr, byval as any ptr, byval as gsl_vector ptr)
	fdf as sub cdecl(byval as gsl_vector ptr, byval as any ptr, byval as double ptr, byval as gsl_vector ptr)
	n as integer
	params as any ptr
end type

type gsl_multimin_function_fdf as gsl_multimin_function_fdf_struct

extern "c"
declare function gsl_multimin_diff (byval f as gsl_multimin_function ptr, byval x as gsl_vector ptr, byval g as gsl_vector ptr) as integer
end extern

type gsl_multimin_fminimizer_type
	name as byte ptr
	size as integer
	alloc as function cdecl(byval as any ptr, byval as integer) as integer
	set as function cdecl(byval as any ptr, byval as gsl_multimin_function ptr, byval as gsl_vector ptr, byval as double ptr, byval as gsl_vector ptr) as integer
	iterate as function cdecl(byval as any ptr, byval as gsl_multimin_function ptr, byval as gsl_vector ptr, byval as double ptr, byval as double ptr) as integer
	free as sub cdecl(byval as any ptr)
end type

type gsl_multimin_fminimizer
	type as gsl_multimin_fminimizer_type ptr
	f as gsl_multimin_function ptr
	fval as double
	x as gsl_vector ptr
	size as double
	state as any ptr
end type

extern "c"
declare function gsl_multimin_fminimizer_alloc (byval T as gsl_multimin_fminimizer_type ptr, byval n as integer) as gsl_multimin_fminimizer ptr
declare function gsl_multimin_fminimizer_set (byval s as gsl_multimin_fminimizer ptr, byval f as gsl_multimin_function ptr, byval x as gsl_vector ptr, byval step_size as gsl_vector ptr) as integer
declare sub gsl_multimin_fminimizer_free (byval s as gsl_multimin_fminimizer ptr)
declare function gsl_multimin_fminimizer_name (byval s as gsl_multimin_fminimizer ptr) as zstring ptr
declare function gsl_multimin_fminimizer_iterate (byval s as gsl_multimin_fminimizer ptr) as integer
declare function gsl_multimin_fminimizer_x (byval s as gsl_multimin_fminimizer ptr) as gsl_vector ptr
declare function gsl_multimin_fminimizer_minimum (byval s as gsl_multimin_fminimizer ptr) as double
declare function gsl_multimin_fminimizer_size (byval s as gsl_multimin_fminimizer ptr) as double
declare function gsl_multimin_test_gradient (byval g as gsl_vector ptr, byval epsabs as double) as integer
declare function gsl_multimin_test_size (byval size as double, byval epsabs as double) as integer
end extern

type gsl_multimin_fdfminimizer_type
	name as byte ptr
	size as integer
	alloc as function cdecl(byval as any ptr, byval as integer) as integer
	set as function cdecl(byval as any ptr, byval as gsl_multimin_function_fdf ptr, byval as gsl_vector ptr, byval as double ptr, byval as gsl_vector ptr, byval as double, byval as double) as integer
	iterate as function cdecl(byval as any ptr, byval as gsl_multimin_function_fdf ptr, byval as gsl_vector ptr, byval as double ptr, byval as gsl_vector ptr, byval as gsl_vector ptr) as integer
	restart as function cdecl(byval as any ptr) as integer
	free as sub cdecl(byval as any ptr)
end type

type gsl_multimin_fdfminimizer
	type as gsl_multimin_fdfminimizer_type ptr
	fdf as gsl_multimin_function_fdf ptr
	f as double
	x as gsl_vector ptr
	gradient as gsl_vector ptr
	dx as gsl_vector ptr
	state as any ptr
end type

extern "c"
declare function gsl_multimin_fdfminimizer_alloc (byval T as gsl_multimin_fdfminimizer_type ptr, byval n as integer) as gsl_multimin_fdfminimizer ptr
declare function gsl_multimin_fdfminimizer_set (byval s as gsl_multimin_fdfminimizer ptr, byval fdf as gsl_multimin_function_fdf ptr, byval x as gsl_vector ptr, byval step_size as double, byval tol as double) as integer
declare sub gsl_multimin_fdfminimizer_free (byval s as gsl_multimin_fdfminimizer ptr)
declare function gsl_multimin_fdfminimizer_name (byval s as gsl_multimin_fdfminimizer ptr) as zstring ptr
declare function gsl_multimin_fdfminimizer_iterate (byval s as gsl_multimin_fdfminimizer ptr) as integer
declare function gsl_multimin_fdfminimizer_restart (byval s as gsl_multimin_fdfminimizer ptr) as integer
declare function gsl_multimin_fdfminimizer_x (byval s as gsl_multimin_fdfminimizer ptr) as gsl_vector ptr
declare function gsl_multimin_fdfminimizer_dx (byval s as gsl_multimin_fdfminimizer ptr) as gsl_vector ptr
declare function gsl_multimin_fdfminimizer_gradient (byval s as gsl_multimin_fdfminimizer ptr) as gsl_vector ptr
declare function gsl_multimin_fdfminimizer_minimum (byval s as gsl_multimin_fdfminimizer ptr) as double
end extern

#endif
