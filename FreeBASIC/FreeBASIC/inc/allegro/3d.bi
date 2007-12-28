''
''
'' allegro\3d -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __allegro_3d_bi__
#define __allegro_3d_bi__

#include once "allegro/base.bi"
#include once "allegro/fixed.bi"

type V3D
	x as fixed
	y as fixed
	z as fixed
	u as fixed
	v as fixed
	c as integer
end type

type V3D_f
	x as single
	y as single
	z as single
	u as single
	v as single
	c as integer
end type

#define POLYTYPE_FLAT 0
#define POLYTYPE_GCOL 1
#define POLYTYPE_GRGB 2
#define POLYTYPE_ATEX 3
#define POLYTYPE_PTEX 4
#define POLYTYPE_ATEX_MASK 5
#define POLYTYPE_PTEX_MASK 6
#define POLYTYPE_ATEX_LIT 7
#define POLYTYPE_PTEX_LIT 8
#define POLYTYPE_ATEX_MASK_LIT 9
#define POLYTYPE_PTEX_MASK_LIT 10
#define POLYTYPE_ATEX_TRANS 11
#define POLYTYPE_PTEX_TRANS 12
#define POLYTYPE_ATEX_MASK_TRANS 13
#define POLYTYPE_PTEX_MASK_TRANS 14
#define POLYTYPE_MAX 15
#define POLYTYPE_ZBUF 16

extern _AL_DLL scene_gap alias "scene_gap" as single

declare sub polygon3d cdecl alias "polygon3d" (byval bmp as BITMAP ptr, byval type as integer, byval texture as BITMAP ptr, byval vc as integer, byval vtx as V3D ptr ptr)
declare sub polygon3d_f cdecl alias "polygon3d_f" (byval bmp as BITMAP ptr, byval type as integer, byval texture as BITMAP ptr, byval vc as integer, byval vtx as V3D_f ptr ptr)
declare sub triangle3d cdecl alias "triangle3d" (byval bmp as BITMAP ptr, byval type as integer, byval texture as BITMAP ptr, byval v1 as V3D ptr, byval v2 as V3D ptr, byval v3 as V3D ptr)
declare sub triangle3d_f cdecl alias "triangle3d_f" (byval bmp as BITMAP ptr, byval type as integer, byval texture as BITMAP ptr, byval v1 as V3D_f ptr, byval v2 as V3D_f ptr, byval v3 as V3D_f ptr)
declare sub quad3d cdecl alias "quad3d" (byval bmp as BITMAP ptr, byval type as integer, byval texture as BITMAP ptr, byval v1 as V3D ptr, byval v2 as V3D ptr, byval v3 as V3D ptr, byval v4 as V3D ptr)
declare sub quad3d_f cdecl alias "quad3d_f" (byval bmp as BITMAP ptr, byval type as integer, byval texture as BITMAP ptr, byval v1 as V3D_f ptr, byval v2 as V3D_f ptr, byval v3 as V3D_f ptr, byval v4 as V3D_f ptr)
declare function clip3d cdecl alias "clip3d" (byval type as integer, byval min_z as fixed, byval max_z as fixed, byval vc as integer, byval vtx as V3D ptr ptr, byval vout as V3D ptr ptr, byval vtmp as V3D ptr ptr, byval out as integer ptr) as integer
declare function clip3d_f cdecl alias "clip3d_f" (byval type as integer, byval min_z as single, byval max_z as single, byval vc as integer, byval vtx as V3D_f ptr ptr, byval vout as V3D_f ptr ptr, byval vtmp as V3D_f ptr ptr, byval out as integer ptr) as integer
declare function polygon_z_normal cdecl alias "polygon_z_normal" (byval v1 as V3D ptr, byval v2 as V3D ptr, byval v3 as V3D ptr) as fixed
declare function polygon_z_normal_f cdecl alias "polygon_z_normal_f" (byval v1 as V3D_f ptr, byval v2 as V3D_f ptr, byval v3 as V3D_f ptr) as single

type ZBUFFER as BITMAP

declare function create_zbuffer cdecl alias "create_zbuffer" (byval bmp as BITMAP ptr) as ZBUFFER ptr
declare function create_sub_zbuffer cdecl alias "create_sub_zbuffer" (byval parent as ZBUFFER ptr, byval x as integer, byval y as integer, byval width as integer, byval height as integer) as ZBUFFER ptr
declare sub set_zbuffer cdecl alias "set_zbuffer" (byval zbuf as ZBUFFER ptr)
declare sub clear_zbuffer cdecl alias "clear_zbuffer" (byval zbuf as ZBUFFER ptr, byval z as single)
declare sub destroy_zbuffer cdecl alias "destroy_zbuffer" (byval zbuf as ZBUFFER ptr)
declare function create_scene cdecl alias "create_scene" (byval nedge as integer, byval npoly as integer) as integer
declare sub clear_scene cdecl alias "clear_scene" (byval bmp as BITMAP ptr)
declare sub destroy_scene cdecl alias "destroy_scene" ()
declare function scene_polygon3d cdecl alias "scene_polygon3d" (byval type as integer, byval texture as BITMAP ptr, byval vx as integer, byval vtx as V3D ptr ptr) as integer
declare function scene_polygon3d_f cdecl alias "scene_polygon3d_f" (byval type as integer, byval texture as BITMAP ptr, byval vx as integer, byval vtx as V3D_f ptr ptr) as integer
declare sub render_scene cdecl alias "render_scene" ()

#endif
