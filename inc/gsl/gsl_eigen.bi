'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
''   eigen/gsl_eigen.h
''
''   Copyright (C) 1996, 1997, 1998, 1999, 2000, 2006, 2007 Gerard Jungman, Brian Gough, Patrick Alken
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

#include once "gsl/gsl_vector.bi"
#include once "gsl/gsl_matrix.bi"

extern "C"

#define __GSL_EIGEN_H__

type gsl_eigen_symm_workspace
	size as uinteger
	d as double ptr
	sd as double ptr
end type

declare function gsl_eigen_symm_alloc(byval n as const uinteger) as gsl_eigen_symm_workspace ptr
declare sub gsl_eigen_symm_free(byval w as gsl_eigen_symm_workspace ptr)
declare function gsl_eigen_symm(byval A as gsl_matrix ptr, byval eval as gsl_vector ptr, byval w as gsl_eigen_symm_workspace ptr) as long

type gsl_eigen_symmv_workspace
	size as uinteger
	d as double ptr
	sd as double ptr
	gc as double ptr
	gs as double ptr
end type

declare function gsl_eigen_symmv_alloc(byval n as const uinteger) as gsl_eigen_symmv_workspace ptr
declare sub gsl_eigen_symmv_free(byval w as gsl_eigen_symmv_workspace ptr)
declare function gsl_eigen_symmv(byval A as gsl_matrix ptr, byval eval as gsl_vector ptr, byval evec as gsl_matrix ptr, byval w as gsl_eigen_symmv_workspace ptr) as long

type gsl_eigen_herm_workspace
	size as uinteger
	d as double ptr
	sd as double ptr
	tau as double ptr
end type

declare function gsl_eigen_herm_alloc(byval n as const uinteger) as gsl_eigen_herm_workspace ptr
declare sub gsl_eigen_herm_free(byval w as gsl_eigen_herm_workspace ptr)
declare function gsl_eigen_herm(byval A as gsl_matrix_complex ptr, byval eval as gsl_vector ptr, byval w as gsl_eigen_herm_workspace ptr) as long

type gsl_eigen_hermv_workspace
	size as uinteger
	d as double ptr
	sd as double ptr
	tau as double ptr
	gc as double ptr
	gs as double ptr
end type

declare function gsl_eigen_hermv_alloc(byval n as const uinteger) as gsl_eigen_hermv_workspace ptr
declare sub gsl_eigen_hermv_free(byval w as gsl_eigen_hermv_workspace ptr)
declare function gsl_eigen_hermv(byval A as gsl_matrix_complex ptr, byval eval as gsl_vector ptr, byval evec as gsl_matrix_complex ptr, byval w as gsl_eigen_hermv_workspace ptr) as long

type gsl_eigen_francis_workspace
	size as uinteger
	max_iterations as uinteger
	n_iter as uinteger
	n_evals as uinteger
	compute_t as long
	H as gsl_matrix ptr
	Z as gsl_matrix ptr
end type

declare function gsl_eigen_francis_alloc() as gsl_eigen_francis_workspace ptr
declare sub gsl_eigen_francis_free(byval w as gsl_eigen_francis_workspace ptr)
declare sub gsl_eigen_francis_T(byval compute_t as const long, byval w as gsl_eigen_francis_workspace ptr)
declare function gsl_eigen_francis(byval H as gsl_matrix ptr, byval eval as gsl_vector_complex ptr, byval w as gsl_eigen_francis_workspace ptr) as long
declare function gsl_eigen_francis_Z(byval H as gsl_matrix ptr, byval eval as gsl_vector_complex ptr, byval Z as gsl_matrix ptr, byval w as gsl_eigen_francis_workspace ptr) as long

type gsl_eigen_nonsymm_workspace
	size as uinteger
	diag as gsl_vector ptr
	tau as gsl_vector ptr
	Z as gsl_matrix ptr
	do_balance as long
	n_evals as uinteger
	francis_workspace_p as gsl_eigen_francis_workspace ptr
end type

declare function gsl_eigen_nonsymm_alloc(byval n as const uinteger) as gsl_eigen_nonsymm_workspace ptr
declare sub gsl_eigen_nonsymm_free(byval w as gsl_eigen_nonsymm_workspace ptr)
declare sub gsl_eigen_nonsymm_params(byval compute_t as const long, byval balance as const long, byval w as gsl_eigen_nonsymm_workspace ptr)
declare function gsl_eigen_nonsymm(byval A as gsl_matrix ptr, byval eval as gsl_vector_complex ptr, byval w as gsl_eigen_nonsymm_workspace ptr) as long
declare function gsl_eigen_nonsymm_Z(byval A as gsl_matrix ptr, byval eval as gsl_vector_complex ptr, byval Z as gsl_matrix ptr, byval w as gsl_eigen_nonsymm_workspace ptr) as long

