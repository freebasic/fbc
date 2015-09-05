'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
''   linalg/gsl_linalg.h
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

#include once "gsl/gsl_mode.bi"
#include once "gsl/gsl_permutation.bi"
#include once "gsl/gsl_vector.bi"
#include once "gsl/gsl_matrix.bi"

extern "C"

#define __GSL_LINALG_H__

type gsl_linalg_matrix_mod_t as long
enum
	GSL_LINALG_MOD_NONE = 0
	GSL_LINALG_MOD_TRANSPOSE = 1
	GSL_LINALG_MOD_CONJUGATE = 2
end enum

declare function gsl_linalg_matmult(byval A as const gsl_matrix ptr, byval B as const gsl_matrix ptr, byval C as gsl_matrix ptr) as long
declare function gsl_linalg_matmult_mod(byval A as const gsl_matrix ptr, byval modA as gsl_linalg_matrix_mod_t, byval B as const gsl_matrix ptr, byval modB as gsl_linalg_matrix_mod_t, byval C as gsl_matrix ptr) as long
declare function gsl_linalg_exponential_ss(byval A as const gsl_matrix ptr, byval eA as gsl_matrix ptr, byval mode as gsl_mode_t) as long
declare function gsl_linalg_householder_transform(byval v as gsl_vector ptr) as double
declare function gsl_linalg_complex_householder_transform(byval v as gsl_vector_complex ptr) as gsl_complex
declare function gsl_linalg_householder_hm(byval tau as double, byval v as const gsl_vector ptr, byval A as gsl_matrix ptr) as long
declare function gsl_linalg_householder_mh(byval tau as double, byval v as const gsl_vector ptr, byval A as gsl_matrix ptr) as long
declare function gsl_linalg_householder_hv(byval tau as double, byval v as const gsl_vector ptr, byval w as gsl_vector ptr) as long
declare function gsl_linalg_householder_hm1(byval tau as double, byval A as gsl_matrix ptr) as long
declare function gsl_linalg_complex_householder_hm(byval tau as gsl_complex, byval v as const gsl_vector_complex ptr, byval A as gsl_matrix_complex ptr) as long
declare function gsl_linalg_complex_householder_mh(byval tau as gsl_complex, byval v as const gsl_vector_complex ptr, byval A as gsl_matrix_complex ptr) as long
declare function gsl_linalg_complex_householder_hv(byval tau as gsl_complex, byval v as const gsl_vector_complex ptr, byval w as gsl_vector_complex ptr) as long
declare function gsl_linalg_hessenberg_decomp(byval A as gsl_matrix ptr, byval tau as gsl_vector ptr) as long
declare function gsl_linalg_hessenberg_unpack(byval H as gsl_matrix ptr, byval tau as gsl_vector ptr, byval U as gsl_matrix ptr) as long
declare function gsl_linalg_hessenberg_unpack_accum(byval H as gsl_matrix ptr, byval tau as gsl_vector ptr, byval U as gsl_matrix ptr) as long
declare function gsl_linalg_hessenberg_set_zero(byval H as gsl_matrix ptr) as long
declare function gsl_linalg_hessenberg_submatrix(byval M as gsl_matrix ptr, byval A as gsl_matrix ptr, byval top as uinteger, byval tau as gsl_vector ptr) as long
declare function gsl_linalg_hessenberg(byval A as gsl_matrix ptr, byval tau as gsl_vector ptr) as long
declare function gsl_linalg_hesstri_decomp(byval A as gsl_matrix ptr, byval B as gsl_matrix ptr, byval U as gsl_matrix ptr, byval V as gsl_matrix ptr, byval work as gsl_vector ptr) as long
declare function gsl_linalg_SV_decomp(byval A as gsl_matrix ptr, byval V as gsl_matrix ptr, byval S as gsl_vector ptr, byval work as gsl_vector ptr) as long
declare function gsl_linalg_SV_decomp_mod(byval A as gsl_matrix ptr, byval X as gsl_matrix ptr, byval V as gsl_matrix ptr, byval S as gsl_vector ptr, byval work as gsl_vector ptr) as long
declare function gsl_linalg_SV_decomp_jacobi(byval A as gsl_matrix ptr, byval Q as gsl_matrix ptr, byval S as gsl_vector ptr) as long
declare function gsl_linalg_SV_solve(byval U as const gsl_matrix ptr, byval Q as const gsl_matrix ptr, byval S as const gsl_vector ptr, byval b as const gsl_vector ptr, byval x as gsl_vector ptr) as long
declare function gsl_linalg_SV_leverage(byval U as const gsl_matrix ptr, byval h as gsl_vector ptr) as long
declare function gsl_linalg_LU_decomp(byval A as gsl_matrix ptr, byval p as gsl_permutation ptr, byval signum as long ptr) as long
declare function gsl_linalg_LU_solve(byval LU as const gsl_matrix ptr, byval p as const gsl_permutation ptr, byval b as const gsl_vector ptr, byval x as gsl_vector ptr) as long
declare function gsl_linalg_LU_svx(byval LU as const gsl_matrix ptr, byval p as const gsl_permutation ptr, byval x as gsl_vector ptr) as long
declare function gsl_linalg_LU_refine(byval A as const gsl_matrix ptr, byval LU as const gsl_matrix ptr, byval p as const gsl_permutation ptr, byval b as const gsl_vector ptr, byval x as gsl_vector ptr, byval residual as gsl_vector ptr) as long
declare function gsl_linalg_LU_invert(byval LU as const gsl_matrix ptr, byval p as const gsl_permutation ptr, byval inverse as gsl_matrix ptr) as long
declare function gsl_linalg_LU_det(byval LU as gsl_matrix ptr, byval signum as long) as double
declare function gsl_linalg_LU_lndet(byval LU as gsl_matrix ptr) as double
declare function gsl_linalg_LU_sgndet(byval lu as gsl_matrix ptr, byval signum as long) as long
declare function gsl_linalg_complex_LU_decomp(byval A as gsl_matrix_complex ptr, byval p as gsl_permutation ptr, byval signum as long ptr) as long
declare function gsl_linalg_complex_LU_solve(byval LU as const gsl_matrix_complex ptr, byval p as const gsl_permutation ptr, byval b as const gsl_vector_complex ptr, byval x as gsl_vector_complex ptr) as long
declare function gsl_linalg_complex_LU_svx(byval LU as const gsl_matrix_complex ptr, byval p as const gsl_permutation ptr, byval x as gsl_vector_complex ptr) as long
declare function gsl_linalg_complex_LU_refine(byval A as const gsl_matrix_complex ptr, byval LU as const gsl_matrix_complex ptr, byval p as const gsl_permutation ptr, byval b as const gsl_vector_complex ptr, byval x as gsl_vector_complex ptr, byval residual as gsl_vector_complex ptr) as long
declare function gsl_linalg_complex_LU_invert(byval LU as const gsl_matrix_complex ptr, byval p as const gsl_permutation ptr, byval inverse as gsl_matrix_complex ptr) as long
declare function gsl_linalg_complex_LU_det(byval LU as gsl_matrix_complex ptr, byval signum as long) as gsl_complex
declare function gsl_linalg_complex_LU_lndet(byval LU as gsl_matrix_complex ptr) as double
declare function gsl_linalg_complex_LU_sgndet(byval LU as gsl_matrix_complex ptr, byval signum as long) as gsl_complex
declare function gsl_linalg_QR_decomp(byval A as gsl_matrix ptr, byval tau as gsl_vector ptr) as long
declare function gsl_linalg_QR_solve(byval QR as const gsl_matrix ptr, byval tau as const gsl_vector ptr, byval b as const gsl_vector ptr, byval x as gsl_vector ptr) as long
declare function gsl_linalg_QR_svx(byval QR as const gsl_matrix ptr, byval tau as const gsl_vector ptr, byval x as gsl_vector ptr) as long
declare function gsl_linalg_QR_lssolve(byval QR as const gsl_matrix ptr, byval tau as const gsl_vector ptr, byval b as const gsl_vector ptr, byval x as gsl_vector ptr, byval residual as gsl_vector ptr) as long
declare function gsl_linalg_QR_QRsolve(byval Q as gsl_matrix ptr, byval R as gsl_matrix ptr, byval b as const gsl_vector ptr, byval x as gsl_vector ptr) as long
declare function gsl_linalg_QR_Rsolve(byval QR as const gsl_matrix ptr, byval b as const gsl_vector ptr, byval x as gsl_vector ptr) as long
declare function gsl_linalg_QR_Rsvx(byval QR as const gsl_matrix ptr, byval x as gsl_vector ptr) as long
declare function gsl_linalg_QR_update(byval Q as gsl_matrix ptr, byval R as gsl_matrix ptr, byval w as gsl_vector ptr, byval v as const gsl_vector ptr) as long
declare function gsl_linalg_QR_QTvec(byval QR as const gsl_matrix ptr, byval tau as const gsl_vector ptr, byval v as gsl_vector ptr) as long
declare function gsl_linalg_QR_Qvec(byval QR as const gsl_matrix ptr, byval tau as const gsl_vector ptr, byval v as gsl_vector ptr) as long
declare function gsl_linalg_QR_QTmat(byval QR as const gsl_matrix ptr, byval tau as const gsl_vector ptr, byval A as gsl_matrix ptr) as long
declare function gsl_linalg_QR_unpack(byval QR as const gsl_matrix ptr, byval tau as const gsl_vector ptr, byval Q as gsl_matrix ptr, byval R as gsl_matrix ptr) as long
declare function gsl_linalg_R_solve(byval R as const gsl_matrix ptr, byval b as const gsl_vector ptr, byval x as gsl_vector ptr) as long
declare function gsl_linalg_R_svx(byval R as const gsl_matrix ptr, byval x as gsl_vector ptr) as long
declare function gsl_linalg_QRPT_decomp(byval A as gsl_matrix ptr, byval tau as gsl_vector ptr, byval p as gsl_permutation ptr, byval signum as long ptr, byval norm as gsl_vector ptr) as long
declare function gsl_linalg_QRPT_decomp2(byval A as const gsl_matrix ptr, byval q as gsl_matrix ptr, byval r as gsl_matrix ptr, byval tau as gsl_vector ptr, byval p as gsl_permutation ptr, byval signum as long ptr, byval norm as gsl_vector ptr) as long
declare function gsl_linalg_QRPT_solve(byval QR as const gsl_matrix ptr, byval tau as const gsl_vector ptr, byval p as const gsl_permutation ptr, byval b as const gsl_vector ptr, byval x as gsl_vector ptr) as long
declare function gsl_linalg_QRPT_svx(byval QR as const gsl_matrix ptr, byval tau as const gsl_vector ptr, byval p as const gsl_permutation ptr, byval x as gsl_vector ptr) as long
declare function gsl_linalg_QRPT_QRsolve(byval Q as const gsl_matrix ptr, byval R as const gsl_matrix ptr, byval p as const gsl_permutation ptr, byval b as const gsl_vector ptr, byval x as gsl_vector ptr) as long
declare function gsl_linalg_QRPT_Rsolve(byval QR as const gsl_matrix ptr, byval p as const gsl_permutation ptr, byval b as const gsl_vector ptr, byval x as gsl_vector ptr) as long
declare function gsl_linalg_QRPT_Rsvx(byval QR as const gsl_matrix ptr, byval p as const gsl_permutation ptr, byval x as gsl_vector ptr) as long
declare function gsl_linalg_QRPT_update(byval Q as gsl_matrix ptr, byval R as gsl_matrix ptr, byval p as const gsl_permutation ptr, byval u as gsl_vector ptr, byval v as const gsl_vector ptr) as long
declare function gsl_linalg_LQ_decomp(byval A as gsl_matrix ptr, byval tau as gsl_vector ptr) as long
declare function gsl_linalg_LQ_solve_T(byval LQ as const gsl_matrix ptr, byval tau as const gsl_vector ptr, byval b as const gsl_vector ptr, byval x as gsl_vector ptr) as long
declare function gsl_linalg_LQ_svx_T(byval LQ as const gsl_matrix ptr, byval tau as const gsl_vector ptr, byval x as gsl_vector ptr) as long
declare function gsl_linalg_LQ_lssolve_T(byval LQ as const gsl_matrix ptr, byval tau as const gsl_vector ptr, byval b as const gsl_vector ptr, byval x as gsl_vector ptr, byval residual as gsl_vector ptr) as long
declare function gsl_linalg_LQ_Lsolve_T(byval LQ as const gsl_matrix ptr, byval b as const gsl_vector ptr, byval x as gsl_vector ptr) as long
declare function gsl_linalg_LQ_Lsvx_T(byval LQ as const gsl_matrix ptr, byval x as gsl_vector ptr) as long
declare function gsl_linalg_L_solve_T(byval L as const gsl_matrix ptr, byval b as const gsl_vector ptr, byval x as gsl_vector ptr) as long
declare function gsl_linalg_LQ_vecQ(byval LQ as const gsl_matrix ptr, byval tau as const gsl_vector ptr, byval v as gsl_vector ptr) as long
declare function gsl_linalg_LQ_vecQT(byval LQ as const gsl_matrix ptr, byval tau as const gsl_vector ptr, byval v as gsl_vector ptr) as long
declare function gsl_linalg_LQ_unpack(byval LQ as const gsl_matrix ptr, byval tau as const gsl_vector ptr, byval Q as gsl_matrix ptr, byval L as gsl_matrix ptr) as long
declare function gsl_linalg_LQ_update(byval Q as gsl_matrix ptr, byval R as gsl_matrix ptr, byval v as const gsl_vector ptr, byval w as gsl_vector ptr) as long
declare function gsl_linalg_LQ_LQsolve(byval Q as gsl_matrix ptr, byval L as gsl_matrix ptr, byval b as const gsl_vector ptr, byval x as gsl_vector ptr) as long
declare function gsl_linalg_PTLQ_decomp(byval A as gsl_matrix ptr, byval tau as gsl_vector ptr, byval p as gsl_permutation ptr, byval signum as long ptr, byval norm as gsl_vector ptr) as long
declare function gsl_linalg_PTLQ_decomp2(byval A as const gsl_matrix ptr, byval q as gsl_matrix ptr, byval r as gsl_matrix ptr, byval tau as gsl_vector ptr, byval p as gsl_permutation ptr, byval signum as long ptr, byval norm as gsl_vector ptr) as long
declare function gsl_linalg_PTLQ_solve_T(byval QR as const gsl_matrix ptr, byval tau as const gsl_vector ptr, byval p as const gsl_permutation ptr, byval b as const gsl_vector ptr, byval x as gsl_vector ptr) as long
declare function gsl_linalg_PTLQ_svx_T(byval LQ as const gsl_matrix ptr, byval tau as const gsl_vector ptr, byval p as const gsl_permutation ptr, byval x as gsl_vector ptr) as long
declare function gsl_linalg_PTLQ_LQsolve_T(byval Q as const gsl_matrix ptr, byval L as const gsl_matrix ptr, byval p as const gsl_permutation ptr, byval b as const gsl_vector ptr, byval x as gsl_vector ptr) as long
declare function gsl_linalg_PTLQ_Lsolve_T(byval LQ as const gsl_matrix ptr, byval p as const gsl_permutation ptr, byval b as const gsl_vector ptr, byval x as gsl_vector ptr) as long
declare function gsl_linalg_PTLQ_Lsvx_T(byval LQ as const gsl_matrix ptr, byval p as const gsl_permutation ptr, byval x as gsl_vector ptr) as long
declare function gsl_linalg_PTLQ_update(byval Q as gsl_matrix ptr, byval L as gsl_matrix ptr, byval p as const gsl_permutation ptr, byval v as const gsl_vector ptr, byval w as gsl_vector ptr) as long
declare function gsl_linalg_cholesky_decomp(byval A as gsl_matrix ptr) as long
declare function gsl_linalg_cholesky_solve(byval cholesky as const gsl_matrix ptr, byval b as const gsl_vector ptr, byval x as gsl_vector ptr) as long
declare function gsl_linalg_cholesky_svx(byval cholesky as const gsl_matrix ptr, byval x as gsl_vector ptr) as long
declare function gsl_linalg_cholesky_invert(byval cholesky as gsl_matrix ptr) as long
declare function gsl_linalg_cholesky_decomp_unit(byval A as gsl_matrix ptr, byval D as gsl_vector ptr) as long
declare function gsl_linalg_complex_cholesky_decomp(byval A as gsl_matrix_complex ptr) as long
declare function gsl_linalg_complex_cholesky_solve(byval cholesky as const gsl_matrix_complex ptr, byval b as const gsl_vector_complex ptr, byval x as gsl_vector_complex ptr) as long
declare function gsl_linalg_complex_cholesky_svx(byval cholesky as const gsl_matrix_complex ptr, byval x as gsl_vector_complex ptr) as long
declare function gsl_linalg_complex_cholesky_invert(byval cholesky as gsl_matrix_complex ptr) as long
declare function gsl_linalg_symmtd_decomp(byval A as gsl_matrix ptr, byval tau as gsl_vector ptr) as long
declare function gsl_linalg_symmtd_unpack(byval A as const gsl_matrix ptr, byval tau as const gsl_vector ptr, byval Q as gsl_matrix ptr, byval diag as gsl_vector ptr, byval subdiag as gsl_vector ptr) as long
declare function gsl_linalg_symmtd_unpack_T(byval A as const gsl_matrix ptr, byval diag as gsl_vector ptr, byval subdiag as gsl_vector ptr) as long
declare function gsl_linalg_hermtd_decomp(byval A as gsl_matrix_complex ptr, byval tau as gsl_vector_complex ptr) as long
declare function gsl_linalg_hermtd_unpack(byval A as const gsl_matrix_complex ptr, byval tau as const gsl_vector_complex ptr, byval U as gsl_matrix_complex ptr, byval diag as gsl_vector ptr, byval sudiag as gsl_vector ptr) as long
declare function gsl_linalg_hermtd_unpack_T(byval A as const gsl_matrix_complex ptr, byval diag as gsl_vector ptr, byval subdiag as gsl_vector ptr) as long
declare function gsl_linalg_HH_solve(byval A as gsl_matrix ptr, byval b as const gsl_vector ptr, byval x as gsl_vector ptr) as long
declare function gsl_linalg_HH_svx(byval A as gsl_matrix ptr, byval x as gsl_vector ptr) as long
declare function gsl_linalg_solve_symm_tridiag(byval diag as const gsl_vector ptr, byval offdiag as const gsl_vector ptr, byval b as const gsl_vector ptr, byval x as gsl_vector ptr) as long
declare function gsl_linalg_solve_tridiag(byval diag as const gsl_vector ptr, byval abovediag as const gsl_vector ptr, byval belowdiag as const gsl_vector ptr, byval b as const gsl_vector ptr, byval x as gsl_vector ptr) as long
declare function gsl_linalg_solve_symm_cyc_tridiag(byval diag as const gsl_vector ptr, byval offdiag as const gsl_vector ptr, byval b as const gsl_vector ptr, byval x as gsl_vector ptr) as long
declare function gsl_linalg_solve_cyc_tridiag(byval diag as const gsl_vector ptr, byval abovediag as const gsl_vector ptr, byval belowdiag as const gsl_vector ptr, byval b as const gsl_vector ptr, byval x as gsl_vector ptr) as long
declare function gsl_linalg_bidiag_decomp(byval A as gsl_matrix ptr, byval tau_U as gsl_vector ptr, byval tau_V as gsl_vector ptr) as long
declare function gsl_linalg_bidiag_unpack(byval A as const gsl_matrix ptr, byval tau_U as const gsl_vector ptr, byval U as gsl_matrix ptr, byval tau_V as const gsl_vector ptr, byval V as gsl_matrix ptr, byval diag as gsl_vector ptr, byval superdiag as gsl_vector ptr) as long
declare function gsl_linalg_bidiag_unpack2(byval A as gsl_matrix ptr, byval tau_U as gsl_vector ptr, byval tau_V as gsl_vector ptr, byval V as gsl_matrix ptr) as long
declare function gsl_linalg_bidiag_unpack_B(byval A as const gsl_matrix ptr, byval diag as gsl_vector ptr, byval superdiag as gsl_vector ptr) as long
declare function gsl_linalg_balance_matrix(byval A as gsl_matrix ptr, byval D as gsl_vector ptr) as long
declare function gsl_linalg_balance_accum(byval A as gsl_matrix ptr, byval D as gsl_vector ptr) as long
declare function gsl_linalg_balance_columns(byval A as gsl_matrix ptr, byval D as gsl_vector ptr) as long

end extern
