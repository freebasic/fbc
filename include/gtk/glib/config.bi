''
''
'' glibconfig -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __glibconfig_bi__
#define __glibconfig_bi__

#include once "gmacros.bi"

type gint8 as byte
type guint8 as ubyte
type gint16 as short
type guint16 as ushort

#define G_GINT16_MODIFIER "h"
#define G_GINT16_FORMAT "hi"
#define G_GUINT16_FORMAT "hu"

type gint32 as integer
type guint32 as uinteger

#define G_GINT32_MODIFIER ""
#define G_GINT32_FORMAT "i"
#define G_GUINT32_FORMAT "u"
#define G_HAVE_GINT64 1

type gint64 as longint
type guint64 as ulongint

#define G_GINT64_MODIFIER "I64"
#define G_GINT64_FORMAT "I64i"
#define G_GUINT64_FORMAT "I64u"
#define GLIB_SIZEOF_VOID_P 4
#define GLIB_SIZEOF_LONG 4
#define GLIB_SIZEOF_integer 4

type gssize as integer
type gsize as uinteger

#define G_GSIZE_MODIFIER ""
#define G_GSSIZE_FORMAT "i"
#define G_GSIZE_FORMAT "u"
#define GLIB_MAJOR_VERSION 2
#define GLIB_MINOR_VERSION 6
#define GLIB_MICRO_VERSION 1
#define G_HAVE_INLINE 1
#define G_HAVE___INLINE 1
#define G_HAVE___INLINE__ 1
#define G_HAVE_ISO_VARARGS 1
#define G_HAVE_GNUC_VARARGS 1
#define G_HAVE_GROWING_STACK 0

type GStaticMutex as _GMutex ptr
type GSystemThread as _GSystemThread

union _GSystemThread
	data as zstring * 4
	dummy_double as double
	dummy_pointer as any ptr
	dummy_long as integer
end union

#define G_MODULE_SUFFIX "dll"

type GPid as any ptr

#endif
