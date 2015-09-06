'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
''   wavelet/gsl_wavelet.h
''
''   Copyright (C) 2004 Ivo Alxneit
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
#include once "gsl/gsl_vector_double.bi"
#include once "gsl/gsl_matrix_double.bi"
#include once "gsl/gsl_wavelet.bi"

extern "C"

#define __GSL_WAVELET2D_H__
declare function gsl_wavelet2d_transform(byval w as const gsl_wavelet ptr, byval data as double ptr, byval tda as uinteger, byval size1 as uinteger, byval size2 as uinteger, byval dir as gsl_wavelet_direction, byval work as gsl_wavelet_workspace ptr) as long
declare function gsl_wavelet2d_transform_forward(byval w as const gsl_wavelet ptr, byval data as double ptr, byval tda as uinteger, byval size1 as uinteger, byval size2 as uinteger, byval work as gsl_wavelet_workspace ptr) as long
declare function gsl_wavelet2d_transform_inverse(byval w as const gsl_wavelet ptr, byval data as double ptr, byval tda as uinteger, byval size1 as uinteger, byval size2 as uinteger, byval work as gsl_wavelet_workspace ptr) as long
declare function gsl_wavelet2d_nstransform(byval w as const gsl_wavelet ptr, byval data as double ptr, byval tda as uinteger, byval size1 as uinteger, byval size2 as uinteger, byval dir as gsl_wavelet_direction, byval work as gsl_wavelet_workspace ptr) as long
declare function gsl_wavelet2d_nstransform_forward(byval w as const gsl_wavelet ptr, byval data as double ptr, byval tda as uinteger, byval size1 as uinteger, byval size2 as uinteger, byval work as gsl_wavelet_workspace ptr) as long
declare function gsl_wavelet2d_nstransform_inverse(byval w as const gsl_wavelet ptr, byval data as double ptr, byval tda as uinteger, byval size1 as uinteger, byval size2 as uinteger, byval work as gsl_wavelet_workspace ptr) as long
declare function gsl_wavelet2d_transform_matrix(byval w as const gsl_wavelet ptr, byval a as gsl_matrix ptr, byval dir as gsl_wavelet_direction, byval work as gsl_wavelet_workspace ptr) as long
declare function gsl_wavelet2d_transform_matrix_forward(byval w as const gsl_wavelet ptr, byval a as gsl_matrix ptr, byval work as gsl_wavelet_workspace ptr) as long
declare function gsl_wavelet2d_transform_matrix_inverse(byval w as const gsl_wavelet ptr, byval a as gsl_matrix ptr, byval work as gsl_wavelet_workspace ptr) as long
declare function gsl_wavelet2d_nstransform_matrix(byval w as const gsl_wavelet ptr, byval a as gsl_matrix ptr, byval dir as gsl_wavelet_direction, byval work as gsl_wavelet_workspace ptr) as long
declare function gsl_wavelet2d_nstransform_matrix_forward(byval w as const gsl_wavelet ptr, byval a as gsl_matrix ptr, byval work as gsl_wavelet_workspace ptr) as long
declare function gsl_wavelet2d_nstransform_matrix_inverse(byval w as const gsl_wavelet ptr, byval a as gsl_matrix ptr, byval work as gsl_wavelet_workspace ptr) as long

end extern
