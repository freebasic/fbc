'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
''   sort/gsl_sort_ushort.h
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

#include once "crt/stdlib.bi"
#include once "gsl/gsl_errno.bi"
#include once "gsl/gsl_permutation.bi"

extern "C"

#define __GSL_SORT_USHORT_H__
declare sub gsl_sort_ushort(byval data as ushort ptr, byval stride as const uinteger, byval n as const uinteger)
declare sub gsl_sort2_ushort(byval data1 as ushort ptr, byval stride1 as const uinteger, byval data2 as ushort ptr, byval stride2 as const uinteger, byval n as const uinteger)
declare sub gsl_sort_ushort_index(byval p as uinteger ptr, byval data as const ushort ptr, byval stride as const uinteger, byval n as const uinteger)
declare function gsl_sort_ushort_smallest(byval dest as ushort ptr, byval k as const uinteger, byval src as const ushort ptr, byval stride as const uinteger, byval n as const uinteger) as long
declare function gsl_sort_ushort_smallest_index(byval p as uinteger ptr, byval k as const uinteger, byval src as const ushort ptr, byval stride as const uinteger, byval n as const uinteger) as long
declare function gsl_sort_ushort_largest(byval dest as ushort ptr, byval k as const uinteger, byval src as const ushort ptr, byval stride as const uinteger, byval n as const uinteger) as long
declare function gsl_sort_ushort_largest_index(byval p as uinteger ptr, byval k as const uinteger, byval src as const ushort ptr, byval stride as const uinteger, byval n as const uinteger) as long

end extern
