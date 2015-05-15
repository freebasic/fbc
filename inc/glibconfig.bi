'' FreeBASIC binding for glib-2.42.2
''
'' based on the C header files:
''   GLIB - Library of useful routines for C programming
''   Copyright (C) 1995-1997  Peter Mattis, Spencer Kimball and Josh MacDonald
''
''   This library is free software; you can redistribute it and/or
''   modify it under the terms of the GNU Lesser General Public
''   License as published by the Free Software Foundation; either
''   version 2 of the License, or (at your option) any later version.
''
''   This library is distributed in the hope that it will be useful,
''   but WITHOUT ANY WARRANTY; without even the implied warranty of
''   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the GNU
''   Lesser General Public License for more details.
''
''   You should have received a copy of the GNU Lesser General Public
''   License along with this library; if not, see <http://www.gnu.org/licenses/>.
''
'' translated to FreeBASIC by:
''   (C) 2011, 2012 Thomas[ dot ]Freiherr[ at ]gmx[ dot ]net
''   Copyright © 2015 FreeBASIC development team

#pragma once

#if defined(__FB_LINUX__) and defined(__FB_64BIT__)
	#include once "crt/long.bi"
#endif

#include once "crt/limits.bi"

#define __GLIBCONFIG_H__
#define GLIB_HAVE_ALLOCA_H
#define GLIB_USING_SYSTEM_PRINTF
#define G_MINFLOAT FLT_MIN
#define G_MAXFLOAT FLT_MAX
#define G_MINDOUBLE DBL_MIN
#define G_MAXDOUBLE DBL_MAX
#define G_MINSHORT SHRT_MIN
#define G_MAXSHORT SHRT_MAX
#define G_MAXUSHORT USHRT_MAX
#define G_MININT INT_MIN
#define G_MAXINT INT_MAX
#define G_MAXUINT UINT_MAX
#define G_MINLONG LONG_MIN
#define G_MAXLONG LONG_MAX
#define G_MAXULONG ULONG_MAX

type gint8 as byte
type guint8 as ubyte
type gint16 as short
type guint16 as ushort

#define G_GINT16_MODIFIER "h"
#define G_GINT16_FORMAT "hi"
#define G_GUINT16_FORMAT "hu"
type gint32 as long
type guint32 as ulong
#define G_GINT32_MODIFIER ""
#define G_GINT32_FORMAT "i"
#define G_GUINT32_FORMAT "u"
const G_HAVE_GINT64 = 1

#if (defined(__FB_LINUX__) and (not defined(__FB_64BIT__))) or defined(__FB_WIN32__)
	type gint64 as longint
	type guint64 as ulongint
	#define G_GINT64_CONSTANT(val) val##LL
	#define G_GUINT64_CONSTANT(val) val##ULL
#endif

#ifdef __FB_WIN32__
	#define G_GINT64_MODIFIER "I64"
	#define G_GINT64_FORMAT "I64i"
	#define G_GUINT64_FORMAT "I64u"
#elseif defined(__FB_LINUX__) and defined(__FB_64BIT__)
	type gint64 as clong
	type guint64 as culong
	#define G_GINT64_CONSTANT(val) val##L
	#define G_GUINT64_CONSTANT(val) val##UL
	#define G_GINT64_MODIFIER "l"
	#define G_GINT64_FORMAT "li"
	#define G_GUINT64_FORMAT "lu"
#endif

#ifdef __FB_64BIT__
	const GLIB_SIZEOF_VOID_P = 8
#elseif defined(__FB_LINUX__) and (not defined(__FB_64BIT__))
	#define G_GINT64_MODIFIER "ll"
	#define G_GINT64_FORMAT "lli"
	#define G_GUINT64_FORMAT "llu"
#endif

#ifndef __FB_64BIT__
	const GLIB_SIZEOF_VOID_P = 4
#endif

#if (defined(__FB_LINUX__) and (not defined(__FB_64BIT__))) or defined(__FB_WIN32__)
	const GLIB_SIZEOF_LONG = 4
#else
	const GLIB_SIZEOF_LONG = 8
#endif

#ifdef __FB_64BIT__
	const GLIB_SIZEOF_SIZE_T = 8
#endif

#if defined(__FB_WIN32__) and defined(__FB_64BIT__)
	type gssize as longint
	type gsize as ulongint
	#define G_GSIZE_MODIFIER "I64"
	#define G_GSSIZE_MODIFIER "I64"
	#define G_GSIZE_FORMAT "I64u"
	#define G_GSSIZE_FORMAT "I64d"
	#define G_MAXSIZE G_MAXUINT64
	#define G_MINSSIZE G_MININT64
	#define G_MAXSSIZE G_MAXINT64
