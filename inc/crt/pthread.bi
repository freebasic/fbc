'' FreeBASIC binding for glibc-2.22
''
'' based on the C header files:
''   Copyright (C) 2002-2015 Free Software Foundation, Inc.
''   This file is part of the GNU C Library.
''
''   The GNU C Library is free software; you can redistribute it and/or
''   modify it under the terms of the GNU Lesser General Public
''   License as published by the Free Software Foundation; either
''   version 2.1 of the License, or (at your option) any later version.
''
''   The GNU C Library is distributed in the hope that it will be useful,
''   but WITHOUT ANY WARRANTY; without even the implied warranty of
''   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
''   Lesser General Public License for more details.
''
''   You should have received a copy of the GNU Lesser General Public
''   License along with the GNU C Library; if not, see
''   <http://www.gnu.org/licenses/>.  
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#ifndef __FB_UNIX__
	#error "target not supported; this header is for GNU/Linux glibc"
#endif

#if defined(__FB_64BIT__) and (not defined(__FB_ARM__))
	#include once "crt/long.bi"
#endif

#include once "crt/sched.bi"
#include once "crt/time.bi"
#include once "crt/bits/pthreadtypes.bi"
#include once "crt/bits/wordsize.bi"

extern "C"

const _PTHREAD_H = 1

enum
	PTHREAD_CREATE_JOINABLE
	PTHREAD_CREATE_DETACHED
end enum

enum
	PTHREAD_MUTEX_TIMED_NP
	PTHREAD_MUTEX_RECURSIVE_NP
	PTHREAD_MUTEX_ERRORCHECK_NP
	PTHREAD_MUTEX_ADAPTIVE_NP
	PTHREAD_MUTEX_NORMAL = PTHREAD_MUTEX_TIMED_NP
	PTHREAD_MUTEX_RECURSIVE = PTHREAD_MUTEX_RECURSIVE_NP
	PTHREAD_MUTEX_ERRORCHECK = PTHREAD_MUTEX_ERRORCHECK_NP
	PTHREAD_MUTEX_DEFAULT = PTHREAD_MUTEX_NORMAL
	PTHREAD_MUTEX_FAST_NP = PTHREAD_MUTEX_TIMED_NP
end enum

enum
	PTHREAD_MUTEX_STALLED
	PTHREAD_MUTEX_STALLED_NP = PTHREAD_MUTEX_STALLED
	PTHREAD_MUTEX_ROBUST
	PTHREAD_MUTEX_ROBUST_NP = PTHREAD_MUTEX_ROBUST
end enum

enum
	PTHREAD_PRIO_NONE
	PTHREAD_PRIO_INHERIT
	PTHREAD_PRIO_PROTECT
end enum

#ifdef __FB_64BIT__
	#define PTHREAD_MUTEX_INITIALIZER ((0, 0, 0, 0, 0, __PTHREAD_SPINS, (0, 0)))
	#define PTHREAD_RECURSIVE_MUTEX_INITIALIZER_NP ((0, 0, 0, 0, PTHREAD_MUTEX_RECURSIVE_NP, __PTHREAD_SPINS, (0, 0)))
	#define PTHREAD_ERRORCHECK_MUTEX_INITIALIZER_NP ((0, 0, 0, 0, PTHREAD_MUTEX_ERRORCHECK_NP, __PTHREAD_SPINS, (0, 0)))
	#define PTHREAD_ADAPTIVE_MUTEX_INITIALIZER_NP ((0, 0, 0, 0, PTHREAD_MUTEX_ADAPTIVE_NP, __PTHREAD_SPINS, (0, 0)))
#else
	#define PTHREAD_MUTEX_INITIALIZER ((0, 0, 0, 0, 0, (__PTHREAD_SPINS)))
	#define PTHREAD_RECURSIVE_MUTEX_INITIALIZER_NP ((0, 0, 0, PTHREAD_MUTEX_RECURSIVE_NP, 0, (__PTHREAD_SPINS)))
	#define PTHREAD_ERRORCHECK_MUTEX_INITIALIZER_NP ((0, 0, 0, PTHREAD_MUTEX_ERRORCHECK_NP, 0, (__PTHREAD_SPINS)))
	#define PTHREAD_ADAPTIVE_MUTEX_INITIALIZER_NP ((0, 0, 0, PTHREAD_MUTEX_ADAPTIVE_NP, 0, (__PTHREAD_SPINS)))
#endif

