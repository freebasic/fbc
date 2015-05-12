''
''
'' gsl_wavelet2d -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_wavelet2d_bi__
#define __gsl_wavelet2d_bi__

#include once "gsl_errno.bi"
#include once "gsl_vector_double.bi"
#include once "gsl_matrix_double.bi"
#include once "gsl_wavelet.bi"
#include once "gsl_types.bi"

extern "c"
declare function gsl_wavelet2d_transform (byval w as gsl_wavelet ptr, byval data as double ptr, byval tda as integer, byval size1 as integer, byval size2 as integer, byval dir as gsl_wavelet_direction, byval work as gsl_wavelet_workspace ptr) as integer
declare function gsl_wavelet2d_transform_forward (byval w as gsl_wavelet ptr, byval data as double ptr, byval tda as integer, byval size1 as integer, byval size2 as integer, byval work as gsl_wavelet_workspace ptr) as integer
declare function gsl_wavelet2d_transform_inverse (byval w as gsl_wavelet ptr, byval data as double ptr, byval tda as integer, byval size1 as integer, byval size2 as integer, byval work as gsl_wavelet_workspace ptr) as integer
declare function gsl_wavelet2d_nstransform (byval w as gsl_wavelet ptr, byval data as double ptr, byval tda as integer, byval size1 as integer, byval size2 as integer, byval dir as gsl_wavelet_direction, byval work as gsl_wavelet_workspace ptr) as integer
declare function gsl_wavelet2d_nstransform_forward (byval w as gsl_wavelet ptr, byval data as double ptr, byval tda as integer, byval size1 as integer, byval size2 as integer, byval work as gsl_wavelet_workspace ptr) as integer
declare function gsl_wavelet2d_nstransform_inverse (byval w as gsl_wavelet ptr, byval data as double ptr, byval tda as integer, byval size1 as integer, byval size2 as integer, byval work as gsl_wavelet_workspace ptr) as integer
declare function gsl_wavelet2d_transform_matrix (byval w as gsl_wavelet ptr, byval a as gsl_matrix ptr, byval dir as gsl_wavelet_direction, byval work as gsl_wavelet_workspace ptr) as integer
declare function gsl_wavelet2d_transform_matrix_forward (byval w as gsl_wavelet ptr, byval a as gsl_matrix ptr, byval work as gsl_wavelet_workspace ptr) as integer
declare function gsl_wavelet2d_transform_matrix_inverse (byval w as gsl_wavelet ptr, byval a as gsl_matrix ptr, byval work as gsl_wavelet_workspace ptr) as integer
declare function gsl_wavelet2d_nstransform_matrix (byval w as gsl_wavelet ptr, byval a as gsl_matrix ptr, byval dir as gsl_wavelet_direction, byval work as gsl_wavelet_workspace ptr) as integer
declare function gsl_wavelet2d_nstransform_matrix_forward (byval w as gsl_wavelet ptr, byval a as gsl_matrix ptr, byval work as gsl_wavelet_workspace ptr) as integer
declare function gsl_wavelet2d_nstransform_matrix_inverse (byval w as gsl_wavelet ptr, byval a as gsl_matrix ptr, byval work as gsl_wavelet_workspace ptr) as integer
end extern

#endif
