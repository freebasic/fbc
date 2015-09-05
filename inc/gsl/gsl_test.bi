'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
''   err/gsl_test.h
''
''   Copyright (C) 1996, 1997, 1998, 1999, 2000, 2007 Gerard Jungman, Brian Gough
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

#define __GSL_TEST_H__
declare sub gsl_test(byval status as long, byval test_description as const zstring ptr, ...)
declare sub gsl_test_rel(byval result as double, byval expected as double, byval relative_error as double, byval test_description as const zstring ptr, ...)
declare sub gsl_test_abs(byval result as double, byval expected as double, byval absolute_error as double, byval test_description as const zstring ptr, ...)
declare sub gsl_test_factor(byval result as double, byval expected as double, byval factor as double, byval test_description as const zstring ptr, ...)
declare sub gsl_test_int(byval result as long, byval expected as long, byval test_description as const zstring ptr, ...)
declare sub gsl_test_str(byval result as const zstring ptr, byval expected as const zstring ptr, byval test_description as const zstring ptr, ...)
declare sub gsl_test_verbose(byval verbose as long)
declare function gsl_test_summary() as long

end extern
