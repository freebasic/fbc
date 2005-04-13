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
'      3D oriented math routines.
'
'      By Shawn Hargreaves.
'
'      See readme.txt for copyright information.
'

#ifndef ALLEGRO_3DMATHS_H
#define ALLEGRO_3DMATHS_H


#include "allegro/base.bi"
#include "allegro/fixed.bi"
#include "allegro/quat.bi"
#include "allegro/matrix.bi"

Declare Function vector_length CDecl Alias "vector_length" (ByVal x As fixed, BYVal y As fixed, ByVal z As fixed) As fixed
Declare Function vector_length_f CDecl Alias "vector_length_f" (ByVal x As Single, BYVal y As Single, ByVal z As Single) As SIngle

Declare Sub normalize_vector CDecl Alias "normalize_vector" (ByRef x As fixed, ByRef y As fixed, ByRef z As fixed)
Declare Sub normalize_vector_f CDecl Alias "normalize_vector_f" (ByRef x As Single, ByRef y As Single, ByRef z As Single)

Declare Sub cross_product CDecl Alias "cross_product" (ByVal x1 As fixed, BYVal y1 As fixed, ByVal z1 As fixed, BYVal x2 As fixed, BYVal y2 As fixed, ByVal z2 As fixed, ByRef xout As fixed, ByRef yout As fixed, ByRef zout As fixed)
Declare Sub cross_product_f CDecl Alias "cross_product_f" (ByVal x1 As Single, BYVal y1 As Single, ByVal z1 As Single, BYVal x2 As Single, BYVal y2 As Single, ByVal z2 As Single, ByRef xout As Single, ByRef yout As Single, ByRef zout As Single)

extern import _persp_xscale alias "_persp_xscale" as fixed
extern import _persp_yscale alias "_persp_yscale" as fixed
extern import _persp_xoffset alias "_persp_xoffset" as fixed
extern import _persp_yoffset alias "_persp_yoffset" as fixed

extern import _persp_xscale_f alias "_persp_xscale_f" as single
extern import _persp_yscale_f alias "_persp_yscale_f" as single
extern import _persp_xoffset_f alias "_persp_xoffset_f" as single
extern import _persp_yoffset_f alias "_persp_yoffset_f" as single

Declare Sub set_projection_viewport CDecl Alias "set_projection_viewport" (ByVal x As Integer, BYVal y As Integer, ByVal w As Integer, ByVal h As Integer)

declare sub quat_to_matrix cdecl alias "quat_to_matrix" ( byval q as QUAT ptr, byval m as MATRIX_f ptr )
declare sub matrix_to_quat cdecl alias "matrix_to_quat" ( byval m as MATRIX_f ptr, byval q as QUAT ptr )

#include "allegro/inline/3dmaths.inl"

#endif
