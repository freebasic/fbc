'' FreeBASIC binding for glibc-2.21

#pragma once

#ifndef __FB_UNIX__
	#error "target not supported; this header is for GNU/Linux glibc"
#endif

#include once "crt/long.bi"
#include once "crt/bits/wordsize.bi"

const _BITS_PTHREADTYPES_H = 1

#ifdef __FB_64BIT__
	const __SIZEOF_PTHREAD_ATTR_T = 56
	const __SIZEOF_PTHREAD_MUTEX_T = 40
#else
	const __SIZEOF_PTHREAD_ATTR_T = 36
	const __SIZEOF_PTHREAD_MUTEX_T = 24
#endif

const __SIZEOF_PTHREAD_MUTEXATTR_T = 4
const __SIZEOF_PTHREAD_COND_T = 48
const __SIZEOF_PTHREAD_CONDATTR_T = 4

#ifdef __FB_64BIT__
	const __SIZEOF_PTHREAD_RWLOCK_T = 56
#else
	const __SIZEOF_PTHREAD_RWLOCK_T = 32
#endif

const __SIZEOF_PTHREAD_RWLOCKATTR_T = 8

#ifdef __FB_64BIT__
	const __SIZEOF_PTHREAD_BARRIER_T = 32
#else
	const __SIZEOF_PTHREAD_BARRIER_T = 20
#endif

const __SIZEOF_PTHREAD_BARRIERATTR_T = 4
type pthread_t as culong

union pthread_attr_t
	#ifdef __FB_64BIT__
		__size as zstring * 56
	#else
		__size as zstring * 36
	#endif

	__align as clong
end union

const __have_pthread_attr_t = 1

#ifdef __FB_64BIT__
	type __pthread_internal_list
		__prev as __pthread_internal_list ptr
		__next as __pthread_internal_list ptr
	end type

	type __pthread_list_t as __pthread_internal_list
#else
	type __pthread_internal_slist
		__next as __pthread_internal_slist ptr
	end type

	type __pthread_slist_t as __pthread_internal_slist

	type pthread_mutex_t___pthread_mutex_s___elision_data
		__espins as short
		__elision as short
	end type
#endif

type __pthread_mutex_s
	__lock as long
	__count as ulong
	__owner as long

	#ifndef __FB_64BIT__
		__kind as long
	#endif

	__nusers as ulong

	#ifdef __FB_64BIT__
		__kind as long
		__spins as short
		__elision as short
		__list as __pthread_list_t
	#else
		union
			__elision_data as pthread_mutex_t___pthread_mutex_s___elision_data
			__list as __pthread_slist_t
		end union
	#endif
end type

union pthread_mutex_t
	__data as __pthread_mutex_s

	#ifdef __FB_64BIT__
		__size as zstring * 40
	#else
		__size as zstring * 24
	#endif

	__align as clong
end union

#ifdef __FB_64BIT__
	const __PTHREAD_MUTEX_HAVE_PREV = 1
	#define __PTHREAD_SPINS '' TODO: 0, 0
#else
	#define __spins __elision_data.__espins
	#define __elision __elision_data.__elision
	#define __PTHREAD_SPINS (0, 0)
#endif

union pthread_mutexattr_t
	__size as zstring * 4
	__align as long
end union

type pthread_cond_t___data
	__lock as long
	__futex as ulong
	__total_seq as ulongint
	__wakeup_seq as ulongint
	__woken_seq as ulongint
	__mutex as any ptr
	__nwaiters as ulong
	__broadcast_seq as ulong
end type

union pthread_cond_t
	__data as pthread_cond_t___data
	__size as zstring * 48
	__align as longint
end union

union pthread_condattr_t
	__size as zstring * 4
	__align as long
end union

type pthread_key_t as ulong
type pthread_once_t as long

type pthread_rwlock_t___data
	__lock as long
	__nr_readers as ulong
	__readers_wakeup as ulong
	__writer_wakeup as ulong
	__nr_readers_queued as ulong
	__nr_writers_queued as ulong

	#ifndef __FB_64BIT__
		__flags as ubyte
		__shared as ubyte
		__rwelision as byte
		__pad2 as ubyte
	#endif

	__writer as long

	#ifdef __FB_64BIT__
		__shared as long
		__rwelision as byte
		__pad1(0 to 6) as ubyte
		__pad2 as culong
		__flags as ulong
	#endif
end type

union pthread_rwlock_t
	__data as pthread_rwlock_t___data

	#ifdef __FB_64BIT__
		__size as zstring * 56
	#else
		__size as zstring * 32
	#endif

	__align as clong
end union

#ifdef __FB_64BIT__
	#define __PTHREAD_RWLOCK_ELISION_EXTRA '' TODO: 0, { 0, 0, 0, 0, 0, 0, 0 }
	const __PTHREAD_RWLOCK_INT_FLAGS_SHARED = 1
#else
	const __PTHREAD_RWLOCK_ELISION_EXTRA = 0
#endif

union pthread_rwlockattr_t
	__size as zstring * 8
	__align as clong
end union

type pthread_spinlock_t as long

union pthread_barrier_t
	#ifdef __FB_64BIT__
		__size as zstring * 32
	#else
		__size as zstring * 20
	#endif

	__align as clong
end union

union pthread_barrierattr_t
	__size as zstring * 4
	__align as long
end union
