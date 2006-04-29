''
''
'' allegro\compiled -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __allegro_compiled_bi__
#define __allegro_compiled_bi__

#include once "allegro/base.bi"

#if defined(ALLEGRO_I386) and not defined(ALLEGRO_USE_C)
type COMPILED_SPRITE__proc
	draw as any ptr
	len as integer
end type

type COMPILED_SPRITE
	planar as short
	color_depth as short
	w as short
	h as short
	proc(0 to 4-1) as COMPILED_SPRITE__proc
end type
#else
type RLE_SPRITE_ as RLE_SPRITE
type COMPILED_SPRITE as RLE_SPRITE_
#endif

declare function get_compiled_sprite cdecl alias "get_compiled_sprite" (byval bitmap as BITMAP ptr, byval planar as integer) as COMPILED_SPRITE ptr
declare sub destroy_compiled_sprite cdecl alias "destroy_compiled_sprite" (byval sprite as COMPILED_SPRITE ptr)
declare sub draw_compiled_sprite cdecl alias "draw_compiled_sprite" (byval bmp as BITMAP ptr, byval sprite as COMPILED_SPRITE ptr, byval x as integer, byval y as integer)

#endif
