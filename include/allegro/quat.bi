''
''
'' allegro\quat -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __allegro_quat_bi__
#define __allegro_quat_bi__

#include once "allegro/base.bi"

type QUAT
	w as single
	x as single
	y as single
	z as single
end type

extern _AL_DLL identity_quat alias "identity_quat" as QUAT

declare sub quat_mul cdecl alias "quat_mul" (byval p as QUAT ptr, byval q as QUAT ptr, byval out as QUAT ptr)
declare sub get_x_rotate_quat cdecl alias "get_x_rotate_quat" (byval q as QUAT ptr, byval r as single)
declare sub get_y_rotate_quat cdecl alias "get_y_rotate_quat" (byval q as QUAT ptr, byval r as single)
declare sub get_z_rotate_quat cdecl alias "get_z_rotate_quat" (byval q as QUAT ptr, byval r as single)
declare sub get_rotation_quat cdecl alias "get_rotation_quat" (byval q as QUAT ptr, byval x as single, byval y as single, byval z as single)
declare sub get_vector_rotation_quat cdecl alias "get_vector_rotation_quat" (byval q as QUAT ptr, byval x as single, byval y as single, byval z as single, byval a as single)
declare sub apply_quat cdecl alias "apply_quat" (byval q as QUAT ptr, byval x as single, byval y as single, byval z as single, byval xout as single ptr, byval yout as single ptr, byval zout as single ptr)
declare sub quat_slerp cdecl alias "quat_slerp" (byval from as QUAT ptr, byval to as QUAT ptr, byval t as single, byval out as QUAT ptr, byval how as integer)

#define QUAT_SHORT 0
#define QUAT_LONG 1
#define QUAT_CW 2
#define QUAT_CCW 3
#define QUAT_USER 4

#define quat_interpolate(from, to_, t, out_) quat_slerp(from, to_, t, out_, QUAT_SHORT)

#endif
