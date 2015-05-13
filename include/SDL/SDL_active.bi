''
''
'' SDL_active -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __SDL_active_bi__
#define __SDL_active_bi__

#include once "begin_code.bi"

#define SDL_APPMOUSEFOCUS &h01
#define SDL_APPINPUTFOCUS &h02
#define SDL_APPACTIVE &h04

declare function SDL_GetAppState cdecl alias "SDL_GetAppState" () as Uint8

#include once "close_code.bi"

#endif