#elseif not defined(__FB_64BIT__)
	const GLIB_SIZEOF_SIZE_T = 4
#endif

#if defined(__FB_LINUX__) and (not defined(__FB_64BIT__))
	const GLIB_SIZEOF_SSIZE_T = 4
#endif

#ifndef __FB_64BIT__
	type gssize as long
	type gsize as ulong
	#define G_GSIZE_MODIFIER ""
	#define G_GSSIZE_MODIFIER ""
	#define G_GSIZE_FORMAT "u"
	#define G_GSSIZE_FORMAT "i"
	#define G_MAXSIZE G_MAXUINT
	#define G_MINSSIZE G_MININT
	#define G_MAXSSIZE G_MAXINT
#elseif defined(__FB_LINUX__) and defined(__FB_64BIT__)
	const GLIB_SIZEOF_SSIZE_T = 8
	type gssize as clong
	type gsize as culong
	#define G_GSIZE_MODIFIER "l"
	#define G_GSSIZE_MODIFIER "l"
	#define G_GSIZE_FORMAT "lu"
	#define G_GSSIZE_FORMAT "li"
	#define G_MAXSIZE G_MAXULONG
	#define G_MINSSIZE G_MINLONG
	#define G_MAXSSIZE G_MAXLONG
#endif

type goffset as gint64
#define G_MINOFFSET G_MININT64
#define G_MAXOFFSET G_MAXINT64
#define G_GOFFSET_MODIFIER G_GINT64_MODIFIER
#define G_GOFFSET_FORMAT G_GINT64_FORMAT
#define G_GOFFSET_CONSTANT(val) G_GINT64_CONSTANT(val)

#if defined(__FB_WIN32__) and defined(__FB_64BIT__)
	#define GPOINTER_TO_INT(p) cast(gint, cast(gint64, (p)))
	#define GPOINTER_TO_UINT(p) cast(guint, cast(guint64, (p)))
	#define GINT_TO_POINTER(i) cast(gpointer, cast(gint64, (i)))
	#define GUINT_TO_POINTER(u) cast(gpointer, cast(guint64, (u)))
	type gintptr as longint
	type guintptr as ulongint
	#define G_GINTPTR_MODIFIER "I64"
	#define G_GINTPTR_FORMAT "I64i"
	#define G_GUINTPTR_FORMAT "I64u"
#elseif defined(__FB_WIN32__) and (not defined(__FB_64BIT__))
	#define GPOINTER_TO_INT(p) cast(gint, (p))
	#define GPOINTER_TO_UINT(p) cast(guint, (p))
	#define GINT_TO_POINTER(i) cast(gpointer, (i))
	#define GUINT_TO_POINTER(u) cast(gpointer, (u))
#elseif defined(__FB_LINUX__) and (not defined(__FB_64BIT__))
	#define GPOINTER_TO_INT(p) cast(gint, cast(gint, (p)))
	#define GPOINTER_TO_UINT(p) cast(guint, cast(guint, (p)))
	#define GINT_TO_POINTER(i) cast(gpointer, cast(gint, (i)))
	#define GUINT_TO_POINTER(u) cast(gpointer, cast(guint, (u)))
#endif

#ifndef __FB_64BIT__
	type gintptr as long
	type guintptr as ulong
	#define G_GINTPTR_MODIFIER ""
	#define G_GINTPTR_FORMAT "i"
	#define G_GUINTPTR_FORMAT "u"
#elseif defined(__FB_LINUX__) and defined(__FB_64BIT__)
	#define GPOINTER_TO_INT(p) cast(gint, cast(glong, (p)))
	#define GPOINTER_TO_UINT(p) cast(guint, cast(gulong, (p)))
	#define GINT_TO_POINTER(i) cast(gpointer, cast(glong, (i)))
	#define GUINT_TO_POINTER(u) cast(gpointer, cast(gulong, (u)))
	type gintptr as clong
	type guintptr as culong
	#define G_GINTPTR_MODIFIER "l"
	#define G_GINTPTR_FORMAT "li"
	#define G_GUINTPTR_FORMAT "lu"
#endif

#define g_memmove(dest, src, len) memmove((dest), (src), (len))
const GLIB_MAJOR_VERSION = 2
const GLIB_MINOR_VERSION = 42
const GLIB_MICRO_VERSION = 2

#ifdef __FB_WIN32__
	#define G_OS_WIN32
	#define G_PLATFORM_WIN32
#else
	#define G_OS_UNIX
#endif

#define G_VA_COPY va_copy

#if defined(__FB_LINUX__) and defined(__FB_64BIT__)
	const G_VA_COPY_AS_ARRAY = 1
#endif

