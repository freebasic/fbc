'' FreeBASIC binding for graphene
''
'' Note: incomplete translation, focuses on Gtk4 requirements
''
'' based on the C header files:
''   graphene
''
''   SPDX-License-Identifier: MIT
''
''   Copyright 2014  Emmanuele Bassi
''
''   Permission is hereby granted, free of charge, to any person obtaining a copy
''   of this software and associated documentation files (the "Software"), to deal
''   in the Software without restriction, including without limitation the rights
''   to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
''   copies of the Software, and to permit persons to whom the Software is
''   furnished to do so, subject to the following conditions:
''
''   The above copyright notice and this permission notice shall be included in
''   all copies or substantial portions of the Software.
''
''   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
''   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
''   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
''   AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
''   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
''   OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
''   THE SOFTWARE.
''
'' translated to FreeBASIC by:
''   Ahmad Khalifa

#pragma once

#inclib "graphene-1.0"

extern "C"

#DEFINE GRAPHENE_PI 3.1415926535897932384626434f
#DEFINE GRAPHENE_PI_2 1.5707963267948966192313217f

#DEFINE GRAPHENE_VEC2_LEN 2
#DEFINE GRAPHENE_VEC3_LEN 3
#DEFINE GRAPHENE_VEC4_LEN 4

Type bool AS LONG

Type graphene_vec2_t AS _graphene_vec2_t
Type graphene_vec3_t AS _graphene_vec3_t
Type graphene_vec4_t AS _graphene_vec4_t
Type graphene_matrix_t AS _graphene_matrix_t
Type graphene_point_t AS _graphene_point_t
Type graphene_size_t AS _graphene_size_t
Type graphene_rect_t AS _graphene_rect_t
Type graphene_point3d_t AS _graphene_point3d_t
Type graphene_quad_t AS _graphene_quad_t
Type graphene_quaternion_t AS _graphene_quaternion_t
Type graphene_euler_t AS _graphene_euler_t
Type graphene_plane_t AS _graphene_plane_t
Type graphene_frustum_t AS _graphene_frustum_t
Type graphene_sphere_t AS _graphene_sphere_t
Type graphene_box_t AS _graphene_box_t
Type graphene_triangle_t AS _graphene_triangle_t
Type graphene_ray_t AS _graphene_ray_t


Type _graphene_point_t
	AS SINGLE x
	AS SINGLE y
End Type

Declare Function graphene_point_alloc CDECL() AS graphene_point_t Ptr
Declare Sub graphene_point_free CDECL(BYVAL AS graphene_point_t Ptr)
Declare Function graphene_point_init CDECL(BYVAL AS graphene_point_t Ptr, BYVAL AS SINGLE, BYVAL AS SINGLE) AS graphene_point_t Ptr
Declare Function graphene_point_init_from_point CDECL(BYVAL AS graphene_point_t Ptr, BYVAL AS Const graphene_point_t Ptr) AS graphene_point_t Ptr
Declare Function graphene_point_init_from_vec2 CDECL(BYVAL AS graphene_point_t Ptr, BYVAL AS Const graphene_vec2_t Ptr) AS graphene_point_t Ptr
Declare Function graphene_point_equal CDECL(BYVAL AS Const graphene_point_t Ptr, BYVAL AS Const graphene_point_t Ptr) AS bool
Declare Function graphene_point_distance CDECL(BYVAL AS Const graphene_point_t Ptr, BYVAL AS Const graphene_point_t Ptr, BYVAL AS SINGLE Ptr, BYVAL AS SINGLE Ptr) AS SINGLE
Declare Function graphene_point_near CDECL(BYVAL AS Const graphene_point_t Ptr, BYVAL AS Const graphene_point_t Ptr, BYVAL AS SINGLE) AS bool
Declare Sub graphene_point_interpolate CDECL(BYVAL AS Const graphene_point_t Ptr, BYVAL AS Const graphene_point_t Ptr, BYVAL AS DOUBLE, BYVAL AS graphene_point_t Ptr)
Declare Sub graphene_point_to_vec2 CDECL(BYVAL AS Const graphene_point_t Ptr, BYVAL AS graphene_vec2_t Ptr)
Declare Function graphene_point_zero CDECL() AS Const graphene_point_t Ptr


Type _graphene_size_t
	AS SINGLE width
	AS SINGLE height
End Type

