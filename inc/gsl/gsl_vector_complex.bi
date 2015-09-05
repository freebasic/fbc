'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
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

'' The following symbols have been renamed:
''     #define GSL_VECTOR_COMPLEX => GSL_VECTOR_COMPLEX_

#define __GSL_VECTOR_COMPLEX_H__
#define GSL_VECTOR_REAL(z, i) (z)->data[((2 * (i)) * (z)->stride)]
#define GSL_VECTOR_IMAG(z, i) (z)->data[(((2 * (i)) * (z)->stride) + 1)]
#define GSL_VECTOR_COMPLEX_(zv, i) (*GSL_COMPLEX_AT((zv), (i)))
#define GSL_COMPLEX_AT(zv, i) cptr(gsl_complex ptr, @(zv)->data[((2 * (i)) * (zv)->stride)])
#define GSL_COMPLEX_FLOAT_AT(zv, i) cptr(gsl_complex_float ptr, @(zv)->data[((2 * (i)) * (zv)->stride)])
#define GSL_COMPLEX_LONG_DOUBLE_AT(zv, i) cptr(gsl_complex_long_double ptr, @(zv)->data[((2 * (i)) * (zv)->stride)])