const G_HAVE_ISO_VARARGS = 1
const G_HAVE_GNUC_VARARGS = 1
const G_HAVE_GROWING_STACK = 0

#ifdef __FB_WIN32__
	#define G_GNUC_INTERNAL
#else
	const G_HAVE_GNUC_VISIBILITY = 1
#endif

#define G_THREADS_ENABLED

#ifdef __FB_WIN32__
	#define G_THREADS_IMPL_WIN32
#else
	#define G_THREADS_IMPL_POSIX
#endif

#define G_ATOMIC_LOCK_FREE
#define GINT16_TO_LE(val) cast(gint16, (val))
#define GUINT16_TO_LE(val) cast(guint16, (val))
#define GINT16_TO_BE(val) cast(gint16, GUINT16_SWAP_LE_BE(val))
#define GUINT16_TO_BE(val) GUINT16_SWAP_LE_BE(val)
#define GINT32_TO_LE(val) cast(gint32, (val))
#define GUINT32_TO_LE(val) cast(guint32, (val))
#define GINT32_TO_BE(val) cast(gint32, GUINT32_SWAP_LE_BE(val))
#define GUINT32_TO_BE(val) GUINT32_SWAP_LE_BE(val)
#define GINT64_TO_LE(val) cast(gint64, (val))
#define GUINT64_TO_LE(val) cast(guint64, (val))
#define GINT64_TO_BE(val) cast(gint64, GUINT64_SWAP_LE_BE(val))
#define GUINT64_TO_BE(val) GUINT64_SWAP_LE_BE(val)

#if (defined(__FB_LINUX__) and (not defined(__FB_64BIT__))) or defined(__FB_WIN32__)
	#define GLONG_TO_LE(val) cast(glong, GINT32_TO_LE(val))
	#define GULONG_TO_LE(val) cast(gulong, GUINT32_TO_LE(val))
	#define GLONG_TO_BE(val) cast(glong, GINT32_TO_BE(val))
	#define GULONG_TO_BE(val) cast(gulong, GUINT32_TO_BE(val))
#else
	#define GLONG_TO_LE(val) cast(glong, GINT64_TO_LE(val))
	#define GULONG_TO_LE(val) cast(gulong, GUINT64_TO_LE(val))
	#define GLONG_TO_BE(val) cast(glong, GINT64_TO_BE(val))
	#define GULONG_TO_BE(val) cast(gulong, GUINT64_TO_BE(val))
#endif

#define GINT_TO_LE(val) cast(gint, GINT32_TO_LE(val))
#define GUINT_TO_LE(val) cast(guint, GUINT32_TO_LE(val))
#define GINT_TO_BE(val) cast(gint, GINT32_TO_BE(val))
#define GUINT_TO_BE(val) cast(guint, GUINT32_TO_BE(val))

#ifdef __FB_64BIT__
	#define GSIZE_TO_LE(val) cast(gsize, GUINT64_TO_LE(val))
	#define GSSIZE_TO_LE(val) cast(gssize, GINT64_TO_LE(val))
	#define GSIZE_TO_BE(val) cast(gsize, GUINT64_TO_BE(val))
	#define GSSIZE_TO_BE(val) cast(gssize, GINT64_TO_BE(val))
#else
	#define GSIZE_TO_LE(val) cast(gsize, GUINT32_TO_LE(val))
	#define GSSIZE_TO_LE(val) cast(gssize, GINT32_TO_LE(val))
	#define GSIZE_TO_BE(val) cast(gsize, GUINT32_TO_BE(val))
	#define GSSIZE_TO_BE(val) cast(gssize, GINT32_TO_BE(val))
#endif

#define G_BYTE_ORDER G_LITTLE_ENDIAN
#define GLIB_SYSDEF_POLLIN =1
#define GLIB_SYSDEF_POLLOUT =4
#define GLIB_SYSDEF_POLLPRI =2
#define GLIB_SYSDEF_POLLHUP =16
#define GLIB_SYSDEF_POLLERR =8
#define GLIB_SYSDEF_POLLNVAL =32

#ifdef __FB_WIN32__
	#define G_MODULE_SUFFIX "dll"
	type GPid as any ptr
#else
	#define G_MODULE_SUFFIX "so"
	type GPid as long
#endif

const GLIB_SYSDEF_AF_UNIX = 1
const GLIB_SYSDEF_AF_INET = 2

#ifdef __FB_WIN32__
	const GLIB_SYSDEF_AF_INET6 = 23
#else
	const GLIB_SYSDEF_AF_INET6 = 10
#endif

const GLIB_SYSDEF_MSG_OOB = 1
const GLIB_SYSDEF_MSG_PEEK = 2
const GLIB_SYSDEF_MSG_DONTROUTE = 4
