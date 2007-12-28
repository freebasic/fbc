''
''
'' allegro\rle -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __allegro_inline_rle_bi__
#define __allegro_inline_rle_bi__

#include once "allegro/debug.bi"

declare sub draw_rle_sprite cdecl alias "draw_rle_sprite" (byval bmp as BITMAP ptr, byval sprite as RLE_SPRITE ptr, byval x as integer, byval y as integer)
declare sub draw_trans_rle_sprite cdecl alias "draw_trans_rle_sprite" (byval bmp as BITMAP ptr, byval sprite as RLE_SPRITE ptr, byval x as integer, byval y as integer)
declare sub draw_lit_rle_sprite cdecl alias "draw_lit_rle_sprite" (byval bmp as BITMAP ptr, byval sprite as RLE_SPRITE ptr, byval x as integer, byval y as integer, byval color as integer)

#endif