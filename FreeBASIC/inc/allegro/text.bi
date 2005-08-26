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
'      Text output routines.
'
'      By Shawn Hargreaves.
'
'      See readme.txt for copyright information.
'


#ifndef ALLEGRO_TEXT_H
#define ALLEGRO_TEXT_H

#include "allegro/base.bi"

type FONT_GLYPH					' a single monochrome font character
	w as short
	h as short
	dat as ubyte ptr
end type

Type FONT
	data As UByte Ptr
	height As Integer
	vtable As Any Ptr
End Type

Extern Import font Alias "font" As FONT Ptr
Extern Import allegro_404_char Alias "allegro_404_char" As Integer
Declare Function text_mode CDecl Alias "text_mode" (ByVal mode As Integer) As Integer
Declare Sub textout CDecl Alias "textout" (ByVal bmp As BITMAP Ptr, ByVal f As FONT Ptr, byval s as zstring ptr, ByVal x As Integer, ByVal y As Integer, ByVal c As Integer)
Declare Sub textout_centre CDecl Alias "textout_centre" (ByVal bmp As BITMAP Ptr, ByVal f As FONT Ptr, byval s as zstring ptr, ByVal x As Integer, ByVal y As Integer, ByVal c As Integer)
Declare Sub textout_right CDecl Alias "textout_right" (ByVal bmp As BITMAP Ptr, ByVal f As FONT Ptr, byval s as zstring ptr, ByVal x As Integer, ByVal y As Integer, ByVal c As Integer)
Declare Sub textout_justify CDecl Alias "textout_justify" (ByVal bmp As BITMAP Ptr, ByVal f As FONT Ptr, byval s as zstring ptr, ByVal x1 As Integer, ByVal x2 As Integer, ByVal y As Integer, ByVal diff As Integer, ByVal c As Integer)
Declare Sub textprintf CDecl Alias "textprintf" (ByVal bmp As BITMAP Ptr, ByVal f As FONT Ptr, ByVal x As Integer, ByVal y As Integer, ByVal c As Integer, byval s as zstring ptr, ...)
Declare Sub textprintf_centre CDecl Alias "textprintf_centre" (ByVal bmp As BITMAP Ptr, ByVal f As FONT Ptr, ByVal x As Integer, ByVal y As Integer, ByVal _color As Integer, byval format as zstring ptr, ...)
Declare Sub textprintf_right CDecl Alias "textprintf_right" (ByVal bmp As BITMAP Ptr, ByVal f As FONT Ptr, ByVal x As Integer, ByVal y As Integer, ByVal _color As Integer, byval format as zstring ptr, ...)
Declare Sub textprintf_justify CDecl Alias "textprintf_justify" (ByVal bmp As BITMAP Ptr, ByVal f As FONT Ptr, Byval x1 As Integer, ByVal x2 As Integer, ByVal y As Integer, ByVal diff As Integer, ByVal _color As Integer, byval format as zstring ptr, ...)
Declare Function text_length CDecl Alias "text_length" (ByVal f As FONT Ptr, byval s as zstring ptr) As Integer
Declare Function text_height CDecl Alias "text_height" (ByVal f As FONT Ptr) As Integer
Declare Sub destroy_font CDecl Alias "destroy_font" (ByVal f As FONT Ptr)

#endif
