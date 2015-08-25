'' FreeBASIC binding for allegro-5.0.11
''
'' based on the C header files:
''   Copyright (c) 2004-2011 the Allegro 5 Development Team
''
''   This software is provided 'as-is', without any express or implied
''   warranty. In no event will the authors be held liable for any damages
''   arising from the use of this software.
''
''   Permission is granted to anyone to use this software for any purpose,
''   including commercial applications, and to alter it and redistribute it
''   freely, subject to the following restrictions:
''
''       1. The origin of this software must not be misrepresented; you must not
''       claim that you wrote the original software. If you use this software
''       in a product, an acknowledgment in the product documentation would be
''       appreciated but is not required.
''
''       2. Altered source versions must be plainly marked as such, and must not be
''       misrepresented as being the original software.
''
''       3. This notice may not be removed or altered from any source
''       distribution.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#ifdef __FB_UNIX__
	#inclib "allegro_primitives"
#elseif defined(__FB_WIN32__) and defined(ALLEGRO_STATICLINK)
	#inclib "allegro_primitives-5.0.10-static-md"
#else
	#inclib "allegro_primitives-5.0.10-md"
#endif

#include once "allegro5/allegro.bi"

extern "C"

#define __al_included_allegro5_allegro_primitives_h

type ALLEGRO_PRIM_TYPE as long
enum
	ALLEGRO_PRIM_LINE_LIST
	ALLEGRO_PRIM_LINE_STRIP
	ALLEGRO_PRIM_LINE_LOOP
	ALLEGRO_PRIM_TRIANGLE_LIST
	ALLEGRO_PRIM_TRIANGLE_STRIP
	ALLEGRO_PRIM_TRIANGLE_FAN
	ALLEGRO_PRIM_POINT_LIST
	ALLEGRO_PRIM_NUM_TYPES
end enum

type ALLEGRO_PRIM_ATTR as long
enum
	ALLEGRO_PRIM_POSITION = 1
	ALLEGRO_PRIM_COLOR_ATTR
	ALLEGRO_PRIM_TEX_COORD
	ALLEGRO_PRIM_TEX_COORD_PIXEL
	ALLEGRO_PRIM_ATTR_NUM
end enum

type ALLEGRO_PRIM_STORAGE as long
enum
	ALLEGRO_PRIM_FLOAT_2
	ALLEGRO_PRIM_FLOAT_3
	ALLEGRO_PRIM_SHORT_2
end enum

const ALLEGRO_VERTEX_CACHE_SIZE = 256
const ALLEGRO_PRIM_QUALITY = 10

type ALLEGRO_VERTEX_ELEMENT
	attribute as long
	storage as long
	offset as long
end type

#define _ALLEGRO_VERTEX_DEFINED

type ALLEGRO_VERTEX
	x as single
	y as single
	z as single
	u as single
	v as single
	color as ALLEGRO_COLOR
end type

