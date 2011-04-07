''
''
'' allegro\fli -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __allegro_fli_bi__
#define __allegro_fli_bi__

#include once "allegro/base.bi"
#include once "allegro/palette.bi"

#define FLI_OK 0
#define FLI_EOF -1
#define FLI_ERROR -2
#define FLI_NOT_OPEN -3

declare function play_fli cdecl alias "play_fli" (byval filename as zstring ptr, byval bmp as BITMAP ptr, byval loop as integer, byval callback as function cdecl() as integer) as integer
declare function play_memory_fli cdecl alias "play_memory_fli" (byval fli_data as any ptr, byval bmp as BITMAP ptr, byval loop as integer, byval callback as function cdecl() as integer) as integer
declare function open_fli cdecl alias "open_fli" (byval filename as zstring ptr) as integer
declare function open_memory_fli cdecl alias "open_memory_fli" (byval fli_data as any ptr) as integer
declare sub close_fli cdecl alias "close_fli" ()
declare function next_fli_frame cdecl alias "next_fli_frame" (byval loop as integer) as integer
declare sub reset_fli_variables cdecl alias "reset_fli_variables" ()

extern _AL_DLL fli_bitmap alias "fli_bitmap" as BITMAP ptr
extern _AL_DLL fli_palette(0 to PAL_SIZE-1) alias "fli_palette" as PALETTE
extern _AL_DLL fli_bmp_dirty_from alias "fli_bmp_dirty_from" as integer
extern _AL_DLL fli_bmp_dirty_to alias "fli_bmp_dirty_to" as integer
extern _AL_DLL fli_pal_dirty_from alias "fli_pal_dirty_from" as integer
extern _AL_DLL fli_pal_dirty_to alias "fli_pal_dirty_to" as integer
extern _AL_DLL fli_frame alias "fli_frame" as integer
extern _AL_DLL fli_timer alias "fli_timer" as integer

#endif
