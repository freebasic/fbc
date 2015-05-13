''
''
'' process -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __crt_win32_process_bi__
#define __crt_win32_process_bi__

#include "crt/sys/types.bi"
#include once "crt/stdint.bi"

#define	_WAIT_CHILD 0
#define	_WAIT_GRANDCHILD 1

#define	WAIT_CHILD _WAIT_CHILD
#define	WAIT_GRANDCHILD _WAIT_GRANDCHILD

#define	_P_WAIT 0
#define	_P_NOWAIT 1
#define	_P_OVERLAY 2
#define	_OLD_P_OVERLAY _P_OVERLAY
#define	_P_NOWAITO 3
#define	_P_DETACH 4

#define	P_WAIT _P_WAIT
#define	P_NOWAIT _P_NOWAIT
#define	P_OVERLAY _P_OVERLAY
#define	OLD_P_OVERLAY _OLD_P_OVERLAY
#define	P_NOWAITO _P_NOWAITO
#define	P_DETACH _P_DETACH

extern "C"

declare sub cexit ()
declare sub _c_exit ()
declare function _getpid () as long
declare function _cwait (byval as long ptr, byval as intptr_t, byval as long) as intptr_t
declare function _execl (byval as zstring ptr, byval as zstring ptr, ...) as intptr_t
declare function _execle (byval as zstring ptr, byval as zstring ptr, ...) as intptr_t
declare function _execlp (byval as zstring ptr, byval as zstring ptr, ...) as intptr_t
declare function _execlpe (byval as zstring ptr, byval as zstring ptr, ...) as intptr_t
declare function _execv (byval as zstring ptr, byval as zstring ptr ptr) as intptr_t
declare function _execve (byval as zstring ptr, byval as zstring ptr ptr, byval as zstring ptr ptr) as intptr_t
declare function _execvp (byval as zstring ptr, byval as zstring ptr ptr) as intptr_t
declare function _execvpe (byval as zstring ptr, byval as zstring ptr ptr, byval as zstring ptr ptr) as intptr_t
declare function _spawnl (byval as long, byval as zstring ptr, byval as zstring ptr, ...) as intptr_t
declare function _spawnle (byval as long, byval as zstring ptr, byval as zstring ptr, ...) as intptr_t
declare function _spawnlp (byval as long, byval as zstring ptr, byval as zstring ptr, ...) as intptr_t
declare function _spawnlpe (byval as long, byval as zstring ptr, byval as zstring ptr, ...) as intptr_t
declare function _spawnv (byval as long, byval as zstring ptr, byval as zstring ptr ptr) as intptr_t
declare function _spawnve (byval as long, byval as zstring ptr, byval as zstring ptr ptr, byval as zstring ptr ptr) as intptr_t
declare function _spawnvp (byval as long, byval as zstring ptr, byval as zstring ptr ptr) as intptr_t
declare function _spawnvpe (byval as long, byval as zstring ptr, byval as zstring ptr ptr, byval as zstring ptr ptr) as intptr_t

declare function _beginthread (byval as sub(byval as any ptr), byval as ulong, byval as any ptr) as uintptr_t
declare sub _endthread()
declare function _beginthreadex (byval as any ptr, byval as ulong, byval as function stdcall(byval as any ptr) as ulong, byval as any ptr, byval as ulong, byval as ulong ptr) as uintptr_t
declare sub _endthreadex(byval as ulong)

declare function getpid () as long
declare function cwait (byval as long ptr, byval as intptr_t, byval as long) as intptr_t
declare function execl (byval as zstring ptr, byval as zstring ptr, ...) as intptr_t
declare function execle (byval as zstring ptr, byval as zstring ptr, ...) as intptr_t
declare function execlp (byval as zstring ptr, byval as zstring ptr, ...) as intptr_t
declare function execlpe (byval as zstring ptr, byval as zstring ptr, ...) as intptr_t
declare function execv (byval as zstring ptr, byval as zstring ptr ptr) as intptr_t
declare function execve (byval as zstring ptr, byval as zstring ptr ptr, byval as zstring ptr ptr) as intptr_t
declare function execvp (byval as zstring ptr, byval as zstring ptr ptr) as intptr_t
declare function execvpe (byval as zstring ptr, byval as zstring ptr ptr, byval as zstring ptr ptr) as intptr_t
declare function spawnl (byval as long, byval as zstring ptr, byval as zstring ptr, ...) as intptr_t
declare function spawnle (byval as long, byval as zstring ptr, byval as zstring ptr, ...) as intptr_t
declare function spawnlp (byval as long, byval as zstring ptr, byval as zstring ptr, ...) as intptr_t
declare function spawnlpe (byval as long, byval as zstring ptr, byval as zstring ptr, ...) as intptr_t
declare function spawnv (byval as long, byval as zstring ptr, byval as zstring ptr ptr) as intptr_t
declare function spawnve (byval as long, byval as zstring ptr, byval as zstring ptr ptr, byval as zstring ptr ptr) as intptr_t
declare function spawnvp (byval as long, byval as zstring ptr, byval as zstring ptr ptr) as intptr_t
declare function spawnvpe (byval as long, byval as zstring ptr, byval as zstring ptr ptr, byval as zstring ptr ptr) as intptr_t

end extern

#endif
