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
declare function _cwait (byval as integer ptr, byval as _pid_t, byval as integer) as integer
declare function _getpid () as _pid_t
declare function _execl (byval as zstring ptr, byval as zstring ptr, ...) as integer
declare function _execle (byval as zstring ptr, byval as zstring ptr, ...) as integer
declare function _execlp (byval as zstring ptr, byval as zstring ptr, ...) as integer
declare function _execlpe (byval as zstring ptr, byval as zstring ptr, ...) as integer
declare function _execv (byval as zstring ptr, byval as zstring ptr, byval as zstring ptr ptr) as integer
declare function _spawnl (byval as integer, byval as zstring ptr, byval as zstring ptr, ...) as integer
declare function _spawnle (byval as integer, byval as zstring ptr, byval as zstring ptr, ...) as integer
declare function _spawnlp (byval as integer, byval as zstring ptr, byval as zstring ptr, ...) as integer
declare function _spawnlpe (byval as integer, byval as zstring ptr, byval as zstring ptr, ...) as integer
declare function _spawnv (byval as integer, byval as zstring ptr, byval as zstring ptr ptr) as integer
declare function _spawnve (byval as integer, byval as zstring ptr, byval as zstring ptr ptr, byval as zstring ptr ptr) as integer
declare function _spawnvp (byval as integer, byval as zstring ptr, byval as zstring ptr ptr) as integer
declare function _spawnvpe (byval as integer, byval as zstring ptr, byval as zstring ptr ptr, byval as zstring ptr) as integer

declare function _beginthread (byval as sub(byval as any ptr), byval as uinteger, byval as any ptr) as ulong
declare sub _endthread()
declare function _beginthreadex (byval as any ptr, byval as uinteger, byval as function stdcall(byval as any ptr) as uinteger, byval as any ptr, byval as uinteger, byval as uinteger ptr) as ulong
declare sub _endthreadex(byval as uinteger)

declare function cwait (byval as integer ptr, byval as _pid_t, byval as integer) as integer
declare function getpid () as _pid_t
declare function execl (byval as zstring ptr, byval as zstring ptr, ...) as integer
declare function execle (byval as zstring ptr, byval as zstring ptr, ...) as integer
declare function execlp (byval as zstring ptr, byval as zstring ptr, ...) as integer
declare function execlpe (byval as zstring ptr, byval as zstring ptr, ...) as integer
declare function execv (byval as zstring ptr, byval as zstring ptr, byval as zstring ptr ptr) as integer
declare function spawnl (byval as integer, byval as zstring ptr, byval as zstring ptr, ...) as integer
declare function spawnle (byval as integer, byval as zstring ptr, byval as zstring ptr, ...) as integer
declare function spawnlp (byval as integer, byval as zstring ptr, byval as zstring ptr, ...) as integer
declare function spawnlpe (byval as integer, byval as zstring ptr, byval as zstring ptr, ...) as integer
declare function spawnv (byval as integer, byval as zstring ptr, byval as zstring ptr ptr) as integer
declare function spawnve (byval as integer, byval as zstring ptr, byval as zstring ptr ptr, byval as zstring ptr ptr) as integer
declare function spawnvp (byval as integer, byval as zstring ptr, byval as zstring ptr ptr) as integer
declare function spawnvpe (byval as integer, byval as zstring ptr, byval as zstring ptr ptr, byval as zstring ptr) as integer

end extern

#endif
