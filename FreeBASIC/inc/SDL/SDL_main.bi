' SDL_main.h header ported to freeBasic by Edmond Leung (leung.edmond@gmail.com)

'$inclib: "SDL"

#ifndef SDL_main_bi_
#define SDL_main_bi_

#if defined(__FB_WIN32__)
'$include: 'SDL/SDL_types.bi'
'$include: 'SDL/begin_code.bi'

declare sub SDL_SetModuleHandle SDLCALL alias "SDL_SetModuleHandle" _
   (byval hInst as any ptr)

declare function SDL_RegisterApp SDLCALL alias "SDL_RegisterApp" _
   (byval name as zstring ptr, byval style as Uint32, byval hInst as any ptr) _
   as integer

'$include: 'SDL/close_code.bi'
#endif

#endif
