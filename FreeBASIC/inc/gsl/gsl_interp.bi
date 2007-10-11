''
''
'' gsl_interp -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_interp_bi__
#define __gsl_interp_bi__

#include once "gsl_types.bi"

type gsl_interp_accel
	cache as integer
	miss_count as integer
	hit_count as integer
end type

type gsl_interp_type
	name as byte ptr
	min_size as uinteger
	alloc as sub cdecl(byval as integer)
	init as function cdecl(byval as any ptr, byval as double ptr, byval as double ptr, byval as integer) as integer
	eval as function cdecl(byval as any ptr, byval as double ptr, byval as double ptr, byval as integer, byval as double, byval as gsl_interp_accel ptr, byval as double ptr) as integer
	eval_deriv as function cdecl(byval as any ptr, byval as double ptr, byval as double ptr, byval as integer, byval as double, byval as gsl_interp_accel ptr, byval as double ptr) as integer
	eval_deriv2 as function cdecl(byval as any ptr, byval as double ptr, byval as double ptr, byval as integer, byval as double, byval as gsl_interp_accel ptr, byval as double ptr) as integer
	eval_integ as function cdecl(byval as any ptr, byval as double ptr, byval as double ptr, byval as integer, byval as gsl_interp_accel ptr, byval as double, byval as double, byval as double ptr) as integer
	free as sub cdecl(byval as any ptr)
end type

type gsl_interp
	type as gsl_interp_type ptr
	xmin as double
	xmax as double
	size as integer
	state as any ptr
end type

extern "c"
declare function gsl_interp_accel_alloc () as gsl_interp_accel ptr
declare function gsl_interp_accel_find (byval a as gsl_interp_accel ptr, byval x_array as double ptr, byval size as integer, byval x as double) as integer
declare function gsl_interp_accel_reset (byval a as gsl_interp_accel ptr) as integer
declare sub gsl_interp_accel_free (byval a as gsl_interp_accel ptr)
declare function gsl_interp_alloc (byval T as gsl_interp_type ptr, byval n as integer) as gsl_interp ptr
declare function gsl_interp_init (byval obj as gsl_interp ptr, byval xa as double ptr, byval ya as double ptr, byval size as integer) as integer
declare function gsl_interp_name (byval interp as gsl_interp ptr) as zstring ptr
declare function gsl_interp_min_size (byval interp as gsl_interp ptr) as uinteger
declare function gsl_interp_eval_e (byval obj as gsl_interp ptr, byval xa as double ptr, byval ya as double ptr, byval x as double, byval a as gsl_interp_accel ptr, byval y as double ptr) as integer
declare function gsl_interp_eval (byval obj as gsl_interp ptr, byval xa as double ptr, byval ya as double ptr, byval x as double, byval a as gsl_interp_accel ptr) as double
declare function gsl_interp_eval_deriv_e (byval obj as gsl_interp ptr, byval xa as double ptr, byval ya as double ptr, byval x as double, byval a as gsl_interp_accel ptr, byval d as double ptr) as integer
declare function gsl_interp_eval_deriv (byval obj as gsl_interp ptr, byval xa as double ptr, byval ya as double ptr, byval x as double, byval a as gsl_interp_accel ptr) as double
declare function gsl_interp_eval_deriv2_e (byval obj as gsl_interp ptr, byval xa as double ptr, byval ya as double ptr, byval x as double, byval a as gsl_interp_accel ptr, byval d2 as double ptr) as integer
declare function gsl_interp_eval_deriv2 (byval obj as gsl_interp ptr, byval xa as double ptr, byval ya as double ptr, byval x as double, byval a as gsl_interp_accel ptr) as double
declare function gsl_interp_eval_integ_e (byval obj as gsl_interp ptr, byval xa as double ptr, byval ya as double ptr, byval a as double, byval b as double, byval acc as gsl_interp_accel ptr, byval result as double ptr) as integer
declare function gsl_interp_eval_integ (byval obj as gsl_interp ptr, byval xa as double ptr, byval ya as double ptr, byval a as double, byval b as double, byval acc as gsl_interp_accel ptr) as double
declare sub gsl_interp_free (byval interp as gsl_interp ptr)
declare function gsl_interp_bsearch (byval x_array as double ptr, byval x as double, byval index_lo as integer, byval index_hi as integer) as integer
end extern

#endif
