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
'      RLE sprites.
'
'      By Shawn Hargreaves.
'
'      See readme.txt for copyright information.
'


#ifndef ALLEGRO_RLE_H
#define ALLEGRO_RLE_H

#include "allegro/base.bi"
#include "allegro/gfx.bi"

Type RLE_SPRITE					' a RLE compressed sprite
	w As Integer				' width and height in pixels
	h As Integer
	color_depth As Integer			' color depth of the image
	size As Integer				' size of sprite data in bytes
	dat As UByte Ptr			' ZERO_SIZE_ARRAY(signed char, dat);
End Type

declare function get_rle_sprite cdecl alias "get_rle_sprite" ( byval bmp as BITMAP ptr ) as RLE_SPRITE ptr
declare sub destroy_rle_sprite cdecl alias "destroy_rle_sprite" ( byval sprite as RLE_SPRITE ptr )

#include "allegro/inline/rle.inl"

#endif
