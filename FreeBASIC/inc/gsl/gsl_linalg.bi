''
''
'' gsl_linalg -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_linalg_bi__
#define __gsl_linalg_bi__

#include once "gsl_mode.bi"
#include once "gsl_permutation.bi"
#include once "gsl_vector.bi"
#include once "gsl_matrix.bi"
#include once "gsl_types.bi"

enum gsl_linalg_matrix_mod_t
	GSL_LINALG_MOD_NONE = 0
	GSL_LINALG_MOD_TRANSPOSE = 1
	GSL_LINALG_MOD_CONJUGATE = 2
end enum


extern "c"
declare function gsl_linalg_matmult (byval A as gsl_matrix ptr, byval B as gsl_matrix ptr, byval C as gsl_matrix ptr) as integer
declare function gsl_linalg_matmult_mod (byval A as gsl_matrix ptr, byval modA as gsl_linalg_matrix_mod_t, byval B as gsl_matrix ptr, byval modB as gsl_linalg_matrix_mod_t, byval C as gsl_matrix ptr) as integer
declare function gsl_linalg_exponential_ss (byval A as gsl_matrix ptr, byval eA as gsl_matrix ptr, byval mode as gsl_mode_t) as integer
declare function gsl_linalg_householder_transform (byval v as gsl_vector ptr) as double
declare function gsl_linalg_complex_householder_transform (byval v as gsl_vector_complex ptr) as gsl_complex
declare function gsl_linalg_householder_hm (byval tau as double, byval v as gsl_vector ptr, byval A as gsl_matrix ptr) as integer
declare function gsl_linalg_householder_mh (byval tau as double, byval v as gsl_vector ptr, byval A as gsl_matrix ptr) as integer
declare function gsl_linalg_householder_hv (byval tau as double, byval v as gsl_vector ptr, byval w as gsl_vector ptr) as integer
declare function gsl_linalg_householder_hm1 (byval tau as double, byval A as gsl_matrix ptr) as integer
declare function gsl_linalg_complex_householder_hm (byval tau as gsl_complex, byval v as gsl_vector_complex ptr, byval A as gsl_matrix_complex ptr) as integer
declare function gsl_linalg_complex_householder_hv (byval tau as gsl_complex, byval v as gsl_vector_complex ptr, byval w as gsl_vector_complex ptr) as integer
declare function gsl_linalg_SV_decomp (byval A as gsl_matrix ptr, byval V as gsl_matrix ptr, byval S as gsl_vector ptr, byval work as gsl_vector ptr) as integer
declare function gsl_linalg_SV_decomp_mod (byval A as gsl_matrix ptr, byval X as gsl_matrix ptr, byval V as gsl_matrix ptr, byval S as gsl_vector ptr, byval work as gsl_vector ptr) as integer
declare function gsl_linalg_SV_decomp_jacobi (byval A as gsl_matrix ptr, byval Q as gsl_matrix ptr, byval S as gsl_vector ptr) as integer
declare function gsl_linalg_SV_solve (byval U as gsl_matrix ptr, byval Q as gsl_matrix ptr, byval S as gsl_vector ptr, byval b as gsl_vector ptr, byval x as gsl_vector ptr) as integer
declare function gsl_linalg_LU_decomp (byval A as gsl_matrix ptr, byval p as gsl_permutation ptr, byval signum as integer ptr) as integer
declare function gsl_linalg_LU_solve (byval LU as gsl_matrix ptr, byval p as gsl_permutation ptr, byval b as gsl_vector ptr, byval x as gsl_vector ptr) as integer
declare function gsl_linalg_LU_svx (byval LU as gsl_matrix ptr, byval p as gsl_permutation ptr, byval x as gsl_vector ptr) as integer
declare function gsl_linalg_LU_refine (byval A as gsl_matrix ptr, byval LU as gsl_matrix ptr, byval p as gsl_permutation ptr, byval b as gsl_vector ptr, byval x as gsl_vector ptr, byval residual as gsl_vector ptr) as integer
declare function gsl_linalg_LU_invert (byval LU as gsl_matrix ptr, byval p as gsl_permutation ptr, byval inverse as gsl_matrix ptr) as integer
declare function gsl_linalg_LU_det (byval LU as gsl_matrix ptr, byval signum as integer) as double
declare function gsl_linalg_LU_lndet (byval LU as gsl_matrix ptr) as double
declare function gsl_linalg_LU_sgndet (byval lu as gsl_matrix ptr, byval signum as integer) as integer
declare function gsl_linalg_complex_LU_decomp (byval A as gsl_matrix_complex ptr, byval p as gsl_permutation ptr, byval signum as integer ptr) as integer
declare function gsl_linalg_complex_LU_solve (byval LU as gsl_matrix_complex ptr, byval p as gsl_permutation ptr, byval b as gsl_vector_complex ptr, byval x as gsl_vector_complex ptr) as integer
declare function gsl_linalg_complex_LU_svx (byval LU as gsl_matrix_complex ptr, byval p as gsl_permutation ptr, byval x as gsl_vector_complex ptr) as integer
declare function gsl_linalg_complex_LU_refine (byval A as gsl_matrix_complex ptr, byval LU as gsl_matrix_complex ptr, byval p as gsl_permutation ptr, byval b as gsl_vector_complex ptr, byval x as gsl_vector_complex ptr, byval residual as gsl_vector_complex ptr) as integer
declare function gsl_linalg_complex_LU_invert (byval LU as gsl_matrix_complex ptr, byval p as gsl_permutation ptr, byval inverse as gsl_matrix_complex ptr) as integer
declare function gsl_linalg_complex_LU_det (byval LU as gsl_matrix_complex ptr, byval signum as integer) as gsl_complex
declare function gsl_linalg_complex_LU_lndet (byval LU as gsl_matrix_complex ptr) as double
declare function gsl_linalg_complex_LU_sgndet (byval LU as gsl_matrix_complex ptr, byval signum as integer) as gsl_complex
declare function gsl_linalg_QR_decomp (byval A as gsl_matrix ptr, byval tau as gsl_vector ptr) as integer
declare function gsl_linalg_QR_solve (byval QR as gsl_matrix ptr, byval tau as gsl_vector ptr, byval b as gsl_vector ptr, byval x as gsl_vector ptr) as integer
declare function gsl_linalg_QR_svx (byval QR as gsl_matrix ptr, byval tau as gsl_vector ptr, byval x as gsl_vector ptr) as integer
declare function gsl_linalg_QR_lssolve (byval QR as gsl_matrix ptr, byval tau as gsl_vector ptr, byval b as gsl_vector ptr, byval x as gsl_vector ptr, byval residual as gsl_vector ptr) as integer
declare function gsl_linalg_QR_QRsolve (byval Q as gsl_matrix ptr, byval R as gsl_matrix ptr, byval b as gsl_vector ptr, byval x as gsl_vector ptr) as integer
declare function gsl_linalg_QR_Rsolve (byval QR as gsl_matrix ptr, byval b as gsl_vector ptr, byval x as gsl_vector ptr) as integer
declare function gsl_linalg_QR_Rsvx (byval QR as gsl_matrix ptr, byval x as gsl_vector ptr) as integer
declare function gsl_linalg_QR_update (byval Q as gsl_matrix ptr, byval R as gsl_matrix ptr, byval w as gsl_vector ptr, byval v as gsl_vector ptr) as integer
declare function gsl_linalg_QR_QTvec (byval QR as gsl_matrix ptr, byval tau as gsl_vector ptr, byval v as gsl_vector ptr) as integer
declare function gsl_linalg_QR_Qvec (byval QR as gsl_matrix ptr, byval tau as gsl_vector ptr, byval v as gsl_vector ptr) as integer
declare function gsl_linalg_QR_unpack (byval QR as gsl_matrix ptr, byval tau as gsl_vector ptr, byval Q as gsl_matrix ptr, byval R as gsl_matrix ptr) as integer
declare function gsl_linalg_R_solve (byval R as gsl_matrix ptr, byval b as gsl_vector ptr, byval x as gsl_vector ptr) as integer
declare function gsl_linalg_R_svx (byval R as gsl_matrix ptr, byval x as gsl_vector ptr) as integer
declare function gsl_linalg_QRPT_decomp (byval A as gsl_matrix ptr, byval tau as gsl_vector ptr, byval p as gsl_permutation ptr, byval signum as integer ptr, byval norm as gsl_vector ptr) as integer
declare function gsl_linalg_QRPT_decomp2 (byval A as gsl_matrix ptr, byval q as gsl_matrix ptr, byval r as gsl_matrix ptr, byval tau as gsl_vector ptr, byval p as gsl_permutation ptr, byval signum as integer ptr, byval norm as gsl_vector ptr) as integer
declare function gsl_linalg_QRPT_solve (byval QR as gsl_matrix ptr, byval tau as gsl_vector ptr, byval p as gsl_permutation ptr, byval b as gsl_vector ptr, byval x as gsl_vector ptr) as integer
declare function gsl_linalg_QRPT_svx (byval QR as gsl_matrix ptr, byval tau as gsl_vector ptr, byval p as gsl_permutation ptr, byval x as gsl_vector ptr) as integer
declare function gsl_linalg_QRPT_QRsolve (byval Q as gsl_matrix ptr, byval R as gsl_matrix ptr, byval p as gsl_permutation ptr, byval b as gsl_vector ptr, byval x as gsl_vector ptr) as integer
declare function gsl_linalg_QRPT_Rsolve (byval QR as gsl_matrix ptr, byval p as gsl_permutation ptr, byval b as gsl_vector ptr, byval x as gsl_vector ptr) as integer
declare function gsl_linalg_QRPT_Rsvx (byval QR as gsl_matrix ptr, byval p as gsl_permutation ptr, byval x as gsl_vector ptr) as integer
declare function gsl_linalg_QRPT_update (byval Q as gsl_matrix ptr, byval R as gsl_matrix ptr, byval p as gsl_permutation ptr, byval u as gsl_vector ptr, byval v as gsl_vector ptr) as integer
declare function gsl_linalg_LQ_decomp (byval A as gsl_matrix ptr, byval tau as gsl_vector ptr) as integer
declare function gsl_linalg_LQ_solve_T (byval LQ as gsl_matrix ptr, byval tau as gsl_vector ptr, byval b as gsl_vector ptr, byval x as gsl_vector ptr) as integer
declare function gsl_linalg_LQ_svx_T (byval LQ as gsl_matrix ptr, byval tau as gsl_vector ptr, byval x as gsl_vector ptr) as integer
declare function gsl_linalg_LQ_lssolve_T (byval LQ as gsl_matrix ptr, byval tau as gsl_vector ptr, byval b as gsl_vector ptr, byval x as gsl_vector ptr, byval residual as gsl_vector ptr) as integer
declare function gsl_linalg_LQ_Lsolve_T (byval LQ as gsl_matrix ptr, byval b as gsl_vector ptr, byval x as gsl_vector ptr) as integer
declare function gsl_linalg_LQ_Lsvx_T (byval LQ as gsl_matrix ptr, byval x as gsl_vector ptr) as integer
declare function gsl_linalg_L_solve_T (byval L as gsl_matrix ptr, byval b as gsl_vector ptr, byval x as gsl_vector ptr) as integer
declare function gsl_linalg_LQ_vecQ (byval LQ as gsl_matrix ptr, byval tau as gsl_vector ptr, byval v as gsl_vector ptr) as integer
declare function gsl_linalg_LQ_vecQT (byval LQ as gsl_matrix ptr, byval tau as gsl_vector ptr, byval v as gsl_vector ptr) as integer
declare function gsl_linalg_LQ_unpack (byval LQ as gsl_matrix ptr, byval tau as gsl_vector ptr, byval Q as gsl_matrix ptr, byval L as gsl_matrix ptr) as integer
declare function gsl_linalg_LQ_update (byval Q as gsl_matrix ptr, byval R as gsl_matrix ptr, byval v as gsl_vector ptr, byval w as gsl_vector ptr) as integer
declare function gsl_linalg_LQ_LQsolve (byval Q as gsl_matrix ptr, byval L as gsl_matrix ptr, byval b as gsl_vector ptr, byval x as gsl_vector ptr) as integer
declare function gsl_linalg_PTLQ_decomp (byval A as gsl_matrix ptr, byval tau as gsl_vector ptr, byval p as gsl_permutation ptr, byval signum as integer ptr, byval norm as gsl_vector ptr) as integer
declare function gsl_linalg_PTLQ_decomp2 (byval A as gsl_matrix ptr, byval q as gsl_matrix ptr, byval r as gsl_matrix ptr, byval tau as gsl_vector ptr, byval p as gsl_permutation ptr, byval signum as integer ptr, byval norm as gsl_vector ptr) as integer
declare function gsl_linalg_PTLQ_solve_T (byval QR as gsl_matrix ptr, byval tau as gsl_vector ptr, byval p as gsl_permutation ptr, byval b as gsl_vector ptr, byval x as gsl_vector ptr) as integer
declare function gsl_linalg_PTLQ_svx_T (byval LQ as gsl_matrix ptr, byval tau as gsl_vector ptr, byval p as gsl_permutation ptr, byval x as gsl_vector ptr) as integer
declare function gsl_linalg_PTLQ_LQsolve_T (byval Q as gsl_matrix ptr, byval L as gsl_matrix ptr, byval p as gsl_permutation ptr, byval b as gsl_vector ptr, byval x as gsl_vector ptr) as integer
declare function gsl_linalg_PTLQ_Lsolve_T (byval LQ as gsl_matrix ptr, byval p as gsl_permutation ptr, byval b as gsl_vector ptr, byval x as gsl_vector ptr) as integer
declare function gsl_linalg_PTLQ_Lsvx_T (byval LQ as gsl_matrix ptr, byval p as gsl_permutation ptr, byval x as gsl_vector ptr) as integer
declare function gsl_linalg_PTLQ_update (byval Q as gsl_matrix ptr, byval L as gsl_matrix ptr, byval p as gsl_permutation ptr, byval v as gsl_vector ptr, byval w as gsl_vector ptr) as integer
declare function gsl_linalg_cholesky_decomp (byval A as gsl_matrix ptr) as integer
declare function gsl_linalg_cholesky_solve (byval cholesky as gsl_matrix ptr, byval b as gsl_vector ptr, byval x as gsl_vector ptr) as integer
declare function gsl_linalg_cholesky_svx (byval cholesky as gsl_matrix ptr, byval x as gsl_vector ptr) as integer
declare function gsl_linalg_symmtd_decomp (byval A as gsl_matrix ptr, byval tau as gsl_vector ptr) as integer
declare function gsl_linalg_symmtd_unpack (byval A as gsl_matrix ptr, byval tau as gsl_vector ptr, byval Q as gsl_matrix ptr, byval diag as gsl_vector ptr, byval subdiag as gsl_vector ptr) as integer
declare function gsl_linalg_symmtd_unpack_T (byval A as gsl_matrix ptr, byval diag as gsl_vector ptr, byval subdiag as gsl_vector ptr) as integer
declare function gsl_linalg_hermtd_decomp (byval A as gsl_matrix_complex ptr, byval tau as gsl_vector_complex ptr) as integer
declare function gsl_linalg_hermtd_unpack (byval A as gsl_matrix_complex ptr, byval tau as gsl_vector_complex ptr, byval Q as gsl_matrix_complex ptr, byval diag as gsl_vector ptr, byval sudiag as gsl_vector ptr) as integer
declare function gsl_linalg_hermtd_unpack_T (byval A as gsl_matrix_complex ptr, byval diag as gsl_vector ptr, byval subdiag as gsl_vector ptr) as integer
declare function gsl_linalg_HH_solve (byval A as gsl_matrix ptr, byval b as gsl_vector ptr, byval x as gsl_vector ptr) as integer
declare function gsl_linalg_HH_svx (byval A as gsl_matrix ptr, byval x as gsl_vector ptr) as integer
declare function gsl_linalg_solve_symm_tridiag (byval diag as gsl_vector ptr, byval offdiag as gsl_vector ptr, byval b as gsl_vector ptr, byval x as gsl_vector ptr) as integer
declare function gsl_linalg_solve_tridiag (byval diag as gsl_vector ptr, byval abovediag as gsl_vector ptr, byval belowdiag as gsl_vector ptr, byval b as gsl_vector ptr, byval x as gsl_vector ptr) as integer
declare function gsl_linalg_solve_symm_cyc_tridiag (byval diag as gsl_vector ptr, byval offdiag as gsl_vector ptr, byval b as gsl_vector ptr, byval x as gsl_vector ptr) as integer
declare function gsl_linalg_solve_cyc_tridiag (byval diag as gsl_vector ptr, byval abovediag as gsl_vector ptr, byval belowdiag as gsl_vector ptr, byval b as gsl_vector ptr, byval x as gsl_vector ptr) as integer
declare function gsl_linalg_bidiag_decomp (byval A as gsl_matrix ptr, byval tau_U as gsl_vector ptr, byval tau_V as gsl_vector ptr) as integer
declare function gsl_linalg_bidiag_unpack (byval A as gsl_matrix ptr, byval tau_U as gsl_vector ptr, byval U as gsl_matrix ptr, byval tau_V as gsl_vector ptr, byval V as gsl_matrix ptr, byval diag as gsl_vector ptr, byval superdiag as gsl_vector ptr) as integer
declare function gsl_linalg_bidiag_unpack2 (byval A as gsl_matrix ptr, byval tau_U as gsl_vector ptr, byval tau_V as gsl_vector ptr, byval V as gsl_matrix ptr) as integer
declare function gsl_linalg_bidiag_unpack_B (byval A as gsl_matrix ptr, byval diag as gsl_vector ptr, byval superdiag as gsl_vector ptr) as integer
declare function gsl_linalg_balance_columns (byval A as gsl_matrix ptr, byval D as gsl_vector ptr) as integer
end extern

#endif
