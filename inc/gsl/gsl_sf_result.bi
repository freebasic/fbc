'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
''   specfunc/gsl_sf_result.h
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

extern "C"

#define __GSL_SF_RESULT_H__

type gsl_sf_result_struct
	val as double
	err as double
end type

type gsl_sf_result as gsl_sf_result_struct
#macro GSL_SF_RESULT_SET(r, v, e)
	scope
		(r)->val = (v)
		(r)->err = (e)
	end scope
#endmacro

type gsl_sf_result_e10_struct
	val as double
	err as double
	e10 as long
end type

type gsl_sf_result_e10 as gsl_sf_result_e10_struct
declare function gsl_sf_result_smash_e(byval re as const gsl_sf_result_e10 ptr, byval r as gsl_sf_result ptr) as long

end extern
