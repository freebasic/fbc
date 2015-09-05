'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
''   deriv/gsl_deriv.h
''
''   Copyright (C) 2000 David Morrison
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

#include once "gsl/gsl_math.bi"

extern "C"

#define __GSL_DERIV_H__
declare function gsl_deriv_central(byval f as const gsl_function ptr, byval x as double, byval h as double, byval result as double ptr, byval abserr as double ptr) as long
declare function gsl_deriv_backward(byval f as const gsl_function ptr, byval x as double, byval h as double, byval result as double ptr, byval abserr as double ptr) as long
declare function gsl_deriv_forward(byval f as const gsl_function ptr, byval x as double, byval h as double, byval result as double ptr, byval abserr as double ptr) as long

end extern