type gsl_eigen_nonsymmv_workspace
	size as uinteger
	work as gsl_vector ptr
	work2 as gsl_vector ptr
	work3 as gsl_vector ptr
	Z as gsl_matrix ptr
	nonsymm_workspace_p as gsl_eigen_nonsymm_workspace ptr
end type

declare function gsl_eigen_nonsymmv_alloc(byval n as const uinteger) as gsl_eigen_nonsymmv_workspace ptr
declare sub gsl_eigen_nonsymmv_free(byval w as gsl_eigen_nonsymmv_workspace ptr)
declare sub gsl_eigen_nonsymmv_params(byval balance as const long, byval w as gsl_eigen_nonsymmv_workspace ptr)
declare function gsl_eigen_nonsymmv(byval A as gsl_matrix ptr, byval eval as gsl_vector_complex ptr, byval evec as gsl_matrix_complex ptr, byval w as gsl_eigen_nonsymmv_workspace ptr) as long
declare function gsl_eigen_nonsymmv_Z(byval A as gsl_matrix ptr, byval eval as gsl_vector_complex ptr, byval evec as gsl_matrix_complex ptr, byval Z as gsl_matrix ptr, byval w as gsl_eigen_nonsymmv_workspace ptr) as long

type gsl_eigen_gensymm_workspace
	size as uinteger
	symm_workspace_p as gsl_eigen_symm_workspace ptr
end type

declare function gsl_eigen_gensymm_alloc(byval n as const uinteger) as gsl_eigen_gensymm_workspace ptr
declare sub gsl_eigen_gensymm_free(byval w as gsl_eigen_gensymm_workspace ptr)
declare function gsl_eigen_gensymm(byval A as gsl_matrix ptr, byval B as gsl_matrix ptr, byval eval as gsl_vector ptr, byval w as gsl_eigen_gensymm_workspace ptr) as long
declare function gsl_eigen_gensymm_standardize(byval A as gsl_matrix ptr, byval B as const gsl_matrix ptr) as long

type gsl_eigen_gensymmv_workspace
	size as uinteger
	symmv_workspace_p as gsl_eigen_symmv_workspace ptr
end type

declare function gsl_eigen_gensymmv_alloc(byval n as const uinteger) as gsl_eigen_gensymmv_workspace ptr
declare sub gsl_eigen_gensymmv_free(byval w as gsl_eigen_gensymmv_workspace ptr)
declare function gsl_eigen_gensymmv(byval A as gsl_matrix ptr, byval B as gsl_matrix ptr, byval eval as gsl_vector ptr, byval evec as gsl_matrix ptr, byval w as gsl_eigen_gensymmv_workspace ptr) as long

type gsl_eigen_genherm_workspace
	size as uinteger
	herm_workspace_p as gsl_eigen_herm_workspace ptr
end type

declare function gsl_eigen_genherm_alloc(byval n as const uinteger) as gsl_eigen_genherm_workspace ptr
declare sub gsl_eigen_genherm_free(byval w as gsl_eigen_genherm_workspace ptr)
declare function gsl_eigen_genherm(byval A as gsl_matrix_complex ptr, byval B as gsl_matrix_complex ptr, byval eval as gsl_vector ptr, byval w as gsl_eigen_genherm_workspace ptr) as long
declare function gsl_eigen_genherm_standardize(byval A as gsl_matrix_complex ptr, byval B as const gsl_matrix_complex ptr) as long

type gsl_eigen_genhermv_workspace
	size as uinteger
	hermv_workspace_p as gsl_eigen_hermv_workspace ptr
end type

declare function gsl_eigen_genhermv_alloc(byval n as const uinteger) as gsl_eigen_genhermv_workspace ptr
declare sub gsl_eigen_genhermv_free(byval w as gsl_eigen_genhermv_workspace ptr)
declare function gsl_eigen_genhermv(byval A as gsl_matrix_complex ptr, byval B as gsl_matrix_complex ptr, byval eval as gsl_vector ptr, byval evec as gsl_matrix_complex ptr, byval w as gsl_eigen_genhermv_workspace ptr) as long

type gsl_eigen_gen_workspace
	size as uinteger
	work as gsl_vector ptr
	n_evals as uinteger
	max_iterations as uinteger
	n_iter as uinteger
	eshift as double
	needtop as long
	atol as double
	btol as double
	ascale as double
	bscale as double
	H as gsl_matrix ptr
	R as gsl_matrix ptr
	compute_s as long
	compute_t as long
	Q as gsl_matrix ptr
	Z as gsl_matrix ptr
end type

