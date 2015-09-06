'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
''   specfunc/gsl_sf_coupling.h
''
''   Copyright (C) 1996,1997,1998,1999,2000,2001,2002 Gerard Jungman
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

#include once "gsl/gsl_sf_result.bi"

extern "C"

#define __GSL_SF_COUPLING_H__
declare function gsl_sf_coupling_3j_e(byval two_ja as long, byval two_jb as long, byval two_jc as long, byval two_ma as long, byval two_mb as long, byval two_mc as long, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_coupling_3j(byval two_ja as long, byval two_jb as long, byval two_jc as long, byval two_ma as long, byval two_mb as long, byval two_mc as long) as double
declare function gsl_sf_coupling_6j_e(byval two_ja as long, byval two_jb as long, byval two_jc as long, byval two_jd as long, byval two_je as long, byval two_jf as long, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_coupling_6j(byval two_ja as long, byval two_jb as long, byval two_jc as long, byval two_jd as long, byval two_je as long, byval two_jf as long) as double
declare function gsl_sf_coupling_RacahW_e(byval two_ja as long, byval two_jb as long, byval two_jc as long, byval two_jd as long, byval two_je as long, byval two_jf as long, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_coupling_RacahW(byval two_ja as long, byval two_jb as long, byval two_jc as long, byval two_jd as long, byval two_je as long, byval two_jf as long) as double
declare function gsl_sf_coupling_9j_e(byval two_ja as long, byval two_jb as long, byval two_jc as long, byval two_jd as long, byval two_je as long, byval two_jf as long, byval two_jg as long, byval two_jh as long, byval two_ji as long, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_coupling_9j(byval two_ja as long, byval two_jb as long, byval two_jc as long, byval two_jd as long, byval two_je as long, byval two_jf as long, byval two_jg as long, byval two_jh as long, byval two_ji as long) as double
declare function gsl_sf_coupling_6j_INCORRECT_e(byval two_ja as long, byval two_jb as long, byval two_jc as long, byval two_jd as long, byval two_je as long, byval two_jf as long, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_coupling_6j_INCORRECT(byval two_ja as long, byval two_jb as long, byval two_jc as long, byval two_jd as long, byval two_je as long, byval two_jf as long) as double

end extern
