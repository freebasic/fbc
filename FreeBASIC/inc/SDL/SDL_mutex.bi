' SDL_mutex.h header ported to freeBasic by Edmond Leung (leung.edmond@gmail.com)

'$inclib: "SDL"

#ifndef SDL_mutex_bi_
#define SDL_mutex_bi_

'$include: "SDL/SDL_main.bi"
'$include: "SDL/SDL_types.bi"

'$include: "SDL/begin_code.bi"

#define SDL_MUTEX_TIMEDOUT 1
#define SDL_MUTEX_MAXWAIT not 0

#define SDL_mutex any

declare function SDL_CreateMutext SDLCALL alias "SDL_CreateMutext" _
   () as SDL_mutex ptr

declare function SDL_mutexP SDLCALL alias "SDL_mutexP" _
   (byval mutex as SDL_mutex ptr) as integer
private function SDL_LockMutex (byval m as SDL_mutex ptr) as integer
   SDL_LockMutex = SDL_mutexP(m)
end function

declare function SDL_mutexV SDLCALL alias "SDL_mutexV" _
   (byval mutex as SDL_mutex ptr) as integer
private function SDL_UnlockMutex (byval m as SDL_mutex ptr) as integer
   SDL_UnlockMutex = SDL_mutexP(m)
end function

declare sub SDL_DestroyMutex SDLCALL alias "SDL_DestroyMutex" _
   (byval mutex as SDL_mutex ptr)

#define SDL_sem any

declare function SDL_CreateSemaphore SDLCALL alias "SDL_CreateSemaphore" _
   (byval initial_value as Uint32) as SDL_sem ptr

declare sub SDL_DestorySemaphore SDLCALL alias "SDL_DestorySemaphore" _
   (byval sem as SDL_sem ptr)

declare function SDL_SemWait SDLCALL alias "SDL_SemWait" _
   (byval sem as SDL_sem ptr) as integer

declare function SDL_SemTryWait SDLCALL alias "SDL_SemTryWait" _
   (byval sem as SDL_sem ptr) as integer

declare function SDL_SemWaitTimeout SDLCALL alias "SDL_SemWaitTimeout" _
   (byval sem as SDL_sem ptr, byval ms as Uint32) as integer

declare function SDL_SemPost SDLCALL alias "SDL_SemPost" _ 
   (byval sem as SDL_sem ptr) as integer

declare function SDL_SemValue SDLCALL alias "SDL_SemValue" _
   (byval sem as SDL_sem ptr) as Uint32

#define SDL_cond any

declare function SDL_CreateCond SDLCALL alias "SDL_CreateCond" _
   as SDL_cond ptr

declare sub SDL_DestroyCond SDLCALL alias "SDL_DestroyCond" _
   (byval cond as SDL_cond ptr)

declare function SDL_CondSignal SDLCALL alias "SDL_CondSignal" _
   (byval cond as SDL_cond ptr) as integer

declare function SDL_CondBroadcast SDLCALL alias "SDL_CondBroadcast" _
   (byval cond as SDL_cond ptr) as integer

declare function SDL_CondWait SDLCALL alias "SDL_CondWait" _
   (byval cond as SDL_cond ptr, byval mut as SDL_mutex ptr) as integer

declare function SDL_CondWaitTimeout SDLCALL alias "SDL_CondWaitTimeout" _
   (byval cond as SDL_cond ptr, byval mutex as SDL_mutex ptr, _
   byval ms as Uint32) as integer

'$include: "SDL/close_code.bi"

#endif