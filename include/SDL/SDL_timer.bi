''
''
'' SDL_timer -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __SDL_timer_bi__
#define __SDL_timer_bi__

#include once "SDL_main.bi"
#include once "SDL_types.bi"
#include once "begin_code.bi"

#define SDL_TIMESLICE 10
#define TIMER_RESOLUTION 10

declare function SDL_GetTicks cdecl alias "SDL_GetTicks" () as Uint32
declare sub SDL_Delay cdecl alias "SDL_Delay" (byval ms as Uint32)

type SDL_TimerCallback as function cdecl(byval as Uint32) as Uint32

declare function SDL_SetTimer cdecl alias "SDL_SetTimer" (byval interval as Uint32, byval callback as SDL_TimerCallback) as integer

type SDL_NewTimerCallback as function cdecl(byval as Uint32, byval as any ptr) as Uint32
type SDL_TimerID as _SDL_TimerID ptr

declare function SDL_AddTimer cdecl alias "SDL_AddTimer" (byval interval as Uint32, byval callback as SDL_NewTimerCallback, byval param as any ptr) as SDL_TimerID
declare function SDL_RemoveTimer cdecl alias "SDL_RemoveTimer" (byval t as SDL_TimerID) as SDL_bool

#include once "close_code.bi"

#endif