declare function gsl_eigen_gen_alloc(byval n as const uinteger) as gsl_eigen_gen_workspace ptr
declare sub gsl_eigen_gen_free(byval w as gsl_eigen_gen_workspace ptr)
declare sub gsl_eigen_gen_params(byval compute_s as const long, byval compute_t as const long, byval balance as const long, byval w as gsl_eigen_gen_workspace ptr)
declare function gsl_eigen_gen(byval A as gsl_matrix ptr, byval B as gsl_matrix ptr, byval alpha as gsl_vector_complex ptr, byval beta as gsl_vector ptr, byval w as gsl_eigen_gen_workspace ptr) as long
declare function gsl_eigen_gen_QZ(byval A as gsl_matrix ptr, byval B as gsl_matrix ptr, byval alpha as gsl_vector_complex ptr, byval beta as gsl_vector ptr, byval Q as gsl_matrix ptr, byval Z as gsl_matrix ptr, byval w as gsl_eigen_gen_workspace ptr) as long

type gsl_eigen_genv_workspace
	size as uinteger
	work1 as gsl_vector ptr
	work2 as gsl_vector ptr
	work3 as gsl_vector ptr
	work4 as gsl_vector ptr
	work5 as gsl_vector ptr
	work6 as gsl_vector ptr
	Q as gsl_matrix ptr
	Z as gsl_matrix ptr
	gen_workspace_p as gsl_eigen_gen_workspace ptr
end type

declare function gsl_eigen_genv_alloc(byval n as const uinteger) as gsl_eigen_genv_workspace ptr
declare sub gsl_eigen_genv_free(byval w as gsl_eigen_genv_workspace ptr)
declare function gsl_eigen_genv(byval A as gsl_matrix ptr, byval B as gsl_matrix ptr, byval alpha as gsl_vector_complex ptr, byval beta as gsl_vector ptr, byval evec as gsl_matrix_complex ptr, byval w as gsl_eigen_genv_workspace ptr) as long
declare function gsl_eigen_genv_QZ(byval A as gsl_matrix ptr, byval B as gsl_matrix ptr, byval alpha as gsl_vector_complex ptr, byval beta as gsl_vector ptr, byval evec as gsl_matrix_complex ptr, byval Q as gsl_matrix ptr, byval Z as gsl_matrix ptr, byval w as gsl_eigen_genv_workspace ptr) as long

type gsl_eigen_sort_t as long
enum
	GSL_EIGEN_SORT_VAL_ASC
	GSL_EIGEN_SORT_VAL_DESC
	GSL_EIGEN_SORT_ABS_ASC
	GSL_EIGEN_SORT_ABS_DESC
end enum

declare function gsl_eigen_symmv_sort(byval eval as gsl_vector ptr, byval evec as gsl_matrix ptr, byval sort_type as gsl_eigen_sort_t) as long
declare function gsl_eigen_hermv_sort(byval eval as gsl_vector ptr, byval evec as gsl_matrix_complex ptr, byval sort_type as gsl_eigen_sort_t) as long
declare function gsl_eigen_nonsymmv_sort(byval eval as gsl_vector_complex ptr, byval evec as gsl_matrix_complex ptr, byval sort_type as gsl_eigen_sort_t) as long
declare function gsl_eigen_gensymmv_sort(byval eval as gsl_vector ptr, byval evec as gsl_matrix ptr, byval sort_type as gsl_eigen_sort_t) as long
declare function gsl_eigen_genhermv_sort(byval eval as gsl_vector ptr, byval evec as gsl_matrix_complex ptr, byval sort_type as gsl_eigen_sort_t) as long
declare function gsl_eigen_genv_sort(byval alpha as gsl_vector_complex ptr, byval beta as gsl_vector ptr, byval evec as gsl_matrix_complex ptr, byval sort_type as gsl_eigen_sort_t) as long
declare function gsl_schur_gen_eigvals(byval A as const gsl_matrix ptr, byval B as const gsl_matrix ptr, byval wr1 as double ptr, byval wr2 as double ptr, byval wi as double ptr, byval scale1 as double ptr, byval scale2 as double ptr) as long
declare function gsl_schur_solve_equation(byval ca as double, byval A as const gsl_matrix ptr, byval z as double, byval d1 as double, byval d2 as double, byval b as const gsl_vector ptr, byval x as gsl_vector ptr, byval s as double ptr, byval xnorm as double ptr, byval smin as double) as long
declare function gsl_schur_solve_equation_z(byval ca as double, byval A as const gsl_matrix ptr, byval z as gsl_complex ptr, byval d1 as double, byval d2 as double, byval b as const gsl_vector_complex ptr, byval x as gsl_vector_complex ptr, byval s as double ptr, byval xnorm as double ptr, byval smin as double) as long
declare function gsl_eigen_jacobi(byval matrix as gsl_matrix ptr, byval eval as gsl_vector ptr, byval evec as gsl_matrix ptr, byval max_rot as ulong, byval nrot as ulong ptr) as long
declare function gsl_eigen_invert_jacobi(byval matrix as const gsl_matrix ptr, byval ainv as gsl_matrix ptr, byval max_rot as ulong) as long

end extern