Declare Function graphene_size_alloc CDECL() AS graphene_size_t Ptr
Declare Sub graphene_size_free CDECL(BYVAL AS graphene_size_t Ptr)
Declare Function graphene_size_init CDECL(BYVAL AS graphene_size_t Ptr, BYVAL AS SINGLE, BYVAL AS SINGLE) AS graphene_size_t Ptr
Declare Function graphene_size_init_from_size CDECL(BYVAL AS graphene_size_t Ptr, BYVAL AS Const graphene_size_t Ptr) AS graphene_size_t Ptr
Declare Function graphene_size_equal CDECL(BYVAL AS Const graphene_size_t Ptr, BYVAL AS Const graphene_size_t Ptr) AS bool
Declare Sub graphene_size_scale CDECL(BYVAL AS Const graphene_size_t Ptr, BYVAL AS SINGLE, BYVAL AS graphene_size_t Ptr)
Declare Sub graphene_size_interpolate CDECL(BYVAL AS Const graphene_size_t Ptr, BYVAL AS Const graphene_size_t Ptr, BYVAL AS DOUBLE, BYVAL AS graphene_size_t Ptr)
Declare Function graphene_size_zero CDECL() AS Const graphene_size_t Ptr


Type _graphene_point3d_t
	AS SINGLE x
	AS SINGLE y
	AS SINGLE z
End Type

Declare Function graphene_point3d_alloc CDECL() AS graphene_point3d_t Ptr
Declare Sub graphene_point3d_free CDECL(BYVAL AS graphene_point3d_t Ptr)
Declare Function graphene_point3d_init CDECL(BYVAL AS graphene_point3d_t Ptr, BYVAL AS SINGLE, BYVAL AS SINGLE, BYVAL AS SINGLE) AS graphene_point3d_t Ptr
Declare Function graphene_point3d_init_from_point CDECL(BYVAL AS graphene_point3d_t Ptr, BYVAL AS Const graphene_point3d_t Ptr) AS graphene_point3d_t Ptr
Declare Function graphene_point3d_init_from_vec3 CDECL(BYVAL AS graphene_point3d_t Ptr, BYVAL AS Const graphene_vec3_t Ptr) AS graphene_point3d_t Ptr
Declare Sub graphene_point3d_to_vec3 CDECL(BYVAL AS Const graphene_point3d_t Ptr, BYVAL AS graphene_vec3_t Ptr)
Declare Function graphene_point3d_equal CDECL(BYVAL AS Const graphene_point3d_t Ptr, BYVAL AS Const graphene_point3d_t Ptr) AS bool
Declare Function graphene_point3d_near CDECL(BYVAL AS Const graphene_point3d_t Ptr, BYVAL AS Const graphene_point3d_t Ptr, BYVAL AS SINGLE) AS bool
Declare Sub graphene_point3d_scale CDECL(BYVAL AS Const graphene_point3d_t Ptr, BYVAL AS SINGLE, BYVAL AS graphene_point3d_t Ptr)
Declare Sub graphene_point3d_cross CDECL(BYVAL AS Const graphene_point3d_t Ptr, BYVAL AS Const graphene_point3d_t Ptr, BYVAL AS graphene_point3d_t Ptr)
Declare Function graphene_point3d_dot CDECL(BYVAL AS Const graphene_point3d_t Ptr, BYVAL AS Const graphene_point3d_t Ptr) AS SINGLE
Declare Function graphene_point3d_length CDECL(BYVAL AS Const graphene_point3d_t Ptr) AS SINGLE
Declare Sub graphene_point3d_normalize CDECL(BYVAL AS Const graphene_point3d_t Ptr, BYVAL AS graphene_point3d_t Ptr)
Declare Function graphene_point3d_distance CDECL(BYVAL AS Const graphene_point3d_t Ptr, BYVAL AS Const graphene_point3d_t Ptr, BYVAL AS graphene_vec3_t Ptr) AS SINGLE
Declare Sub graphene_point3d_interpolate CDECL(BYVAL AS Const graphene_point3d_t Ptr, BYVAL AS Const graphene_point3d_t Ptr, BYVAL AS DOUBLE, BYVAL AS graphene_point3d_t Ptr)
Declare Sub graphene_point3d_normalize_viewport CDECL(BYVAL AS Const graphene_point3d_t Ptr, BYVAL AS Const graphene_rect_t Ptr, BYVAL AS SINGLE, BYVAL AS SINGLE, BYVAL AS graphene_point3d_t Ptr)
Declare Function graphene_point3d_zero CDECL() AS Const graphene_point3d_t Ptr


Type _graphene_rect_t
	AS graphene_point_t origin
	AS graphene_size_t size
End Type