enum
	PTHREAD_RWLOCK_PREFER_READER_NP
	PTHREAD_RWLOCK_PREFER_WRITER_NP
	PTHREAD_RWLOCK_PREFER_WRITER_NONRECURSIVE_NP
	PTHREAD_RWLOCK_DEFAULT_NP = PTHREAD_RWLOCK_PREFER_READER_NP
end enum

#if defined(__FB_64BIT__) and defined(__FB_ARM__)
	const __PTHREAD_RWLOCK_INT_FLAGS_SHARED = 1
#endif

#define PTHREAD_RWLOCK_INITIALIZER ((0, 0, 0, 0, 0, 0, 0, 0, __PTHREAD_RWLOCK_ELISION_EXTRA, 0, 0))

#ifdef __FB_64BIT__
	#define PTHREAD_RWLOCK_WRITER_NONRECURSIVE_INITIALIZER_NP ((0, 0, 0, 0, 0, 0, 0, 0, __PTHREAD_RWLOCK_ELISION_EXTRA, 0, PTHREAD_RWLOCK_PREFER_WRITER_NONRECURSIVE_NP))
#else
	#define PTHREAD_RWLOCK_WRITER_NONRECURSIVE_INITIALIZER_NP ((0, 0, 0, 0, 0, 0, PTHREAD_RWLOCK_PREFER_WRITER_NONRECURSIVE_NP, 0, __PTHREAD_RWLOCK_ELISION_EXTRA, 0, 0))
#endif

enum
	PTHREAD_INHERIT_SCHED
	PTHREAD_EXPLICIT_SCHED
end enum

enum
	PTHREAD_SCOPE_SYSTEM
	PTHREAD_SCOPE_PROCESS
end enum

enum
	PTHREAD_PROCESS_PRIVATE
	PTHREAD_PROCESS_SHARED
end enum

#define PTHREAD_COND_INITIALIZER ((0, 0, 0, 0, 0, cptr(any ptr, 0), 0, 0))

type _pthread_cleanup_buffer
	__routine as sub(byval as any ptr)
	__arg as any ptr
	__canceltype as long
	__prev as _pthread_cleanup_buffer ptr
end type

enum
	PTHREAD_CANCEL_ENABLE
	PTHREAD_CANCEL_DISABLE
end enum

enum
	PTHREAD_CANCEL_DEFERRED
	PTHREAD_CANCEL_ASYNCHRONOUS
end enum

const PTHREAD_CANCELED = cptr(any ptr, -1)
const PTHREAD_ONCE_INIT = 0
const PTHREAD_BARRIER_SERIAL_THREAD = -1

