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
'      Compiled sprites.
'
'      By Shawn Hargreaves.
'
'      See readme.txt for copyright information.
'


#ifndef ALLEGRO_COMPILED_H
#define ALLEGRO_COMPILED_H

#include "allegro/base.bi"

Type COMPILED_SPRITE_PROC
	draw As Integer Ptr			' routines to draw the image
	length As Integer			' length of the drawing functions - name changed from 'len' in fB
End Type

Type COMPILED_SPRITE				' compiled sprite structure
	planar As Short				' set if it's a planar (mode-X) sprite
	color_depth As Short			' color depth of the image
	w As Short				' size of the sprite
	h As Short
	proc(3) As COMPILED_SPRITE_PROC		' routines to draw the image
End Type

declare function get_compiled_sprite cdecl alias "get_compiled_sprite" ( byval bmp as BITMAP ptr , byval planar as integer ) as COMPILED_SPRITE ptr
declare sub destroy_compiled_sprite cdecl alias "destroy_compiled_sprite" ( byval sprite as COMPILED_SPRITE ptr )
declare sub draw_compiled_sprite cdecl alias "draw_compiled_sprite" ( byval bmp as BITMAP ptr, byval sprite as COMPILED_SPRITE ptr, byval x as integer, byval y as integer )

#endif
