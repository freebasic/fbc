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
'      Palette type.
'
'      By Shawn Hargreaves.
'
'      See readme.txt for copyright information.
'


#ifndef ALLEGRO_PALETTE_H
#define ALLEGRO_PALETTE_H

Type RGB
	r As UByte
	g As UByte
	b As UByte
	filler As UByte
End Type

Const PAL_SIZE%				= 256

Type PALETTE As RGB Ptr	' this is wrong for variable declarations but right for parameters;
			' instead of declaring a variable of type PALETTE, use 'Dim pal(255) As RGB'.

#endif