declare function pthread_create(byval __newthread as pthread_t ptr, byval __attr as const pthread_attr_t ptr, byval __start_routine as function(byval as any ptr) as any ptr, byval __arg as any ptr) as long
declare sub pthread_exit(byval __retval as any ptr)
declare function pthread_join(byval __th as pthread_t, byval __thread_return as any ptr ptr) as long
declare function pthread_tryjoin_np(byval __th as pthread_t, byval __thread_return as any ptr ptr) as long
declare function pthread_timedjoin_np(byval __th as pthread_t, byval __thread_return as any ptr ptr, byval __abstime as const timespec ptr) as long
declare function pthread_detach(byval __th as pthread_t) as long
declare function pthread_self() as pthread_t
declare function pthread_equal(byval __thread1 as pthread_t, byval __thread2 as pthread_t) as long
declare function pthread_attr_init(byval __attr as pthread_attr_t ptr) as long
declare function pthread_attr_destroy(byval __attr as pthread_attr_t ptr) as long
declare function pthread_attr_getdetachstate(byval __attr as const pthread_attr_t ptr, byval __detachstate as long ptr) as long
declare function pthread_attr_setdetachstate(byval __attr as pthread_attr_t ptr, byval __detachstate as long) as long
declare function pthread_attr_getguardsize(byval __attr as const pthread_attr_t ptr, byval __guardsize as uinteger ptr) as long
declare function pthread_attr_setguardsize(byval __attr as pthread_attr_t ptr, byval __guardsize as uinteger) as long
declare function pthread_attr_getschedparam(byval __attr as const pthread_attr_t ptr, byval __param as sched_param ptr) as long
declare function pthread_attr_setschedparam(byval __attr as pthread_attr_t ptr, byval __param as const sched_param ptr) as long
declare function pthread_attr_getschedpolicy(byval __attr as const pthread_attr_t ptr, byval __policy as long ptr) as long
declare function pthread_attr_setschedpolicy(byval __attr as pthread_attr_t ptr, byval __policy as long) as long
declare function pthread_attr_getinheritsched(byval __attr as const pthread_attr_t ptr, byval __inherit as long ptr) as long
declare function pthread_attr_setinheritsched(byval __attr as pthread_attr_t ptr, byval __inherit as long) as long
declare function pthread_attr_getscope(byval __attr as const pthread_attr_t ptr, byval __scope as long ptr) as long
declare function pthread_attr_setscope(byval __attr as pthread_attr_t ptr, byval __scope as long) as long
declare function pthread_attr_getstackaddr(byval __attr as const pthread_attr_t ptr, byval __stackaddr as any ptr ptr) as long
declare function pthread_attr_setstackaddr(byval __attr as pthread_attr_t ptr, byval __stackaddr as any ptr) as long
declare function pthread_attr_getstacksize(byval __attr as const pthread_attr_t ptr, byval __stacksize as uinteger ptr) as long
declare function pthread_attr_setstacksize(byval __attr as pthread_attr_t ptr, byval __stacksize as uinteger) as long
declare function pthread_attr_getstack(byval __attr as const pthread_attr_t ptr, byval __stackaddr as any ptr ptr, byval __stacksize as uinteger ptr) as long
declare function pthread_attr_setstack(byval __attr as pthread_attr_t ptr, byval __stackaddr as any ptr, byval __stacksize as uinteger) as long
declare function pthread_attr_setaffinity_np(byval __attr as pthread_attr_t ptr, byval __cpusetsize as uinteger, byval __cpuset as const cpu_set_t ptr) as long
declare function pthread_attr_getaffinity_np(byval __attr as const pthread_attr_t ptr, byval __cpusetsize as uinteger, byval __cpuset as cpu_set_t ptr) as long
declare function pthread_getattr_default_np(byval __attr as pthread_attr_t ptr) as long
declare function pthread_setattr_default_np(byval __attr as const pthread_attr_t ptr) as long
declare function pthread_getattr_np(byval __th as pthread_t, byval __attr as pthread_attr_t ptr) as long
declare function pthread_setschedparam(byval __target_thread as pthread_t, byval __policy as long, byval __param as const sched_param ptr) as long
declare function pthread_getschedparam(byval __target_thread as pthread_t, byval __policy as long ptr, byval __param as sched_param ptr) as long
declare function pthread_setschedprio(byval __target_thread as pthread_t, byval __prio as long) as long
declare function pthread_getname_np(byval __target_thread as pthread_t, byval __buf as zstring ptr, byval __buflen as uinteger) as long
declare function pthread_setname_np(byval __target_thread as pthread_t, byval __name as const zstring ptr) as long
declare function pthread_getconcurrency() as long
declare function pthread_setconcurrency(byval __level as long) as long
declare function pthread_yield() as long
declare function pthread_setaffinity_np(byval __th as pthread_t, byval __cpusetsize as uinteger, byval __cpuset as const cpu_set_t ptr) as long
declare function pthread_getaffinity_np(byval __th as pthread_t, byval __cpusetsize as uinteger, byval __cpuset as cpu_set_t ptr) as long
declare function pthread_once(byval __once_control as pthread_once_t ptr, byval __init_routine as sub()) as long
declare function pthread_setcancelstate(byval __state as long, byval __oldstate as long ptr) as long
declare function pthread_setcanceltype(byval __type as long, byval __oldtype as long ptr) as long
declare function pthread_cancel(byval __th as pthread_t) as long
declare sub pthread_testcancel()

type __pthread_unwind_buf_t___cancel_jmp_buf
	#if (not defined(__FB_64BIT__)) and (not defined(__FB_ARM__))
		__cancel_jmp_buf(0 to 5) as long
	#elseif defined(__FB_64BIT__) and (not defined(__FB_ARM__))
		__cancel_jmp_buf(0 to 7) as clong
	#elseif (not defined(__FB_64BIT__)) and defined(__FB_ARM__)
		__cancel_jmp_buf(0 to 63) as long
	#else
		__cancel_jmp_buf(0 to 21) as ulongint
	#endif

	__mask_was_saved as long
end type

type __pthread_unwind_buf_t
	__cancel_jmp_buf(0 to 0) as __pthread_unwind_buf_t___cancel_jmp_buf
	__pad(0 to 3) as any ptr
end type

