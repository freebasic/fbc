'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
''   monte/gsl_monte_plain.h
''
''   Copyright (C) 1996, 1997, 1998, 1999, 2000 Michael Booth
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

#include once "crt/stdio.bi"
#include once "gsl/gsl_monte.bi"
#include once "gsl/gsl_rng.bi"

extern "C"

#define __GSL_MONTE_PLAIN_H__

type gsl_monte_plain_state
	as uinteger dim
	x as double ptr
end type

declare function gsl_monte_plain_integrate(byval f as const gsl_monte_function ptr, byval xl as const double ptr, byval xu as const double ptr, byval dim as const uinteger, byval calls as const uinteger, byval r as gsl_rng ptr, byval state as gsl_monte_plain_state ptr, byval result as double ptr, byval abserr as double ptr) as long
declare function gsl_monte_plain_alloc(byval dim as uinteger) as gsl_monte_plain_state ptr
declare function gsl_monte_plain_init(byval state as gsl_monte_plain_state ptr) as long
declare sub gsl_monte_plain_free(byval state as gsl_monte_plain_state ptr)

end extern
