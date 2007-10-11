''
''
'' gsl_multifit_nlin -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_multifit_nlin_bi__
#define __gsl_multifit_nlin_bi__

#include once "gsl_types.bi"
#include once "gsl_math.bi"
#include once "gsl_vector.bi"
#include once "gsl_matrix.bi"

extern "c"
declare function gsl_multifit_gradient (byval J as gsl_matrix ptr, byval f as gsl_vector ptr, byval g as gsl_vector ptr) as integer
declare function gsl_multifit_covar (byval J as gsl_matrix ptr, byval epsrel as double, byval covar as gsl_matrix ptr) as integer
end extern

type gsl_multifit_function_struct
	f as function cdecl(byval as gsl_vector ptr, byval as any ptr, byval as gsl_vector ptr) as integer
	n as integer
	p as integer
	params as any ptr
end type

type gsl_multifit_function as gsl_multifit_function_struct

type gsl_multifit_fsolver_type
	name as byte ptr
	size as integer
	alloc as function cdecl(byval as any ptr, byval as integer, byval as integer) as integer
	set as function cdecl(byval as any ptr, byval as gsl_multifit_function ptr, byval as gsl_vector ptr, byval as gsl_vector ptr, byval as gsl_vector ptr) as integer
	iterate as function cdecl(byval as any ptr, byval as gsl_multifit_function ptr, byval as gsl_vector ptr, byval as gsl_vector ptr, byval as gsl_vector ptr) as integer
	free as sub cdecl(byval as any ptr)
end type

type gsl_multifit_fsolver
	type as gsl_multifit_fsolver_type ptr
	function as gsl_multifit_function ptr
	x as gsl_vector ptr
	f as gsl_vector ptr
	dx as gsl_vector ptr
	state as any ptr
end type

extern "c"
declare function gsl_multifit_fsolver_alloc (byval T as gsl_multifit_fsolver_type ptr, byval n as integer, byval p as integer) as gsl_multifit_fsolver ptr
declare sub gsl_multifit_fsolver_free (byval s as gsl_multifit_fsolver ptr)
declare function gsl_multifit_fsolver_set (byval s as gsl_multifit_fsolver ptr, byval f as gsl_multifit_function ptr, byval x as gsl_vector ptr) as integer
declare function gsl_multifit_fsolver_iterate (byval s as gsl_multifit_fsolver ptr) as integer
declare function gsl_multifit_fsolver_name (byval s as gsl_multifit_fsolver ptr) as zstring ptr
declare function gsl_multifit_fsolver_position (byval s as gsl_multifit_fsolver ptr) as gsl_vector ptr
end extern

type gsl_multifit_function_fdf_struct
	f as function cdecl(byval as gsl_vector ptr, byval as any ptr, byval as gsl_vector ptr) as integer
	df as function cdecl(byval as gsl_vector ptr, byval as any ptr, byval as gsl_matrix ptr) as integer
	fdf as function cdecl(byval as gsl_vector ptr, byval as any ptr, byval as gsl_vector ptr, byval as gsl_matrix ptr) as integer
	n as integer
	p as integer
	params as any ptr
end type

type gsl_multifit_function_fdf as gsl_multifit_function_fdf_struct

type gsl_multifit_fdfsolver_type
	name as byte ptr
	size as integer
	alloc as function cdecl(byval as any ptr, byval as integer, byval as integer) as integer
	set as function cdecl(byval as any ptr, byval as gsl_multifit_function_fdf ptr, byval as gsl_vector ptr, byval as gsl_vector ptr, byval as gsl_matrix ptr, byval as gsl_vector ptr) as integer
	iterate as function cdecl(byval as any ptr, byval as gsl_multifit_function_fdf ptr, byval as gsl_vector ptr, byval as gsl_vector ptr, byval as gsl_matrix ptr, byval as gsl_vector ptr) as integer
	free as sub cdecl(byval as any ptr)
end type

type gsl_multifit_fdfsolver
	type as gsl_multifit_fdfsolver_type ptr
	fdf as gsl_multifit_function_fdf ptr
	x as gsl_vector ptr
	f as gsl_vector ptr
	J as gsl_matrix ptr
	dx as gsl_vector ptr
	state as any ptr
end type

extern "c"
declare function gsl_multifit_fdfsolver_alloc (byval T as gsl_multifit_fdfsolver_type ptr, byval n as integer, byval p as integer) as gsl_multifit_fdfsolver ptr
declare function gsl_multifit_fdfsolver_set (byval s as gsl_multifit_fdfsolver ptr, byval fdf as gsl_multifit_function_fdf ptr, byval x as gsl_vector ptr) as integer
declare function gsl_multifit_fdfsolver_iterate (byval s as gsl_multifit_fdfsolver ptr) as integer
declare sub gsl_multifit_fdfsolver_free (byval s as gsl_multifit_fdfsolver ptr)
declare function gsl_multifit_fdfsolver_name (byval s as gsl_multifit_fdfsolver ptr) as zstring ptr
declare function gsl_multifit_fdfsolver_position (byval s as gsl_multifit_fdfsolver ptr) as gsl_vector ptr
declare function gsl_multifit_test_delta (byval dx as gsl_vector ptr, byval x as gsl_vector ptr, byval epsabs as double, byval epsrel as double) as integer
declare function gsl_multifit_test_gradient (byval g as gsl_vector ptr, byval epsabs as double) as integer
end extern

#endif
