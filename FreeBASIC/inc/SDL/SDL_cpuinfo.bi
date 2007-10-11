''
''
'' SDL_cpuinfo -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __SDL_cpuinfo_bi__
#define __SDL_cpuinfo_bi__

#include once "begin_code.bi"

declare function SDL_HasRDTSC cdecl alias "SDL_HasRDTSC" () as SDL_bool
declare function SDL_HasMMX cdecl alias "SDL_HasMMX" () as SDL_bool
declare function SDL_HasMMXExt cdecl alias "SDL_HasMMXExt" () as SDL_bool
declare function SDL_Has3DNow cdecl alias "SDL_Has3DNow" () as SDL_bool
declare function SDL_Has3DNowExt cdecl alias "SDL_Has3DNowExt" () as SDL_bool
declare function SDL_HasSSE cdecl alias "SDL_HasSSE" () as SDL_bool
declare function SDL_HasSSE2 cdecl alias "SDL_HasSSE2" () as SDL_bool
declare function SDL_HasAltiVec cdecl alias "SDL_HasAltiVec" () as SDL_bool

#include once "close_code.bi"

#endif
