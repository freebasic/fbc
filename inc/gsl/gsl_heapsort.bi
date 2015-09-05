'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
''   sort/gsl_heapsort.h
''
''   Copyright (C) 1996, 1997, 1998, 1999, 2000, 2007 Thomas Walter, Brian Gough
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

#include once "gsl/gsl_permutation.bi"

extern "C"

#define __GSL_HEAPSORT_H__
type gsl_comparison_fn_t as function(byval as const any ptr, byval as const any ptr) as long
declare sub gsl_heapsort(byval array as any ptr, byval count as uinteger, byval size as uinteger, byval compare as gsl_comparison_fn_t)
declare function gsl_heapsort_index(byval p as uinteger ptr, byval array as const any ptr, byval count as uinteger, byval size as uinteger, byval compare as gsl_comparison_fn_t) as long

end extern
