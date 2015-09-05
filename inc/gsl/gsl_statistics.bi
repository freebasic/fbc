'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
''
''   Copyright (C) 1996, 1997, 1998, 1999, 2000, 2007 Jim Davies, Brian Gough
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

#include once "gsl/gsl_statistics_long_double.bi"
#include once "gsl/gsl_statistics_double.bi"
#include once "gsl/gsl_statistics_float.bi"
#include once "gsl/gsl_statistics_ulong.bi"
#include once "gsl/gsl_statistics_long.bi"
#include once "gsl/gsl_statistics_uint.bi"
#include once "gsl/gsl_statistics_int.bi"
#include once "gsl/gsl_statistics_ushort.bi"
#include once "gsl/gsl_statistics_short.bi"
#include once "gsl/gsl_statistics_uchar.bi"
#include once "gsl/gsl_statistics_char.bi"

#define __GSL_STATISTICS_H__
