'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
''   gsl_minmax.h
''
''   Copyright (C) 2008 Gerard Jungman, Brian Gough
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

'' The following symbols have been renamed:
''     #define GSL_MAX => GSL_MAX_
''     #define GSL_MIN => GSL_MIN_

extern "C"

#define __GSL_MINMAX_H__
#define GSL_MAX_(a, b) iif((a) > (b), (a), (b))
#define GSL_MIN_(a, b) iif((a) < (b), (a), (b))
declare function gsl_max(byval a as double, byval b as double) as double
declare function gsl_min(byval a as double, byval b as double) as double
#define GSL_MAX_INT(a, b) GSL_MAX_(a, b)
#define GSL_MIN_INT(a, b) GSL_MIN_(a, b)
#define GSL_MAX_DBL(a, b) GSL_MAX_(a, b)
#define GSL_MIN_DBL(a, b) GSL_MIN_(a, b)
#define GSL_MAX_LDBL(a, b) GSL_MAX_(a, b)
#define GSL_MIN_LDBL(a, b) GSL_MIN_(a, b)

end extern
