' SDL_syswm.h header ported to freeBasic by Edmond Leung (leung.edmond@gmail.com)

'$inclib: "SDL"

#ifndef SDL_syswm_bi_
#define SDL_syswm_bi_

'$include: "SDL/SDL_version.bi"

'$include: "SDL/begin_code.bi"

#ifdef SDL_PROTOTYPES_ONLY
#define SDL_SysWMinfo any
#else

type SDL_SysWMmsg
   version as SDL_version
   data as integer
end type

type SDL_SysWMinfo
   version as SDL_version
   data as integer
end type

#endif

declare function SDL_GetWMInfo SDLCALL alias "SDL_GetWMInfo" _
   (byval info as SDL_SysWMInfo ptr)

'$include: "SDL/close_code.bi"