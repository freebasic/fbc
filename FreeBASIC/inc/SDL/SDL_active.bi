' SDL_active.h header ported to freeBasic by Edmond Leung (leung.edmond@gmail.com)

'$inclib: "SDL"

#ifndef SDL_active_bi_
#define SDL_active_bi_

'$include: 'SDL/begin_code.bi'

#define SDL_APPMOUSEFOCUS &h01
#define SDL_APPINPUTFOCUS &h02
#define SDL_APPACTIVE &h04

declare function SDL_GetAppState SDLCALL alias "SDL_GetAppState" () as Uint8

'$include: 'SDL/close_code.bi'

#endif