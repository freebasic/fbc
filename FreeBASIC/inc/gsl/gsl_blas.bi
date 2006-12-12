''
''
'' gsl_blas -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_blas_bi__
#define __gsl_blas_bi__

#include once "gsl_vector.bi"
#include once "gsl_matrix.bi"
#include once "gsl_blas_types.bi"
#include once "gsl_types.bi"

extern "c"
declare function gsl_blas_sdsdot (byval alpha as single, byval X as gsl_vector_float ptr, byval Y as gsl_vector_float ptr, byval result as single ptr) as integer
declare function gsl_blas_dsdot (byval X as gsl_vector_float ptr, byval Y as gsl_vector_float ptr, byval result as double ptr) as integer
declare function gsl_blas_sdot (byval X as gsl_vector_float ptr, byval Y as gsl_vector_float ptr, byval result as single ptr) as integer
declare function gsl_blas_ddot (byval X as gsl_vector ptr, byval Y as gsl_vector ptr, byval result as double ptr) as integer
declare function gsl_blas_cdotu (byval X as gsl_vector_complex_float ptr, byval Y as gsl_vector_complex_float ptr, byval dotu as gsl_complex_float ptr) as integer
declare function gsl_blas_cdotc (byval X as gsl_vector_complex_float ptr, byval Y as gsl_vector_complex_float ptr, byval dotc as gsl_complex_float ptr) as integer
declare function gsl_blas_zdotu (byval X as gsl_vector_complex ptr, byval Y as gsl_vector_complex ptr, byval dotu as gsl_complex ptr) as integer
declare function gsl_blas_zdotc (byval X as gsl_vector_complex ptr, byval Y as gsl_vector_complex ptr, byval dotc as gsl_complex ptr) as integer
declare function gsl_blas_snrm2 (byval X as gsl_vector_float ptr) as single
declare function gsl_blas_sasum (byval X as gsl_vector_float ptr) as single
declare function gsl_blas_dnrm2 (byval X as gsl_vector ptr) as double
declare function gsl_blas_dasum (byval X as gsl_vector ptr) as double
declare function gsl_blas_scnrm2 (byval X as gsl_vector_complex_float ptr) as single
declare function gsl_blas_scasum (byval X as gsl_vector_complex_float ptr) as single
declare function gsl_blas_dznrm2 (byval X as gsl_vector_complex ptr) as double
declare function gsl_blas_dzasum (byval X as gsl_vector_complex ptr) as double
declare function gsl_blas_isamax (byval X as gsl_vector_float ptr) as CBLAS_INDEX_t
declare function gsl_blas_idamax (byval X as gsl_vector ptr) as CBLAS_INDEX_t
declare function gsl_blas_icamax (byval X as gsl_vector_complex_float ptr) as CBLAS_INDEX_t
declare function gsl_blas_izamax (byval X as gsl_vector_complex ptr) as CBLAS_INDEX_t
declare function gsl_blas_sswap (byval X as gsl_vector_float ptr, byval Y as gsl_vector_float ptr) as integer
declare function gsl_blas_scopy (byval X as gsl_vector_float ptr, byval Y as gsl_vector_float ptr) as integer
declare function gsl_blas_saxpy (byval alpha as single, byval X as gsl_vector_float ptr, byval Y as gsl_vector_float ptr) as integer
declare function gsl_blas_dswap (byval X as gsl_vector ptr, byval Y as gsl_vector ptr) as integer
declare function gsl_blas_dcopy (byval X as gsl_vector ptr, byval Y as gsl_vector ptr) as integer
declare function gsl_blas_daxpy (byval alpha as double, byval X as gsl_vector ptr, byval Y as gsl_vector ptr) as integer
declare function gsl_blas_cswap (byval X as gsl_vector_complex_float ptr, byval Y as gsl_vector_complex_float ptr) as integer
declare function gsl_blas_ccopy (byval X as gsl_vector_complex_float ptr, byval Y as gsl_vector_complex_float ptr) as integer
declare function gsl_blas_caxpy (byval alpha as gsl_complex_float, byval X as gsl_vector_complex_float ptr, byval Y as gsl_vector_complex_float ptr) as integer
declare function gsl_blas_zswap (byval X as gsl_vector_complex ptr, byval Y as gsl_vector_complex ptr) as integer
declare function gsl_blas_zcopy (byval X as gsl_vector_complex ptr, byval Y as gsl_vector_complex ptr) as integer
declare function gsl_blas_zaxpy (byval alpha as gsl_complex, byval X as gsl_vector_complex ptr, byval Y as gsl_vector_complex ptr) as integer
declare function gsl_blas_srotg (byval a as single ptr, byval b as single ptr, byval c as single ptr, byval s as single ptr) as integer
declare function gsl_blas_srotmg (byval d1 as single ptr, byval d2 as single ptr, byval b1 as single ptr, byval b2 as single, byval P as single ptr) as integer
declare function gsl_blas_srot (byval X as gsl_vector_float ptr, byval Y as gsl_vector_float ptr, byval c as single, byval s as single) as integer
declare function gsl_blas_srotm (byval X as gsl_vector_float ptr, byval Y as gsl_vector_float ptr, byval P as single ptr) as integer
declare function gsl_blas_drotg (byval a as double ptr, byval b as double ptr, byval c as double ptr, byval s as double ptr) as integer
declare function gsl_blas_drotmg (byval d1 as double ptr, byval d2 as double ptr, byval b1 as double ptr, byval b2 as double, byval P as double ptr) as integer
declare function gsl_blas_drot (byval X as gsl_vector ptr, byval Y as gsl_vector ptr, byval c as double, byval s as double) as integer
declare function gsl_blas_drotm (byval X as gsl_vector ptr, byval Y as gsl_vector ptr, byval P as double ptr) as integer
declare sub gsl_blas_sscal (byval alpha as single, byval X as gsl_vector_float ptr)
declare sub gsl_blas_dscal (byval alpha as double, byval X as gsl_vector ptr)
declare sub gsl_blas_cscal (byval alpha as gsl_complex_float, byval X as gsl_vector_complex_float ptr)
declare sub gsl_blas_zscal (byval alpha as gsl_complex, byval X as gsl_vector_complex ptr)
declare sub gsl_blas_csscal (byval alpha as single, byval X as gsl_vector_complex_float ptr)
declare sub gsl_blas_zdscal (byval alpha as double, byval X as gsl_vector_complex ptr)
declare function gsl_blas_sgemv (byval TransA as CBLAS_TRANSPOSE_t, byval alpha as single, byval A as gsl_matrix_float ptr, byval X as gsl_vector_float ptr, byval beta as single, byval Y as gsl_vector_float ptr) as integer
declare function gsl_blas_strmv (byval Uplo as CBLAS_UPLO_t, byval TransA as CBLAS_TRANSPOSE_t, byval Diag as CBLAS_DIAG_t, byval A as gsl_matrix_float ptr, byval X as gsl_vector_float ptr) as integer
declare function gsl_blas_strsv (byval Uplo as CBLAS_UPLO_t, byval TransA as CBLAS_TRANSPOSE_t, byval Diag as CBLAS_DIAG_t, byval A as gsl_matrix_float ptr, byval X as gsl_vector_float ptr) as integer
declare function gsl_blas_dgemv (byval TransA as CBLAS_TRANSPOSE_t, byval alpha as double, byval A as gsl_matrix ptr, byval X as gsl_vector ptr, byval beta as double, byval Y as gsl_vector ptr) as integer
declare function gsl_blas_dtrmv (byval Uplo as CBLAS_UPLO_t, byval TransA as CBLAS_TRANSPOSE_t, byval Diag as CBLAS_DIAG_t, byval A as gsl_matrix ptr, byval X as gsl_vector ptr) as integer
declare function gsl_blas_dtrsv (byval Uplo as CBLAS_UPLO_t, byval TransA as CBLAS_TRANSPOSE_t, byval Diag as CBLAS_DIAG_t, byval A as gsl_matrix ptr, byval X as gsl_vector ptr) as integer
declare function gsl_blas_cgemv (byval TransA as CBLAS_TRANSPOSE_t, byval alpha as gsl_complex_float, byval A as gsl_matrix_complex_float ptr, byval X as gsl_vector_complex_float ptr, byval beta as gsl_complex_float, byval Y as gsl_vector_complex_float ptr) as integer
declare function gsl_blas_ctrmv (byval Uplo as CBLAS_UPLO_t, byval TransA as CBLAS_TRANSPOSE_t, byval Diag as CBLAS_DIAG_t, byval A as gsl_matrix_complex_float ptr, byval X as gsl_vector_complex_float ptr) as integer
declare function gsl_blas_ctrsv (byval Uplo as CBLAS_UPLO_t, byval TransA as CBLAS_TRANSPOSE_t, byval Diag as CBLAS_DIAG_t, byval A as gsl_matrix_complex_float ptr, byval X as gsl_vector_complex_float ptr) as integer
declare function gsl_blas_zgemv (byval TransA as CBLAS_TRANSPOSE_t, byval alpha as gsl_complex, byval A as gsl_matrix_complex ptr, byval X as gsl_vector_complex ptr, byval beta as gsl_complex, byval Y as gsl_vector_complex ptr) as integer
declare function gsl_blas_ztrmv (byval Uplo as CBLAS_UPLO_t, byval TransA as CBLAS_TRANSPOSE_t, byval Diag as CBLAS_DIAG_t, byval A as gsl_matrix_complex ptr, byval X as gsl_vector_complex ptr) as integer
declare function gsl_blas_ztrsv (byval Uplo as CBLAS_UPLO_t, byval TransA as CBLAS_TRANSPOSE_t, byval Diag as CBLAS_DIAG_t, byval A as gsl_matrix_complex ptr, byval X as gsl_vector_complex ptr) as integer
declare function gsl_blas_ssymv (byval Uplo as CBLAS_UPLO_t, byval alpha as single, byval A as gsl_matrix_float ptr, byval X as gsl_vector_float ptr, byval beta as single, byval Y as gsl_vector_float ptr) as integer
declare function gsl_blas_sger (byval alpha as single, byval X as gsl_vector_float ptr, byval Y as gsl_vector_float ptr, byval A as gsl_matrix_float ptr) as integer
declare function gsl_blas_ssyr (byval Uplo as CBLAS_UPLO_t, byval alpha as single, byval X as gsl_vector_float ptr, byval A as gsl_matrix_float ptr) as integer
declare function gsl_blas_ssyr2 (byval Uplo as CBLAS_UPLO_t, byval alpha as single, byval X as gsl_vector_float ptr, byval Y as gsl_vector_float ptr, byval A as gsl_matrix_float ptr) as integer
declare function gsl_blas_dsymv (byval Uplo as CBLAS_UPLO_t, byval alpha as double, byval A as gsl_matrix ptr, byval X as gsl_vector ptr, byval beta as double, byval Y as gsl_vector ptr) as integer
declare function gsl_blas_dger (byval alpha as double, byval X as gsl_vector ptr, byval Y as gsl_vector ptr, byval A as gsl_matrix ptr) as integer
declare function gsl_blas_dsyr (byval Uplo as CBLAS_UPLO_t, byval alpha as double, byval X as gsl_vector ptr, byval A as gsl_matrix ptr) as integer
declare function gsl_blas_dsyr2 (byval Uplo as CBLAS_UPLO_t, byval alpha as double, byval X as gsl_vector ptr, byval Y as gsl_vector ptr, byval A as gsl_matrix ptr) as integer
declare function gsl_blas_chemv (byval Uplo as CBLAS_UPLO_t, byval alpha as gsl_complex_float, byval A as gsl_matrix_complex_float ptr, byval X as gsl_vector_complex_float ptr, byval beta as gsl_complex_float, byval Y as gsl_vector_complex_float ptr) as integer
declare function gsl_blas_cgeru (byval alpha as gsl_complex_float, byval X as gsl_vector_complex_float ptr, byval Y as gsl_vector_complex_float ptr, byval A as gsl_matrix_complex_float ptr) as integer
declare function gsl_blas_cgerc (byval alpha as gsl_complex_float, byval X as gsl_vector_complex_float ptr, byval Y as gsl_vector_complex_float ptr, byval A as gsl_matrix_complex_float ptr) as integer
declare function gsl_blas_cher (byval Uplo as CBLAS_UPLO_t, byval alpha as single, byval X as gsl_vector_complex_float ptr, byval A as gsl_matrix_complex_float ptr) as integer
declare function gsl_blas_cher2 (byval Uplo as CBLAS_UPLO_t, byval alpha as gsl_complex_float, byval X as gsl_vector_complex_float ptr, byval Y as gsl_vector_complex_float ptr, byval A as gsl_matrix_complex_float ptr) as integer
declare function gsl_blas_zhemv (byval Uplo as CBLAS_UPLO_t, byval alpha as gsl_complex, byval A as gsl_matrix_complex ptr, byval X as gsl_vector_complex ptr, byval beta as gsl_complex, byval Y as gsl_vector_complex ptr) as integer
declare function gsl_blas_zgeru (byval alpha as gsl_complex, byval X as gsl_vector_complex ptr, byval Y as gsl_vector_complex ptr, byval A as gsl_matrix_complex ptr) as integer
declare function gsl_blas_zgerc (byval alpha as gsl_complex, byval X as gsl_vector_complex ptr, byval Y as gsl_vector_complex ptr, byval A as gsl_matrix_complex ptr) as integer
declare function gsl_blas_zher (byval Uplo as CBLAS_UPLO_t, byval alpha as double, byval X as gsl_vector_complex ptr, byval A as gsl_matrix_complex ptr) as integer
declare function gsl_blas_zher2 (byval Uplo as CBLAS_UPLO_t, byval alpha as gsl_complex, byval X as gsl_vector_complex ptr, byval Y as gsl_vector_complex ptr, byval A as gsl_matrix_complex ptr) as integer
declare function gsl_blas_sgemm (byval TransA as CBLAS_TRANSPOSE_t, byval TransB as CBLAS_TRANSPOSE_t, byval alpha as single, byval A as gsl_matrix_float ptr, byval B as gsl_matrix_float ptr, byval beta as single, byval C as gsl_matrix_float ptr) as integer
declare function gsl_blas_ssymm (byval Side as CBLAS_SIDE_t, byval Uplo as CBLAS_UPLO_t, byval alpha as single, byval A as gsl_matrix_float ptr, byval B as gsl_matrix_float ptr, byval beta as single, byval C as gsl_matrix_float ptr) as integer
declare function gsl_blas_ssyrk (byval Uplo as CBLAS_UPLO_t, byval Trans as CBLAS_TRANSPOSE_t, byval alpha as single, byval A as gsl_matrix_float ptr, byval beta as single, byval C as gsl_matrix_float ptr) as integer
declare function gsl_blas_ssyr2k (byval Uplo as CBLAS_UPLO_t, byval Trans as CBLAS_TRANSPOSE_t, byval alpha as single, byval A as gsl_matrix_float ptr, byval B as gsl_matrix_float ptr, byval beta as single, byval C as gsl_matrix_float ptr) as integer
declare function gsl_blas_strmm (byval Side as CBLAS_SIDE_t, byval Uplo as CBLAS_UPLO_t, byval TransA as CBLAS_TRANSPOSE_t, byval Diag as CBLAS_DIAG_t, byval alpha as single, byval A as gsl_matrix_float ptr, byval B as gsl_matrix_float ptr) as integer
declare function gsl_blas_strsm (byval Side as CBLAS_SIDE_t, byval Uplo as CBLAS_UPLO_t, byval TransA as CBLAS_TRANSPOSE_t, byval Diag as CBLAS_DIAG_t, byval alpha as single, byval A as gsl_matrix_float ptr, byval B as gsl_matrix_float ptr) as integer
declare function gsl_blas_dgemm (byval TransA as CBLAS_TRANSPOSE_t, byval TransB as CBLAS_TRANSPOSE_t, byval alpha as double, byval A as gsl_matrix ptr, byval B as gsl_matrix ptr, byval beta as double, byval C as gsl_matrix ptr) as integer
declare function gsl_blas_dsymm (byval Side as CBLAS_SIDE_t, byval Uplo as CBLAS_UPLO_t, byval alpha as double, byval A as gsl_matrix ptr, byval B as gsl_matrix ptr, byval beta as double, byval C as gsl_matrix ptr) as integer
declare function gsl_blas_dsyrk (byval Uplo as CBLAS_UPLO_t, byval Trans as CBLAS_TRANSPOSE_t, byval alpha as double, byval A as gsl_matrix ptr, byval beta as double, byval C as gsl_matrix ptr) as integer
declare function gsl_blas_dsyr2k (byval Uplo as CBLAS_UPLO_t, byval Trans as CBLAS_TRANSPOSE_t, byval alpha as double, byval A as gsl_matrix ptr, byval B as gsl_matrix ptr, byval beta as double, byval C as gsl_matrix ptr) as integer
declare function gsl_blas_dtrmm (byval Side as CBLAS_SIDE_t, byval Uplo as CBLAS_UPLO_t, byval TransA as CBLAS_TRANSPOSE_t, byval Diag as CBLAS_DIAG_t, byval alpha as double, byval A as gsl_matrix ptr, byval B as gsl_matrix ptr) as integer
declare function gsl_blas_dtrsm (byval Side as CBLAS_SIDE_t, byval Uplo as CBLAS_UPLO_t, byval TransA as CBLAS_TRANSPOSE_t, byval Diag as CBLAS_DIAG_t, byval alpha as double, byval A as gsl_matrix ptr, byval B as gsl_matrix ptr) as integer
declare function gsl_blas_cgemm (byval TransA as CBLAS_TRANSPOSE_t, byval TransB as CBLAS_TRANSPOSE_t, byval alpha as gsl_complex_float, byval A as gsl_matrix_complex_float ptr, byval B as gsl_matrix_complex_float ptr, byval beta as gsl_complex_float, byval C as gsl_matrix_complex_float ptr) as integer
declare function gsl_blas_csymm (byval Side as CBLAS_SIDE_t, byval Uplo as CBLAS_UPLO_t, byval alpha as gsl_complex_float, byval A as gsl_matrix_complex_float ptr, byval B as gsl_matrix_complex_float ptr, byval beta as gsl_complex_float, byval C as gsl_matrix_complex_float ptr) as integer
declare function gsl_blas_csyrk (byval Uplo as CBLAS_UPLO_t, byval Trans as CBLAS_TRANSPOSE_t, byval alpha as gsl_complex_float, byval A as gsl_matrix_complex_float ptr, byval beta as gsl_complex_float, byval C as gsl_matrix_complex_float ptr) as integer
declare function gsl_blas_csyr2k (byval Uplo as CBLAS_UPLO_t, byval Trans as CBLAS_TRANSPOSE_t, byval alpha as gsl_complex_float, byval A as gsl_matrix_complex_float ptr, byval B as gsl_matrix_complex_float ptr, byval beta as gsl_complex_float, byval C as gsl_matrix_complex_float ptr) as integer
declare function gsl_blas_ctrmm (byval Side as CBLAS_SIDE_t, byval Uplo as CBLAS_UPLO_t, byval TransA as CBLAS_TRANSPOSE_t, byval Diag as CBLAS_DIAG_t, byval alpha as gsl_complex_float, byval A as gsl_matrix_complex_float ptr, byval B as gsl_matrix_complex_float ptr) as integer
declare function gsl_blas_ctrsm (byval Side as CBLAS_SIDE_t, byval Uplo as CBLAS_UPLO_t, byval TransA as CBLAS_TRANSPOSE_t, byval Diag as CBLAS_DIAG_t, byval alpha as gsl_complex_float, byval A as gsl_matrix_complex_float ptr, byval B as gsl_matrix_complex_float ptr) as integer
declare function gsl_blas_zgemm (byval TransA as CBLAS_TRANSPOSE_t, byval TransB as CBLAS_TRANSPOSE_t, byval alpha as gsl_complex, byval A as gsl_matrix_complex ptr, byval B as gsl_matrix_complex ptr, byval beta as gsl_complex, byval C as gsl_matrix_complex ptr) as integer
declare function gsl_blas_zsymm (byval Side as CBLAS_SIDE_t, byval Uplo as CBLAS_UPLO_t, byval alpha as gsl_complex, byval A as gsl_matrix_complex ptr, byval B as gsl_matrix_complex ptr, byval beta as gsl_complex, byval C as gsl_matrix_complex ptr) as integer
declare function gsl_blas_zsyrk (byval Uplo as CBLAS_UPLO_t, byval Trans as CBLAS_TRANSPOSE_t, byval alpha as gsl_complex, byval A as gsl_matrix_complex ptr, byval beta as gsl_complex, byval C as gsl_matrix_complex ptr) as integer
declare function gsl_blas_zsyr2k (byval Uplo as CBLAS_UPLO_t, byval Trans as CBLAS_TRANSPOSE_t, byval alpha as gsl_complex, byval A as gsl_matrix_complex ptr, byval B as gsl_matrix_complex ptr, byval beta as gsl_complex, byval C as gsl_matrix_complex ptr) as integer
declare function gsl_blas_ztrmm (byval Side as CBLAS_SIDE_t, byval Uplo as CBLAS_UPLO_t, byval TransA as CBLAS_TRANSPOSE_t, byval Diag as CBLAS_DIAG_t, byval alpha as gsl_complex, byval A as gsl_matrix_complex ptr, byval B as gsl_matrix_complex ptr) as integer
declare function gsl_blas_ztrsm (byval Side as CBLAS_SIDE_t, byval Uplo as CBLAS_UPLO_t, byval TransA as CBLAS_TRANSPOSE_t, byval Diag as CBLAS_DIAG_t, byval alpha as gsl_complex, byval A as gsl_matrix_complex ptr, byval B as gsl_matrix_complex ptr) as integer
declare function gsl_blas_chemm (byval Side as CBLAS_SIDE_t, byval Uplo as CBLAS_UPLO_t, byval alpha as gsl_complex_float, byval A as gsl_matrix_complex_float ptr, byval B as gsl_matrix_complex_float ptr, byval beta as gsl_complex_float, byval C as gsl_matrix_complex_float ptr) as integer
declare function gsl_blas_cherk (byval Uplo as CBLAS_UPLO_t, byval Trans as CBLAS_TRANSPOSE_t, byval alpha as single, byval A as gsl_matrix_complex_float ptr, byval beta as single, byval C as gsl_matrix_complex_float ptr) as integer
declare function gsl_blas_cher2k (byval Uplo as CBLAS_UPLO_t, byval Trans as CBLAS_TRANSPOSE_t, byval alpha as gsl_complex_float, byval A as gsl_matrix_complex_float ptr, byval B as gsl_matrix_complex_float ptr, byval beta as single, byval C as gsl_matrix_complex_float ptr) as integer
declare function gsl_blas_zhemm (byval Side as CBLAS_SIDE_t, byval Uplo as CBLAS_UPLO_t, byval alpha as gsl_complex, byval A as gsl_matrix_complex ptr, byval B as gsl_matrix_complex ptr, byval beta as gsl_complex, byval C as gsl_matrix_complex ptr) as integer
declare function gsl_blas_zherk (byval Uplo as CBLAS_UPLO_t, byval Trans as CBLAS_TRANSPOSE_t, byval alpha as double, byval A as gsl_matrix_complex ptr, byval beta as double, byval C as gsl_matrix_complex ptr) as integer
declare function gsl_blas_zher2k (byval Uplo as CBLAS_UPLO_t, byval Trans as CBLAS_TRANSPOSE_t, byval alpha as gsl_complex, byval A as gsl_matrix_complex ptr, byval B as gsl_matrix_complex ptr, byval beta as double, byval C as gsl_matrix_complex ptr) as integer
end extern

#endif
