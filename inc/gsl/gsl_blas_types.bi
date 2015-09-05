'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
''   blas/gsl_blas_types.h
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

#include once "gsl/gsl_cblas.bi"

#define __GSL_BLAS_TYPES_H__
type CBLAS_INDEX_t as uinteger
type CBLAS_ORDER_t as CBLAS_ORDER
type CBLAS_TRANSPOSE_t as CBLAS_TRANSPOSE
type CBLAS_UPLO_t as CBLAS_UPLO
type CBLAS_DIAG_t as CBLAS_DIAG
type CBLAS_SIDE_t as CBLAS_SIDE
