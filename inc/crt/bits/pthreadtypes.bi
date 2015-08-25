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

#include once "crt/long.bi"
#include once "crt/bits/wordsize.bi"

const _BITS_PTHREADTYPES_H = 1

#ifndef __FB_64BIT__
	const __SIZEOF_PTHREAD_ATTR_T = 36
	const __SIZEOF_PTHREAD_MUTEX_T = 24
#elseif defined(__FB_64BIT__) and (not defined(__FB_ARM__))
	const __SIZEOF_PTHREAD_ATTR_T = 56
	const __SIZEOF_PTHREAD_MUTEX_T = 40
#endif

#if defined(__FB_64BIT__) and defined(__FB_ARM__)
	const __SIZEOF_PTHREAD_ATTR_T = 64
	const __SIZEOF_PTHREAD_MUTEX_T = 48
	const __SIZEOF_PTHREAD_MUTEXATTR_T = 8
#else
	const __SIZEOF_PTHREAD_MUTEXATTR_T = 4
#endif

const __SIZEOF_PTHREAD_COND_T = 48

#if (not defined(__FB_64BIT__)) and defined(__FB_ARM__)
	const __SIZEOF_PTHREAD_COND_COMPAT_T = 12
#endif

#if (defined(__FB_64BIT__) and (not defined(__FB_ARM__))) or (not defined(__FB_64BIT__))
	const __SIZEOF_PTHREAD_CONDATTR_T = 4
#endif

#ifndef __FB_64BIT__
	const __SIZEOF_PTHREAD_RWLOCK_T = 32
#elseif defined(__FB_64BIT__) and defined(__FB_ARM__)
	const __SIZEOF_PTHREAD_COND_COMPAT_T = 48
	const __SIZEOF_PTHREAD_CONDATTR_T = 8
#endif

#ifdef __FB_64BIT__
	const __SIZEOF_PTHREAD_RWLOCK_T = 56
#endif

const __SIZEOF_PTHREAD_RWLOCKATTR_T = 8

#ifdef __FB_64BIT__
	const __SIZEOF_PTHREAD_BARRIER_T = 32
#else
	const __SIZEOF_PTHREAD_BARRIER_T = 20
#endif

#if defined(__FB_64BIT__) and defined(__FB_ARM__)
	const __SIZEOF_PTHREAD_BARRIERATTR_T = 8
#else
	const __SIZEOF_PTHREAD_BARRIERATTR_T = 4
#endif

type pthread_t as culong

union pthread_attr_t
	#ifndef __FB_64BIT__
		__size as zstring * 36
	#elseif defined(__FB_64BIT__) and (not defined(__FB_ARM__))
		__size as zstring * 56
	#else
		__size as zstring * 64
	#endif

	__align as clong
end union

#if (defined(__FB_64BIT__) and (not defined(__FB_ARM__))) or (not defined(__FB_64BIT__))
	const __have_pthread_attr_t = 1
#endif

#ifndef __FB_64BIT__
	type __pthread_internal_slist
		__next as __pthread_internal_slist ptr
	end type

	type __pthread_slist_t as __pthread_internal_slist
#endif

#if (not defined(__FB_64BIT__)) and (not defined(__FB_ARM__))
	type pthread_mutex_t___pthread_mutex_s___elision_data
		__espins as short
		__elision as short
	end type
#elseif defined(__FB_64BIT__) and defined(__FB_ARM__)
	#define __have_pthread_attr_t1
#endif

#ifdef __FB_64BIT__
	type __pthread_internal_list
		__prev as __pthread_internal_list ptr
		__next as __pthread_internal_list ptr
	end type

	type __pthread_list_t as __pthread_internal_list
#endif

type __pthread_mutex_s
	__lock as long
	__count as ulong
	__owner as long

	#ifdef __FB_64BIT__
		__nusers as ulong
	#endif

	__kind as long

	#ifndef __FB_64BIT__
		__nusers as ulong

		union
			#ifndef __FB_64BIT__
				#ifdef __FB_ARM__
					__spins as long
				#else
					__elision_data as pthread_mutex_t___pthread_mutex_s___elision_data
				#endif
			#endif

			__list as __pthread_slist_t
		end union
	#elseif defined(__FB_64BIT__) and (not defined(__FB_ARM__))
		__spins as short
		__elision as short
	#else
		__spins as long
	#endif

	#ifdef __FB_64BIT__
		__list as __pthread_list_t
	#endif
end type

union pthread_mutex_t
	__data as __pthread_mutex_s

	#ifndef __FB_64BIT__
		__size as zstring * 24
	#elseif defined(__FB_64BIT__) and (not defined(__FB_ARM__))
		__size as zstring * 40
	#else
		__size as zstring * 48
	#endif

	__align as clong
end union

#if (not defined(__FB_64BIT__)) and (not defined(__FB_ARM__))
	#define __spins __elision_data.__espins
	#define __elision __elision_data.__elision
	#define __PTHREAD_SPINS (0, 0)
#elseif defined(__FB_64BIT__)
	const __PTHREAD_MUTEX_HAVE_PREV = 1
#endif

#if defined(__FB_64BIT__) and (not defined(__FB_ARM__))
	#define __PTHREAD_SPINS 0, 0
#elseif defined(__FB_ARM__)
	const __PTHREAD_SPINS = 0
#endif

union pthread_mutexattr_t
	#if (defined(__FB_64BIT__) and (not defined(__FB_ARM__))) or (not defined(__FB_64BIT__))
		__size as zstring * 4
	#endif

	#ifndef __FB_ARM__
		__align as long
	#elseif defined(__FB_64BIT__) and defined(__FB_ARM__)
		__size as zstring * 8
	#endif

	#ifdef __FB_ARM__
		__align as clong
	#endif
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

	#if defined(__FB_64BIT__) and defined(__FB_ARM__)
		__align as clong
	#else
		__align as longint
	#endif
end union

union pthread_condattr_t
	#if defined(__FB_64BIT__) and defined(__FB_ARM__)
		__size as zstring * 8
	#else
		__size as zstring * 4
	#endif

	#if (not defined(__FB_64BIT__)) and defined(__FB_ARM__)
		__align as clong
	#else
		__align as long
	#endif
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

	#ifdef __FB_64BIT__
		__writer as long
		__shared as long
	#else
		__flags as ubyte
		__shared as ubyte
	#endif

	#ifndef __FB_ARM__
		__rwelision as byte
	#elseif (not defined(__FB_64BIT__)) and defined(__FB_ARM__)
		__pad1 as ubyte
	#endif

	#ifndef __FB_64BIT__
		__pad2 as ubyte
		__writer as long
	#elseif defined(__FB_64BIT__) and (not defined(__FB_ARM__))
		__pad1(0 to 6) as ubyte
	#else
		__pad1 as culong
	#endif

	#ifdef __FB_64BIT__
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

#if defined(__FB_64BIT__) and (not defined(__FB_ARM__))
	#define __PTHREAD_RWLOCK_ELISION_EXTRA 0, { 0, 0, 0, 0, 0, 0, 0 }
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
	#if defined(__FB_64BIT__) and defined(__FB_ARM__)
		__size as zstring * 8
	#else
		__size as zstring * 4
	#endif

	__align as long
end union