declare function al_get_allegro_primitives_version() as ulong
declare function al_init_primitives_addon() as byte
declare sub al_shutdown_primitives_addon()
type ALLEGRO_VERTEX_DECL as ALLEGRO_VERTEX_DECL_
declare function al_draw_prim(byval vtxs as const any ptr, byval decl as const ALLEGRO_VERTEX_DECL ptr, byval texture as ALLEGRO_BITMAP ptr, byval start as long, byval end as long, byval type as long) as long
declare function al_draw_indexed_prim(byval vtxs as const any ptr, byval decl as const ALLEGRO_VERTEX_DECL ptr, byval texture as ALLEGRO_BITMAP ptr, byval indices as const long ptr, byval num_vtx as long, byval type as long) as long
declare function al_create_vertex_decl(byval elements as const ALLEGRO_VERTEX_ELEMENT ptr, byval stride as long) as ALLEGRO_VERTEX_DECL ptr
declare sub al_destroy_vertex_decl(byval decl as ALLEGRO_VERTEX_DECL ptr)
declare sub al_draw_soft_triangle(byval v1 as ALLEGRO_VERTEX ptr, byval v2 as ALLEGRO_VERTEX ptr, byval v3 as ALLEGRO_VERTEX ptr, byval state as uinteger, byval init as sub(byval as uinteger, byval as ALLEGRO_VERTEX ptr, byval as ALLEGRO_VERTEX ptr, byval as ALLEGRO_VERTEX ptr), byval first as sub(byval as uinteger, byval as long, byval as long, byval as long, byval as long), byval step as sub(byval as uinteger, byval as long), byval draw as sub(byval as uinteger, byval as long, byval as long, byval as long))
declare sub al_draw_soft_line(byval v1 as ALLEGRO_VERTEX ptr, byval v2 as ALLEGRO_VERTEX ptr, byval state as uinteger, byval first as sub(byval as uinteger, byval as long, byval as long, byval as ALLEGRO_VERTEX ptr, byval as ALLEGRO_VERTEX ptr), byval step as sub(byval as uinteger, byval as long), byval draw as sub(byval as uinteger, byval as long, byval as long))
declare sub al_draw_line(byval x1 as single, byval y1 as single, byval x2 as single, byval y2 as single, byval color as ALLEGRO_COLOR, byval thickness as single)
declare sub al_draw_triangle(byval x1 as single, byval y1 as single, byval x2 as single, byval y2 as single, byval x3 as single, byval y3 as single, byval color as ALLEGRO_COLOR, byval thickness as single)
declare sub al_draw_rectangle(byval x1 as single, byval y1 as single, byval x2 as single, byval y2 as single, byval color as ALLEGRO_COLOR, byval thickness as single)
declare sub al_draw_rounded_rectangle(byval x1 as single, byval y1 as single, byval x2 as single, byval y2 as single, byval rx as single, byval ry as single, byval color as ALLEGRO_COLOR, byval thickness as single)
declare sub al_calculate_arc(byval dest as single ptr, byval stride as long, byval cx as single, byval cy as single, byval rx as single, byval ry as single, byval start_theta as single, byval delta_theta as single, byval thickness as single, byval num_points as long)
declare sub al_draw_circle(byval cx as single, byval cy as single, byval r as single, byval color as ALLEGRO_COLOR, byval thickness as single)
declare sub al_draw_ellipse(byval cx as single, byval cy as single, byval rx as single, byval ry as single, byval color as ALLEGRO_COLOR, byval thickness as single)
declare sub al_draw_arc(byval cx as single, byval cy as single, byval r as single, byval start_theta as single, byval delta_theta as single, byval color as ALLEGRO_COLOR, byval thickness as single)
declare sub al_draw_elliptical_arc(byval cx as single, byval cy as single, byval rx as single, byval ry as single, byval start_theta as single, byval delta_theta as single, byval color as ALLEGRO_COLOR, byval thickness as single)
declare sub al_draw_pieslice(byval cx as single, byval cy as single, byval r as single, byval start_theta as single, byval delta_theta as single, byval color as ALLEGRO_COLOR, byval thickness as single)
declare sub al_calculate_spline(byval dest as single ptr, byval stride as long, byval points as single ptr, byval thickness as single, byval num_segments as long)
declare sub al_draw_spline(byval points as single ptr, byval color as ALLEGRO_COLOR, byval thickness as single)
declare sub al_calculate_ribbon(byval dest as single ptr, byval dest_stride as long, byval points as const single ptr, byval points_stride as long, byval thickness as single, byval num_segments as long)
declare sub al_draw_ribbon(byval points as const single ptr, byval points_stride as long, byval color as ALLEGRO_COLOR, byval thickness as single, byval num_segments as long)
declare sub al_draw_filled_triangle(byval x1 as single, byval y1 as single, byval x2 as single, byval y2 as single, byval x3 as single, byval y3 as single, byval color as ALLEGRO_COLOR)
declare sub al_draw_filled_rectangle(byval x1 as single, byval y1 as single, byval x2 as single, byval y2 as single, byval color as ALLEGRO_COLOR)
declare sub al_draw_filled_ellipse(byval cx as single, byval cy as single, byval rx as single, byval ry as single, byval color as ALLEGRO_COLOR)
declare sub al_draw_filled_circle(byval cx as single, byval cy as single, byval r as single, byval color as ALLEGRO_COLOR)
declare sub al_draw_filled_pieslice(byval cx as single, byval cy as single, byval r as single, byval start_theta as single, byval delta_theta as single, byval color as ALLEGRO_COLOR)
declare sub al_draw_filled_rounded_rectangle(byval x1 as single, byval y1 as single, byval x2 as single, byval y2 as single, byval rx as single, byval ry as single, byval color as ALLEGRO_COLOR)

end extern
