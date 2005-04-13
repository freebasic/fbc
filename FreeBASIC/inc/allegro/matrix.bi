'         ______   ___    ___
'        /\  _  \ /\_ \  /\_ \
'        \ \ \L\ \\//\ \ \//\ \      __     __   _ __   ___
'         \ \  __ \ \ \ \  \ \ \   /'__`\ /'_ `\/\`'__\/ __`\
'          \ \ \/\ \ \_\ \_ \_\ \_/\  __//\ \L\ \ \ \//\ \L\ \
'           \ \_\ \_\/\____\/\____\ \____\ \____ \ \_\\ \____/
'            \/_/\/_/\/____/\/____/\/____/\/___L\ \/_/ \/___/
'                                           /\____/
'                                           \_/__/
'
'      Matrix math routines.
'
'      By Shawn Hargreaves.
'
'      See readme.txt for copyright information.
'


#ifndef ALLEGRO_MATRIX_H
#define ALLEGRO_MATRIX_H

#include "allegro/base.bi"
#include "allegro/fixed.bi"
#include "allegro/fmaths.bi"

Type MATRIX					' transformation matrix (fixed point)
	v(2, 2) As fixed			' scaling and rotation
	t(2) As fixed				' translation
End Type

Type MATRIX_f					' transformation matrix (floating point)
	v(2, 2) As Single			' scaling and rotation
	t(2) As Single				' translation
End Type

extern import identity_matrix alias "identity_matrix" as MATRIX
extern import identity_matrix_f alias "identity_matrix_f" as MATRIX_f

Declare Sub get_translation_matrix CDecl Alias "get_translation_matrix" (ByVal m As MATRIX Ptr, ByVal x As fixed, ByVal y As fixed, ByVal z As fixed)
Declare Sub get_translation_matrix_f CDecl Alias "get_translation_matrix_f" (ByVal m As MATRIX_f Ptr, ByVal x As Single, ByVal y As Single, ByVal z As Single)

Declare Sub get_scaling_matrix CDecl Alias "get_scaling_matrix" (ByVal m As MATRIX Ptr, Byval x As fixed, ByVal y As fixed, ByVal z As fixed)
Declare Sub get_scaling_matrix_f CDecl Alias "get_scaling_matrix_f" (ByVal m As MATRIX_f Ptr, ByVal x As Single, ByVal y As Single, ByVal z As Single)

Declare Sub get_x_rotate_matrix CDecl Alias "get_x_rotate_matrix" (ByVal m As MATRIX Ptr, ByVal r As fixed)
Declare Sub get_x_rotate_matrix_f CDecl Alias "get_x_rotate_matrix_f" (ByVal m As MATRIX_f Ptr, ByVal r As Single)

Declare Sub get_y_rotate_matrix CDecl Alias "get_y_rotate_matrix" (ByVal m As MATRIX Ptr, ByVal r As fixed)
Declare Sub get_y_rotate_matrix_f CDecl Alias "get_y_rotate_matrix_f" (ByVal m As MATRIX_f Ptr, ByVal r As Single)

Declare Sub get_z_rotate_matrix CDecl Alias "get_z_rotate_matrix" (ByVal m As MATRIX Ptr, ByVal r As fixed)
Declare Sub get_z_rotate_matrix_f CDecl Alias "get_z_rotate_matrix_f" (ByVal m As MATRIX_f Ptr, ByVal r As Single)

Declare Sub get_rotation_matrix CDecl Alias "get_rotation_matrix" (ByVal m As MATRIX Ptr, ByVal x As fixed, BYVal y As fixed, ByVal z As fixed)
Declare Sub get_rotation_matrix_f CDecl Alias "get_rotation_matrix_f" (ByVal m As MATRIX_f Ptr, ByVal x As Single, ByVal y As Single, ByVal z As Single)

