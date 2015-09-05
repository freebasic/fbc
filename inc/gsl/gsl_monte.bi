'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
''   monte/gsl_monte.h
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

extern "C"

#define __GSL_MONTE_H__

type gsl_monte_function_struct
	f as function(byval x_array as double ptr, byval dim as uinteger, byval params as any ptr) as double
	as uinteger dim
	params as any ptr
end type

type gsl_monte_function as gsl_monte_function_struct
#define GSL_MONTE_FN_EVAL(F_, x) (F_)->f(x, (F_)->dim, (F_)->params)

end extern
