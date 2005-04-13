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
'      Drawing and sprite routines.
'
'      By Shawn Hargreaves.
'
'      See readme.txt for copyright information.
'


#ifndef ALLEGRO_DRAW_H
#define ALLEGRO_DRAW_H

#include "allegro/base.bi"
#include "allegro/fixed.bi"
#include "allegro/gfx.bi"

#define DRAW_MODE_SOLID             0        ' flags for drawing_mode()
#define DRAW_MODE_XOR               1
#define DRAW_MODE_COPY_PATTERN      2
#define DRAW_MODE_SOLID_PATTERN     3
#define DRAW_MODE_MASKED_PATTERN    4
#define DRAW_MODE_TRANS             5

Declare Sub drawing_mode CDecl Alias "drawing_mode" ( byval mode as integer, byval pattern as BITMAP ptr, byval x_anchor as integer, byval y_anchor as integer )
Declare Sub xor_mode CDecl Alias "xor_mode" (ByVal iOn As Integer)
Declare Sub solid_mode CDecl Alias "solid_mode" ()
Declare Sub do_line CDecl Alias "do_line" (ByVal bmp As BITMAP Ptr, ByVal x1 As Integer, ByVal y1 As Integer, ByVal x2 As Integer, ByVal y2 As Integer, ByVal d As Integer, ByVal proc As Sub(ByVal bmp As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal d As Integer))
Declare Sub triangle CDecl Alias "triangle" (ByVal bmp As BITMAP Ptr, ByVal x1 As Integer, ByVal y1 As Integer, ByVal x2 As Integer, ByVal y2 As Integer, ByVal x3 As Integer, ByVal y3 As Integer, ByVal c As Integer)
Declare Sub polygon CDecl Alias "polygon" (ByVal bmp As BITMAP Ptr, ByVal vertices As Integer, ByVal points As Integer Ptr, ByVal c As Integer)
Declare Sub rect CDecl Alias "rect" (ByVal bmp As BITMAP Ptr, ByVal x1 As Integer, ByVal y1 As Integer, ByVal x2 As Integer, ByVal y2 As Integer, ByVal c As Integer)
Declare Sub do_circle CDecl Alias "do_circle" (ByVal bmp As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal radius As Integer, ByVal d As Integer, ByVal proc As Sub(ByVal bmp As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal d As Integer))
Declare Sub circle CDecl Alias "circle" (ByVal bmp As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal radius As Integer, ByVal c As Integer) ' note: this is called 'circle' in Allegro docs
Declare Sub circlefill CDecl Alias "circlefill" (ByVal bmp As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal radius As Integer, ByVal c As Integer)
Declare Sub do_ellipse CDecl Alias "do_ellipse" (ByVal bmp As BITMAP Ptr, BYVal x As Integer, ByVal y As Integer, ByVal rx As Integer, ByVal ry As Integer, ByVal d As Integer, ByVal proc As Sub(ByVal bmp As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal d As Integer))
Declare Sub ellipse CDecl Alias "ellipse" (ByVal bmp As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal rx As Integer, ByVal ry As Integer, ByVal c As Integer)
Declare Sub ellipsefill CDecl Alias "ellipsefill" (ByVal bmp As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal rx As Integer, ByVal ry As Integer, ByVal c As Integer)
Declare Sub do_arc CDecl Alias "do_arc" (ByVal bmp As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal a1 As fixed, ByVal a2 As fixed, ByVal r As Integer, ByVal d As Integer, ByVal proc As Sub(ByVal bmp As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal d As Integer))
Declare Sub arc CDecl Alias "arc" (ByVal bmp As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal ang1 As fixed, ByVal ang2 As fixed, ByVal r As Integer, ByVal c As Integer)
Declare Sub calc_spline CDecl Alias "calc_spline" (ByVal points As Integer Ptr, ByVal npts As Integer, ByRef x As Integer, ByRef y As Integer)
Declare Sub spline CDecl Alias "spline" (ByVal bmp As BITMAP Ptr, ByVal points As Integer Ptr, ByVal c As Integer)
Declare Sub floodfill CDecl Alias "floodfill" (ByVal bmp As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal c As Integer)
Declare Sub blit CDecl Alias "blit" (ByVal source AS BITMAP Ptr, ByVal dest As BITMAP Ptr, ByVal source_x As Integer, BYVal source_y As Integer, ByVal dest_x As Integer, ByVal dest_y As Integer, ByVal width As Integer, ByVal height As Integer)
Declare Sub masked_blit CDecl Alias "masked_blit" (ByVal source AS BITMAP Ptr, ByVal dest As BITMAP Ptr, ByVal source_x As Integer, BYVal source_y As Integer, ByVal dest_x As Integer, ByVal dest_y As Integer, ByVal width As Integer, ByVal height As Integer)
Declare Sub stretch_blit CDecl Alias "stretch_blit" (ByVal source As BITMAP Ptr, ByVal dest As BITMAP Ptr, ByVal source_x As Integer, ByVal source_y As Integer, ByVal source_width As Integer, ByVal source_height As Integer, ByVal dest_x As Integer, ByVal dest_y As Integer, ByVal dest_width As Integer, ByVal dest_height As Integer)
Declare Sub masked_stretch_blit CDecl Alias "masked_stretch_blit" (ByVal source As BITMAP Ptr, ByVal dest As BITMAP Ptr, ByVal source_x As Integer, ByVal source_y As Integer, ByVal source_width As Integer, ByVal source_height As Integer, ByVal dest_x As Integer, ByVal dest_y As Integer, ByVal dest_width As Integer, ByVal dest_height As Integer)
Declare Sub stretch_sprite CDecl Alias "stretch_sprite" (ByVal bmp As BITMAP Ptr, ByVal sprite As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal w As Integer, ByVal h As Integer)
Declare Sub draw_gouraud_sprite CDecl Alias "draw_gouraud_sprite" (ByVal bmp As BITMAP Ptr, ByVal sprite As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal c1 As Integer, ByVal c2 As Integer, ByVal c3 As Integer, ByVal c4 As Integer)

#include "allegro/inline/draw.inl"

#endif
