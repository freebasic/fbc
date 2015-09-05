'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
''   interpolation/gsl_interp.h
''
''   Copyright (C) 1996, 1997, 1998, 1999, 2000, 2004 Gerard Jungman
''
''   This program is free software; you can redistribute it and/or modify
''   it under the terms of the GNU General Public License as published by
''   the Free Software Foundation; either version 3 of the License, or (at
''   your option) any later version.
''
''   This program is distributed in the hope that it will be useful, but
''   WITHOUT ANY WARRANTY; without even the implied warranty of
''   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
''   General Public License for more details.
''
''   You should have received a copy of the GNU General Public License
''   along with this program; if not, write to the Free Software
''   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "crt/stdlib.bi"
#include once "gsl/gsl_inline.bi"
#include once "gsl/gsl_types.bi"

extern "C"

#define __GSL_INTERP_H__

type gsl_interp_accel
	cache as uinteger
	miss_count as uinteger
	hit_count as uinteger
end type

type gsl_interp_type
	name as const zstring ptr
	min_size as ulong
	alloc as function(byval size as uinteger) as any ptr
	init as function(byval as any ptr, byval xa as const double ptr, byval ya as const double ptr, byval size as uinteger) as long
	eval as function(byval as const any ptr, byval xa as const double ptr, byval ya as const double ptr, byval size as uinteger, byval x as double, byval as gsl_interp_accel ptr, byval y as double ptr) as long
	eval_deriv as function(byval as const any ptr, byval xa as const double ptr, byval ya as const double ptr, byval size as uinteger, byval x as double, byval as gsl_interp_accel ptr, byval y_p as double ptr) as long
	eval_deriv2 as function(byval as const any ptr, byval xa as const double ptr, byval ya as const double ptr, byval size as uinteger, byval x as double, byval as gsl_interp_accel ptr, byval y_pp as double ptr) as long
	eval_integ as function(byval as const any ptr, byval xa as const double ptr, byval ya as const double ptr, byval size as uinteger, byval as gsl_interp_accel ptr, byval a as double, byval b as double, byval result as double ptr) as long
	free as sub(byval as any ptr)
end type

type gsl_interp
	as const gsl_interp_type ptr type
	xmin as double
	xmax as double
	size as uinteger
	state as any ptr
end type

extern gsl_interp_linear as const gsl_interp_type ptr
extern gsl_interp_polynomial as const gsl_interp_type ptr
extern gsl_interp_cspline as const gsl_interp_type ptr
extern gsl_interp_cspline_periodic as const gsl_interp_type ptr
extern gsl_interp_akima as const gsl_interp_type ptr
extern gsl_interp_akima_periodic as const gsl_interp_type ptr

declare function gsl_interp_accel_alloc() as gsl_interp_accel ptr
declare function gsl_interp_accel_reset(byval a as gsl_interp_accel ptr) as long
declare sub gsl_interp_accel_free(byval a as gsl_interp_accel ptr)
declare function gsl_interp_alloc(byval T as const gsl_interp_type ptr, byval n as uinteger) as gsl_interp ptr
declare function gsl_interp_init(byval obj as gsl_interp ptr, byval xa as const double ptr, byval ya as const double ptr, byval size as uinteger) as long
declare function gsl_interp_name(byval interp as const gsl_interp ptr) as const zstring ptr
declare function gsl_interp_min_size(byval interp as const gsl_interp ptr) as ulong
declare function gsl_interp_type_min_size(byval T as const gsl_interp_type ptr) as ulong
declare function gsl_interp_eval_e(byval obj as const gsl_interp ptr, byval xa as const double ptr, byval ya as const double ptr, byval x as double, byval a as gsl_interp_accel ptr, byval y as double ptr) as long
declare function gsl_interp_eval(byval obj as const gsl_interp ptr, byval xa as const double ptr, byval ya as const double ptr, byval x as double, byval a as gsl_interp_accel ptr) as double
declare function gsl_interp_eval_deriv_e(byval obj as const gsl_interp ptr, byval xa as const double ptr, byval ya as const double ptr, byval x as double, byval a as gsl_interp_accel ptr, byval d as double ptr) as long
declare function gsl_interp_eval_deriv(byval obj as const gsl_interp ptr, byval xa as const double ptr, byval ya as const double ptr, byval x as double, byval a as gsl_interp_accel ptr) as double
declare function gsl_interp_eval_deriv2_e(byval obj as const gsl_interp ptr, byval xa as const double ptr, byval ya as const double ptr, byval x as double, byval a as gsl_interp_accel ptr, byval d2 as double ptr) as long
declare function gsl_interp_eval_deriv2(byval obj as const gsl_interp ptr, byval xa as const double ptr, byval ya as const double ptr, byval x as double, byval a as gsl_interp_accel ptr) as double
declare function gsl_interp_eval_integ_e(byval obj as const gsl_interp ptr, byval xa as const double ptr, byval ya as const double ptr, byval a as double, byval b as double, byval acc as gsl_interp_accel ptr, byval result as double ptr) as long
declare function gsl_interp_eval_integ(byval obj as const gsl_interp ptr, byval xa as const double ptr, byval ya as const double ptr, byval a as double, byval b as double, byval acc as gsl_interp_accel ptr) as double
declare sub gsl_interp_free(byval interp as gsl_interp ptr)
declare function gsl_interp_bsearch(byval x_array as const double ptr, byval x as double, byval index_lo as uinteger, byval index_hi as uinteger) as uinteger
declare function gsl_interp_accel_find(byval a as gsl_interp_accel ptr, byval x_array as const double ptr, byval size as uinteger, byval x as double) as uinteger

end extern
