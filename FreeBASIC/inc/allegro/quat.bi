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
'      Quaternion routines.
'
'      By Shawn Hargreaves.
'
'      See readme.txt for copyright information.
'


#ifndef ALLEGRO_QUAT_H
#define ALLEGRO_QUAT_H

#include "allegro/base.bi"

Type QUAT
	w As Single
	x As Single
	y As Single
	z As Single
End Type

Extern import identity_quat alias "identity_quat" As QUAT

Declare Sub quat_mul CDecl Alias "quat_mul" (byval p as QUAT ptr, byval q as QUAT ptr, byval outp as QUAT ptr)
Declare sub get_x_rotate_quat cdecl alias "get_x_rotate_quat" ( byval q as QUAT ptr, byval r as single)
Declare sub get_y_rotate_quat cdecl alias "get_y_rotate_quat" ( byval q as QUAT ptr, byval r as single)
Declare sub get_z_rotate_quat cdecl alias "get_z_rotate_quat" ( byval q as QUAT ptr, byval r as single)
declare sub get_rotation_quat cdecl alias "get_rotation_quat" ( byval q as QUAT ptr, byval x as single, byval y as single, byval z as single )
declare sub get_vector_rotation_quat cdecl alias "get_vector_rotation_quat" ( byval q as QUAT ptr, byval x as single, byval y as single, byval z as single, byval a as single )

declare sub apply_quat cdecl alias "apply_quat" ( byval q as QUAT ptr, byval x as single, byval y as single, byval z as single, byval xout as single ptr, byval yout as single ptr, byval zout as single ptr )
declare sub quat_slerp cdecl alias "quat_slerp" ( byval pfrom as QUAT ptr, byval pto as QUAT ptr, byval t as single, byval outp as QUAT ptr, byval how as integer )

#define QUAT_SHORT   0
#define QUAT_LONG    1
#define QUAT_CW      2
#define QUAT_CCW     3
#define QUAT_USER    4

#define quat_interpolate(pfrom, pto, t, pout)   quat_slerp (pfrom), (pto), (t), (pout), QUAT_SHORT

#endif
