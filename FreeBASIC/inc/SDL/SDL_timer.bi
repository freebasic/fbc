' SDL_timer.h header ported to freeBasic by Edmond Leung (leung.edmond@gmail.com)

'$inclib: "SDL"

#ifndef SDL_timer_bi_
#define SDL_timer_bi_

'$include: 'SDL/SDL_main.bi'
'$include: 'SDL/SDL_types.bi'

'$include: 'SDL/begin_code.bi'

#define SDL_TIMESLICE 10

#define TIMER_SOLUTION 10

declare function SDL_GetTicks SDLCALL alias "SDL_GetTicks" () as Uint32

declare sub SDL_Delay SDLCALL alias "SDL_Delay" (byval ms as Uint32)

#define SDL_TimerCallBack _
   function SDLCALL (byval interval as Uint32) as Uint32

declare function SDL_SetTimer SDLCALL alias "SDL_SetTimer" _
   (byval interval as Uint32, byval callback as SDL_TimerCallBack ) as integer

#define SDL_NewTimerCallBack _
   function SDLCALL (byval interval as Uint32, byval param as any ptr) _
   as Uint32

#define SDL_TimerID any ptr

declare function SDL_AddTimer SDLCALL alias "SDL_AddTimer" _
   (byval interval as Uint32, byval callback as SDL_NewTimerCallBack, _
   byval param as any ptr) as SDL_TimerID

declare function SDL_RemoveTimer SDLCALL alias "SDL_RemoveTimer" _
   (byval t as SDL_TimerID) as SDL_bool

'$include: 'SDL/close_code.bi'

#endif