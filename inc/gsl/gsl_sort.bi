'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
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

#include once "gsl/gsl_sort_long_double.bi"
#include once "gsl/gsl_sort_double.bi"
#include once "gsl/gsl_sort_float.bi"
#include once "gsl/gsl_sort_ulong.bi"
#include once "gsl/gsl_sort_long.bi"
#include once "gsl/gsl_sort_uint.bi"
#include once "gsl/gsl_sort_int.bi"
#include once "gsl/gsl_sort_ushort.bi"
#include once "gsl/gsl_sort_short.bi"
#include once "gsl/gsl_sort_uchar.bi"
#include once "gsl/gsl_sort_char.bi"

#define __GSL_SORT_H__
