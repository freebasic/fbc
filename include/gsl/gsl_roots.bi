''
''
'' gsl_roots -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_roots_bi__
#define __gsl_roots_bi__

#include once "gsl_types.bi"
#include once "gsl_math.bi"

type gsl_root_fsolver_type
	name as byte ptr
	size as integer
	set as function cdecl(byval as any ptr, byval as gsl_function ptr, byval as double ptr, byval as double, byval as double) as integer
	iterate as function cdecl(byval as any ptr, byval as gsl_function ptr, byval as double ptr, byval as double ptr, byval as double ptr) as integer
end type

type gsl_root_fsolver
	type as gsl_root_fsolver_type ptr
	function as gsl_function ptr
	root as double
	x_lower as double
	x_upper as double
	state as any ptr
end type

type gsl_root_fdfsolver_type
	name as byte ptr
	size as integer
	set as function cdecl(byval as any ptr, byval as gsl_function_fdf ptr, byval as double ptr) as integer
	iterate as function cdecl(byval as any ptr, byval as gsl_function_fdf ptr, byval as double ptr) as integer
end type

type gsl_root_fdfsolver
	type as gsl_root_fdfsolver_type ptr
	fdf as gsl_function_fdf ptr
	root as double
	state as any ptr
end type

extern "c"
declare function gsl_root_fsolver_alloc (byval T as gsl_root_fsolver_type ptr) as gsl_root_fsolver ptr
declare sub gsl_root_fsolver_free (byval s as gsl_root_fsolver ptr)
declare function gsl_root_fsolver_set (byval s as gsl_root_fsolver ptr, byval f as gsl_function ptr, byval x_lower as double, byval x_upper as double) as integer
declare function gsl_root_fsolver_iterate (byval s as gsl_root_fsolver ptr) as integer
declare function gsl_root_fsolver_name (byval s as gsl_root_fsolver ptr) as zstring ptr
declare function gsl_root_fsolver_root (byval s as gsl_root_fsolver ptr) as double
declare function gsl_root_fsolver_x_lower (byval s as gsl_root_fsolver ptr) as double
declare function gsl_root_fsolver_x_upper (byval s as gsl_root_fsolver ptr) as double
declare function gsl_root_fdfsolver_alloc (byval T as gsl_root_fdfsolver_type ptr) as gsl_root_fdfsolver ptr
declare function gsl_root_fdfsolver_set (byval s as gsl_root_fdfsolver ptr, byval fdf as gsl_function_fdf ptr, byval root as double) as integer
declare function gsl_root_fdfsolver_iterate (byval s as gsl_root_fdfsolver ptr) as integer
declare sub gsl_root_fdfsolver_free (byval s as gsl_root_fdfsolver ptr)
declare function gsl_root_fdfsolver_name (byval s as gsl_root_fdfsolver ptr) as zstring ptr
declare function gsl_root_fdfsolver_root (byval s as gsl_root_fdfsolver ptr) as double
declare function gsl_root_test_interval (byval x_lower as double, byval x_upper as double, byval epsabs as double, byval epsrel as double) as integer
declare function gsl_root_test_residual (byval f as double, byval epsabs as double) as integer
declare function gsl_root_test_delta (byval x1 as double, byval x0 as double, byval epsabs as double, byval epsrel as double) as integer
end extern

#endif
