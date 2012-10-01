''
''
'' SDL_error -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __SDL_error_bi__
#define __SDL_error_bi__

#include once "begin_code.bi"

declare sub SDL_SetError cdecl alias "SDL_SetError" (byval fmt as zstring ptr, ...)
declare function SDL_GetError cdecl alias "SDL_GetError" () as zstring ptr
declare sub SDL_ClearError cdecl alias "SDL_ClearError" ()

#define SDL_OutOfMemory() SDL_Error(SDL_ENOMEM)

enum SDL_errorcode
	SDL_ENOMEM
	SDL_EFREAD
	SDL_EFWRITE
	SDL_EFSEEK
	SDL_LASTERROR
end enum


declare sub SDL_Error cdecl alias "SDL_Error" (byval code as SDL_errorcode)

#include once "close_code.bi"

#endif
