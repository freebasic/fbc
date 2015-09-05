'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
''   siman/gsl_siman.h
''
''   Copyright (C) 1996, 1997, 1998, 1999, 2000 Mark Galassi
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
#include once "gsl/gsl_rng.bi"

extern "C"

#define __GSL_SIMAN_H__
type gsl_siman_Efunc_t as function(byval xp as any ptr) as double
type gsl_siman_step_t as sub(byval r as const gsl_rng ptr, byval xp as any ptr, byval step_size as double)
type gsl_siman_metric_t as function(byval xp as any ptr, byval yp as any ptr) as double
type gsl_siman_print_t as sub(byval xp as any ptr)
type gsl_siman_copy_t as sub(byval source as any ptr, byval dest as any ptr)
type gsl_siman_copy_construct_t as function(byval xp as any ptr) as any ptr
type gsl_siman_destroy_t as sub(byval xp as any ptr)

type gsl_siman_params_t
	n_tries as long
	iters_fixed_T as long
	step_size as double
	k as double
	t_initial as double
	mu_t as double
	t_min as double
end type

declare sub gsl_siman_solve(byval r as const gsl_rng ptr, byval x0_p as any ptr, byval Ef as gsl_siman_Efunc_t, byval take_step as gsl_siman_step_t, byval distance as gsl_siman_metric_t, byval print_position as gsl_siman_print_t, byval copyfunc as gsl_siman_copy_t, byval copy_constructor as gsl_siman_copy_construct_t, byval destructor as gsl_siman_destroy_t, byval element_size as uinteger, byval params as gsl_siman_params_t)
declare sub gsl_siman_solve_many(byval r as const gsl_rng ptr, byval x0_p as any ptr, byval Ef as gsl_siman_Efunc_t, byval take_step as gsl_siman_step_t, byval distance as gsl_siman_metric_t, byval print_position as gsl_siman_print_t, byval element_size as uinteger, byval params as gsl_siman_params_t)

end extern
