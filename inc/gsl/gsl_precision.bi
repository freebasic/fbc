'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
''   gsl_precision.h
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

#include once "gsl/gsl_types.bi"

extern "C"

#define __GSL_PRECISION_H__
type gsl_prec_t as ulong
const _GSL_PREC_T_NUM = 3
extern gsl_prec_eps(0 to _GSL_PREC_T_NUM - 1) as const double
extern gsl_prec_sqrt_eps(0 to _GSL_PREC_T_NUM - 1) as const double
extern gsl_prec_root3_eps(0 to _GSL_PREC_T_NUM - 1) as const double
extern gsl_prec_root4_eps(0 to _GSL_PREC_T_NUM - 1) as const double
extern gsl_prec_root5_eps(0 to _GSL_PREC_T_NUM - 1) as const double
extern gsl_prec_root6_eps(0 to _GSL_PREC_T_NUM - 1) as const double

end extern