Declare Sub get_align_matrix CDecl Alias "get_align_matrix" (ByVal m As MATRIX Ptr, ByVal xfront As fixed, ByVal yfront As fixed, ByVal zfront As fixed, ByVal xup As fixed, ByVal yup As fixed, ByVal zup As fixed)
Declare Sub get_align_matrix_f CDecl Alias "get_align_matrix_f" (ByVal m As MATRIX_f Ptr, ByVal xfront As Single, ByVal yfront As Single, ByVal zfront As Single, ByVal xup As Single, ByVal yup As Single, ByVal zup As Single)

Declare Sub get_vector_rotation_matrix CDecl Alias "get_vector_rotation_matrix" (ByVal m As MATRIX Ptr, ByVal x As fixed, ByVal y As fixed, BYVal z AS fixed, ByVal a As fixed)
Declare Sub get_vector_rotation_matrix_f CDecl Alias "get_vector_rotation_matrix_f" (ByVal m As MATRIX_f Ptr, ByVal x As Single, ByVal y As Single, ByVal z As Single, ByVal a As Single)

Declare Sub get_transformation_matrix CDecl Alias "get_transformation_matrix" (ByVal m As MATRIX Ptr, ByVal scale As fixed, ByVal xrot As fixed, ByVal yrot As fixed, ByVal zrot As fixed, ByVal x As fixed, ByVal y As fixed, byVal z As fixed)
Declare Sub get_transformation_matrix_f CDecl Alias "get_transformation_matrix_f" (ByVal m As MATRIX_f Ptr, ByVal scale As Single, ByVal xrot As Single, BYVal yrot As Single, ByVal zrot As Single, ByVal x As Single, BYVal y As Single, ByVal z As Single)

Declare Sub get_camera_matrix CDecl Alias "get_camera_matrix" (ByVal m As MATRIX Ptr, ByVal x As fixed, ByVal y As fixed, ByVal z As fixed, ByVal xfront As fixed, ByVal yfront As fixed, BYval zfront As fixed, ByVal xup As fixed, ByVal yup As fixed, ByVal zup As fixed, ByVal fov As fixed, ByVal aspect As fixed)
Declare Sub get_camera_matrix_f CDecl Alias "get_camera_matrix_f" (ByVal m As MATRIX_f Ptr, ByVal x As Single, ByVal y As Single, ByVal z As Single, ByVal xfront As Single, ByVal yfront As Single, ByVal zfront As Single, ByVal xup As Single, BYVal yup As Single, ByVal zup As Single, ByVal fov As Single, Byval aspect As Single)

Declare Sub qtranslate_matrix CDecl Alias "qtranslate_matrix" (ByVal m As MATRIX Ptr, ByVal x As fixed, BYVal y As fixed, ByVal z As fixed)
Declare Sub qtrnslate_matrix_f CDecl Alias "qtranslate_matrix_f" (ByVal m As MATRIX_f Ptr, ByVal x As Single, ByVal y As Single, ByVal z As Single)

Declare Sub qscale_matrix CDecl Alias "qscale_matrix" (ByVal m As MATRIX Ptr, ByVal scale As fixed)
Declare Sub qscale_matrix_f CDecl Alias "qscale_matrix_f" (ByVal m As MATRIX_f Ptr, ByVal scale As Single)

Declare Sub matrix_mul CDecl Alias "matrix_mul" (ByVal m1 As MATRIX Ptr, ByVal m2 As MATRIX Ptr, ByVal mout As MATRIX Ptr)
Declare Sub matrix_mul_f CDecl Alias "matrix_mul_f" (ByVal m1 As MATRIX_f Ptr, ByVal m2 As MATRIX_f Ptr, ByVal mout As MATRIX_f Ptr)

Declare Sub apply_matrix_f CDecl Alias "apply_matrix_f" (ByVal m As MATRIX_f Ptr, ByVal x As Single, ByVal y As SIngle, byVal z As Single, ByRef xout As Single, ByRef yout As Single, Byref zout As Single)

#include "allegro/inline/matrix.inl"

#endif
