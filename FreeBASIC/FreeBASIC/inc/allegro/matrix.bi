''
''
'' allegro\matrix -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __allegro_matrix_bi__
#define __allegro_matrix_bi__

#include once "allegro/base.bi"
#include once "allegro/fixed.bi"
#include once "allegro/fmaths.bi"

type MATRIX
	v(0 to 3-1, 0 to 3-1) as fixed
	t(0 to 3-1) as fixed
end type

type MATRIX_f
	v(0 to 3-1, 0 to 3-1) as single
	t(0 to 3-1) as single
end type

extern _AL_DLL identity_matrix alias "identity_matrix" as MATRIX
extern _AL_DLL identity_matrix_f alias "identity_matrix_f" as MATRIX_f

declare sub get_translation_matrix cdecl alias "get_translation_matrix" (byval m as MATRIX ptr, byval x as fixed, byval y as fixed, byval z as fixed)
declare sub get_translation_matrix_f cdecl alias "get_translation_matrix_f" (byval m as MATRIX_f ptr, byval x as single, byval y as single, byval z as single)
declare sub get_scaling_matrix cdecl alias "get_scaling_matrix" (byval m as MATRIX ptr, byval x as fixed, byval y as fixed, byval z as fixed)
declare sub get_scaling_matrix_f cdecl alias "get_scaling_matrix_f" (byval m as MATRIX_f ptr, byval x as single, byval y as single, byval z as single)
declare sub get_x_rotate_matrix cdecl alias "get_x_rotate_matrix" (byval m as MATRIX ptr, byval r as fixed)
declare sub get_x_rotate_matrix_f cdecl alias "get_x_rotate_matrix_f" (byval m as MATRIX_f ptr, byval r as single)
declare sub get_y_rotate_matrix cdecl alias "get_y_rotate_matrix" (byval m as MATRIX ptr, byval r as fixed)
declare sub get_y_rotate_matrix_f cdecl alias "get_y_rotate_matrix_f" (byval m as MATRIX_f ptr, byval r as single)
declare sub get_z_rotate_matrix cdecl alias "get_z_rotate_matrix" (byval m as MATRIX ptr, byval r as fixed)
declare sub get_z_rotate_matrix_f cdecl alias "get_z_rotate_matrix_f" (byval m as MATRIX_f ptr, byval r as single)
declare sub get_rotation_matrix cdecl alias "get_rotation_matrix" (byval m as MATRIX ptr, byval x as fixed, byval y as fixed, byval z as fixed)
declare sub get_rotation_matrix_f cdecl alias "get_rotation_matrix_f" (byval m as MATRIX_f ptr, byval x as single, byval y as single, byval z as single)
declare sub get_align_matrix cdecl alias "get_align_matrix" (byval m as MATRIX ptr, byval xfront as fixed, byval yfront as fixed, byval zfront as fixed, byval xup as fixed, byval yup as fixed, byval zup as fixed)
declare sub get_align_matrix_f cdecl alias "get_align_matrix_f" (byval m as MATRIX_f ptr, byval xfront as single, byval yfront as single, byval zfront as single, byval xup as single, byval yup as single, byval zup as single)
declare sub get_vector_rotation_matrix cdecl alias "get_vector_rotation_matrix" (byval m as MATRIX ptr, byval x as fixed, byval y as fixed, byval z as fixed, byval a as fixed)
declare sub get_vector_rotation_matrix_f cdecl alias "get_vector_rotation_matrix_f" (byval m as MATRIX_f ptr, byval x as single, byval y as single, byval z as single, byval a as single)
declare sub get_transformation_matrix cdecl alias "get_transformation_matrix" (byval m as MATRIX ptr, byval scale as fixed, byval xrot as fixed, byval yrot as fixed, byval zrot as fixed, byval x as fixed, byval y as fixed, byval z as fixed)
declare sub get_transformation_matrix_f cdecl alias "get_transformation_matrix_f" (byval m as MATRIX_f ptr, byval scale as single, byval xrot as single, byval yrot as single, byval zrot as single, byval x as single, byval y as single, byval z as single)
declare sub get_camera_matrix cdecl alias "get_camera_matrix" (byval m as MATRIX ptr, byval x as fixed, byval y as fixed, byval z as fixed, byval xfront as fixed, byval yfront as fixed, byval zfront as fixed, byval xup as fixed, byval yup as fixed, byval zup as fixed, byval fov as fixed, byval aspect as fixed)
declare sub get_camera_matrix_f cdecl alias "get_camera_matrix_f" (byval m as MATRIX_f ptr, byval x as single, byval y as single, byval z as single, byval xfront as single, byval yfront as single, byval zfront as single, byval xup as single, byval yup as single, byval zup as single, byval fov as single, byval aspect as single)
declare sub qtranslate_matrix cdecl alias "qtranslate_matrix" (byval m as MATRIX ptr, byval x as fixed, byval y as fixed, byval z as fixed)
declare sub qtranslate_matrix_f cdecl alias "qtranslate_matrix_f" (byval m as MATRIX_f ptr, byval x as single, byval y as single, byval z as single)
declare sub qscale_matrix cdecl alias "qscale_matrix" (byval m as MATRIX ptr, byval scale as fixed)
declare sub qscale_matrix_f cdecl alias "qscale_matrix_f" (byval m as MATRIX_f ptr, byval scale as single)
declare sub matrix_mul cdecl alias "matrix_mul" (byval m1 as MATRIX ptr, byval m2 as MATRIX ptr, byval out as MATRIX ptr)
declare sub matrix_mul_f cdecl alias "matrix_mul_f" (byval m1 as MATRIX_f ptr, byval m2 as MATRIX_f ptr, byval out as MATRIX_f ptr)
declare sub apply_matrix_f cdecl alias "apply_matrix_f" (byval m as MATRIX_f ptr, byval x as single, byval y as single, byval z as single, byval xout as single ptr, byval yout as single ptr, byval zout as single ptr)

#include once "allegro/inline/matrix.bi"

#endif
