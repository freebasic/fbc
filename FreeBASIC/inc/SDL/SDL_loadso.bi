' SDL_loadso.h header ported to freeBasic by Edmond Leung (leung.edmond@gmail.com)

'$inclib: "SDL"

#ifndef SDL_loadso_bi_
#define SDL_loadso_bi_

'$include: "SDL/begin_code.bi"

declare function SDL_LoadObject SDLCALL alias "SDL_LoadObject" _
   (byval sofile as zstring ptr) as any ptr

declare function SDL_LoadFunction SDLCALL alias "SDL_LoadFunction" _
   (byval handle as any ptr, byval name as zstring ptr) as any ptr

declare sub SDL_UnloadObject SDLCALL alias "SDL_UnloadObject" _
   (byval handle as any ptr)

'$include: "SDL/close_code.bi"

#endif