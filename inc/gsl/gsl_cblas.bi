'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
''   blas/gsl_cblas.h
''
''   Copyright (C) 1996, 1997, 1998, 1999, 2000 Gerard Jungman
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

#inclib "gslcblas"

#include once "crt/stddef.bi"

extern "C"

#define __GSL_CBLAS_H__
type CBLAS_INDEX as uinteger

type CBLAS_ORDER as long
enum
	CblasRowMajor = 101
	CblasColMajor = 102
end enum

type CBLAS_TRANSPOSE as long
enum
	CblasNoTrans = 111
	CblasTrans = 112
	CblasConjTrans = 113
end enum

type CBLAS_UPLO as long
enum
	CblasUpper = 121
	CblasLower = 122
end enum

type CBLAS_DIAG as long
enum
	CblasNonUnit = 131
	CblasUnit = 132
end enum

type CBLAS_SIDE as long
enum
	CblasLeft = 141
	CblasRight = 142
end enum

declare function cblas_sdsdot(byval N as const long, byval alpha as const single, byval X as const single ptr, byval incX as const long, byval Y as const single ptr, byval incY as const long) as single
declare function cblas_dsdot(byval N as const long, byval X as const single ptr, byval incX as const long, byval Y as const single ptr, byval incY as const long) as double
declare function cblas_sdot(byval N as const long, byval X as const single ptr, byval incX as const long, byval Y as const single ptr, byval incY as const long) as single
declare function cblas_ddot(byval N as const long, byval X as const double ptr, byval incX as const long, byval Y as const double ptr, byval incY as const long) as double
declare sub cblas_cdotu_sub(byval N as const long, byval X as const any ptr, byval incX as const long, byval Y as const any ptr, byval incY as const long, byval dotu as any ptr)
declare sub cblas_cdotc_sub(byval N as const long, byval X as const any ptr, byval incX as const long, byval Y as const any ptr, byval incY as const long, byval dotc as any ptr)
declare sub cblas_zdotu_sub(byval N as const long, byval X as const any ptr, byval incX as const long, byval Y as const any ptr, byval incY as const long, byval dotu as any ptr)
declare sub cblas_zdotc_sub(byval N as const long, byval X as const any ptr, byval incX as const long, byval Y as const any ptr, byval incY as const long, byval dotc as any ptr)
declare function cblas_snrm2(byval N as const long, byval X as const single ptr, byval incX as const long) as single
declare function cblas_sasum(byval N as const long, byval X as const single ptr, byval incX as const long) as single
declare function cblas_dnrm2(byval N as const long, byval X as const double ptr, byval incX as const long) as double
declare function cblas_dasum(byval N as const long, byval X as const double ptr, byval incX as const long) as double
declare function cblas_scnrm2(byval N as const long, byval X as const any ptr, byval incX as const long) as single
declare function cblas_scasum(byval N as const long, byval X as const any ptr, byval incX as const long) as single
declare function cblas_dznrm2(byval N as const long, byval X as const any ptr, byval incX as const long) as double
declare function cblas_dzasum(byval N as const long, byval X as const any ptr, byval incX as const long) as double
declare function cblas_isamax(byval N as const long, byval X as const single ptr, byval incX as const long) as uinteger
declare function cblas_idamax(byval N as const long, byval X as const double ptr, byval incX as const long) as uinteger
declare function cblas_icamax(byval N as const long, byval X as const any ptr, byval incX as const long) as uinteger
declare function cblas_izamax(byval N as const long, byval X as const any ptr, byval incX as const long) as uinteger
declare sub cblas_sswap(byval N as const long, byval X as single ptr, byval incX as const long, byval Y as single ptr, byval incY as const long)
declare sub cblas_scopy(byval N as const long, byval X as const single ptr, byval incX as const long, byval Y as single ptr, byval incY as const long)
declare sub cblas_saxpy(byval N as const long, byval alpha as const single, byval X as const single ptr, byval incX as const long, byval Y as single ptr, byval incY as const long)
declare sub cblas_dswap(byval N as const long, byval X as double ptr, byval incX as const long, byval Y as double ptr, byval incY as const long)
declare sub cblas_dcopy(byval N as const long, byval X as const double ptr, byval incX as const long, byval Y as double ptr, byval incY as const long)
declare sub cblas_daxpy(byval N as const long, byval alpha as const double, byval X as const double ptr, byval incX as const long, byval Y as double ptr, byval incY as const long)
declare sub cblas_cswap(byval N as const long, byval X as any ptr, byval incX as const long, byval Y as any ptr, byval incY as const long)
declare sub cblas_ccopy(byval N as const long, byval X as const any ptr, byval incX as const long, byval Y as any ptr, byval incY as const long)
declare sub cblas_caxpy(byval N as const long, byval alpha as const any ptr, byval X as const any ptr, byval incX as const long, byval Y as any ptr, byval incY as const long)
declare sub cblas_zswap(byval N as const long, byval X as any ptr, byval incX as const long, byval Y as any ptr, byval incY as const long)
declare sub cblas_zcopy(byval N as const long, byval X as const any ptr, byval incX as const long, byval Y as any ptr, byval incY as const long)
declare sub cblas_zaxpy(byval N as const long, byval alpha as const any ptr, byval X as const any ptr, byval incX as const long, byval Y as any ptr, byval incY as const long)
declare sub cblas_srotg(byval a as single ptr, byval b as single ptr, byval c as single ptr, byval s as single ptr)
declare sub cblas_srotmg(byval d1 as single ptr, byval d2 as single ptr, byval b1 as single ptr, byval b2 as const single, byval P as single ptr)
declare sub cblas_srot(byval N as const long, byval X as single ptr, byval incX as const long, byval Y as single ptr, byval incY as const long, byval c as const single, byval s as const single)
declare sub cblas_srotm(byval N as const long, byval X as single ptr, byval incX as const long, byval Y as single ptr, byval incY as const long, byval P as const single ptr)
declare sub cblas_drotg(byval a as double ptr, byval b as double ptr, byval c as double ptr, byval s as double ptr)
declare sub cblas_drotmg(byval d1 as double ptr, byval d2 as double ptr, byval b1 as double ptr, byval b2 as const double, byval P as double ptr)
declare sub cblas_drot(byval N as const long, byval X as double ptr, byval incX as const long, byval Y as double ptr, byval incY as const long, byval c as const double, byval s as const double)
declare sub cblas_drotm(byval N as const long, byval X as double ptr, byval incX as const long, byval Y as double ptr, byval incY as const long, byval P as const double ptr)
declare sub cblas_sscal(byval N as const long, byval alpha as const single, byval X as single ptr, byval incX as const long)
declare sub cblas_dscal(byval N as const long, byval alpha as const double, byval X as double ptr, byval incX as const long)
declare sub cblas_cscal(byval N as const long, byval alpha as const any ptr, byval X as any ptr, byval incX as const long)
declare sub cblas_zscal(byval N as const long, byval alpha as const any ptr, byval X as any ptr, byval incX as const long)
declare sub cblas_csscal(byval N as const long, byval alpha as const single, byval X as any ptr, byval incX as const long)
declare sub cblas_zdscal(byval N as const long, byval alpha as const double, byval X as any ptr, byval incX as const long)
declare sub cblas_sgemv(byval order as const CBLAS_ORDER, byval TransA as const CBLAS_TRANSPOSE, byval M as const long, byval N as const long, byval alpha as const single, byval A as const single ptr, byval lda as const long, byval X as const single ptr, byval incX as const long, byval beta as const single, byval Y as single ptr, byval incY as const long)
declare sub cblas_sgbmv(byval order as const CBLAS_ORDER, byval TransA as const CBLAS_TRANSPOSE, byval M as const long, byval N as const long, byval KL as const long, byval KU as const long, byval alpha as const single, byval A as const single ptr, byval lda as const long, byval X as const single ptr, byval incX as const long, byval beta as const single, byval Y as single ptr, byval incY as const long)
declare sub cblas_strmv(byval order as const CBLAS_ORDER, byval Uplo as const CBLAS_UPLO, byval TransA as const CBLAS_TRANSPOSE, byval Diag as const CBLAS_DIAG, byval N as const long, byval A as const single ptr, byval lda as const long, byval X as single ptr, byval incX as const long)
declare sub cblas_stbmv(byval order as const CBLAS_ORDER, byval Uplo as const CBLAS_UPLO, byval TransA as const CBLAS_TRANSPOSE, byval Diag as const CBLAS_DIAG, byval N as const long, byval K as const long, byval A as const single ptr, byval lda as const long, byval X as single ptr, byval incX as const long)
declare sub cblas_stpmv(byval order as const CBLAS_ORDER, byval Uplo as const CBLAS_UPLO, byval TransA as const CBLAS_TRANSPOSE, byval Diag as const CBLAS_DIAG, byval N as const long, byval Ap as const single ptr, byval X as single ptr, byval incX as const long)
declare sub cblas_strsv(byval order as const CBLAS_ORDER, byval Uplo as const CBLAS_UPLO, byval TransA as const CBLAS_TRANSPOSE, byval Diag as const CBLAS_DIAG, byval N as const long, byval A as const single ptr, byval lda as const long, byval X as single ptr, byval incX as const long)
declare sub cblas_stbsv(byval order as const CBLAS_ORDER, byval Uplo as const CBLAS_UPLO, byval TransA as const CBLAS_TRANSPOSE, byval Diag as const CBLAS_DIAG, byval N as const long, byval K as const long, byval A as const single ptr, byval lda as const long, byval X as single ptr, byval incX as const long)
declare sub cblas_stpsv(byval order as const CBLAS_ORDER, byval Uplo as const CBLAS_UPLO, byval TransA as const CBLAS_TRANSPOSE, byval Diag as const CBLAS_DIAG, byval N as const long, byval Ap as const single ptr, byval X as single ptr, byval incX as const long)
declare sub cblas_dgemv(byval order as const CBLAS_ORDER, byval TransA as const CBLAS_TRANSPOSE, byval M as const long, byval N as const long, byval alpha as const double, byval A as const double ptr, byval lda as const long, byval X as const double ptr, byval incX as const long, byval beta as const double, byval Y as double ptr, byval incY as const long)
declare sub cblas_dgbmv(byval order as const CBLAS_ORDER, byval TransA as const CBLAS_TRANSPOSE, byval M as const long, byval N as const long, byval KL as const long, byval KU as const long, byval alpha as const double, byval A as const double ptr, byval lda as const long, byval X as const double ptr, byval incX as const long, byval beta as const double, byval Y as double ptr, byval incY as const long)
declare sub cblas_dtrmv(byval order as const CBLAS_ORDER, byval Uplo as const CBLAS_UPLO, byval TransA as const CBLAS_TRANSPOSE, byval Diag as const CBLAS_DIAG, byval N as const long, byval A as const double ptr, byval lda as const long, byval X as double ptr, byval incX as const long)
declare sub cblas_dtbmv(byval order as const CBLAS_ORDER, byval Uplo as const CBLAS_UPLO, byval TransA as const CBLAS_TRANSPOSE, byval Diag as const CBLAS_DIAG, byval N as const long, byval K as const long, byval A as const double ptr, byval lda as const long, byval X as double ptr, byval incX as const long)
declare sub cblas_dtpmv(byval order as const CBLAS_ORDER, byval Uplo as const CBLAS_UPLO, byval TransA as const CBLAS_TRANSPOSE, byval Diag as const CBLAS_DIAG, byval N as const long, byval Ap as const double ptr, byval X as double ptr, byval incX as const long)
declare sub cblas_dtrsv(byval order as const CBLAS_ORDER, byval Uplo as const CBLAS_UPLO, byval TransA as const CBLAS_TRANSPOSE, byval Diag as const CBLAS_DIAG, byval N as const long, byval A as const double ptr, byval lda as const long, byval X as double ptr, byval incX as const long)
declare sub cblas_dtbsv(byval order as const CBLAS_ORDER, byval Uplo as const CBLAS_UPLO, byval TransA as const CBLAS_TRANSPOSE, byval Diag as const CBLAS_DIAG, byval N as const long, byval K as const long, byval A as const double ptr, byval lda as const long, byval X as double ptr, byval incX as const long)
declare sub cblas_dtpsv(byval order as const CBLAS_ORDER, byval Uplo as const CBLAS_UPLO, byval TransA as const CBLAS_TRANSPOSE, byval Diag as const CBLAS_DIAG, byval N as const long, byval Ap as const double ptr, byval X as double ptr, byval incX as const long)
declare sub cblas_cgemv(byval order as const CBLAS_ORDER, byval TransA as const CBLAS_TRANSPOSE, byval M as const long, byval N as const long, byval alpha as const any ptr, byval A as const any ptr, byval lda as const long, byval X as const any ptr, byval incX as const long, byval beta as const any ptr, byval Y as any ptr, byval incY as const long)
declare sub cblas_cgbmv(byval order as const CBLAS_ORDER, byval TransA as const CBLAS_TRANSPOSE, byval M as const long, byval N as const long, byval KL as const long, byval KU as const long, byval alpha as const any ptr, byval A as const any ptr, byval lda as const long, byval X as const any ptr, byval incX as const long, byval beta as const any ptr, byval Y as any ptr, byval incY as const long)
declare sub cblas_ctrmv(byval order as const CBLAS_ORDER, byval Uplo as const CBLAS_UPLO, byval TransA as const CBLAS_TRANSPOSE, byval Diag as const CBLAS_DIAG, byval N as const long, byval A as const any ptr, byval lda as const long, byval X as any ptr, byval incX as const long)
declare sub cblas_ctbmv(byval order as const CBLAS_ORDER, byval Uplo as const CBLAS_UPLO, byval TransA as const CBLAS_TRANSPOSE, byval Diag as const CBLAS_DIAG, byval N as const long, byval K as const long, byval A as const any ptr, byval lda as const long, byval X as any ptr, byval incX as const long)
declare sub cblas_ctpmv(byval order as const CBLAS_ORDER, byval Uplo as const CBLAS_UPLO, byval TransA as const CBLAS_TRANSPOSE, byval Diag as const CBLAS_DIAG, byval N as const long, byval Ap as const any ptr, byval X as any ptr, byval incX as const long)
declare sub cblas_ctrsv(byval order as const CBLAS_ORDER, byval Uplo as const CBLAS_UPLO, byval TransA as const CBLAS_TRANSPOSE, byval Diag as const CBLAS_DIAG, byval N as const long, byval A as const any ptr, byval lda as const long, byval X as any ptr, byval incX as const long)
declare sub cblas_ctbsv(byval order as const CBLAS_ORDER, byval Uplo as const CBLAS_UPLO, byval TransA as const CBLAS_TRANSPOSE, byval Diag as const CBLAS_DIAG, byval N as const long, byval K as const long, byval A as const any ptr, byval lda as const long, byval X as any ptr, byval incX as const long)
declare sub cblas_ctpsv(byval order as const CBLAS_ORDER, byval Uplo as const CBLAS_UPLO, byval TransA as const CBLAS_TRANSPOSE, byval Diag as const CBLAS_DIAG, byval N as const long, byval Ap as const any ptr, byval X as any ptr, byval incX as const long)
declare sub cblas_zgemv(byval order as const CBLAS_ORDER, byval TransA as const CBLAS_TRANSPOSE, byval M as const long, byval N as const long, byval alpha as const any ptr, byval A as const any ptr, byval lda as const long, byval X as const any ptr, byval incX as const long, byval beta as const any ptr, byval Y as any ptr, byval incY as const long)
declare sub cblas_zgbmv(byval order as const CBLAS_ORDER, byval TransA as const CBLAS_TRANSPOSE, byval M as const long, byval N as const long, byval KL as const long, byval KU as const long, byval alpha as const any ptr, byval A as const any ptr, byval lda as const long, byval X as const any ptr, byval incX as const long, byval beta as const any ptr, byval Y as any ptr, byval incY as const long)
declare sub cblas_ztrmv(byval order as const CBLAS_ORDER, byval Uplo as const CBLAS_UPLO, byval TransA as const CBLAS_TRANSPOSE, byval Diag as const CBLAS_DIAG, byval N as const long, byval A as const any ptr, byval lda as const long, byval X as any ptr, byval incX as const long)
declare sub cblas_ztbmv(byval order as const CBLAS_ORDER, byval Uplo as const CBLAS_UPLO, byval TransA as const CBLAS_TRANSPOSE, byval Diag as const CBLAS_DIAG, byval N as const long, byval K as const long, byval A as const any ptr, byval lda as const long, byval X as any ptr, byval incX as const long)
declare sub cblas_ztpmv(byval order as const CBLAS_ORDER, byval Uplo as const CBLAS_UPLO, byval TransA as const CBLAS_TRANSPOSE, byval Diag as const CBLAS_DIAG, byval N as const long, byval Ap as const any ptr, byval X as any ptr, byval incX as const long)
declare sub cblas_ztrsv(byval order as const CBLAS_ORDER, byval Uplo as const CBLAS_UPLO, byval TransA as const CBLAS_TRANSPOSE, byval Diag as const CBLAS_DIAG, byval N as const long, byval A as const any ptr, byval lda as const long, byval X as any ptr, byval incX as const long)
declare sub cblas_ztbsv(byval order as const CBLAS_ORDER, byval Uplo as const CBLAS_UPLO, byval TransA as const CBLAS_TRANSPOSE, byval Diag as const CBLAS_DIAG, byval N as const long, byval K as const long, byval A as const any ptr, byval lda as const long, byval X as any ptr, byval incX as const long)
declare sub cblas_ztpsv(byval order as const CBLAS_ORDER, byval Uplo as const CBLAS_UPLO, byval TransA as const CBLAS_TRANSPOSE, byval Diag as const CBLAS_DIAG, byval N as const long, byval Ap as const any ptr, byval X as any ptr, byval incX as const long)
declare sub cblas_ssymv(byval order as const CBLAS_ORDER, byval Uplo as const CBLAS_UPLO, byval N as const long, byval alpha as const single, byval A as const single ptr, byval lda as const long, byval X as const single ptr, byval incX as const long, byval beta as const single, byval Y as single ptr, byval incY as const long)
declare sub cblas_ssbmv(byval order as const CBLAS_ORDER, byval Uplo as const CBLAS_UPLO, byval N as const long, byval K as const long, byval alpha as const single, byval A as const single ptr, byval lda as const long, byval X as const single ptr, byval incX as const long, byval beta as const single, byval Y as single ptr, byval incY as const long)
declare sub cblas_sspmv(byval order as const CBLAS_ORDER, byval Uplo as const CBLAS_UPLO, byval N as const long, byval alpha as const single, byval Ap as const single ptr, byval X as const single ptr, byval incX as const long, byval beta as const single, byval Y as single ptr, byval incY as const long)
declare sub cblas_sger(byval order as const CBLAS_ORDER, byval M as const long, byval N as const long, byval alpha as const single, byval X as const single ptr, byval incX as const long, byval Y as const single ptr, byval incY as const long, byval A as single ptr, byval lda as const long)
declare sub cblas_ssyr(byval order as const CBLAS_ORDER, byval Uplo as const CBLAS_UPLO, byval N as const long, byval alpha as const single, byval X as const single ptr, byval incX as const long, byval A as single ptr, byval lda as const long)
declare sub cblas_sspr(byval order as const CBLAS_ORDER, byval Uplo as const CBLAS_UPLO, byval N as const long, byval alpha as const single, byval X as const single ptr, byval incX as const long, byval Ap as single ptr)
declare sub cblas_ssyr2(byval order as const CBLAS_ORDER, byval Uplo as const CBLAS_UPLO, byval N as const long, byval alpha as const single, byval X as const single ptr, byval incX as const long, byval Y as const single ptr, byval incY as const long, byval A as single ptr, byval lda as const long)
declare sub cblas_sspr2(byval order as const CBLAS_ORDER, byval Uplo as const CBLAS_UPLO, byval N as const long, byval alpha as const single, byval X as const single ptr, byval incX as const long, byval Y as const single ptr, byval incY as const long, byval A as single ptr)
declare sub cblas_dsymv(byval order as const CBLAS_ORDER, byval Uplo as const CBLAS_UPLO, byval N as const long, byval alpha as const double, byval A as const double ptr, byval lda as const long, byval X as const double ptr, byval incX as const long, byval beta as const double, byval Y as double ptr, byval incY as const long)
declare sub cblas_dsbmv(byval order as const CBLAS_ORDER, byval Uplo as const CBLAS_UPLO, byval N as const long, byval K as const long, byval alpha as const double, byval A as const double ptr, byval lda as const long, byval X as const double ptr, byval incX as const long, byval beta as const double, byval Y as double ptr, byval incY as const long)
declare sub cblas_dspmv(byval order as const CBLAS_ORDER, byval Uplo as const CBLAS_UPLO, byval N as const long, byval alpha as const double, byval Ap as const double ptr, byval X as const double ptr, byval incX as const long, byval beta as const double, byval Y as double ptr, byval incY as const long)
declare sub cblas_dger(byval order as const CBLAS_ORDER, byval M as const long, byval N as const long, byval alpha as const double, byval X as const double ptr, byval incX as const long, byval Y as const double ptr, byval incY as const long, byval A as double ptr, byval lda as const long)
declare sub cblas_dsyr(byval order as const CBLAS_ORDER, byval Uplo as const CBLAS_UPLO, byval N as const long, byval alpha as const double, byval X as const double ptr, byval incX as const long, byval A as double ptr, byval lda as const long)
declare sub cblas_dspr(byval order as const CBLAS_ORDER, byval Uplo as const CBLAS_UPLO, byval N as const long, byval alpha as const double, byval X as const double ptr, byval incX as const long, byval Ap as double ptr)
declare sub cblas_dsyr2(byval order as const CBLAS_ORDER, byval Uplo as const CBLAS_UPLO, byval N as const long, byval alpha as const double, byval X as const double ptr, byval incX as const long, byval Y as const double ptr, byval incY as const long, byval A as double ptr, byval lda as const long)
declare sub cblas_dspr2(byval order as const CBLAS_ORDER, byval Uplo as const CBLAS_UPLO, byval N as const long, byval alpha as const double, byval X as const double ptr, byval incX as const long, byval Y as const double ptr, byval incY as const long, byval A as double ptr)
declare sub cblas_chemv(byval order as const CBLAS_ORDER, byval Uplo as const CBLAS_UPLO, byval N as const long, byval alpha as const any ptr, byval A as const any ptr, byval lda as const long, byval X as const any ptr, byval incX as const long, byval beta as const any ptr, byval Y as any ptr, byval incY as const long)
declare sub cblas_chbmv(byval order as const CBLAS_ORDER, byval Uplo as const CBLAS_UPLO, byval N as const long, byval K as const long, byval alpha as const any ptr, byval A as const any ptr, byval lda as const long, byval X as const any ptr, byval incX as const long, byval beta as const any ptr, byval Y as any ptr, byval incY as const long)
declare sub cblas_chpmv(byval order as const CBLAS_ORDER, byval Uplo as const CBLAS_UPLO, byval N as const long, byval alpha as const any ptr, byval Ap as const any ptr, byval X as const any ptr, byval incX as const long, byval beta as const any ptr, byval Y as any ptr, byval incY as const long)
declare sub cblas_cgeru(byval order as const CBLAS_ORDER, byval M as const long, byval N as const long, byval alpha as const any ptr, byval X as const any ptr, byval incX as const long, byval Y as const any ptr, byval incY as const long, byval A as any ptr, byval lda as const long)
declare sub cblas_cgerc(byval order as const CBLAS_ORDER, byval M as const long, byval N as const long, byval alpha as const any ptr, byval X as const any ptr, byval incX as const long, byval Y as const any ptr, byval incY as const long, byval A as any ptr, byval lda as const long)
declare sub cblas_cher(byval order as const CBLAS_ORDER, byval Uplo as const CBLAS_UPLO, byval N as const long, byval alpha as const single, byval X as const any ptr, byval incX as const long, byval A as any ptr, byval lda as const long)
declare sub cblas_chpr(byval order as const CBLAS_ORDER, byval Uplo as const CBLAS_UPLO, byval N as const long, byval alpha as const single, byval X as const any ptr, byval incX as const long, byval A as any ptr)
declare sub cblas_cher2(byval order as const CBLAS_ORDER, byval Uplo as const CBLAS_UPLO, byval N as const long, byval alpha as const any ptr, byval X as const any ptr, byval incX as const long, byval Y as const any ptr, byval incY as const long, byval A as any ptr, byval lda as const long)
declare sub cblas_chpr2(byval order as const CBLAS_ORDER, byval Uplo as const CBLAS_UPLO, byval N as const long, byval alpha as const any ptr, byval X as const any ptr, byval incX as const long, byval Y as const any ptr, byval incY as const long, byval Ap as any ptr)
declare sub cblas_zhemv(byval order as const CBLAS_ORDER, byval Uplo as const CBLAS_UPLO, byval N as const long, byval alpha as const any ptr, byval A as const any ptr, byval lda as const long, byval X as const any ptr, byval incX as const long, byval beta as const any ptr, byval Y as any ptr, byval incY as const long)
declare sub cblas_zhbmv(byval order as const CBLAS_ORDER, byval Uplo as const CBLAS_UPLO, byval N as const long, byval K as const long, byval alpha as const any ptr, byval A as const any ptr, byval lda as const long, byval X as const any ptr, byval incX as const long, byval beta as const any ptr, byval Y as any ptr, byval incY as const long)
declare sub cblas_zhpmv(byval order as const CBLAS_ORDER, byval Uplo as const CBLAS_UPLO, byval N as const long, byval alpha as const any ptr, byval Ap as const any ptr, byval X as const any ptr, byval incX as const long, byval beta as const any ptr, byval Y as any ptr, byval incY as const long)
declare sub cblas_zgeru(byval order as const CBLAS_ORDER, byval M as const long, byval N as const long, byval alpha as const any ptr, byval X as const any ptr, byval incX as const long, byval Y as const any ptr, byval incY as const long, byval A as any ptr, byval lda as const long)
declare sub cblas_zgerc(byval order as const CBLAS_ORDER, byval M as const long, byval N as const long, byval alpha as const any ptr, byval X as const any ptr, byval incX as const long, byval Y as const any ptr, byval incY as const long, byval A as any ptr, byval lda as const long)
declare sub cblas_zher(byval order as const CBLAS_ORDER, byval Uplo as const CBLAS_UPLO, byval N as const long, byval alpha as const double, byval X as const any ptr, byval incX as const long, byval A as any ptr, byval lda as const long)
declare sub cblas_zhpr(byval order as const CBLAS_ORDER, byval Uplo as const CBLAS_UPLO, byval N as const long, byval alpha as const double, byval X as const any ptr, byval incX as const long, byval A as any ptr)
declare sub cblas_zher2(byval order as const CBLAS_ORDER, byval Uplo as const CBLAS_UPLO, byval N as const long, byval alpha as const any ptr, byval X as const any ptr, byval incX as const long, byval Y as const any ptr, byval incY as const long, byval A as any ptr, byval lda as const long)
declare sub cblas_zhpr2(byval order as const CBLAS_ORDER, byval Uplo as const CBLAS_UPLO, byval N as const long, byval alpha as const any ptr, byval X as const any ptr, byval incX as const long, byval Y as const any ptr, byval incY as const long, byval Ap as any ptr)
declare sub cblas_sgemm(byval Order as const CBLAS_ORDER, byval TransA as const CBLAS_TRANSPOSE, byval TransB as const CBLAS_TRANSPOSE, byval M as const long, byval N as const long, byval K as const long, byval alpha as const single, byval A as const single ptr, byval lda as const long, byval B as const single ptr, byval ldb as const long, byval beta as const single, byval C as single ptr, byval ldc as const long)
declare sub cblas_ssymm(byval Order as const CBLAS_ORDER, byval Side as const CBLAS_SIDE, byval Uplo as const CBLAS_UPLO, byval M as const long, byval N as const long, byval alpha as const single, byval A as const single ptr, byval lda as const long, byval B as const single ptr, byval ldb as const long, byval beta as const single, byval C as single ptr, byval ldc as const long)
declare sub cblas_ssyrk(byval Order as const CBLAS_ORDER, byval Uplo as const CBLAS_UPLO, byval Trans as const CBLAS_TRANSPOSE, byval N as const long, byval K as const long, byval alpha as const single, byval A as const single ptr, byval lda as const long, byval beta as const single, byval C as single ptr, byval ldc as const long)
declare sub cblas_ssyr2k(byval Order as const CBLAS_ORDER, byval Uplo as const CBLAS_UPLO, byval Trans as const CBLAS_TRANSPOSE, byval N as const long, byval K as const long, byval alpha as const single, byval A as const single ptr, byval lda as const long, byval B as const single ptr, byval ldb as const long, byval beta as const single, byval C as single ptr, byval ldc as const long)
declare sub cblas_strmm(byval Order as const CBLAS_ORDER, byval Side as const CBLAS_SIDE, byval Uplo as const CBLAS_UPLO, byval TransA as const CBLAS_TRANSPOSE, byval Diag as const CBLAS_DIAG, byval M as const long, byval N as const long, byval alpha as const single, byval A as const single ptr, byval lda as const long, byval B as single ptr, byval ldb as const long)
declare sub cblas_strsm(byval Order as const CBLAS_ORDER, byval Side as const CBLAS_SIDE, byval Uplo as const CBLAS_UPLO, byval TransA as const CBLAS_TRANSPOSE, byval Diag as const CBLAS_DIAG, byval M as const long, byval N as const long, byval alpha as const single, byval A as const single ptr, byval lda as const long, byval B as single ptr, byval ldb as const long)
declare sub cblas_dgemm(byval Order as const CBLAS_ORDER, byval TransA as const CBLAS_TRANSPOSE, byval TransB as const CBLAS_TRANSPOSE, byval M as const long, byval N as const long, byval K as const long, byval alpha as const double, byval A as const double ptr, byval lda as const long, byval B as const double ptr, byval ldb as const long, byval beta as const double, byval C as double ptr, byval ldc as const long)
declare sub cblas_dsymm(byval Order as const CBLAS_ORDER, byval Side as const CBLAS_SIDE, byval Uplo as const CBLAS_UPLO, byval M as const long, byval N as const long, byval alpha as const double, byval A as const double ptr, byval lda as const long, byval B as const double ptr, byval ldb as const long, byval beta as const double, byval C as double ptr, byval ldc as const long)
declare sub cblas_dsyrk(byval Order as const CBLAS_ORDER, byval Uplo as const CBLAS_UPLO, byval Trans as const CBLAS_TRANSPOSE, byval N as const long, byval K as const long, byval alpha as const double, byval A as const double ptr, byval lda as const long, byval beta as const double, byval C as double ptr, byval ldc as const long)
declare sub cblas_dsyr2k(byval Order as const CBLAS_ORDER, byval Uplo as const CBLAS_UPLO, byval Trans as const CBLAS_TRANSPOSE, byval N as const long, byval K as const long, byval alpha as const double, byval A as const double ptr, byval lda as const long, byval B as const double ptr, byval ldb as const long, byval beta as const double, byval C as double ptr, byval ldc as const long)
declare sub cblas_dtrmm(byval Order as const CBLAS_ORDER, byval Side as const CBLAS_SIDE, byval Uplo as const CBLAS_UPLO, byval TransA as const CBLAS_TRANSPOSE, byval Diag as const CBLAS_DIAG, byval M as const long, byval N as const long, byval alpha as const double, byval A as const double ptr, byval lda as const long, byval B as double ptr, byval ldb as const long)
declare sub cblas_dtrsm(byval Order as const CBLAS_ORDER, byval Side as const CBLAS_SIDE, byval Uplo as const CBLAS_UPLO, byval TransA as const CBLAS_TRANSPOSE, byval Diag as const CBLAS_DIAG, byval M as const long, byval N as const long, byval alpha as const double, byval A as const double ptr, byval lda as const long, byval B as double ptr, byval ldb as const long)
declare sub cblas_cgemm(byval Order as const CBLAS_ORDER, byval TransA as const CBLAS_TRANSPOSE, byval TransB as const CBLAS_TRANSPOSE, byval M as const long, byval N as const long, byval K as const long, byval alpha as const any ptr, byval A as const any ptr, byval lda as const long, byval B as const any ptr, byval ldb as const long, byval beta as const any ptr, byval C as any ptr, byval ldc as const long)
declare sub cblas_csymm(byval Order as const CBLAS_ORDER, byval Side as const CBLAS_SIDE, byval Uplo as const CBLAS_UPLO, byval M as const long, byval N as const long, byval alpha as const any ptr, byval A as const any ptr, byval lda as const long, byval B as const any ptr, byval ldb as const long, byval beta as const any ptr, byval C as any ptr, byval ldc as const long)
declare sub cblas_csyrk(byval Order as const CBLAS_ORDER, byval Uplo as const CBLAS_UPLO, byval Trans as const CBLAS_TRANSPOSE, byval N as const long, byval K as const long, byval alpha as const any ptr, byval A as const any ptr, byval lda as const long, byval beta as const any ptr, byval C as any ptr, byval ldc as const long)
declare sub cblas_csyr2k(byval Order as const CBLAS_ORDER, byval Uplo as const CBLAS_UPLO, byval Trans as const CBLAS_TRANSPOSE, byval N as const long, byval K as const long, byval alpha as const any ptr, byval A as const any ptr, byval lda as const long, byval B as const any ptr, byval ldb as const long, byval beta as const any ptr, byval C as any ptr, byval ldc as const long)
declare sub cblas_ctrmm(byval Order as const CBLAS_ORDER, byval Side as const CBLAS_SIDE, byval Uplo as const CBLAS_UPLO, byval TransA as const CBLAS_TRANSPOSE, byval Diag as const CBLAS_DIAG, byval M as const long, byval N as const long, byval alpha as const any ptr, byval A as const any ptr, byval lda as const long, byval B as any ptr, byval ldb as const long)
declare sub cblas_ctrsm(byval Order as const CBLAS_ORDER, byval Side as const CBLAS_SIDE, byval Uplo as const CBLAS_UPLO, byval TransA as const CBLAS_TRANSPOSE, byval Diag as const CBLAS_DIAG, byval M as const long, byval N as const long, byval alpha as const any ptr, byval A as const any ptr, byval lda as const long, byval B as any ptr, byval ldb as const long)
declare sub cblas_zgemm(byval Order as const CBLAS_ORDER, byval TransA as const CBLAS_TRANSPOSE, byval TransB as const CBLAS_TRANSPOSE, byval M as const long, byval N as const long, byval K as const long, byval alpha as const any ptr, byval A as const any ptr, byval lda as const long, byval B as const any ptr, byval ldb as const long, byval beta as const any ptr, byval C as any ptr, byval ldc as const long)
declare sub cblas_zsymm(byval Order as const CBLAS_ORDER, byval Side as const CBLAS_SIDE, byval Uplo as const CBLAS_UPLO, byval M as const long, byval N as const long, byval alpha as const any ptr, byval A as const any ptr, byval lda as const long, byval B as const any ptr, byval ldb as const long, byval beta as const any ptr, byval C as any ptr, byval ldc as const long)
declare sub cblas_zsyrk(byval Order as const CBLAS_ORDER, byval Uplo as const CBLAS_UPLO, byval Trans as const CBLAS_TRANSPOSE, byval N as const long, byval K as const long, byval alpha as const any ptr, byval A as const any ptr, byval lda as const long, byval beta as const any ptr, byval C as any ptr, byval ldc as const long)
declare sub cblas_zsyr2k(byval Order as const CBLAS_ORDER, byval Uplo as const CBLAS_UPLO, byval Trans as const CBLAS_TRANSPOSE, byval N as const long, byval K as const long, byval alpha as const any ptr, byval A as const any ptr, byval lda as const long, byval B as const any ptr, byval ldb as const long, byval beta as const any ptr, byval C as any ptr, byval ldc as const long)
declare sub cblas_ztrmm(byval Order as const CBLAS_ORDER, byval Side as const CBLAS_SIDE, byval Uplo as const CBLAS_UPLO, byval TransA as const CBLAS_TRANSPOSE, byval Diag as const CBLAS_DIAG, byval M as const long, byval N as const long, byval alpha as const any ptr, byval A as const any ptr, byval lda as const long, byval B as any ptr, byval ldb as const long)
declare sub cblas_ztrsm(byval Order as const CBLAS_ORDER, byval Side as const CBLAS_SIDE, byval Uplo as const CBLAS_UPLO, byval TransA as const CBLAS_TRANSPOSE, byval Diag as const CBLAS_DIAG, byval M as const long, byval N as const long, byval alpha as const any ptr, byval A as const any ptr, byval lda as const long, byval B as any ptr, byval ldb as const long)
declare sub cblas_chemm(byval Order as const CBLAS_ORDER, byval Side as const CBLAS_SIDE, byval Uplo as const CBLAS_UPLO, byval M as const long, byval N as const long, byval alpha as const any ptr, byval A as const any ptr, byval lda as const long, byval B as const any ptr, byval ldb as const long, byval beta as const any ptr, byval C as any ptr, byval ldc as const long)
declare sub cblas_cherk(byval Order as const CBLAS_ORDER, byval Uplo as const CBLAS_UPLO, byval Trans as const CBLAS_TRANSPOSE, byval N as const long, byval K as const long, byval alpha as const single, byval A as const any ptr, byval lda as const long, byval beta as const single, byval C as any ptr, byval ldc as const long)
declare sub cblas_cher2k(byval Order as const CBLAS_ORDER, byval Uplo as const CBLAS_UPLO, byval Trans as const CBLAS_TRANSPOSE, byval N as const long, byval K as const long, byval alpha as const any ptr, byval A as const any ptr, byval lda as const long, byval B as const any ptr, byval ldb as const long, byval beta as const single, byval C as any ptr, byval ldc as const long)
declare sub cblas_zhemm(byval Order as const CBLAS_ORDER, byval Side as const CBLAS_SIDE, byval Uplo as const CBLAS_UPLO, byval M as const long, byval N as const long, byval alpha as const any ptr, byval A as const any ptr, byval lda as const long, byval B as const any ptr, byval ldb as const long, byval beta as const any ptr, byval C as any ptr, byval ldc as const long)
declare sub cblas_zherk(byval Order as const CBLAS_ORDER, byval Uplo as const CBLAS_UPLO, byval Trans as const CBLAS_TRANSPOSE, byval N as const long, byval K as const long, byval alpha as const double, byval A as const any ptr, byval lda as const long, byval beta as const double, byval C as any ptr, byval ldc as const long)
declare sub cblas_zher2k(byval Order as const CBLAS_ORDER, byval Uplo as const CBLAS_UPLO, byval Trans as const CBLAS_TRANSPOSE, byval N as const long, byval K as const long, byval alpha as const any ptr, byval A as const any ptr, byval lda as const long, byval B as const any ptr, byval ldb as const long, byval beta as const double, byval C as any ptr, byval ldc as const long)
declare sub cblas_xerbla(byval p as long, byval rout as const zstring ptr, byval form as const zstring ptr, ...)

end extern
