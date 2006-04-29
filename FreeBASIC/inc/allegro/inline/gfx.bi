''
''
'' allegro\gfx -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __allegro_inline_gfx_bi__
#define __allegro_inline_gfx_bi__

#include once "allegro/debug.bi"

#define ALLEGRO_IMPORT_GFX_ASM
#include "asm.bi"
#undef ALLEGRO_IMPORT_GFX_ASM

declare sub clear_to_color cdecl alias "clear_to_color" (byval bitmap as BITMAP ptr, byval color as integer)
declare function bitmap_color_depth cdecl alias "bitmap_color_depth" (byval bmp as BITMAP ptr) as integer
declare function bitmap_mask_color cdecl alias "bitmap_mask_color" (byval bmp as BITMAP ptr) as integer
declare function is_same_bitmap cdecl alias "is_same_bitmap" (byval bmp1 as BITMAP ptr, byval bmp2 as BITMAP ptr) as integer
declare function is_linear_bitmap cdecl alias "is_linear_bitmap" (byval bmp as BITMAP ptr) as integer
declare function is_planar_bitmap cdecl alias "is_planar_bitmap" (byval bmp as BITMAP ptr) as integer
declare function is_memory_bitmap cdecl alias "is_memory_bitmap" (byval bmp as BITMAP ptr) as integer
declare function is_screen_bitmap cdecl alias "is_screen_bitmap" (byval bmp as BITMAP ptr) as integer
declare function is_video_bitmap cdecl alias "is_video_bitmap" (byval bmp as BITMAP ptr) as integer
declare function is_system_bitmap cdecl alias "is_system_bitmap" (byval bmp as BITMAP ptr) as integer
declare function is_sub_bitmap cdecl alias "is_sub_bitmap" (byval bmp as BITMAP ptr) as integer
declare sub acquire_bitmap cdecl alias "acquire_bitmap" (byval bmp as BITMAP ptr)
declare sub release_bitmap cdecl alias "release_bitmap" (byval bmp as BITMAP ptr)
declare sub acquire_screen cdecl alias "acquire_screen" ()
declare sub release_screen cdecl alias "release_screen" ()

#endif
