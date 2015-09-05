'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
''   gsl_pow_int.h
''
''   Copyright (C) 1996, 1997, 1998, 1999, 2000, 2004, 2007 Gerard Jungman, Brian Gough
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

#include once "gsl/gsl_inline.bi"

extern "C"

#define __GSL_POW_INT_H__
declare function gsl_pow_2(byval x as const double) as double
declare function gsl_pow_3(byval x as const double) as double
declare function gsl_pow_4(byval x as const double) as double
declare function gsl_pow_5(byval x as const double) as double
declare function gsl_pow_6(byval x as const double) as double
declare function gsl_pow_7(byval x as const double) as double
declare function gsl_pow_8(byval x as const double) as double
declare function gsl_pow_9(byval x as const double) as double
declare function gsl_pow_int(byval x as double, byval n as long) as double
declare function gsl_pow_uint(byval x as double, byval n as ulong) as double

end extern
