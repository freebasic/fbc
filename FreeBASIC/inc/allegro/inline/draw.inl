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
'      Draw inline functions (generic C).
'
'      By Shawn Hargreaves.
'
'      See readme.txt for copyright information.
'


#ifndef ALLEGRO_DRAW_INL
#define ALLEGRO_DRAW_INL

#include "allegro/debug.bi"
#include "allegro/inline/gfx.inl"

Declare Sub putpixel CDecl Alias "putpixel" (ByVal bmp As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal c As Integer)
Declare Sub putpixel8 CDecl Alias "_putpixel" (ByVal bmp As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal c As Integer)
Declare Sub putpixel15 CDecl Alias "_putpixel15" (ByVal bmp As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal c As Integer)
Declare Sub putpixel16 CDecl Alias "_putpixel16" (ByVal bmp As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal c As Integer)
Declare Sub putpixel24 CDecl Alias "_putpixel24" (ByVal bmp As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal c As Integer)
Declare Sub putpixel32 CDecl Alias "_putpixel32" (ByVal bmp As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal c As Integer)
Declare Function getpixel CDecl Alias "getpixel" (ByVal bmp As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer) As Integer
Declare Function getpixel8 CDecl Alias "_getpixel8" (ByVal bmp As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer) As Integer
Declare Function getpixel15 CDecl Alias "_getpixel15" (ByVal bmp As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer) As Integer
Declare Function getpixel16 CDecl Alias "_getpixel16" (ByVal bmp As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer) As Integer
Declare Function getpixel24 CDecl Alias "_getpixel24" (ByVal bmp As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer) As Integer
Declare Function getpixel32 CDecl Alias "_getpixel32" (ByVal bmp As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer) As Integer
Declare Sub vline CDecl Alias "vline" (ByVal bmp As BITMAP Ptr, ByVal x As Integer, ByVal y1 As Integer, ByVal y2 As Integer, ByVal c As Integer)
Declare Sub hline CDecl Alias "hline" (ByVal bmp As BITMAP Ptr, ByVal x1 As Integer, ByVal y As Integer, ByVal x2 As Integer, ByVal c As Integer)
Declare Sub line CDecl Alias "line" (ByVal bmp As BITMAP Ptr, ByVal x1 As Integer, ByVal y1 As Integer, ByVal x2 As Integer, ByVal y2 As Integer, ByVal c As Integer)
Declare Sub fastline CDecl Alias "fastline" (ByVal bmp As BITMAP Ptr, ByVal x1 As Integer, ByVal y1 As Integer, ByVal x2 As Integer, ByVal y2 As Integer, ByVal c As Integer)
Declare Sub rectfill CDecl Alias "rectfill" (ByVal bmp As BITMAP Ptr, ByVal x1 As Integer, ByVal y1 As Integer, ByVal x2 As Integer, ByVal y2 As Integer, ByVal c As Integer)
Declare Sub clear_to_color CDecl Alias "clear_to_color" (ByVal bmp As BITMAP Ptr, ByVal c As Integer)
Declare Sub draw_sprite CDecl Alias "draw_sprite" (ByVal bmp As BITMAP Ptr, ByVal sprite As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer)
Declare Sub draw_sprite_v_flip CDecl Alias "draw_sprite_v_flip" (ByVal bmp As BITMAP Ptr, ByVal sprite As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer)
Declare Sub draw_sprite_h_flip CDecl Alias "draw_sprite_h_flip" (ByVal bmp As BITMAP Ptr, ByVal sprite As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer)
Declare Sub draw_sprite_vh_flip CDecl Alias "draw_sprite_vh_flip" (ByVal bmp As BITMAP Ptr, ByVal sprite As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer)
Declare Sub draw_trans_sprite CDecl Alias "draw_trans_sprite" (ByVal bmp As BITMAP Ptr, ByVal sprite As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer)
Declare Sub draw_lit_sprite CDecl Alias "draw_lit_sprite" (ByVal bmp As BITMAP Ptr, ByVal sprite As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal c As Integer)
Declare Sub draw_character_ex CDecl Alias "draw_character_ex" (ByVal bmp As BITMAP Ptr, ByVal sprite As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal c As Integer, ByVal bg As Integer)
Declare Sub rotate_sprite CDecl Alias "rotate_sprite" (ByVal bmp As BITMAP Ptr, ByVal sprite As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal angle As fixed)
Declare Sub rotate_sprite_v_flip CDecl Alias "rotate_sprite_v_flip" (ByVal bmp As BITMAP Ptr, ByVal sprite As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal angle As fixed)
Declare Sub rotate_scaled_sprite CDecl Alias "rotate_scaled_sprite" (ByVal bmp As BITMAP Ptr, ByVal sprite As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal angle As fixed, ByVal scale As fixed)
Declare Sub pivot_sprite CDecl Alias "pivot_sprite" (ByVal bmp As BITMAP Ptr, ByVal sprite As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal cx As Integer, ByVal cy As Integer, ByVal angle As fixed)
Declare Sub pivot_sprite_v_flip CDecl Alias "pivot_sprite_v_flip" (ByVal bmp As BITMAP Ptr, ByVal sprite As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal cx As Integer, ByVal cy As Integer, ByVal angle As fixed)
Declare Sub pivot_scaled_sprite CDecl Alias "pivot_scaled_sprite" (ByVal bmp As BITMAP Ptr, ByVal sprite As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal cx As Integer, ByVal cy As Integer, ByVal angle As fixed, ByVal scale As fixed)
Declare Sub pivot_scaled_sprite_v_flip CDecl Alias "pivot_scaled_sprite_v_flip" (ByVal bmp As BITMAP Ptr, ByVal sprite As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal cx As Integer, ByVal cy As Integer, ByVal angle As fixed, ByVal scale As fixed)

#endif


