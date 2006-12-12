''
''
'' gdkglshapes -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gdkglshapes_bi__
#define __gdkglshapes_bi__

#include once "gdkgldefs.bi"
#include once "gdkgltypes.bi"

declare sub gdk_gl_draw_cube (byval solid as gboolean, byval size as double)
declare sub gdk_gl_draw_sphere (byval solid as gboolean, byval radius as double, byval slices as integer, byval stacks as integer)
declare sub gdk_gl_draw_cone (byval solid as gboolean, byval base as double, byval height as double, byval slices as integer, byval stacks as integer)
declare sub gdk_gl_draw_torus (byval solid as gboolean, byval inner_radius as double, byval outer_radius as double, byval nsides as integer, byval rings as integer)
declare sub gdk_gl_draw_tetrahedron (byval solid as gboolean)
declare sub gdk_gl_draw_octahedron (byval solid as gboolean)
declare sub gdk_gl_draw_dodecahedron (byval solid as gboolean)
declare sub gdk_gl_draw_icosahedron (byval solid as gboolean)
declare sub gdk_gl_draw_teapot (byval solid as gboolean, byval scale as double)

#endif
