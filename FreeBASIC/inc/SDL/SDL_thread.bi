' SDL_thread.h header ported to freeBasic by Edmond Leung (leung.edmond@gmail.com)

'$inclinc: "sdl"

#ifndef SDL_thread_bi_
#define SDL_thread_bi_

'$include: 'SDL/SDL_main.bi'
'$include: 'SDL/SDL_types.bi'

'$include: 'SDL/SDL_mutex.bi'

'$include: 'SDL/begin_code.bi'

type SDL_Thread as any

declare function SDL_CreateThread SDLCALL alias "SDL_CreateThread" _
   (byval fn as function(byval pntr as any ptr) as integer, _
   byval dat as any ptr) as SDL_Thread ptr

declare function SDL_ThreadID SDLCALL alias "SDL_ThreadID" () as Uint32

declare function SDL_GetThreadID SDLCALL alias "SDL_GetThreadID" _
   (byval thread as SDL_Thread ptr) as Uint32

declare sub SDL_WaitThread SDLCALL alias "SDL_WaitThread" _
   (byval thread as SDL_Thread ptr, byval status as integer ptr)

declare sub SDL_KillThread SDLCALL alias "SDL_KillThread" _
   (byval thread as SDL_Thread ptr)

'#include: 'SDL/close_code.bi'

#endif  