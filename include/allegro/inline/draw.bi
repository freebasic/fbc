''
''
'' allegro\draw -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __allegro_inline_draw_bi__
#define __allegro_inline_draw_bi__

#include once "allegro/debug.bi"
#include once "allegro/inline/gfx.bi"

declare function getpixel cdecl alias "getpixel" (byval bmp as BITMAP ptr, byval x as integer, byval y as integer) as integer
declare sub putpixel cdecl alias "putpixel" (byval bmp as BITMAP ptr, byval x as integer, byval y as integer, byval color as integer)
declare sub vline cdecl alias "vline" (byval bmp as BITMAP ptr, byval x as integer, byval y1 as integer, byval y2 as integer, byval color as integer)
declare sub hline cdecl alias "hline" (byval bmp as BITMAP ptr, byval x1 as integer, byval y as integer, byval x2 as integer, byval color as integer)
declare sub line cdecl alias "line" (byval bmp as BITMAP ptr, byval x1 as integer, byval y1 as integer, byval x2 as integer, byval y2 as integer, byval color as integer)
declare sub rectfill cdecl alias "rectfill" (byval bmp as BITMAP ptr, byval x1 as integer, byval y1 as integer, byval x2 as integer, byval y2 as integer, byval color as integer)
declare sub draw_sprite cdecl alias "draw_sprite" (byval bmp as BITMAP ptr, byval sprite as BITMAP ptr, byval x as integer, byval y as integer)
declare sub draw_sprite_v_flip cdecl alias "draw_sprite_v_flip" (byval bmp as BITMAP ptr, byval sprite as BITMAP ptr, byval x as integer, byval y as integer)
declare sub draw_sprite_h_flip cdecl alias "draw_sprite_h_flip" (byval bmp as BITMAP ptr, byval sprite as BITMAP ptr, byval x as integer, byval y as integer)
declare sub draw_sprite_vh_flip cdecl alias "draw_sprite_vh_flip" (byval bmp as BITMAP ptr, byval sprite as BITMAP ptr, byval x as integer, byval y as integer)
declare sub draw_trans_sprite cdecl alias "draw_trans_sprite" (byval bmp as BITMAP ptr, byval sprite as BITMAP ptr, byval x as integer, byval y as integer)
declare sub draw_lit_sprite cdecl alias "draw_lit_sprite" (byval bmp as BITMAP ptr, byval sprite as BITMAP ptr, byval x as integer, byval y as integer, byval color as integer)
declare sub draw_character cdecl alias "draw_character" (byval bmp as BITMAP ptr, byval sprite as BITMAP ptr, byval x as integer, byval y as integer, byval color as integer)
declare sub rotate_sprite cdecl alias "rotate_sprite" (byval bmp as BITMAP ptr, byval sprite as BITMAP ptr, byval x as integer, byval y as integer, byval angle as fixed)
declare sub rotate_sprite_v_flip cdecl alias "rotate_sprite_v_flip" (byval bmp as BITMAP ptr, byval sprite as BITMAP ptr, byval x as integer, byval y as integer, byval angle as fixed)
declare sub rotate_scaled_sprite cdecl alias "rotate_scaled_sprite" (byval bmp as BITMAP ptr, byval sprite as BITMAP ptr, byval x as integer, byval y as integer, byval angle as fixed, byval scale as fixed)
declare sub rotate_scaled_sprite_v_flip cdecl alias "rotate_scaled_sprite_v_flip" (byval bmp as BITMAP ptr, byval sprite as BITMAP ptr, byval x as integer, byval y as integer, byval angle as fixed, byval scale as fixed)
declare sub pivot_sprite cdecl alias "pivot_sprite" (byval bmp as BITMAP ptr, byval sprite as BITMAP ptr, byval x as integer, byval y as integer, byval cx as integer, byval cy as integer, byval angle as fixed)
declare sub pivot_sprite_v_flip cdecl alias "pivot_sprite_v_flip" (byval bmp as BITMAP ptr, byval sprite as BITMAP ptr, byval x as integer, byval y as integer, byval cx as integer, byval cy as integer, byval angle as fixed)
declare sub pivot_scaled_sprite cdecl alias "pivot_scaled_sprite" (byval bmp as BITMAP ptr, byval sprite as BITMAP ptr, byval x as integer, byval y as integer, byval cx as integer, byval cy as integer, byval angle as fixed, byval scale as fixed)
declare sub pivot_scaled_sprite_v_flip cdecl alias "pivot_scaled_sprite_v_flip" (byval bmp as BITMAP ptr, byval sprite as BITMAP ptr, byval x as integer, byval y as integer, byval cx as integer, byval cy as integer, byval angle as fixed, byval scale as fixed)
declare sub _putpixel cdecl alias "_putpixel" (byval bmp as BITMAP ptr, byval x as integer, byval y as integer, byval color as integer)
declare function _getpixel cdecl alias "_getpixel" (byval bmp as BITMAP ptr, byval x as integer, byval y as integer) as integer
declare sub _putpixel15 cdecl alias "_putpixel15" (byval bmp as BITMAP ptr, byval x as integer, byval y as integer, byval color as integer)
declare function _getpixel15 cdecl alias "_getpixel15" (byval bmp as BITMAP ptr, byval x as integer, byval y as integer) as integer
declare sub _putpixel16 cdecl alias "_putpixel16" (byval bmp as BITMAP ptr, byval x as integer, byval y as integer, byval color as integer)
declare function _getpixel16 cdecl alias "_getpixel16" (byval bmp as BITMAP ptr, byval x as integer, byval y as integer) as integer
declare sub _putpixel24 cdecl alias "_putpixel24" (byval bmp as BITMAP ptr, byval x as integer, byval y as integer, byval color as integer)
declare function _getpixel24 cdecl alias "_getpixel24" (byval bmp as BITMAP ptr, byval x as integer, byval y as integer) as integer
declare sub _putpixel32 cdecl alias "_putpixel32" (byval bmp as BITMAP ptr, byval x as integer, byval y as integer, byval color as integer)
declare function _getpixel32 cdecl alias "_getpixel32" (byval bmp as BITMAP ptr, byval x as integer, byval y as integer) as integer

#endif
