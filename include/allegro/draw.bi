''
''
'' allegro\draw -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __allegro_draw_bi__
#define __allegro_draw_bi__

#include once "allegro/base.bi"
#include once "allegro/fixed.bi"
#include once "allegro/gfx.bi"

#define DRAW_MODE_SOLID 0
#define DRAW_MODE_XOR 1
#define DRAW_MODE_COPY_PATTERN 2
#define DRAW_MODE_SOLID_PATTERN 3
#define DRAW_MODE_MASKED_PATTERN 4
#define DRAW_MODE_TRANS 5

declare sub drawing_mode cdecl alias "drawing_mode" (byval mode as integer, byval pattern as BITMAP ptr, byval x_anchor as integer, byval y_anchor as integer)
declare sub xor_mode cdecl alias "xor_mode" (byval on as integer)
declare sub solid_mode cdecl alias "solid_mode" ()
declare sub do_line cdecl alias "do_line" (byval bmp as BITMAP ptr, byval x1 as integer, byval y1 as integer, byval x2 as integer, byval y2 as integer, byval d as integer, byval proc as sub cdecl(byval as BITMAP ptr, byval as integer, byval as integer, byval as integer))
declare sub triangle cdecl alias "triangle" (byval bmp as BITMAP ptr, byval x1 as integer, byval y1 as integer, byval x2 as integer, byval y2 as integer, byval x3 as integer, byval y3 as integer, byval color as integer)
declare sub polygon cdecl alias "polygon" (byval bmp as BITMAP ptr, byval vertices as integer, byval points as integer ptr, byval color as integer)
declare sub rect cdecl alias "rect" (byval bmp as BITMAP ptr, byval x1 as integer, byval y1 as integer, byval x2 as integer, byval y2 as integer, byval color as integer)
declare sub do_circle cdecl alias "do_circle" (byval bmp as BITMAP ptr, byval x as integer, byval y as integer, byval radius as integer, byval d as integer, byval proc as sub cdecl(byval as BITMAP ptr, byval as integer, byval as integer, byval as integer))
declare sub circle cdecl alias "circle" (byval bmp as BITMAP ptr, byval x as integer, byval y as integer, byval radius as integer, byval color as integer)
declare sub circlefill cdecl alias "circlefill" (byval bmp as BITMAP ptr, byval x as integer, byval y as integer, byval radius as integer, byval color as integer)
declare sub do_ellipse cdecl alias "do_ellipse" (byval bmp as BITMAP ptr, byval x as integer, byval y as integer, byval rx as integer, byval ry as integer, byval d as integer, byval proc as sub cdecl(byval as BITMAP ptr, byval as integer, byval as integer, byval as integer))
declare sub ellipse cdecl alias "ellipse" (byval bmp as BITMAP ptr, byval x as integer, byval y as integer, byval rx as integer, byval ry as integer, byval color as integer)
declare sub ellipsefill cdecl alias "ellipsefill" (byval bmp as BITMAP ptr, byval x as integer, byval y as integer, byval rx as integer, byval ry as integer, byval color as integer)
declare sub do_arc cdecl alias "do_arc" (byval bmp as BITMAP ptr, byval x as integer, byval y as integer, byval ang1 as fixed, byval ang2 as fixed, byval r as integer, byval d as integer, byval proc as sub cdecl(byval as BITMAP ptr, byval as integer, byval as integer, byval as integer))
declare sub arc cdecl alias "arc" (byval bmp as BITMAP ptr, byval x as integer, byval y as integer, byval ang1 as fixed, byval ang2 as fixed, byval r as integer, byval color as integer)
declare sub calc_spline cdecl alias "calc_spline" (byval points as integer ptr, byval npts as integer, byval x as integer ptr, byval y as integer ptr)
declare sub spline cdecl alias "spline" (byval bmp as BITMAP ptr, byval points as integer ptr, byval color as integer)
declare sub floodfill cdecl alias "floodfill" (byval bmp as BITMAP ptr, byval x as integer, byval y as integer, byval color as integer)
declare sub blit cdecl alias "blit" (byval source as BITMAP ptr, byval dest as BITMAP ptr, byval source_x as integer, byval source_y as integer, byval dest_x as integer, byval dest_y as integer, byval width as integer, byval height as integer)
declare sub masked_blit cdecl alias "masked_blit" (byval source as BITMAP ptr, byval dest as BITMAP ptr, byval source_x as integer, byval source_y as integer, byval dest_x as integer, byval dest_y as integer, byval width as integer, byval height as integer)
declare sub stretch_blit cdecl alias "stretch_blit" (byval s as BITMAP ptr, byval d as BITMAP ptr, byval s_x as integer, byval s_y as integer, byval s_w as integer, byval s_h as integer, byval d_x as integer, byval d_y as integer, byval d_w as integer, byval d_h as integer)
declare sub masked_stretch_blit cdecl alias "masked_stretch_blit" (byval s as BITMAP ptr, byval d as BITMAP ptr, byval s_x as integer, byval s_y as integer, byval s_w as integer, byval s_h as integer, byval d_x as integer, byval d_y as integer, byval d_w as integer, byval d_h as integer)
declare sub stretch_sprite cdecl alias "stretch_sprite" (byval bmp as BITMAP ptr, byval sprite as BITMAP ptr, byval x as integer, byval y as integer, byval w as integer, byval h as integer)
declare sub draw_gouraud_sprite cdecl alias "draw_gouraud_sprite" (byval bmp as BITMAP ptr, byval sprite as BITMAP ptr, byval x as integer, byval y as integer, byval c1 as integer, byval c2 as integer, byval c3 as integer, byval c4 as integer)

#include once "allegro/inline/draw.bi"

#endif
