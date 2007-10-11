''
''
'' gsl_cblas -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_cblas_bi__
#define __gsl_cblas_bi__

#ifdef __FB_LINUX__
# inclib "gslcblas"
#endif

#include once "gsl_types.bi"

enum CBLAS_ORDER
	CblasRowMajor = 101
	CblasColMajor = 102
end enum

enum CBLAS_TRANSPOSE
	CblasNoTrans = 111
	CblasTrans = 112
	CblasConjTrans = 113
end enum

enum CBLAS_UPLO
	CblasUpper = 121
	CblasLower = 122
end enum

enum CBLAS_DIAG
	CblasNonUnit = 131
	CblasUnit = 132
end enum

enum CBLAS_SIDE
	CblasLeft = 141
	CblasRight = 142
end enum

extern "c"
declare function cblas_sdsdot (byval N as integer, byval alpha as single, byval X as single ptr, byval incX as integer, byval Y as single ptr, byval incY as integer) as single
declare function cblas_dsdot (byval N as integer, byval X as single ptr, byval incX as integer, byval Y as single ptr, byval incY as integer) as double
declare function cblas_sdot (byval N as integer, byval X as single ptr, byval incX as integer, byval Y as single ptr, byval incY as integer) as single
declare function cblas_ddot (byval N as integer, byval X as double ptr, byval incX as integer, byval Y as double ptr, byval incY as integer) as double
declare sub cblas_cdotu_sub (byval N as integer, byval X as any ptr, byval incX as integer, byval Y as any ptr, byval incY as integer, byval dotu as any ptr)
declare sub cblas_cdotc_sub (byval N as integer, byval X as any ptr, byval incX as integer, byval Y as any ptr, byval incY as integer, byval dotc as any ptr)
declare sub cblas_zdotu_sub (byval N as integer, byval X as any ptr, byval incX as integer, byval Y as any ptr, byval incY as integer, byval dotu as any ptr)
declare sub cblas_zdotc_sub (byval N as integer, byval X as any ptr, byval incX as integer, byval Y as any ptr, byval incY as integer, byval dotc as any ptr)
declare function cblas_snrm2 (byval N as integer, byval X as single ptr, byval incX as integer) as single
declare function cblas_sasum (byval N as integer, byval X as single ptr, byval incX as integer) as single
declare function cblas_dnrm2 (byval N as integer, byval X as double ptr, byval incX as integer) as double
declare function cblas_dasum (byval N as integer, byval X as double ptr, byval incX as integer) as double
declare function cblas_scnrm2 (byval N as integer, byval X as any ptr, byval incX as integer) as single
declare function cblas_scasum (byval N as integer, byval X as any ptr, byval incX as integer) as single
declare function cblas_dznrm2 (byval N as integer, byval X as any ptr, byval incX as integer) as double
declare function cblas_dzasum (byval N as integer, byval X as any ptr, byval incX as integer) as double
declare function cblas_isamax (byval N as integer, byval X as single ptr, byval incX as integer) as integer
declare function cblas_idamax (byval N as integer, byval X as double ptr, byval incX as integer) as integer
declare function cblas_icamax (byval N as integer, byval X as any ptr, byval incX as integer) as integer
declare function cblas_izamax (byval N as integer, byval X as any ptr, byval incX as integer) as integer
declare sub cblas_sswap (byval N as integer, byval X as single ptr, byval incX as integer, byval Y as single ptr, byval incY as integer)
declare sub cblas_scopy (byval N as integer, byval X as single ptr, byval incX as integer, byval Y as single ptr, byval incY as integer)
declare sub cblas_saxpy (byval N as integer, byval alpha as single, byval X as single ptr, byval incX as integer, byval Y as single ptr, byval incY as integer)
declare sub cblas_dswap (byval N as integer, byval X as double ptr, byval incX as integer, byval Y as double ptr, byval incY as integer)
declare sub cblas_dcopy (byval N as integer, byval X as double ptr, byval incX as integer, byval Y as double ptr, byval incY as integer)
declare sub cblas_daxpy (byval N as integer, byval alpha as double, byval X as double ptr, byval incX as integer, byval Y as double ptr, byval incY as integer)
declare sub cblas_cswap (byval N as integer, byval X as any ptr, byval incX as integer, byval Y as any ptr, byval incY as integer)
declare sub cblas_ccopy (byval N as integer, byval X as any ptr, byval incX as integer, byval Y as any ptr, byval incY as integer)
declare sub cblas_caxpy (byval N as integer, byval alpha as any ptr, byval X as any ptr, byval incX as integer, byval Y as any ptr, byval incY as integer)
declare sub cblas_zswap (byval N as integer, byval X as any ptr, byval incX as integer, byval Y as any ptr, byval incY as integer)
declare sub cblas_zcopy (byval N as integer, byval X as any ptr, byval incX as integer, byval Y as any ptr, byval incY as integer)
declare sub cblas_zaxpy (byval N as integer, byval alpha as any ptr, byval X as any ptr, byval incX as integer, byval Y as any ptr, byval incY as integer)
declare sub cblas_srotg (byval a as single ptr, byval b as single ptr, byval c as single ptr, byval s as single ptr)
declare sub cblas_srotmg (byval d1 as single ptr, byval d2 as single ptr, byval b1 as single ptr, byval b2 as single, byval P as single ptr)
declare sub cblas_srot (byval N as integer, byval X as single ptr, byval incX as integer, byval Y as single ptr, byval incY as integer, byval c as single, byval s as single)
declare sub cblas_srotm (byval N as integer, byval X as single ptr, byval incX as integer, byval Y as single ptr, byval incY as integer, byval P as single ptr)
declare sub cblas_drotg (byval a as double ptr, byval b as double ptr, byval c as double ptr, byval s as double ptr)
declare sub cblas_drotmg (byval d1 as double ptr, byval d2 as double ptr, byval b1 as double ptr, byval b2 as double, byval P as double ptr)
declare sub cblas_drot (byval N as integer, byval X as double ptr, byval incX as integer, byval Y as double ptr, byval incY as integer, byval c as double, byval s as double)
declare sub cblas_drotm (byval N as integer, byval X as double ptr, byval incX as integer, byval Y as double ptr, byval incY as integer, byval P as double ptr)
declare sub cblas_sscal (byval N as integer, byval alpha as single, byval X as single ptr, byval incX as integer)
declare sub cblas_dscal (byval N as integer, byval alpha as double, byval X as double ptr, byval incX as integer)
declare sub cblas_cscal (byval N as integer, byval alpha as any ptr, byval X as any ptr, byval incX as integer)
declare sub cblas_zscal (byval N as integer, byval alpha as any ptr, byval X as any ptr, byval incX as integer)
declare sub cblas_csscal (byval N as integer, byval alpha as single, byval X as any ptr, byval incX as integer)
declare sub cblas_zdscal (byval N as integer, byval alpha as double, byval X as any ptr, byval incX as integer)
declare sub cblas_sgemv (byval order as CBLAS_ORDER, byval TransA as CBLAS_TRANSPOSE, byval M as integer, byval N as integer, byval alpha as single, byval A as single ptr, byval lda as integer, byval X as single ptr, byval incX as integer, byval beta as single, byval Y as single ptr, byval incY as integer)
declare sub cblas_sgbmv (byval order as CBLAS_ORDER, byval TransA as CBLAS_TRANSPOSE, byval M as integer, byval N as integer, byval KL as integer, byval KU as integer, byval alpha as single, byval A as single ptr, byval lda as integer, byval X as single ptr, byval incX as integer, byval beta as single, byval Y as single ptr, byval incY as integer)
declare sub cblas_strmv (byval order as CBLAS_ORDER, byval Uplo as CBLAS_UPLO, byval TransA as CBLAS_TRANSPOSE, byval Diag as CBLAS_DIAG, byval N as integer, byval A as single ptr, byval lda as integer, byval X as single ptr, byval incX as integer)
declare sub cblas_stbmv (byval order as CBLAS_ORDER, byval Uplo as CBLAS_UPLO, byval TransA as CBLAS_TRANSPOSE, byval Diag as CBLAS_DIAG, byval N as integer, byval K as integer, byval A as single ptr, byval lda as integer, byval X as single ptr, byval incX as integer)
declare sub cblas_stpmv (byval order as CBLAS_ORDER, byval Uplo as CBLAS_UPLO, byval TransA as CBLAS_TRANSPOSE, byval Diag as CBLAS_DIAG, byval N as integer, byval Ap as single ptr, byval X as single ptr, byval incX as integer)
declare sub cblas_strsv (byval order as CBLAS_ORDER, byval Uplo as CBLAS_UPLO, byval TransA as CBLAS_TRANSPOSE, byval Diag as CBLAS_DIAG, byval N as integer, byval A as single ptr, byval lda as integer, byval X as single ptr, byval incX as integer)
declare sub cblas_stbsv (byval order as CBLAS_ORDER, byval Uplo as CBLAS_UPLO, byval TransA as CBLAS_TRANSPOSE, byval Diag as CBLAS_DIAG, byval N as integer, byval K as integer, byval A as single ptr, byval lda as integer, byval X as single ptr, byval incX as integer)
declare sub cblas_stpsv (byval order as CBLAS_ORDER, byval Uplo as CBLAS_UPLO, byval TransA as CBLAS_TRANSPOSE, byval Diag as CBLAS_DIAG, byval N as integer, byval Ap as single ptr, byval X as single ptr, byval incX as integer)
declare sub cblas_dgemv (byval order as CBLAS_ORDER, byval TransA as CBLAS_TRANSPOSE, byval M as integer, byval N as integer, byval alpha as double, byval A as double ptr, byval lda as integer, byval X as double ptr, byval incX as integer, byval beta as double, byval Y as double ptr, byval incY as integer)
declare sub cblas_dgbmv (byval order as CBLAS_ORDER, byval TransA as CBLAS_TRANSPOSE, byval M as integer, byval N as integer, byval KL as integer, byval KU as integer, byval alpha as double, byval A as double ptr, byval lda as integer, byval X as double ptr, byval incX as integer, byval beta as double, byval Y as double ptr, byval incY as integer)
declare sub cblas_dtrmv (byval order as CBLAS_ORDER, byval Uplo as CBLAS_UPLO, byval TransA as CBLAS_TRANSPOSE, byval Diag as CBLAS_DIAG, byval N as integer, byval A as double ptr, byval lda as integer, byval X as double ptr, byval incX as integer)
declare sub cblas_dtbmv (byval order as CBLAS_ORDER, byval Uplo as CBLAS_UPLO, byval TransA as CBLAS_TRANSPOSE, byval Diag as CBLAS_DIAG, byval N as integer, byval K as integer, byval A as double ptr, byval lda as integer, byval X as double ptr, byval incX as integer)
declare sub cblas_dtpmv (byval order as CBLAS_ORDER, byval Uplo as CBLAS_UPLO, byval TransA as CBLAS_TRANSPOSE, byval Diag as CBLAS_DIAG, byval N as integer, byval Ap as double ptr, byval X as double ptr, byval incX as integer)
declare sub cblas_dtrsv (byval order as CBLAS_ORDER, byval Uplo as CBLAS_UPLO, byval TransA as CBLAS_TRANSPOSE, byval Diag as CBLAS_DIAG, byval N as integer, byval A as double ptr, byval lda as integer, byval X as double ptr, byval incX as integer)
declare sub cblas_dtbsv (byval order as CBLAS_ORDER, byval Uplo as CBLAS_UPLO, byval TransA as CBLAS_TRANSPOSE, byval Diag as CBLAS_DIAG, byval N as integer, byval K as integer, byval A as double ptr, byval lda as integer, byval X as double ptr, byval incX as integer)
declare sub cblas_dtpsv (byval order as CBLAS_ORDER, byval Uplo as CBLAS_UPLO, byval TransA as CBLAS_TRANSPOSE, byval Diag as CBLAS_DIAG, byval N as integer, byval Ap as double ptr, byval X as double ptr, byval incX as integer)
declare sub cblas_cgemv (byval order as CBLAS_ORDER, byval TransA as CBLAS_TRANSPOSE, byval M as integer, byval N as integer, byval alpha as any ptr, byval A as any ptr, byval lda as integer, byval X as any ptr, byval incX as integer, byval beta as any ptr, byval Y as any ptr, byval incY as integer)
declare sub cblas_cgbmv (byval order as CBLAS_ORDER, byval TransA as CBLAS_TRANSPOSE, byval M as integer, byval N as integer, byval KL as integer, byval KU as integer, byval alpha as any ptr, byval A as any ptr, byval lda as integer, byval X as any ptr, byval incX as integer, byval beta as any ptr, byval Y as any ptr, byval incY as integer)
declare sub cblas_ctrmv (byval order as CBLAS_ORDER, byval Uplo as CBLAS_UPLO, byval TransA as CBLAS_TRANSPOSE, byval Diag as CBLAS_DIAG, byval N as integer, byval A as any ptr, byval lda as integer, byval X as any ptr, byval incX as integer)
declare sub cblas_ctbmv (byval order as CBLAS_ORDER, byval Uplo as CBLAS_UPLO, byval TransA as CBLAS_TRANSPOSE, byval Diag as CBLAS_DIAG, byval N as integer, byval K as integer, byval A as any ptr, byval lda as integer, byval X as any ptr, byval incX as integer)
declare sub cblas_ctpmv (byval order as CBLAS_ORDER, byval Uplo as CBLAS_UPLO, byval TransA as CBLAS_TRANSPOSE, byval Diag as CBLAS_DIAG, byval N as integer, byval Ap as any ptr, byval X as any ptr, byval incX as integer)
declare sub cblas_ctrsv (byval order as CBLAS_ORDER, byval Uplo as CBLAS_UPLO, byval TransA as CBLAS_TRANSPOSE, byval Diag as CBLAS_DIAG, byval N as integer, byval A as any ptr, byval lda as integer, byval X as any ptr, byval incX as integer)
declare sub cblas_ctbsv (byval order as CBLAS_ORDER, byval Uplo as CBLAS_UPLO, byval TransA as CBLAS_TRANSPOSE, byval Diag as CBLAS_DIAG, byval N as integer, byval K as integer, byval A as any ptr, byval lda as integer, byval X as any ptr, byval incX as integer)
declare sub cblas_ctpsv (byval order as CBLAS_ORDER, byval Uplo as CBLAS_UPLO, byval TransA as CBLAS_TRANSPOSE, byval Diag as CBLAS_DIAG, byval N as integer, byval Ap as any ptr, byval X as any ptr, byval incX as integer)
declare sub cblas_zgemv (byval order as CBLAS_ORDER, byval TransA as CBLAS_TRANSPOSE, byval M as integer, byval N as integer, byval alpha as any ptr, byval A as any ptr, byval lda as integer, byval X as any ptr, byval incX as integer, byval beta as any ptr, byval Y as any ptr, byval incY as integer)
declare sub cblas_zgbmv (byval order as CBLAS_ORDER, byval TransA as CBLAS_TRANSPOSE, byval M as integer, byval N as integer, byval KL as integer, byval KU as integer, byval alpha as any ptr, byval A as any ptr, byval lda as integer, byval X as any ptr, byval incX as integer, byval beta as any ptr, byval Y as any ptr, byval incY as integer)
declare sub cblas_ztrmv (byval order as CBLAS_ORDER, byval Uplo as CBLAS_UPLO, byval TransA as CBLAS_TRANSPOSE, byval Diag as CBLAS_DIAG, byval N as integer, byval A as any ptr, byval lda as integer, byval X as any ptr, byval incX as integer)
declare sub cblas_ztbmv (byval order as CBLAS_ORDER, byval Uplo as CBLAS_UPLO, byval TransA as CBLAS_TRANSPOSE, byval Diag as CBLAS_DIAG, byval N as integer, byval K as integer, byval A as any ptr, byval lda as integer, byval X as any ptr, byval incX as integer)
declare sub cblas_ztpmv (byval order as CBLAS_ORDER, byval Uplo as CBLAS_UPLO, byval TransA as CBLAS_TRANSPOSE, byval Diag as CBLAS_DIAG, byval N as integer, byval Ap as any ptr, byval X as any ptr, byval incX as integer)
declare sub cblas_ztrsv (byval order as CBLAS_ORDER, byval Uplo as CBLAS_UPLO, byval TransA as CBLAS_TRANSPOSE, byval Diag as CBLAS_DIAG, byval N as integer, byval A as any ptr, byval lda as integer, byval X as any ptr, byval incX as integer)
declare sub cblas_ztbsv (byval order as CBLAS_ORDER, byval Uplo as CBLAS_UPLO, byval TransA as CBLAS_TRANSPOSE, byval Diag as CBLAS_DIAG, byval N as integer, byval K as integer, byval A as any ptr, byval lda as integer, byval X as any ptr, byval incX as integer)
declare sub cblas_ztpsv (byval order as CBLAS_ORDER, byval Uplo as CBLAS_UPLO, byval TransA as CBLAS_TRANSPOSE, byval Diag as CBLAS_DIAG, byval N as integer, byval Ap as any ptr, byval X as any ptr, byval incX as integer)
declare sub cblas_ssymv (byval order as CBLAS_ORDER, byval Uplo as CBLAS_UPLO, byval N as integer, byval alpha as single, byval A as single ptr, byval lda as integer, byval X as single ptr, byval incX as integer, byval beta as single, byval Y as single ptr, byval incY as integer)
declare sub cblas_ssbmv (byval order as CBLAS_ORDER, byval Uplo as CBLAS_UPLO, byval N as integer, byval K as integer, byval alpha as single, byval A as single ptr, byval lda as integer, byval X as single ptr, byval incX as integer, byval beta as single, byval Y as single ptr, byval incY as integer)
declare sub cblas_sspmv (byval order as CBLAS_ORDER, byval Uplo as CBLAS_UPLO, byval N as integer, byval alpha as single, byval Ap as single ptr, byval X as single ptr, byval incX as integer, byval beta as single, byval Y as single ptr, byval incY as integer)
declare sub cblas_sger (byval order as CBLAS_ORDER, byval M as integer, byval N as integer, byval alpha as single, byval X as single ptr, byval incX as integer, byval Y as single ptr, byval incY as integer, byval A as single ptr, byval lda as integer)
declare sub cblas_ssyr (byval order as CBLAS_ORDER, byval Uplo as CBLAS_UPLO, byval N as integer, byval alpha as single, byval X as single ptr, byval incX as integer, byval A as single ptr, byval lda as integer)
declare sub cblas_sspr (byval order as CBLAS_ORDER, byval Uplo as CBLAS_UPLO, byval N as integer, byval alpha as single, byval X as single ptr, byval incX as integer, byval Ap as single ptr)
declare sub cblas_ssyr2 (byval order as CBLAS_ORDER, byval Uplo as CBLAS_UPLO, byval N as integer, byval alpha as single, byval X as single ptr, byval incX as integer, byval Y as single ptr, byval incY as integer, byval A as single ptr, byval lda as integer)
declare sub cblas_sspr2 (byval order as CBLAS_ORDER, byval Uplo as CBLAS_UPLO, byval N as integer, byval alpha as single, byval X as single ptr, byval incX as integer, byval Y as single ptr, byval incY as integer, byval A as single ptr)
declare sub cblas_dsymv (byval order as CBLAS_ORDER, byval Uplo as CBLAS_UPLO, byval N as integer, byval alpha as double, byval A as double ptr, byval lda as integer, byval X as double ptr, byval incX as integer, byval beta as double, byval Y as double ptr, byval incY as integer)
declare sub cblas_dsbmv (byval order as CBLAS_ORDER, byval Uplo as CBLAS_UPLO, byval N as integer, byval K as integer, byval alpha as double, byval A as double ptr, byval lda as integer, byval X as double ptr, byval incX as integer, byval beta as double, byval Y as double ptr, byval incY as integer)
declare sub cblas_dspmv (byval order as CBLAS_ORDER, byval Uplo as CBLAS_UPLO, byval N as integer, byval alpha as double, byval Ap as double ptr, byval X as double ptr, byval incX as integer, byval beta as double, byval Y as double ptr, byval incY as integer)
declare sub cblas_dger (byval order as CBLAS_ORDER, byval M as integer, byval N as integer, byval alpha as double, byval X as double ptr, byval incX as integer, byval Y as double ptr, byval incY as integer, byval A as double ptr, byval lda as integer)
declare sub cblas_dsyr (byval order as CBLAS_ORDER, byval Uplo as CBLAS_UPLO, byval N as integer, byval alpha as double, byval X as double ptr, byval incX as integer, byval A as double ptr, byval lda as integer)
declare sub cblas_dspr (byval order as CBLAS_ORDER, byval Uplo as CBLAS_UPLO, byval N as integer, byval alpha as double, byval X as double ptr, byval incX as integer, byval Ap as double ptr)
declare sub cblas_dsyr2 (byval order as CBLAS_ORDER, byval Uplo as CBLAS_UPLO, byval N as integer, byval alpha as double, byval X as double ptr, byval incX as integer, byval Y as double ptr, byval incY as integer, byval A as double ptr, byval lda as integer)
declare sub cblas_dspr2 (byval order as CBLAS_ORDER, byval Uplo as CBLAS_UPLO, byval N as integer, byval alpha as double, byval X as double ptr, byval incX as integer, byval Y as double ptr, byval incY as integer, byval A as double ptr)
declare sub cblas_chemv (byval order as CBLAS_ORDER, byval Uplo as CBLAS_UPLO, byval N as integer, byval alpha as any ptr, byval A as any ptr, byval lda as integer, byval X as any ptr, byval incX as integer, byval beta as any ptr, byval Y as any ptr, byval incY as integer)
declare sub cblas_chbmv (byval order as CBLAS_ORDER, byval Uplo as CBLAS_UPLO, byval N as integer, byval K as integer, byval alpha as any ptr, byval A as any ptr, byval lda as integer, byval X as any ptr, byval incX as integer, byval beta as any ptr, byval Y as any ptr, byval incY as integer)
declare sub cblas_chpmv (byval order as CBLAS_ORDER, byval Uplo as CBLAS_UPLO, byval N as integer, byval alpha as any ptr, byval Ap as any ptr, byval X as any ptr, byval incX as integer, byval beta as any ptr, byval Y as any ptr, byval incY as integer)
declare sub cblas_cgeru (byval order as CBLAS_ORDER, byval M as integer, byval N as integer, byval alpha as any ptr, byval X as any ptr, byval incX as integer, byval Y as any ptr, byval incY as integer, byval A as any ptr, byval lda as integer)
declare sub cblas_cgerc (byval order as CBLAS_ORDER, byval M as integer, byval N as integer, byval alpha as any ptr, byval X as any ptr, byval incX as integer, byval Y as any ptr, byval incY as integer, byval A as any ptr, byval lda as integer)
declare sub cblas_cher (byval order as CBLAS_ORDER, byval Uplo as CBLAS_UPLO, byval N as integer, byval alpha as single, byval X as any ptr, byval incX as integer, byval A as any ptr, byval lda as integer)
declare sub cblas_chpr (byval order as CBLAS_ORDER, byval Uplo as CBLAS_UPLO, byval N as integer, byval alpha as single, byval X as any ptr, byval incX as integer, byval A as any ptr)
declare sub cblas_cher2 (byval order as CBLAS_ORDER, byval Uplo as CBLAS_UPLO, byval N as integer, byval alpha as any ptr, byval X as any ptr, byval incX as integer, byval Y as any ptr, byval incY as integer, byval A as any ptr, byval lda as integer)
declare sub cblas_chpr2 (byval order as CBLAS_ORDER, byval Uplo as CBLAS_UPLO, byval N as integer, byval alpha as any ptr, byval X as any ptr, byval incX as integer, byval Y as any ptr, byval incY as integer, byval Ap as any ptr)
declare sub cblas_zhemv (byval order as CBLAS_ORDER, byval Uplo as CBLAS_UPLO, byval N as integer, byval alpha as any ptr, byval A as any ptr, byval lda as integer, byval X as any ptr, byval incX as integer, byval beta as any ptr, byval Y as any ptr, byval incY as integer)
declare sub cblas_zhbmv (byval order as CBLAS_ORDER, byval Uplo as CBLAS_UPLO, byval N as integer, byval K as integer, byval alpha as any ptr, byval A as any ptr, byval lda as integer, byval X as any ptr, byval incX as integer, byval beta as any ptr, byval Y as any ptr, byval incY as integer)
declare sub cblas_zhpmv (byval order as CBLAS_ORDER, byval Uplo as CBLAS_UPLO, byval N as integer, byval alpha as any ptr, byval Ap as any ptr, byval X as any ptr, byval incX as integer, byval beta as any ptr, byval Y as any ptr, byval incY as integer)
declare sub cblas_zgeru (byval order as CBLAS_ORDER, byval M as integer, byval N as integer, byval alpha as any ptr, byval X as any ptr, byval incX as integer, byval Y as any ptr, byval incY as integer, byval A as any ptr, byval lda as integer)
declare sub cblas_zgerc (byval order as CBLAS_ORDER, byval M as integer, byval N as integer, byval alpha as any ptr, byval X as any ptr, byval incX as integer, byval Y as any ptr, byval incY as integer, byval A as any ptr, byval lda as integer)
declare sub cblas_zher (byval order as CBLAS_ORDER, byval Uplo as CBLAS_UPLO, byval N as integer, byval alpha as double, byval X as any ptr, byval incX as integer, byval A as any ptr, byval lda as integer)
declare sub cblas_zhpr (byval order as CBLAS_ORDER, byval Uplo as CBLAS_UPLO, byval N as integer, byval alpha as double, byval X as any ptr, byval incX as integer, byval A as any ptr)
declare sub cblas_zher2 (byval order as CBLAS_ORDER, byval Uplo as CBLAS_UPLO, byval N as integer, byval alpha as any ptr, byval X as any ptr, byval incX as integer, byval Y as any ptr, byval incY as integer, byval A as any ptr, byval lda as integer)
declare sub cblas_zhpr2 (byval order as CBLAS_ORDER, byval Uplo as CBLAS_UPLO, byval N as integer, byval alpha as any ptr, byval X as any ptr, byval incX as integer, byval Y as any ptr, byval incY as integer, byval Ap as any ptr)
declare sub cblas_sgemm (byval Order as CBLAS_ORDER, byval TransA as CBLAS_TRANSPOSE, byval TransB as CBLAS_TRANSPOSE, byval M as integer, byval N as integer, byval K as integer, byval alpha as single, byval A as single ptr, byval lda as integer, byval B as single ptr, byval ldb as integer, byval beta as single, byval C as single ptr, byval ldc as integer)
declare sub cblas_ssymm (byval Order as CBLAS_ORDER, byval Side as CBLAS_SIDE, byval Uplo as CBLAS_UPLO, byval M as integer, byval N as integer, byval alpha as single, byval A as single ptr, byval lda as integer, byval B as single ptr, byval ldb as integer, byval beta as single, byval C as single ptr, byval ldc as integer)
declare sub cblas_ssyrk (byval Order as CBLAS_ORDER, byval Uplo as CBLAS_UPLO, byval Trans as CBLAS_TRANSPOSE, byval N as integer, byval K as integer, byval alpha as single, byval A as single ptr, byval lda as integer, byval beta as single, byval C as single ptr, byval ldc as integer)
declare sub cblas_ssyr2k (byval Order as CBLAS_ORDER, byval Uplo as CBLAS_UPLO, byval Trans as CBLAS_TRANSPOSE, byval N as integer, byval K as integer, byval alpha as single, byval A as single ptr, byval lda as integer, byval B as single ptr, byval ldb as integer, byval beta as single, byval C as single ptr, byval ldc as integer)
declare sub cblas_strmm (byval Order as CBLAS_ORDER, byval Side as CBLAS_SIDE, byval Uplo as CBLAS_UPLO, byval TransA as CBLAS_TRANSPOSE, byval Diag as CBLAS_DIAG, byval M as integer, byval N as integer, byval alpha as single, byval A as single ptr, byval lda as integer, byval B as single ptr, byval ldb as integer)
declare sub cblas_strsm (byval Order as CBLAS_ORDER, byval Side as CBLAS_SIDE, byval Uplo as CBLAS_UPLO, byval TransA as CBLAS_TRANSPOSE, byval Diag as CBLAS_DIAG, byval M as integer, byval N as integer, byval alpha as single, byval A as single ptr, byval lda as integer, byval B as single ptr, byval ldb as integer)
declare sub cblas_dgemm (byval Order as CBLAS_ORDER, byval TransA as CBLAS_TRANSPOSE, byval TransB as CBLAS_TRANSPOSE, byval M as integer, byval N as integer, byval K as integer, byval alpha as double, byval A as double ptr, byval lda as integer, byval B as double ptr, byval ldb as integer, byval beta as double, byval C as double ptr, byval ldc as integer)
declare sub cblas_dsymm (byval Order as CBLAS_ORDER, byval Side as CBLAS_SIDE, byval Uplo as CBLAS_UPLO, byval M as integer, byval N as integer, byval alpha as double, byval A as double ptr, byval lda as integer, byval B as double ptr, byval ldb as integer, byval beta as double, byval C as double ptr, byval ldc as integer)
declare sub cblas_dsyrk (byval Order as CBLAS_ORDER, byval Uplo as CBLAS_UPLO, byval Trans as CBLAS_TRANSPOSE, byval N as integer, byval K as integer, byval alpha as double, byval A as double ptr, byval lda as integer, byval beta as double, byval C as double ptr, byval ldc as integer)
declare sub cblas_dsyr2k (byval Order as CBLAS_ORDER, byval Uplo as CBLAS_UPLO, byval Trans as CBLAS_TRANSPOSE, byval N as integer, byval K as integer, byval alpha as double, byval A as double ptr, byval lda as integer, byval B as double ptr, byval ldb as integer, byval beta as double, byval C as double ptr, byval ldc as integer)
declare sub cblas_dtrmm (byval Order as CBLAS_ORDER, byval Side as CBLAS_SIDE, byval Uplo as CBLAS_UPLO, byval TransA as CBLAS_TRANSPOSE, byval Diag as CBLAS_DIAG, byval M as integer, byval N as integer, byval alpha as double, byval A as double ptr, byval lda as integer, byval B as double ptr, byval ldb as integer)
declare sub cblas_dtrsm (byval Order as CBLAS_ORDER, byval Side as CBLAS_SIDE, byval Uplo as CBLAS_UPLO, byval TransA as CBLAS_TRANSPOSE, byval Diag as CBLAS_DIAG, byval M as integer, byval N as integer, byval alpha as double, byval A as double ptr, byval lda as integer, byval B as double ptr, byval ldb as integer)
declare sub cblas_cgemm (byval Order as CBLAS_ORDER, byval TransA as CBLAS_TRANSPOSE, byval TransB as CBLAS_TRANSPOSE, byval M as integer, byval N as integer, byval K as integer, byval alpha as any ptr, byval A as any ptr, byval lda as integer, byval B as any ptr, byval ldb as integer, byval beta as any ptr, byval C as any ptr, byval ldc as integer)
declare sub cblas_csymm (byval Order as CBLAS_ORDER, byval Side as CBLAS_SIDE, byval Uplo as CBLAS_UPLO, byval M as integer, byval N as integer, byval alpha as any ptr, byval A as any ptr, byval lda as integer, byval B as any ptr, byval ldb as integer, byval beta as any ptr, byval C as any ptr, byval ldc as integer)
declare sub cblas_csyrk (byval Order as CBLAS_ORDER, byval Uplo as CBLAS_UPLO, byval Trans as CBLAS_TRANSPOSE, byval N as integer, byval K as integer, byval alpha as any ptr, byval A as any ptr, byval lda as integer, byval beta as any ptr, byval C as any ptr, byval ldc as integer)
declare sub cblas_csyr2k (byval Order as CBLAS_ORDER, byval Uplo as CBLAS_UPLO, byval Trans as CBLAS_TRANSPOSE, byval N as integer, byval K as integer, byval alpha as any ptr, byval A as any ptr, byval lda as integer, byval B as any ptr, byval ldb as integer, byval beta as any ptr, byval C as any ptr, byval ldc as integer)
declare sub cblas_ctrmm (byval Order as CBLAS_ORDER, byval Side as CBLAS_SIDE, byval Uplo as CBLAS_UPLO, byval TransA as CBLAS_TRANSPOSE, byval Diag as CBLAS_DIAG, byval M as integer, byval N as integer, byval alpha as any ptr, byval A as any ptr, byval lda as integer, byval B as any ptr, byval ldb as integer)
declare sub cblas_ctrsm (byval Order as CBLAS_ORDER, byval Side as CBLAS_SIDE, byval Uplo as CBLAS_UPLO, byval TransA as CBLAS_TRANSPOSE, byval Diag as CBLAS_DIAG, byval M as integer, byval N as integer, byval alpha as any ptr, byval A as any ptr, byval lda as integer, byval B as any ptr, byval ldb as integer)
declare sub cblas_zgemm (byval Order as CBLAS_ORDER, byval TransA as CBLAS_TRANSPOSE, byval TransB as CBLAS_TRANSPOSE, byval M as integer, byval N as integer, byval K as integer, byval alpha as any ptr, byval A as any ptr, byval lda as integer, byval B as any ptr, byval ldb as integer, byval beta as any ptr, byval C as any ptr, byval ldc as integer)
declare sub cblas_zsymm (byval Order as CBLAS_ORDER, byval Side as CBLAS_SIDE, byval Uplo as CBLAS_UPLO, byval M as integer, byval N as integer, byval alpha as any ptr, byval A as any ptr, byval lda as integer, byval B as any ptr, byval ldb as integer, byval beta as any ptr, byval C as any ptr, byval ldc as integer)
declare sub cblas_zsyrk (byval Order as CBLAS_ORDER, byval Uplo as CBLAS_UPLO, byval Trans as CBLAS_TRANSPOSE, byval N as integer, byval K as integer, byval alpha as any ptr, byval A as any ptr, byval lda as integer, byval beta as any ptr, byval C as any ptr, byval ldc as integer)
declare sub cblas_zsyr2k (byval Order as CBLAS_ORDER, byval Uplo as CBLAS_UPLO, byval Trans as CBLAS_TRANSPOSE, byval N as integer, byval K as integer, byval alpha as any ptr, byval A as any ptr, byval lda as integer, byval B as any ptr, byval ldb as integer, byval beta as any ptr, byval C as any ptr, byval ldc as integer)
declare sub cblas_ztrmm (byval Order as CBLAS_ORDER, byval Side as CBLAS_SIDE, byval Uplo as CBLAS_UPLO, byval TransA as CBLAS_TRANSPOSE, byval Diag as CBLAS_DIAG, byval M as integer, byval N as integer, byval alpha as any ptr, byval A as any ptr, byval lda as integer, byval B as any ptr, byval ldb as integer)
declare sub cblas_ztrsm (byval Order as CBLAS_ORDER, byval Side as CBLAS_SIDE, byval Uplo as CBLAS_UPLO, byval TransA as CBLAS_TRANSPOSE, byval Diag as CBLAS_DIAG, byval M as integer, byval N as integer, byval alpha as any ptr, byval A as any ptr, byval lda as integer, byval B as any ptr, byval ldb as integer)
declare sub cblas_chemm (byval Order as CBLAS_ORDER, byval Side as CBLAS_SIDE, byval Uplo as CBLAS_UPLO, byval M as integer, byval N as integer, byval alpha as any ptr, byval A as any ptr, byval lda as integer, byval B as any ptr, byval ldb as integer, byval beta as any ptr, byval C as any ptr, byval ldc as integer)
declare sub cblas_cherk (byval Order as CBLAS_ORDER, byval Uplo as CBLAS_UPLO, byval Trans as CBLAS_TRANSPOSE, byval N as integer, byval K as integer, byval alpha as single, byval A as any ptr, byval lda as integer, byval beta as single, byval C as any ptr, byval ldc as integer)
declare sub cblas_cher2k (byval Order as CBLAS_ORDER, byval Uplo as CBLAS_UPLO, byval Trans as CBLAS_TRANSPOSE, byval N as integer, byval K as integer, byval alpha as any ptr, byval A as any ptr, byval lda as integer, byval B as any ptr, byval ldb as integer, byval beta as single, byval C as any ptr, byval ldc as integer)
declare sub cblas_zhemm (byval Order as CBLAS_ORDER, byval Side as CBLAS_SIDE, byval Uplo as CBLAS_UPLO, byval M as integer, byval N as integer, byval alpha as any ptr, byval A as any ptr, byval lda as integer, byval B as any ptr, byval ldb as integer, byval beta as any ptr, byval C as any ptr, byval ldc as integer)
declare sub cblas_zherk (byval Order as CBLAS_ORDER, byval Uplo as CBLAS_UPLO, byval Trans as CBLAS_TRANSPOSE, byval N as integer, byval K as integer, byval alpha as double, byval A as any ptr, byval lda as integer, byval beta as double, byval C as any ptr, byval ldc as integer)
declare sub cblas_zher2k (byval Order as CBLAS_ORDER, byval Uplo as CBLAS_UPLO, byval Trans as CBLAS_TRANSPOSE, byval N as integer, byval K as integer, byval alpha as any ptr, byval A as any ptr, byval lda as integer, byval B as any ptr, byval ldb as integer, byval beta as double, byval C as any ptr, byval ldc as integer)
declare sub cblas_xerbla (byval p as integer, byval rout as zstring ptr, byval form as zstring ptr, ...)
end extern

#endif
