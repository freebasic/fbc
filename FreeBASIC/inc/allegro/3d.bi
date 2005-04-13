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
'      3D polygon drawing routines.
'
'      By Shawn Hargreaves.
'
'      See readme.txt for copyright information.
'

#ifndef ALLEGRO_3D_H
#define ALLEGRO_3D_H

#include "allegro/base.bi"
#include "allegro/fixed.bi"
#include "allegro/gfx.bi"


Type V3D					' a 3d point (fixed point version)
	x As fixed				' position
	y As fixed
	z As fixed
	u As fixed				' texture map coordinates
	v As fixed
	c As Integer				' color
End Type

Type V3D_f					' a 3d point (floating point version)
	x As Single				' position
	y As Single
	z As Single
	u As Single				' texture map coordinates
	v As Single
	c As Integer				' color
End Type

Const POLYTYPE_FLAT%			= 0
Const POLYTYPE_GCOL%			= 1
Const POLYTYPE_GRGB%			= 2
Const POLYTYPE_ATEX%			= 3
Const POLYTYPE_PTEX%			= 4
Const POLYTYPE_ATEX_MASK%		= 5
Const POLYTYPE_PTEX_MASK%		= 6
Const POLYTYPE_ATEX_LIT%		= 7
Const POLYTYPE_PTEX_LIT%		= 8
Const POLYTYPE_ATEX_MASK_LIT%		= 9
Const POLYTYPE_PTEX_MASK_LIT%		= 10
Const POLYTYPE_ATEX_TRANS%		= 11
Const POLYTYPE_PTEX_TRANS%		= 12
Const POLYTYPE_ATEX_MASK_TRANS%		= 13
Const POLYTYPE_PTEX_MASK_TRANS%		= 14
Const POLYTYPE_MAX%			= 15
Const POLYTYPE_ZBUF%			= 16

Extern Import scene_gap Alias "scene_gap" As Single

Declare Sub polygon3d CDecl Alias "polygon3d" (ByVal bmp As BITMAP Ptr, ByVal typ As Integer, ByVal texture As BITMAP Ptr, ByVal vc As Integer, vtx() As V3D Ptr)
Declare Sub polygon3d_f CDecl Alias "polygon3d_f" (ByVal bmp As BITMAP Ptr, ByVal typ As Integer, ByVal texture As BITMAP Ptr, ByVal vc As Integer, vtx() As V3D_f Ptr)
Declare Sub triangle3d CDecl Alias "triangle3d" (ByVal bmp As BITMAP Ptr, ByVal typ As Integer, ByVal tex As BITMAP Ptr, ByRef v1 As V3D, ByRef v2 As V3D, ByRef v3 As V3D)
Declare Sub triangle3d_f CDecl Alias "triangle3d_f" (ByVal bmp As BITMAP Ptr, ByVal typ As Integer, ByVal tex As BITMAP Ptr, ByRef v1 As V3D_f, ByRef v2 As V3D_f, ByRef v3 As V3D_f)
Declare Sub quad3d CDecl Alias "quad3d" (ByVal bmp As BITMAP Ptr, ByVal typ As Integer, ByVal tex As BITMAP Ptr, ByRef v1 As V3D, ByRef v2 As V3D, ByRef v3 As V3D, ByRef v4 As V3D)
Declare Sub quad3d_f CDecl Alias "quad3d_f" (ByVal bmp As BITMAP Ptr, ByVal typ As Integer, ByVal tex As BITMAP Ptr, ByRef v1 As V3D_f, ByRef v2 As V3D_f, ByRef v3 As V3D_f, ByRef v4 As V3D_f)
Declare Function clip3d CDecl Alias "clip3d" (ByVal typ As Integer, ByVal min_z As fixed, ByVal max_z As fixed, ByVal vc As Integer, vtx() As V3D Ptr, vout() As V3D Ptr, vtmp() As V3D Ptr, ByVal iOut As Integer Ptr) As Integer
Declare Function clip3d_f CDecl Alias "clip3d_f" (ByVal typ As Integer, ByVal min_z As Single, ByVal max_z As Single, ByVal vc As Integer, vtx() As V3D_f Ptr, vout() As V3D_f Ptr, vtmp() As V3D_f Ptr, ByVal iOut As Integer Ptr) As Integer

Declare Function polygon_z_normal CDecl Alias "polygon_z_normal" (ByVal v1 As V3D Ptr, ByVal v2 As V3D Ptr, ByVal v3 As V3D Ptr) As fixed
Declare Function polygon_z_normal_f CDecl Alias "polygon_z_normal_f" (ByVal v1 As V3D_f Ptr, ByVal v2 As V3D_f Ptr, ByVal v3 As V3D_f Ptr) As Single

' Note: You are not supposed to mix ZBUFFER with BITMAP even though it is
' currently possible. This is just the internal representation, and it may
' change in the future.

Type ZBUFFER As BITMAP

Declare Function create_zbuffer CDecl Alias "create_zbuffer" (ByVal parent As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal width As Integer, ByVal height As Integer) As ZBUFFER Ptr
Declare Function create_sub_zbuffer CDecl Alias "create_sub_zbuffer" (ByVal parent As ZBUFFER Ptr, ByVal x As Integer, ByVal y As Integer, ByVal width As Integer, ByVal height As Integer) As ZBUFFER Ptr
Declare Sub set_zbuffer CDecl Alias "set_zbuffer" (ByVal buf As BITMAP Ptr)
Declare Sub clear_zbuffer CDecl Alias "clear_zbuffer" (ByVal zbuf As BITMAP Ptr, ByVal z As Single)
Declare Sub destroy_zbuffer CDecl Alias "destroy_zbuffer" (ByVal zbuf As BITMAP Ptr)

Declare Function create_scene CDecl Alias "create_scene" (ByVal nedge As Integer, ByVal npoly As Integer)
Declare Sub clear_scene CDecl Alias "clear_scene" (ByVal bmp As BITMAP Ptr)
Declare Sub destroy_scene CDecl Alias "destroy_scene" ()
Declare Function scene_polygon3d CDecl Alias "scene_polygon3d" (ByVal typ As Integer, ByVal texture As BITMAP Ptr, ByVal vc As Integer, vtx() As V3D Ptr)
Declare Function scene_polygon3d_f CDecl Alias "scene_polygon3d_f" (ByVal typ As Integer, ByVal texture As BITMAP Ptr, ByVal vc As Integer, vtx() As V3D_f Ptr)
Declare Sub render_scene CDecl Alias "render_scene" ()

#endif
