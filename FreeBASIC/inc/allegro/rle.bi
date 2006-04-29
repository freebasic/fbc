''
''
'' allegro\rle -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __allegro_rle_bi__
#define __allegro_rle_bi__

#include once "allegro/base.bi"
#include once "allegro/gfx.bi"

type RLE_SPRITE
	w as integer
	h as integer
	color_depth as integer
	size as integer
	dat(0 to 0) as byte
end type

declare function get_rle_sprite cdecl alias "get_rle_sprite" (byval bitmap as BITMAP ptr) as RLE_SPRITE ptr
declare sub destroy_rle_sprite cdecl alias "destroy_rle_sprite" (byval sprite as RLE_SPRITE ptr)

#include once "allegro/inline/rle.bi"

#endif
