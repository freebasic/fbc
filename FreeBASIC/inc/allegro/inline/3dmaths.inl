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
'      3D maths inline functions (generic C).
'
'      By Shawn Hargreaves.
'
'      See readme.txt for copyright information.
'


#ifndef ALLEGRO_3DMATHS_INL
#define ALLEGRO_3DMATHS_INL

#include "allegro/fixed.bi"

'Declare Function dot_product CDecl Alias "dot_product" (Byval x1 As fixed, ByVal y1 As fixed, ByVal z1 As fixed, ByVal x2 As fixed, ByVAl y2 As fixed, BYVal z2 As fixed) As fixed
'Declare Function dot_product_f CDecl Alias "dot_product_f" (ByVal x1 As Single, ByVal y1 As Single, ByVal z1 As Single, ByVal x2 As Single, ByVal y2 AS Single, ByVal z2 As Single) As Single
'Declare Sub persp_project CDecl Alias "persp_project" (ByVal x As fixed, ByVal y As fixed, BYVal z As fixed, ByRef xout As fixed, BYRef yout As fixed)
'Declare Sub persp_project_f CDecl Alias "persp_project_f" (ByVal x As Single, ByVal y As Single, ByVal z As Single, ByRef xout As Single, ByRef yout As Single)

Private Inline Function dot_product(ByVal x1 As fixed, ByVal y1 As fixed, ByVal z1 As fixed, ByVal x2 As fixed, ByVal y2 As fixed, ByVal z2 As fixed) As fixed
	dot_product = fixmul(x1, x2) + fixmul(y1, y2) + fixmul(z1, z2)
End Function

Private Inline Function dot_product_f(ByVal x1 As Single, ByVAl y1 As Single, BYVAl z1 As Single, ByVAl x2 As Single, BYVal y2 As Single, ByVAl z2 As Single) As Single
	dot_product_f = (x1 * x2) + (y1 * y2) + (z1 * z2)
End Function

Private Inline Sub persp_project(ByVal x As fixed, ByVal y As fixed, ByVAl z As fixed, ByVal xout As fixed Ptr, ByVal yout As fixed Ptr)
	*xout = fixmul(fixdiv(x, z), _persp_xscale) + _persp_xoffset
	*yout = fixmul(fixdiv(y, z), _persp_yscale) + _persp_yoffset
End Sub

Private Inline Sub persp_project_f(ByVal x As Single, ByVal y As Single, ByVal z As Single, ByVAl xout As Single Ptr, ByVal yout As Single Ptr)
	Dim z1 As Single
	z1 = 1.0 / z
	*xout = ((x * z1) * _persp_xscale_f) + _persp_xoffset_f
	*yout = ((y * z1) * _persp_yscale_f) + _persp_yoffset_f
End Sub

#endif
