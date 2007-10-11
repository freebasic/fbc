''
''
'' SDL_main -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __SDL_main_bi__
#define __SDL_main_bi__

declare function SDL_main cdecl alias "SDL_main" (byval argc as integer, byval argv as byte ptr ptr) as integer

#include once "SDL_types.bi"
#include once "begin_code.bi"

declare sub SDL_SetModuleHandle cdecl alias "SDL_SetModuleHandle" (byval hInst as any ptr)
declare function SDL_RegisterApp cdecl alias "SDL_RegisterApp" (byval name as zstring ptr, byval style as Uint32, byval hInst as any ptr) as integer

#include once "close_code.bi"

#endif