Declare Function graphene_rect_alloc CDECL() AS graphene_rect_t Ptr
Declare Sub graphene_rect_free CDECL(BYVAL AS graphene_rect_t Ptr)
Declare Function graphene_rect_init CDECL(BYVAL AS graphene_rect_t Ptr, BYVAL AS SINGLE, BYVAL AS SINGLE, BYVAL AS SINGLE, BYVAL AS SINGLE) AS graphene_rect_t Ptr
Declare Function graphene_rect_init_from_rect CDECL(BYVAL AS graphene_rect_t Ptr, BYVAL AS Const graphene_rect_t Ptr) AS graphene_rect_t Ptr
Declare Function graphene_rect_equal CDECL(BYVAL AS Const graphene_rect_t Ptr, BYVAL AS Const graphene_rect_t Ptr) AS bool
Declare Function graphene_rect_normalize CDECL(BYVAL AS graphene_rect_t Ptr) AS graphene_rect_t Ptr
Declare Sub graphene_rect_normalize_r CDECL(BYVAL AS Const graphene_rect_t Ptr, BYVAL AS graphene_rect_t Ptr)
Declare Sub graphene_rect_get_center CDECL(BYVAL AS Const graphene_rect_t Ptr, BYVAL AS graphene_point_t Ptr)
Declare Sub graphene_rect_get_top_left CDECL(BYVAL AS Const graphene_rect_t Ptr, BYVAL AS graphene_point_t Ptr)
Declare Sub graphene_rect_get_top_right CDECL(BYVAL AS Const graphene_rect_t Ptr, BYVAL AS graphene_point_t Ptr)
Declare Sub graphene_rect_get_bottom_right CDECL(BYVAL AS Const graphene_rect_t Ptr, BYVAL AS graphene_point_t Ptr)
Declare Sub graphene_rect_get_bottom_left CDECL(BYVAL AS Const graphene_rect_t Ptr, BYVAL AS graphene_point_t Ptr)
Declare Sub graphene_rect_get_vertices CDECL(BYVAL AS Const graphene_rect_t Ptr, BYVAL AS graphene_vec2_t Ptr)
Declare Function graphene_rect_get_x CDECL(BYVAL AS Const graphene_rect_t Ptr) AS SINGLE
Declare Function graphene_rect_get_y CDECL(BYVAL AS Const graphene_rect_t Ptr) AS SINGLE
Declare Function graphene_rect_get_width CDECL(BYVAL AS Const graphene_rect_t Ptr) AS SINGLE
Declare Function graphene_rect_get_height CDECL(BYVAL AS Const graphene_rect_t Ptr) AS SINGLE
Declare Function graphene_rect_get_area CDECL(BYVAL AS Const graphene_rect_t Ptr) AS SINGLE
Declare Sub graphene_rect_union CDECL(BYVAL AS Const graphene_rect_t Ptr, BYVAL AS Const graphene_rect_t Ptr, BYVAL AS graphene_rect_t Ptr)
Declare Function graphene_rect_intersection CDECL(BYVAL AS Const graphene_rect_t Ptr, BYVAL AS Const graphene_rect_t Ptr, BYVAL AS graphene_rect_t Ptr) AS bool
Declare Function graphene_rect_contains_point CDECL(BYVAL AS Const graphene_rect_t Ptr, BYVAL AS Const graphene_point_t Ptr) AS bool
Declare Function graphene_rect_contains_rect CDECL(BYVAL AS Const graphene_rect_t Ptr, BYVAL AS Const graphene_rect_t Ptr) AS bool
Declare Function graphene_rect_offset CDECL(BYVAL AS graphene_rect_t Ptr, BYVAL AS SINGLE, BYVAL AS SINGLE) AS graphene_rect_t Ptr
Declare Sub graphene_rect_offset_r CDECL(BYVAL AS Const graphene_rect_t Ptr, BYVAL AS SINGLE, BYVAL AS SINGLE, BYVAL AS graphene_rect_t Ptr)
Declare Function graphene_rect_inset CDECL(BYVAL AS graphene_rect_t Ptr, BYVAL AS SINGLE, BYVAL AS SINGLE) AS graphene_rect_t Ptr
Declare Sub graphene_rect_inset_r CDECL(BYVAL AS Const graphene_rect_t Ptr, BYVAL AS SINGLE, BYVAL AS SINGLE, BYVAL AS graphene_rect_t Ptr)
Declare Sub graphene_rect_round_extents CDECL(BYVAL AS Const graphene_rect_t Ptr, BYVAL AS graphene_rect_t Ptr)
Declare Sub graphene_rect_interpolate CDECL(BYVAL AS Const graphene_rect_t Ptr, BYVAL AS Const graphene_rect_t Ptr, BYVAL AS DOUBLE, BYVAL AS graphene_rect_t Ptr)
Declare Sub graphene_rect_expand CDECL(BYVAL AS Const graphene_rect_t Ptr, BYVAL AS Const graphene_point_t Ptr, BYVAL AS graphene_rect_t Ptr)
Declare Function graphene_rect_zero CDECL() AS Const graphene_rect_t Ptr
Declare Sub graphene_rect_scale CDECL(BYVAL AS Const graphene_rect_t Ptr, BYVAL AS SINGLE, BYVAL AS SINGLE, BYVAL AS graphene_rect_t Ptr)

end extern
