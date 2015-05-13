''
''
'' SDL_mutex -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __SDL_mutex_bi__
#define __SDL_mutex_bi__

#include once "SDL_main.bi"
#include once "SDL_types.bi"
#include once "begin_code.bi"

#define SDL_MUTEX_TIMEDOUT 1

type SDL_mutex as _SDL_mutex

declare function SDL_CreateMutex cdecl alias "SDL_CreateMutex" () as SDL_mutex ptr
declare function SDL_mutexP cdecl alias "SDL_mutexP" (byval mutex as SDL_mutex ptr) as integer
declare function SDL_mutexV cdecl alias "SDL_mutexV" (byval mutex as SDL_mutex ptr) as integer
declare sub SDL_DestroyMutex cdecl alias "SDL_DestroyMutex" (byval mutex as SDL_mutex ptr)

#define SDL_LockMutex(m) SDL_mutexP(m)
#define SDL_UnlockMutex(m) SDL_mutexV(m)

type SDL_sem as _SDL_sem

declare function SDL_CreateSemaphore cdecl alias "SDL_CreateSemaphore" (byval initial_value as Uint32) as SDL_sem ptr
declare sub SDL_DestroySemaphore cdecl alias "SDL_DestroySemaphore" (byval sem as SDL_sem ptr)
declare function SDL_SemWait cdecl alias "SDL_SemWait" (byval sem as SDL_sem ptr) as integer
declare function SDL_SemTryWait cdecl alias "SDL_SemTryWait" (byval sem as SDL_sem ptr) as integer
declare function SDL_SemWaitTimeout cdecl alias "SDL_SemWaitTimeout" (byval sem as SDL_sem ptr, byval ms as Uint32) as integer
declare function SDL_SemPost cdecl alias "SDL_SemPost" (byval sem as SDL_sem ptr) as integer
declare function SDL_SemValue cdecl alias "SDL_SemValue" (byval sem as SDL_sem ptr) as Uint32

type SDL_cond as _SDL_cond

declare function SDL_CreateCond cdecl alias "SDL_CreateCond" () as SDL_cond ptr
declare sub SDL_DestroyCond cdecl alias "SDL_DestroyCond" (byval cond as SDL_cond ptr)
declare function SDL_CondSignal cdecl alias "SDL_CondSignal" (byval cond as SDL_cond ptr) as integer
declare function SDL_CondBroadcast cdecl alias "SDL_CondBroadcast" (byval cond as SDL_cond ptr) as integer
declare function SDL_CondWait cdecl alias "SDL_CondWait" (byval cond as SDL_cond ptr, byval mut as SDL_mutex ptr) as integer
declare function SDL_CondWaitTimeout cdecl alias "SDL_CondWaitTimeout" (byval cond as SDL_cond ptr, byval mutex as SDL_mutex ptr, byval ms as Uint32) as integer

#include once "close_code.bi"

#endif
