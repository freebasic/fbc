''
''
'' gsl_multiroots -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_multiroots_bi__
#define __gsl_multiroots_bi__

#include once "gsl_types.bi"
#include once "gsl_math.bi"
#include once "gsl_vector.bi"
#include once "gsl_matrix.bi"

type gsl_multiroot_function_struct
	f as function cdecl(byval as gsl_vector ptr, byval as any ptr, byval as gsl_vector ptr) as integer
	n as integer
	params as any ptr
end type

type gsl_multiroot_function as gsl_multiroot_function_struct

extern "c"
declare function gsl_multiroot_fdjacobian (byval F as gsl_multiroot_function ptr, byval x as gsl_vector ptr, byval f as gsl_vector ptr, byval epsrel as double, byval jacobian as gsl_matrix ptr) as integer
end extern

type gsl_multiroot_fsolver_type
	name as byte ptr
	size as integer
	alloc as function cdecl(byval as any ptr, byval as integer) as integer
	set as function cdecl(byval as any ptr, byval as gsl_multiroot_function ptr, byval as gsl_vector ptr, byval as gsl_vector ptr, byval as gsl_vector ptr) as integer
	iterate as function cdecl(byval as any ptr, byval as gsl_multiroot_function ptr, byval as gsl_vector ptr, byval as gsl_vector ptr, byval as gsl_vector ptr) as integer
	free as sub cdecl(byval as any ptr)
end type

type gsl_multiroot_fsolver
	type as gsl_multiroot_fsolver_type ptr
	function as gsl_multiroot_function ptr
	x as gsl_vector ptr
	f as gsl_vector ptr
	dx as gsl_vector ptr
	state as any ptr
end type

extern "c"
declare function gsl_multiroot_fsolver_alloc (byval T as gsl_multiroot_fsolver_type ptr, byval n as integer) as gsl_multiroot_fsolver ptr
declare sub gsl_multiroot_fsolver_free (byval s as gsl_multiroot_fsolver ptr)
declare function gsl_multiroot_fsolver_set (byval s as gsl_multiroot_fsolver ptr, byval f as gsl_multiroot_function ptr, byval x as gsl_vector ptr) as integer
declare function gsl_multiroot_fsolver_iterate (byval s as gsl_multiroot_fsolver ptr) as integer
declare function gsl_multiroot_fsolver_name (byval s as gsl_multiroot_fsolver ptr) as zstring ptr
declare function gsl_multiroot_fsolver_root (byval s as gsl_multiroot_fsolver ptr) as gsl_vector ptr
declare function gsl_multiroot_fsolver_dx (byval s as gsl_multiroot_fsolver ptr) as gsl_vector ptr
declare function gsl_multiroot_fsolver_f (byval s as gsl_multiroot_fsolver ptr) as gsl_vector ptr
end extern

type gsl_multiroot_function_fdf_struct
	f as function cdecl(byval as gsl_vector ptr, byval as any ptr, byval as gsl_vector ptr) as integer
	df as function cdecl(byval as gsl_vector ptr, byval as any ptr, byval as gsl_matrix ptr) as integer
	fdf as function cdecl(byval as gsl_vector ptr, byval as any ptr, byval as gsl_vector ptr, byval as gsl_matrix ptr) as integer
	n as integer
	params as any ptr
end type

type gsl_multiroot_function_fdf as gsl_multiroot_function_fdf_struct

type gsl_multiroot_fdfsolver_type
	name as byte ptr
	size as integer
	alloc as function cdecl(byval as any ptr, byval as integer) as integer
	set as function cdecl(byval as any ptr, byval as gsl_multiroot_function_fdf ptr, byval as gsl_vector ptr, byval as gsl_vector ptr, byval as gsl_matrix ptr, byval as gsl_vector ptr) as integer
	iterate as function cdecl(byval as any ptr, byval as gsl_multiroot_function_fdf ptr, byval as gsl_vector ptr, byval as gsl_vector ptr, byval as gsl_matrix ptr, byval as gsl_vector ptr) as integer
	free as sub cdecl(byval as any ptr)
end type

type gsl_multiroot_fdfsolver
	type as gsl_multiroot_fdfsolver_type ptr
	fdf as gsl_multiroot_function_fdf ptr
	x as gsl_vector ptr
	f as gsl_vector ptr
	J as gsl_matrix ptr
	dx as gsl_vector ptr
	state as any ptr
end type

extern "c"
declare function gsl_multiroot_fdfsolver_alloc (byval T as gsl_multiroot_fdfsolver_type ptr, byval n as integer) as gsl_multiroot_fdfsolver ptr
declare function gsl_multiroot_fdfsolver_set (byval s as gsl_multiroot_fdfsolver ptr, byval fdf as gsl_multiroot_function_fdf ptr, byval x as gsl_vector ptr) as integer
declare function gsl_multiroot_fdfsolver_iterate (byval s as gsl_multiroot_fdfsolver ptr) as integer
declare sub gsl_multiroot_fdfsolver_free (byval s as gsl_multiroot_fdfsolver ptr)
declare function gsl_multiroot_fdfsolver_name (byval s as gsl_multiroot_fdfsolver ptr) as zstring ptr
declare function gsl_multiroot_fdfsolver_root (byval s as gsl_multiroot_fdfsolver ptr) as gsl_vector ptr
declare function gsl_multiroot_fdfsolver_dx (byval s as gsl_multiroot_fdfsolver ptr) as gsl_vector ptr
declare function gsl_multiroot_fdfsolver_f (byval s as gsl_multiroot_fdfsolver ptr) as gsl_vector ptr
declare function gsl_multiroot_test_delta (byval dx as gsl_vector ptr, byval x as gsl_vector ptr, byval epsabs as double, byval epsrel as double) as integer
declare function gsl_multiroot_test_residual (byval f as gsl_vector ptr, byval epsabs as double) as integer
end extern

#endif