type __pthread_cleanup_frame
	__cancel_routine as sub(byval as any ptr)
	__cancel_arg as any ptr
	__do_it as long
	__cancel_type as long
end type

#if defined(__FB_64BIT__) or defined(__FB_ARM__)
	declare sub __pthread_register_cancel(byval __buf as __pthread_unwind_buf_t ptr)
	declare sub __pthread_unregister_cancel(byval __buf as __pthread_unwind_buf_t ptr)
	declare sub __pthread_register_cancel_defer(byval __buf as __pthread_unwind_buf_t ptr)
	declare sub __pthread_unregister_cancel_restore(byval __buf as __pthread_unwind_buf_t ptr)
#endif

declare function pthread_mutex_init(byval __mutex as pthread_mutex_t ptr, byval __mutexattr as const pthread_mutexattr_t ptr) as long
declare function pthread_mutex_destroy(byval __mutex as pthread_mutex_t ptr) as long
declare function pthread_mutex_trylock(byval __mutex as pthread_mutex_t ptr) as long
declare function pthread_mutex_lock(byval __mutex as pthread_mutex_t ptr) as long
declare function pthread_mutex_timedlock(byval __mutex as pthread_mutex_t ptr, byval __abstime as const timespec ptr) as long
declare function pthread_mutex_unlock(byval __mutex as pthread_mutex_t ptr) as long
declare function pthread_mutex_getprioceiling(byval __mutex as const pthread_mutex_t ptr, byval __prioceiling as long ptr) as long
declare function pthread_mutex_setprioceiling(byval __mutex as pthread_mutex_t ptr, byval __prioceiling as long, byval __old_ceiling as long ptr) as long
declare function pthread_mutex_consistent(byval __mutex as pthread_mutex_t ptr) as long
declare function pthread_mutex_consistent_np(byval __mutex as pthread_mutex_t ptr) as long
declare function pthread_mutexattr_init(byval __attr as pthread_mutexattr_t ptr) as long
declare function pthread_mutexattr_destroy(byval __attr as pthread_mutexattr_t ptr) as long
declare function pthread_mutexattr_getpshared(byval __attr as const pthread_mutexattr_t ptr, byval __pshared as long ptr) as long
declare function pthread_mutexattr_setpshared(byval __attr as pthread_mutexattr_t ptr, byval __pshared as long) as long
declare function pthread_mutexattr_gettype(byval __attr as const pthread_mutexattr_t ptr, byval __kind as long ptr) as long
declare function pthread_mutexattr_settype(byval __attr as pthread_mutexattr_t ptr, byval __kind as long) as long
declare function pthread_mutexattr_getprotocol(byval __attr as const pthread_mutexattr_t ptr, byval __protocol as long ptr) as long
declare function pthread_mutexattr_setprotocol(byval __attr as pthread_mutexattr_t ptr, byval __protocol as long) as long
declare function pthread_mutexattr_getprioceiling(byval __attr as const pthread_mutexattr_t ptr, byval __prioceiling as long ptr) as long
declare function pthread_mutexattr_setprioceiling(byval __attr as pthread_mutexattr_t ptr, byval __prioceiling as long) as long
declare function pthread_mutexattr_getrobust(byval __attr as const pthread_mutexattr_t ptr, byval __robustness as long ptr) as long
declare function pthread_mutexattr_getrobust_np(byval __attr as const pthread_mutexattr_t ptr, byval __robustness as long ptr) as long
declare function pthread_mutexattr_setrobust(byval __attr as pthread_mutexattr_t ptr, byval __robustness as long) as long
declare function pthread_mutexattr_setrobust_np(byval __attr as pthread_mutexattr_t ptr, byval __robustness as long) as long
declare function pthread_rwlock_init(byval __rwlock as pthread_rwlock_t ptr, byval __attr as const pthread_rwlockattr_t ptr) as long
declare function pthread_rwlock_destroy(byval __rwlock as pthread_rwlock_t ptr) as long
declare function pthread_rwlock_rdlock(byval __rwlock as pthread_rwlock_t ptr) as long
declare function pthread_rwlock_tryrdlock(byval __rwlock as pthread_rwlock_t ptr) as long
declare function pthread_rwlock_timedrdlock(byval __rwlock as pthread_rwlock_t ptr, byval __abstime as const timespec ptr) as long
declare function pthread_rwlock_wrlock(byval __rwlock as pthread_rwlock_t ptr) as long
declare function pthread_rwlock_trywrlock(byval __rwlock as pthread_rwlock_t ptr) as long
declare function pthread_rwlock_timedwrlock(byval __rwlock as pthread_rwlock_t ptr, byval __abstime as const timespec ptr) as long
declare function pthread_rwlock_unlock(byval __rwlock as pthread_rwlock_t ptr) as long
declare function pthread_rwlockattr_init(byval __attr as pthread_rwlockattr_t ptr) as long
declare function pthread_rwlockattr_destroy(byval __attr as pthread_rwlockattr_t ptr) as long
declare function pthread_rwlockattr_getpshared(byval __attr as const pthread_rwlockattr_t ptr, byval __pshared as long ptr) as long
declare function pthread_rwlockattr_setpshared(byval __attr as pthread_rwlockattr_t ptr, byval __pshared as long) as long
declare function pthread_rwlockattr_getkind_np(byval __attr as const pthread_rwlockattr_t ptr, byval __pref as long ptr) as long
declare function pthread_rwlockattr_setkind_np(byval __attr as pthread_rwlockattr_t ptr, byval __pref as long) as long
declare function pthread_cond_init(byval __cond as pthread_cond_t ptr, byval __cond_attr as const pthread_condattr_t ptr) as long
declare function pthread_cond_destroy(byval __cond as pthread_cond_t ptr) as long
declare function pthread_cond_signal(byval __cond as pthread_cond_t ptr) as long
declare function pthread_cond_broadcast(byval __cond as pthread_cond_t ptr) as long
declare function pthread_cond_wait(byval __cond as pthread_cond_t ptr, byval __mutex as pthread_mutex_t ptr) as long
declare function pthread_cond_timedwait(byval __cond as pthread_cond_t ptr, byval __mutex as pthread_mutex_t ptr, byval __abstime as const timespec ptr) as long
declare function pthread_condattr_init(byval __attr as pthread_condattr_t ptr) as long
declare function pthread_condattr_destroy(byval __attr as pthread_condattr_t ptr) as long
declare function pthread_condattr_getpshared(byval __attr as const pthread_condattr_t ptr, byval __pshared as long ptr) as long
declare function pthread_condattr_setpshared(byval __attr as pthread_condattr_t ptr, byval __pshared as long) as long
declare function pthread_condattr_getclock(byval __attr as const pthread_condattr_t ptr, byval __clock_id as __clockid_t ptr) as long
declare function pthread_condattr_setclock(byval __attr as pthread_condattr_t ptr, byval __clock_id as __clockid_t) as long
declare function pthread_spin_init(byval __lock as pthread_spinlock_t ptr, byval __pshared as long) as long
declare function pthread_spin_destroy(byval __lock as pthread_spinlock_t ptr) as long
declare function pthread_spin_lock(byval __lock as pthread_spinlock_t ptr) as long
declare function pthread_spin_trylock(byval __lock as pthread_spinlock_t ptr) as long
declare function pthread_spin_unlock(byval __lock as pthread_spinlock_t ptr) as long
declare function pthread_barrier_init(byval __barrier as pthread_barrier_t ptr, byval __attr as const pthread_barrierattr_t ptr, byval __count as ulong) as long
declare function pthread_barrier_destroy(byval __barrier as pthread_barrier_t ptr) as long
declare function pthread_barrier_wait(byval __barrier as pthread_barrier_t ptr) as long
declare function pthread_barrierattr_init(byval __attr as pthread_barrierattr_t ptr) as long
declare function pthread_barrierattr_destroy(byval __attr as pthread_barrierattr_t ptr) as long
declare function pthread_barrierattr_getpshared(byval __attr as const pthread_barrierattr_t ptr, byval __pshared as long ptr) as long
declare function pthread_barrierattr_setpshared(byval __attr as pthread_barrierattr_t ptr, byval __pshared as long) as long
declare function pthread_key_create(byval __key as pthread_key_t ptr, byval __destr_function as sub(byval as any ptr)) as long
declare function pthread_key_delete(byval __key as pthread_key_t) as long
declare function pthread_getspecific(byval __key as pthread_key_t) as any ptr
declare function pthread_setspecific(byval __key as pthread_key_t, byval __pointer as const any ptr) as long
declare function pthread_getcpuclockid(byval __thread_id as pthread_t, byval __clock_id as __clockid_t ptr) as long
declare function pthread_atfork(byval __prepare as sub(), byval __parent as sub(), byval __child as sub()) as long

end extern
