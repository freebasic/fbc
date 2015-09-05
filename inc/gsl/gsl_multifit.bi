'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
''   multifit/gsl_multifit.h
''
''   Copyright (C) 2000, 2007, 2010 Brian Gough
''   Copyright (C) 2013, Patrick Alken
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
#include once "gsl/gsl_math.bi"
#include once "gsl/gsl_vector.bi"
#include once "gsl/gsl_matrix.bi"
#include once "gsl/gsl_types.bi"

extern "C"

#define __GSL_MULTIFIT_H__

type gsl_multifit_linear_workspace
	n as uinteger
	p as uinteger
	A as gsl_matrix ptr
	Q as gsl_matrix ptr
	QSI as gsl_matrix ptr
	S as gsl_vector ptr
	t as gsl_vector ptr
	xt as gsl_vector ptr
	D as gsl_vector ptr
end type

declare function gsl_multifit_linear_alloc(byval n as uinteger, byval p as uinteger) as gsl_multifit_linear_workspace ptr
declare sub gsl_multifit_linear_free(byval work as gsl_multifit_linear_workspace ptr)
declare function gsl_multifit_linear(byval X as const gsl_matrix ptr, byval y as const gsl_vector ptr, byval c as gsl_vector ptr, byval cov as gsl_matrix ptr, byval chisq as double ptr, byval work as gsl_multifit_linear_workspace ptr) as long
declare function gsl_multifit_linear_svd(byval X as const gsl_matrix ptr, byval y as const gsl_vector ptr, byval tol as double, byval rank as uinteger ptr, byval c as gsl_vector ptr, byval cov as gsl_matrix ptr, byval chisq as double ptr, byval work as gsl_multifit_linear_workspace ptr) as long
declare function gsl_multifit_linear_usvd(byval X as const gsl_matrix ptr, byval y as const gsl_vector ptr, byval tol as double, byval rank as uinteger ptr, byval c as gsl_vector ptr, byval cov as gsl_matrix ptr, byval chisq as double ptr, byval work as gsl_multifit_linear_workspace ptr) as long
declare function gsl_multifit_wlinear(byval X as const gsl_matrix ptr, byval w as const gsl_vector ptr, byval y as const gsl_vector ptr, byval c as gsl_vector ptr, byval cov as gsl_matrix ptr, byval chisq as double ptr, byval work as gsl_multifit_linear_workspace ptr) as long
declare function gsl_multifit_wlinear_svd(byval X as const gsl_matrix ptr, byval w as const gsl_vector ptr, byval y as const gsl_vector ptr, byval tol as double, byval rank as uinteger ptr, byval c as gsl_vector ptr, byval cov as gsl_matrix ptr, byval chisq as double ptr, byval work as gsl_multifit_linear_workspace ptr) as long
declare function gsl_multifit_wlinear_usvd(byval X as const gsl_matrix ptr, byval w as const gsl_vector ptr, byval y as const gsl_vector ptr, byval tol as double, byval rank as uinteger ptr, byval c as gsl_vector ptr, byval cov as gsl_matrix ptr, byval chisq as double ptr, byval work as gsl_multifit_linear_workspace ptr) as long
declare function gsl_multifit_linear_est(byval x as const gsl_vector ptr, byval c as const gsl_vector ptr, byval cov as const gsl_matrix ptr, byval y as double ptr, byval y_err as double ptr) as long
declare function gsl_multifit_linear_residuals(byval X as const gsl_matrix ptr, byval y as const gsl_vector ptr, byval c as const gsl_vector ptr, byval r as gsl_vector ptr) as long

type gsl_multifit_robust_type
	name as const zstring ptr
	wfun as function(byval r as const gsl_vector ptr, byval w as gsl_vector ptr) as long
	psi_deriv as function(byval r as const gsl_vector ptr, byval dpsi as gsl_vector ptr) as long
	tuning_default as double
end type

type gsl_multifit_robust_stats
	sigma_ols as double
	sigma_mad as double
	sigma_rob as double
	sigma as double
	Rsq as double
	adj_Rsq as double
	rmse as double
	sse as double
	dof as uinteger
	numit as uinteger
	weights as gsl_vector ptr
	r as gsl_vector ptr
end type

type gsl_multifit_robust_workspace
	n as uinteger
	p as uinteger
	numit as uinteger
	maxiter as uinteger
	as const gsl_multifit_robust_type ptr type
	tune as double
	r as gsl_vector ptr
	weights as gsl_vector ptr
	c_prev as gsl_vector ptr
	resfac as gsl_vector ptr
	psi as gsl_vector ptr
	dpsi as gsl_vector ptr
	QSI as gsl_matrix ptr
	D as gsl_vector ptr
	workn as gsl_vector ptr
	stats as gsl_multifit_robust_stats
	multifit_p as gsl_multifit_linear_workspace ptr
end type

extern gsl_multifit_robust_default as const gsl_multifit_robust_type ptr
extern gsl_multifit_robust_bisquare as const gsl_multifit_robust_type ptr
extern gsl_multifit_robust_cauchy as const gsl_multifit_robust_type ptr
extern gsl_multifit_robust_fair as const gsl_multifit_robust_type ptr
extern gsl_multifit_robust_huber as const gsl_multifit_robust_type ptr
extern gsl_multifit_robust_ols as const gsl_multifit_robust_type ptr
extern gsl_multifit_robust_welsch as const gsl_multifit_robust_type ptr

declare function gsl_multifit_robust_alloc(byval T as const gsl_multifit_robust_type ptr, byval n as const uinteger, byval p as const uinteger) as gsl_multifit_robust_workspace ptr
declare sub gsl_multifit_robust_free(byval w as gsl_multifit_robust_workspace ptr)
declare function gsl_multifit_robust_tune(byval tune as const double, byval w as gsl_multifit_robust_workspace ptr) as long
declare function gsl_multifit_robust_name(byval w as const gsl_multifit_robust_workspace ptr) as const zstring ptr
declare function gsl_multifit_robust_statistics(byval w as const gsl_multifit_robust_workspace ptr) as gsl_multifit_robust_stats
declare function gsl_multifit_robust(byval X as const gsl_matrix ptr, byval y as const gsl_vector ptr, byval c as gsl_vector ptr, byval cov as gsl_matrix ptr, byval w as gsl_multifit_robust_workspace ptr) as long
declare function gsl_multifit_robust_est(byval x as const gsl_vector ptr, byval c as const gsl_vector ptr, byval cov as const gsl_matrix ptr, byval y as double ptr, byval y_err as double ptr) as long

end extern
