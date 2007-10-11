''
''
'' SDL_loadso -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __SDL_loadso_bi__
#define __SDL_loadso_bi__

#include once "begin_code.bi"

declare function SDL_LoadObject cdecl alias "SDL_LoadObject" (byval sofile as zstring ptr) as any ptr
declare function SDL_LoadFunction cdecl alias "SDL_LoadFunction" (byval handle as any ptr, byval name as zstring ptr) as any ptr
declare sub SDL_UnloadObject cdecl alias "SDL_UnloadObject" (byval handle as any ptr)

#include once "close_code.bi"

#endif
