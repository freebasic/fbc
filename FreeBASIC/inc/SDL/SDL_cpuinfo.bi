' SDL_cpuinfo.h header ported to freeBasic by Edmond Leung (leung.edmond@gmail.com)

'$inclib: "SDL"

#ifndef SDL_cpuinfo_bi_
#define SDL_cpuinfo_bi_

'$include: "SDL/begin_code.bi"

declare function SDL_HasRDTSC SDLCALL alias "SDL_HasRDTSC" () as SDL_bool

declare function SDL_HasMMX SDLCALL alias "SDL_HasMMX" () as SDL_bool

declare function SDL_HasMMXExt SDLCALL alias "SDL_HasMMXExt" () as SDL_bool

declare function SDL_Has3DNow SDLCALL alias "SDL_Has3DNow" () as SDL_bool

declare function SDL_Has3DNowExt SDLCALL alias "SDL_Has3DNowExt" () as SDL_bool

declare function SDL_HasSSE SDLCALL alias "SDL_HasSSE" () as SDL_bool

declare function SDL_HasSSE2 SDLCALL alias "SDL_HasSSE2" () as SDL_bool

declare function SDL_HasAltiVec SDLCALL alias "SDL_HasAltiVec" () as SDL_bool

'$include: "SDL/close_code.bi"

#endif