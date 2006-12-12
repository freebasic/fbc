''
''
'' SDL_getenv -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __SDL_getenv_bi__
#define __SDL_getenv_bi__

#ifdef NEED_SDL_GETENV

#include once "begin_code.bi"

declare function SDL_putenv cdecl alias "SDL_putenv" (byval variable as zstring ptr) as integer
declare function SDL_getenv cdecl alias "SDL_getenv" (byval name as zstring ptr) as zstring ptr

#define putenv(X) SDL_putenv(X)
#define getenv(X) SDL_getenv(X)

#include once "close_code.bi"

#endif

#endif
