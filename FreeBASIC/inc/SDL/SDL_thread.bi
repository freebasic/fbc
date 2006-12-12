''
''
'' SDL_thread -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __SDL_thread_bi__
#define __SDL_thread_bi__

#include once "SDL_main.bi"
#include once "SDL_types.bi"
#include once "SDL_mutex.bi"
#include once "begin_code.bi"

type SDL_Thread as _SDL_Thread

declare function SDL_CreateThread cdecl alias "SDL_CreateThread" (byval fn as function cdecl(byval as any ptr) as integer, byval data as any ptr) as SDL_Thread ptr
declare function SDL_ThreadID cdecl alias "SDL_ThreadID" () as Uint32
declare function SDL_GetThreadID cdecl alias "SDL_GetThreadID" (byval thread as SDL_Thread ptr) as Uint32
declare sub SDL_WaitThread cdecl alias "SDL_WaitThread" (byval thread as SDL_Thread ptr, byval status as integer ptr)
declare sub SDL_KillThread cdecl alias "SDL_KillThread" (byval thread as SDL_Thread ptr)

#include once "close_code.bi"

#endif
