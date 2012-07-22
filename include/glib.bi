' This is file glib.bi
' (FreeBasic binding for GLib library version 2.31.4)
'
' translated with help of h_2_bi.bas by
' Thomas[ dot ]Freiherr[ at ]gmx[ dot ]net.
'
' Licence:
' (C) 2011 Thomas[ dot ]Freiherr[ at ]gmx[ dot ]net
'
' This library binding is free software; you can redistribute it
' and/or modify it under the terms of the GNU Lesser General Public
' License as published by the Free Software Foundation; either
' version 2 of the License, or (at your option) ANY later version.
'
' This binding is distributed in the hope that it will be useful,
' but WITHOUT ANY WARRANTY; without even the implied warranty of
' MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
' Lesser General Public License for more details, refer to:
' http://www.gnu.org/licenses/lgpl.html
'
'
' Original license text:
'
'/* GLIB - Library of useful routines for C programming
 '* Copyright (C) 1995-1997  Peter Mattis, Spencer Kimball and Josh MacDonald
 '*
 '* This library is free software; you can redistribute it and/or
 '* modify it under the terms of the GNU Lesser General Public
 '* License as published by the Free Software Foundation; either
 '* version 2 of the License, or (at your option) any later version.
 '*
 '* This library is distributed in the hope that it will be useful,
 '* but WITHOUT ANY WARRANTY; without even the implied warranty of
 '* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.   See the GNU
 '* Lesser General Public License for more details.
 '*
 '* You should have received a copy of the GNU Lesser General Public
 '* License along with this library; if not, write to the
 '* Free Software Foundation, Inc., 59 Temple Place - Suite 330,
 '* Boston, MA 02111-1307, USA.
 '*/

'/*
 '* Modified by the GLib Team and others 1997-2000.  See the AUTHORS
 '* file for a list of people on the GLib Team.  See the ChangeLog
 '* files for a list of changes.  These files are distributed with
 '* GLib at ftp://ftp.gtk.org/pub/gtk/.
 '*/

#IFDEF __FB_WIN32__
#PRAGMA push(msbitfields)
#ENDIF

#INCLIB "glib-2.0"


EXTERN "C"

#IFNDEF __G_LIB_H__
#DEFINE __G_LIB_H__
#DEFINE __GLIB_H_INSIDE__

#IFNDEF __G_ALLOCA_H__
#DEFINE __G_ALLOCA_H__

#IFNDEF __G_TYPES_H__
#DEFINE __G_TYPES_H__

#IFNDEF __GLIB_H_INSIDE__
#ERROR "Only <glib.bi> can be included directly."
#ENDIF ' __GLIB_H_INSIDE__

#IFNDEF __G_LIBCONFIG_H__
#DEFINE __G_LIBCONFIG_H__

#INCLUDE ONCE "crt/limits.bi" '__HEADERS__: limits.h

#IF DEFINED(__FB_UNIX__)
#DEFINE GLIB_HAVE_ALLOCA_H
#DEFINE GLIB_HAVE_SYS_POLL_H
#DEFINE GLIB_USING_SYSTEM_PRINTF
#ENDIF

#DEFINE G_MINFLOAT FLT_MIN
#DEFINE G_MAXFLOAT FLT_MAX
#DEFINE G_MINDOUBLE DBL_MIN
#DEFINE G_MAXDOUBLE DBL_MAX
#DEFINE G_MINSHORT SHRT_MIN
#DEFINE G_MAXSHORT SHRT_MAX
#DEFINE G_MAXUSHORT USHRT_MAX
#DEFINE G_MININT INT_MIN
#DEFINE G_MAXINT INT_MAX
#DEFINE G_MAXUINT UINT_MAX
#DEFINE G_MINLONG LONG_MIN
#DEFINE G_MAXLONG LONG_MAX
#DEFINE G_MAXULONG ULONG_MAX

TYPE gint8 AS BYTE
TYPE guint8 AS UBYTE
TYPE gint16 AS SHORT
TYPE guint16 AS USHORT

#DEFINE G_GINT16_MODIFIER !"h"
#DEFINE G_GINT16_FORMAT !"hi"
#DEFINE G_GUINT16_FORMAT !"hu"

TYPE gint32 AS INTEGER
TYPE guint32 AS UINTEGER

#DEFINE G_GINT32_MODIFIER !""
#DEFINE G_GINT32_FORMAT !"i"
#DEFINE G_GUINT32_FORMAT !"u"
#DEFINE G_HAVE_GINT64 1

TYPE gint64 AS LONGINT
TYPE guint64 AS ULONGINT

#DEFINE G_GINT64_CONSTANT(val) (G_GNUC_EXTENSION (val##LL))
#DEFINE G_GUINT64_CONSTANT(val) (G_GNUC_EXTENSION (val##ULL))
#DEFINE G_GINT64_MODIFIER !"ll"
#DEFINE G_GINT64_FORMAT !"lli"
#DEFINE G_GUINT64_FORMAT !"llu"
#DEFINE GLIB_SIZEOF_VOID_P 4
#DEFINE GLIB_SIZEOF_LONG 4
#DEFINE GLIB_SIZEOF_SIZE_T 4

TYPE gssize AS INTEGER
TYPE gsize AS UINTEGER

#DEFINE G_GSIZE_MODIFIER !""
#DEFINE G_GSSIZE_FORMAT !"i"
#DEFINE G_GSIZE_FORMAT !"u"
#DEFINE G_MAXSIZE G_MAXUINT
#DEFINE G_MINSSIZE G_MININT
#DEFINE G_MAXSSIZE G_MAXINT

TYPE goffset AS gint64

#DEFINE G_MINOFFSET G_MININT64
#DEFINE G_MAXOFFSET G_MAXINT64
#DEFINE G_GOFFSET_MODIFIER G_GINT64_MODIFIER
#DEFINE G_GOFFSET_FORMAT G_GINT64_FORMAT
#DEFINE G_GOFFSET_CONSTANT(val) G_GINT64_CONSTANT(val)
#DEFINE GPOINTER_TO_INT(p) CAST(gint, p)
#DEFINE GPOINTER_TO_UINT(p) CAST(guint, p)
#DEFINE GINT_TO_POINTER(i) CAST(gpointer, CAST(gint, i))
#DEFINE GUINT_TO_POINTER(u) CAST(gpointer, CAST(guint, u))

TYPE gintptr AS INTEGER
TYPE guintptr AS UINTEGER

#DEFINE G_GINTPTR_MODIFIER !""
#DEFINE G_GINTPTR_FORMAT !"i"
#DEFINE G_GUINTPTR_FORMAT !"u"

#DEFINE g_ATEXIT(proc) (atexit (proc))

#DEFINE g_memmove(dest,src,len) memmove ((dest), (src), (len))

#DEFINE GLIB_MAJOR_VERSION 2
#DEFINE GLIB_MINOR_VERSION 31
#DEFINE GLIB_MICRO_VERSION 4

#IF DEFINED(__FB_UNIX__)
 #DEFINE G_OS_UNIX
#ELSE
 #DEFINE G_OS_WIN32
 #DEFINE G_PLATFORM_WIN32
#ENDIF

#DEFINE G_VA_COPY va_copy

#IF __FB_VERSION__ >= "0.22"
#DEFINE G_HAVE_GNUC_VARARGS 1
#ENDIF

#DEFINE G_GNUC_INTERNAL
#DEFINE G_THREADS_ENABLED

#IF DEFINED(__FB_UNIX__)
 #DEFINE G_THREADS_IMPL_POSIX
 #DEFINE G_HAVE_GROWING_STACK 1
#ELSE
 #DEFINE G_THREADS_IMPL_WIN32
#ENDIF

#DEFINE G_ATOMIC_LOCK_FREE
#DEFINE GINT16_TO_LE(val) CAST(gint16, (val))
#DEFINE GUINT16_TO_LE(val) CAST(guint16, (val))
#DEFINE GINT16_TO_BE(val) CAST(gint16, GUINT16_SWAP_LE_BE (val))
#DEFINE GUINT16_TO_BE(val) (GUINT16_SWAP_LE_BE (val))
#DEFINE GINT32_TO_LE(val) CAST(gint32, (val))
#DEFINE GUINT32_TO_LE(val) CAST(guint32, (val))
#DEFINE GINT32_TO_BE(val) CAST(gint32, GUINT32_SWAP_LE_BE (val))
#DEFINE GUINT32_TO_BE(val) (GUINT32_SWAP_LE_BE (val))
#DEFINE GINT64_TO_LE(val) CAST(gint64, (val))
#DEFINE GUINT64_TO_LE(val) CAST(guint64, (val))
#DEFINE GINT64_TO_BE(val) CAST(gint64, GUINT64_SWAP_LE_BE (val))
#DEFINE GUINT64_TO_BE(val) (GUINT64_SWAP_LE_BE (val))
#DEFINE GLONG_TO_LE(val) CAST(glong, GINT32_TO_LE (val))
#DEFINE GULONG_TO_LE(val) CAST(gulong, GUINT32_TO_LE (val))
#DEFINE GLONG_TO_BE(val) CAST(glong, GINT32_TO_BE (val))
#DEFINE GULONG_TO_BE(val) CAST(gulong, GUINT32_TO_BE (val))
#DEFINE GINT_TO_LE(val) CAST(gint, GINT32_TO_LE (val))
#DEFINE GUINT_TO_LE(val) CAST(guint, GUINT32_TO_LE (val))
#DEFINE GINT_TO_BE(val) CAST(gint, GINT32_TO_BE (val))
#DEFINE GUINT_TO_BE(val) CAST(guint, GUINT32_TO_BE (val))
#DEFINE GSIZE_TO_LE(val) CAST(gsize, GUINT32_TO_LE (val))
#DEFINE GSSIZE_TO_LE(val) CAST(gssize, GINT32_TO_LE (val))
#DEFINE GSIZE_TO_BE(val) CAST(gsize, GUINT32_TO_BE (val))
#DEFINE GSSIZE_TO_BE(val) CAST(gssize, GINT32_TO_BE (val))
#DEFINE G_BYTE_ORDER G_LITTLE_ENDIAN
#DEFINE GLIB_SYSDEF_POLLIN =1
#DEFINE GLIB_SYSDEF_POLLOUT =4
#DEFINE GLIB_SYSDEF_POLLPRI =2
#DEFINE GLIB_SYSDEF_POLLHUP =16
#DEFINE GLIB_SYSDEF_POLLERR =8
#DEFINE GLIB_SYSDEF_POLLNVAL =32

#IF DEFINED(__FB_UNIX__)
 #DEFINE G_MODULE_SUFFIX !"so"
 #DEFINE GLIB_SYSDEF_AF_INET6 10
#ELSE
 #DEFINE G_MODULE_SUFFIX !"dll"
 #DEFINE GLIB_SYSDEF_AF_INET6 23
#ENDIF

TYPE GPid AS INTEGER

#DEFINE GLIB_SYSDEF_AF_UNIX 1
#DEFINE GLIB_SYSDEF_AF_INET 2
#DEFINE GLIB_SYSDEF_MSG_OOB 1
#DEFINE GLIB_SYSDEF_MSG_PEEK 2
#DEFINE GLIB_SYSDEF_MSG_DONTROUTE 4

#ENDIF ' __G_LIBCONFIG_H__

#IFNDEF __G_MACROS_H__
#DEFINE __G_MACROS_H__
#INCLUDE ONCE "crt/stddef.bi"

#IFNDEF G_DISABLE_DEPRECATED
#DEFINE G_GNUC_FUNCTION __FUNCTION__
#DEFINE G_GNUC_PRETTY_FUNCTION __FUNCTION__
#ENDIF ' G_DISABLE_DEPRECATED

#DEFINE G_STRINGIFY(macro_or_string) G_STRINGIFY_ARG (macro_or_string)
#DEFINE G_STRINGIFY_ARG(contents) #contents

#IFNDEF __GI_SCANNER__
#DEFINE G_PASTE_ARGS(identifier1,identifier2) identifier1 ## identifier2
#DEFINE G_PASTE(identifier1,identifier2) G_PASTE_ARGS (identifier1, identifier2)

#MACRO G_STATIC_ASSERT(expr)
 #IFDEF __COUNTER__
  TYPE G_PASTE (_GStaticAssert_, __COUNTER__)
 #ELSE
  TYPE G_PASTE (_GStaticAssert_, __LINE__)
 #ENDIF ' __COUNTER__
  AS ZSTRING*(IIF((expr) , 1 , -1)) Compile_Time_Assertion
 END TYPE
#ENDMACRO

#DEFINE G_STATIC_ASSERT_EXPR(expr) (CAST(ANY, SIZEOF (charIIF[(expr) , 1 , -1])))
#ENDIF ' __GI_SCANNER__

#DEFINE G_STRLOC __FILE__ !":" G_STRINGIFY (__LINE__) & ":" & __FUNCTION__ & "()"

#DEFINE G_STRFUNC (CAST(CONST ZSTRING PTR, (@__FUNCTION__)))

#IFNDEF NULL
#DEFINE NULL (CAST(ANY PTR, 0))
#ENDIF ' NULL

#IFNDEF FALSE
#DEFINE FALSE (0)
#ENDIF ' FALSE

#IFNDEF TRUE
#DEFINE TRUE (1)
#ENDIF ' TRUE
#UNDEF MAX
#DEFINE MAX(a, b) IIF(((a) > (b)) , (a) , (b))
#UNDEF MIN
#DEFINE MIN(a, b) IIF(((a) < (b)) , (a) , (b))
'#UNDEF ABS
'#DEFINE ABS_(a) IIF(((a) < 0) , -(a) , (a))
#UNDEF CLAMP
#DEFINE CLAMP(x, low, high) IIF(((x) > (high)) , (high) , IIF(((x) < (low)) , (low) , (x)))
#DEFINE G_N_ELEMENTS(arr) (SIZEOF (arr) / SIZEOF ((arr)[0]))
#DEFINE GPOINTER_TO_SIZE(p) (CAST(gsize, (p)))
#DEFINE GSIZE_TO_POINTER(s) (CAST(gpointer, CAST(gsize, (s))))

#DEFINE G_STRUCT_OFFSET(struct_type, member) _
      (CAST(glong, OFFSETOF (struct_type, member)))
#DEFINE G_STRUCT_MEMBER_P(struct_p, struct_offset) _
    (CAST(gpointer, (CAST(guint8 PTR, struct_p, + CAST(glong, struct_offset)))))
#DEFINE G_STRUCT_MEMBER(member_type, struct_p, struct_offset) _
    (*CAST(member_type PTR, G_STRUCT_MEMBER_P ((struct_p), (struct_offset))))

#IF NOT (DEFINED (G_STMT_START) AND DEFINED (G_STMT_END))
#DEFINE G_STMT_START do
#DEFINE G_STMT_END while (0)
#ENDIF ' NOT (DEFINED (G...

#IFNDEF G_DISABLE_DEPRECATED
#IFDEF G_DISABLE_CONST_RETURNS
#DEFINE G_CONST_RETURN
#ELSE ' G_DISABLE_CONST_RETURNS
#DEFINE G_CONST_RETURN const
#ENDIF ' G_DISABLE_CONST_RETURNS
#ENDIF ' G_DISABLE_DEPRECATED

#DEFINE G_LIKELY(expr) (expr)
#DEFINE G_UNLIKELY(expr) (expr)

#DEFINE G_DEPRECATED #PRINT __FUNCTION__ is deprecated
#DEFINE G_DEPRECATED_FOR(f) #PRINT __FUNCTION__ is deprecated. Use #f instead

#IFDEF GLIB_DISABLE_DEPRECATION_WARNINGS
#DEFINE GLIB_DEPRECATED
#DEFINE GLIB_DEPRECATED_FOR(f)
#ELSE ' GLIB_DISABLE_DEPRECATION_WARNINGS
#DEFINE GLIB_DEPRECATED G_DEPRECATED
#DEFINE GLIB_DEPRECATED_FOR(f) G_DEPRECATED_FOR(f)
#ENDIF ' GLIB_DISABLE_DEPRECATION_WARNINGS
#ENDIF ' __G_MACROS_H__

#INCLUDE ONCE "crt/time.bi"

TYPE gchar AS ZSTRING
TYPE gshort AS SHORT
TYPE glong AS INTEGER
TYPE gint AS INTEGER
TYPE gboolean AS gint
TYPE guchar AS UBYTE
TYPE gushort AS USHORT
TYPE gulong AS UINTEGER
TYPE guint AS UINTEGER
TYPE gfloat AS SINGLE
TYPE gdouble AS DOUBLE

#DEFINE G_MININT8 (CAST(gint8, &h80))
#DEFINE G_MAXINT8 (CAST(gint8, &h7F))
#DEFINE G_MAXUINT8 (CAST(guint8, &hFF))
#DEFINE G_MININT16 (CAST(gint16, &h8000))
#DEFINE G_MAXINT16 (CAST(gint16, &h7FFF))
#DEFINE G_MAXUINT16 (CAST(guint16, &hFFFF))
#DEFINE G_MININT32 (CAST(gint32, &h80000000))
#DEFINE G_MAXINT32 (CAST(gint32, &h7FFFFFFF))
#DEFINE G_MAXUINT32 (CAST(guint32, &hFFFFFFFF))
#DEFINE G_MININT64 (CAST(gint64, G_GINT64_CONSTANT(&h8000000000000000)))
#DEFINE G_MAXINT64 G_GINT64_CONSTANT(&h7FFFFFFFFFFFFFFF)
#DEFINE G_MAXUINT64 G_GINT64_CONSTANT(&hFFFFFFFFFFFFFFFFU)

TYPE gpointer AS ANY PTR
TYPE gconstpointer AS CONST ANY PTR
TYPE GCompareFunc AS FUNCTION(BYVAL AS gconstpointer, BYVAL AS gconstpointer) AS gint
TYPE GCompareDataFunc AS FUNCTION(BYVAL AS gconstpointer, BYVAL AS gconstpointer, BYVAL AS gpointer) AS gint
TYPE GEqualFunc AS FUNCTION(BYVAL AS gconstpointer, BYVAL AS gconstpointer) AS gboolean
TYPE GDestroyNotify AS SUB(BYVAL AS gpointer)
TYPE GFunc AS SUB(BYVAL AS gpointer, BYVAL AS gpointer)
TYPE GHashFunc AS FUNCTION(BYVAL AS gconstpointer) AS guint
TYPE GHFunc AS SUB(BYVAL AS gpointer, BYVAL AS gpointer, BYVAL AS gpointer)
TYPE GFreeFunc AS SUB(BYVAL AS gpointer)
TYPE GTranslateFunc AS FUNCTION(BYVAL AS CONST gchar PTR, BYVAL AS gpointer) AS CONST gchar PTR

#DEFINE G_E 2.7182818284590452353602874713526624977572470937000
#DEFINE G_LN2 0.69314718055994530941723212145817656807550013436026
#DEFINE G_LN10 2.3025850929940456840179914546843642076011014886288
#DEFINE G_PI 3.1415926535897932384626433832795028841971693993751
#DEFINE G_PI_2 1.5707963267948966192313216916397514420985846996876
#DEFINE G_PI_4 0.78539816339744830961566084581987572104929234984378
#DEFINE G_SQRT2 1.4142135623730950488016887242096980785696718753769
#DEFINE G_LITTLE_ENDIAN 1234
#DEFINE G_BIG_ENDIAN 4321
#DEFINE G_PDP_ENDIAN 3412

#DEFINE GUINT16_SWAP_LE_BE_CONSTANT(val) (CAST(guint16, ( _
    CAST(guint16, (CAST(guint16, val) SHR 8)) OR _
    CAST(guint16, (CAST(guint16, val) SHL 8)))))
#DEFINE GUINT32_SWAP_LE_BE_CONSTANT(val) (CAST(guint32, ( _
    ((CAST(guint32, val) AND CAST(guint32, &h000000FFU)) SHL 24) OR _
    ((CAST(guint32, val) AND CAST(guint32, &h0000FF00U)) SHL 8) OR _
    ((CAST(guint32, val) AND CAST(guint32, &h00FF0000U)) SHR 8) OR _
    ((CAST(guint32, val) AND CAST(guint32, &hFF000000U)) SHR 24))))
#DEFINE GUINT64_SWAP_LE_BE_CONSTANT(val) (CAST(guint64, ( _
      ((CAST(guint64, val) AND CAST(guint64, G_GINT64_CONSTANT (&h00000000000000FFU))) SHL 56) OR _
      ((CAST(guint64, val) AND CAST(guint64, G_GINT64_CONSTANT (&h000000000000FF00U))) SHL 40) OR _
      ((CAST(guint64, val) AND CAST(guint64, G_GINT64_CONSTANT (&h0000000000FF0000U))) SHL 24) OR _
      ((CAST(guint64, val) AND CAST(guint64, G_GINT64_CONSTANT (&h00000000FF000000U))) SHL 8) OR _
      ((CAST(guint64, val) AND CAST(guint64, G_GINT64_CONSTANT (&h000000FF00000000U))) SHR 8) OR _
      ((CAST(guint64, val) AND CAST(guint64, G_GINT64_CONSTANT (&h0000FF0000000000U))) SHR 24) OR _
      ((CAST(guint64, val) AND CAST(guint64, G_GINT64_CONSTANT (&h00FF000000000000U))) SHR 40) OR _
      ((CAST(guint64, val) AND CAST(guint64, G_GINT64_CONSTANT (&hFF00000000000000U))) SHR 56))))
#DEFINE GUINT16_SWAP_LE_BE(val) (GUINT16_SWAP_LE_BE_CONSTANT (val))
#DEFINE GUINT32_SWAP_LE_BE(val) (GUINT32_SWAP_LE_BE_CONSTANT (val))
#DEFINE GUINT64_SWAP_LE_BE(val) (GUINT64_SWAP_LE_BE_CONSTANT (val))

#DEFINE GUINT16_SWAP_LE_PDP(val) (CAST(guint16, (val)))
#DEFINE GUINT16_SWAP_BE_PDP(val) (GUINT16_SWAP_LE_BE (val))
#DEFINE GUINT32_SWAP_LE_PDP(val) (CAST(guint32, ( _
    ((CAST(guint32, val) AND CAST(guint32, &h0000FFFFU)) SHL 16) OR _
    ((CAST(guint32, val) AND CAST(guint32, &hFFFF0000U)) SHR 16))))
#DEFINE GUINT32_SWAP_BE_PDP(val) (CAST(guint32, ( _
    ((CAST(guint32, val) AND CAST(guint32, &h00FF00FFU)) SHL 8) OR _
    ((CAST(guint32, val) AND CAST(guint32, &hFF00FF00U)) SHR 8))))
#DEFINE GINT16_FROM_LE(val) (GINT16_TO_LE (val))
#DEFINE GUINT16_FROM_LE(val) (GUINT16_TO_LE (val))
#DEFINE GINT16_FROM_BE(val) (GINT16_TO_BE (val))
#DEFINE GUINT16_FROM_BE(val) (GUINT16_TO_BE (val))
#DEFINE GINT32_FROM_LE(val) (GINT32_TO_LE (val))
#DEFINE GUINT32_FROM_LE(val) (GUINT32_TO_LE (val))
#DEFINE GINT32_FROM_BE(val) (GINT32_TO_BE (val))
#DEFINE GUINT32_FROM_BE(val) (GUINT32_TO_BE (val))
#DEFINE GINT64_FROM_LE(val) (GINT64_TO_LE (val))
#DEFINE GUINT64_FROM_LE(val) (GUINT64_TO_LE (val))
#DEFINE GINT64_FROM_BE(val) (GINT64_TO_BE (val))
#DEFINE GUINT64_FROM_BE(val) (GUINT64_TO_BE (val))
#DEFINE GLONG_FROM_LE(val) (GLONG_TO_LE (val))
#DEFINE GULONG_FROM_LE(val) (GULONG_TO_LE (val))
#DEFINE GLONG_FROM_BE(val) (GLONG_TO_BE (val))
#DEFINE GULONG_FROM_BE(val) (GULONG_TO_BE (val))
#DEFINE GINT_FROM_LE(val) (GINT_TO_LE (val))
#DEFINE GUINT_FROM_LE(val) (GUINT_TO_LE (val))
#DEFINE GINT_FROM_BE(val) (GINT_TO_BE (val))
#DEFINE GUINT_FROM_BE(val) (GUINT_TO_BE (val))
#DEFINE GSIZE_FROM_LE(val) (GSIZE_TO_LE (val))
#DEFINE GSSIZE_FROM_LE(val) (GSSIZE_TO_LE (val))
#DEFINE GSIZE_FROM_BE(val) (GSIZE_TO_BE (val))
#DEFINE GSSIZE_FROM_BE(val) (GSSIZE_TO_BE (val))
#DEFINE g_ntohl(val) (GUINT32_FROM_BE (val))
#DEFINE g_ntohs(val) (GUINT16_FROM_BE (val))
#DEFINE g_htonl(val) (GUINT32_TO_BE (val))
#DEFINE g_htons(val) (GUINT16_TO_BE (val))

TYPE GDoubleIEEE754 AS _GDoubleIEEE754
TYPE GFloatIEEE754 AS _GFloatIEEE754

#DEFINE G_IEEE754_FLOAT_BIAS (127)
#DEFINE G_IEEE754_DOUBLE_BIAS (1023)
#DEFINE G_LOG_2_BASE_10 (0.30102999566398119521)

#IF G_BYTE_ORDER = G_LITTLE_ENDIAN

TYPE _GFloatIEEE754_mpn
  AS guint mantissa : 23
  AS guint biased_exponent : 8
  AS guint sign : 1
END TYPE

UNION _GFloatIEEE754
  AS gfloat v_float
  AS _GFloatIEEE754_mpn mpn
END UNION

TYPE _GDoubleIEEE754_mpn
  AS guint mantissa_low : 32
  AS guint mantissa_high : 20
  AS guint biased_exponent : 11
  AS guint sign : 1
END TYPE

UNION _GDoubleIEEE754
  AS gdouble v_double
  AS _GDoubleIEEE754_mpn mpn
END UNION

#ELSEIF G_BYTE_ORDER = G_BIG_ENDIAN

TYPE _GFloatIEEE754_mpn
  AS guint sign : 1
  AS guint biased_exponent : 8
  AS guint mantissa : 23
END TYPE

UNION _GFloatIEEE754
  AS gfloat v_float
  AS _GFloatIEEE754_mpn mpn
END UNION

TYPE _GDoubleIEEE754_mpn
  AS guint sign : 1
  AS guint biased_exponent : 11
  AS guint mantissa_high : 20
  AS guint mantissa_low : 32
END TYPE

UNION _GDoubleIEEE754
  AS gdouble v_double
  AS _GDoubleIEEE754_mpn mpn
END UNION

#ELSE ' G_BYTE_ORDER = ...
#ERROR unknown ENDIAN type
#ENDIF ' G_BYTE_ORDER = ...

TYPE GTimeVal AS _GTimeVal

TYPE _GTimeVal
  AS glong tv_sec
  AS glong tv_usec
END TYPE

#ENDIF ' __G_TYPES_H__

#INCLUDE ONCE "crt/malloc.bi"
#DEFINE alloca _alloca

#DEFINE g_alloca(size) alloca (size)

#DEFINE g_newa(struct_type, n_structs) CAST(struct_type PTR, g_alloca (SIZEOF (struct_type) * CAST(gsize, (n_structs))))
#ENDIF ' __G_ALLOCA_H__

#IFNDEF __G_ARRAY_H__
#DEFINE __G_ARRAY_H__

TYPE GBytes AS _GBytes
TYPE GArray AS _GArray
TYPE GByteArray AS _GByteArray
TYPE GPtrArray AS _GPtrArray

TYPE _GArray
  AS gchar PTR data
  AS guint len
END TYPE

TYPE _GByteArray
  AS guint8 PTR data
  AS guint len
END TYPE

TYPE _GPtrArray
  AS gpointer PTR pdata
  AS guint len
END TYPE

#DEFINE g_array_append_val(a,v) g_array_append_vals (a, @(v), 1)
#DEFINE g_array_prepend_val(a,v) g_array_prepend_vals (a, @(v), 1)
#DEFINE g_array_insert_val(a,i,v) g_array_insert_vals (a, i, @(v), 1)
#DEFINE g_array_index(a,t,i) ((CAST(t PTR, CAST(ANY PTR, (a)))->data) [(i)])

DECLARE FUNCTION g_array_new(BYVAL AS gboolean, BYVAL AS gboolean, BYVAL AS guint) AS GArray PTR
DECLARE FUNCTION g_array_sized_new(BYVAL AS gboolean, BYVAL AS gboolean, BYVAL AS guint, BYVAL AS guint) AS GArray PTR
DECLARE FUNCTION g_array_free(BYVAL AS GArray PTR, BYVAL AS gboolean) AS gchar PTR
DECLARE FUNCTION g_array_ref(BYVAL AS GArray PTR) AS GArray PTR
DECLARE SUB g_array_unref(BYVAL AS GArray PTR)
DECLARE FUNCTION g_array_get_element_size(BYVAL AS GArray PTR) AS guint
DECLARE FUNCTION g_array_append_vals(BYVAL AS GArray PTR, BYVAL AS gconstpointer, BYVAL AS guint) AS GArray PTR
DECLARE FUNCTION g_array_prepend_vals(BYVAL AS GArray PTR, BYVAL AS gconstpointer, BYVAL AS guint) AS GArray PTR
DECLARE FUNCTION g_array_insert_vals(BYVAL AS GArray PTR, BYVAL AS guint, BYVAL AS gconstpointer, BYVAL AS guint) AS GArray PTR
DECLARE FUNCTION g_array_set_size(BYVAL AS GArray PTR, BYVAL AS guint) AS GArray PTR
DECLARE FUNCTION g_array_remove_index(BYVAL AS GArray PTR, BYVAL AS guint) AS GArray PTR
DECLARE FUNCTION g_array_remove_index_fast(BYVAL AS GArray PTR, BYVAL AS guint) AS GArray PTR
DECLARE FUNCTION g_array_remove_range(BYVAL AS GArray PTR, BYVAL AS guint, BYVAL AS guint) AS GArray PTR
DECLARE SUB g_array_sort(BYVAL AS GArray PTR, BYVAL AS GCompareFunc)
DECLARE SUB g_array_sort_with_data(BYVAL AS GArray PTR, BYVAL AS GCompareDataFunc, BYVAL AS gpointer)

#DEFINE g_ptr_array_index(array,index_) ((array)->pdata)[index_]

DECLARE FUNCTION g_ptr_array_new() AS GPtrArray PTR
DECLARE FUNCTION g_ptr_array_new_with_free_func(BYVAL AS GDestroyNotify) AS GPtrArray PTR
DECLARE FUNCTION g_ptr_array_sized_new(BYVAL AS guint) AS GPtrArray PTR
DECLARE FUNCTION g_ptr_array_new_full(BYVAL AS guint, BYVAL AS GDestroyNotify) AS GPtrArray PTR
DECLARE FUNCTION g_ptr_array_free(BYVAL AS GPtrArray PTR, BYVAL AS gboolean) AS gpointer PTR
DECLARE FUNCTION g_ptr_array_ref(BYVAL AS GPtrArray PTR) AS GPtrArray PTR
DECLARE SUB g_ptr_array_unref(BYVAL AS GPtrArray PTR)
DECLARE SUB g_ptr_array_set_free_func(BYVAL AS GPtrArray PTR, BYVAL AS GDestroyNotify)
DECLARE SUB g_ptr_array_set_size(BYVAL AS GPtrArray PTR, BYVAL AS gint)
DECLARE FUNCTION g_ptr_array_remove_index(BYVAL AS GPtrArray PTR, BYVAL AS guint) AS gpointer
DECLARE FUNCTION g_ptr_array_remove_index_fast(BYVAL AS GPtrArray PTR, BYVAL AS guint) AS gpointer
DECLARE FUNCTION g_ptr_array_remove(BYVAL AS GPtrArray PTR, BYVAL AS gpointer) AS gboolean
DECLARE FUNCTION g_ptr_array_remove_fast(BYVAL AS GPtrArray PTR, BYVAL AS gpointer) AS gboolean
DECLARE SUB g_ptr_array_remove_range(BYVAL AS GPtrArray PTR, BYVAL AS guint, BYVAL AS guint)
DECLARE SUB g_ptr_array_add(BYVAL AS GPtrArray PTR, BYVAL AS gpointer)
DECLARE SUB g_ptr_array_sort(BYVAL AS GPtrArray PTR, BYVAL AS GCompareFunc)
DECLARE SUB g_ptr_array_sort_with_data(BYVAL AS GPtrArray PTR, BYVAL AS GCompareDataFunc, BYVAL AS gpointer)
DECLARE SUB g_ptr_array_foreach(BYVAL AS GPtrArray PTR, BYVAL AS GFunc, BYVAL AS gpointer)
DECLARE FUNCTION g_byte_array_new() AS GByteArray PTR
DECLARE FUNCTION g_byte_array_new_take(BYVAL AS guint8 PTR, BYVAL AS gsize) AS GByteArray PTR
DECLARE FUNCTION g_byte_array_sized_new(BYVAL AS guint) AS GByteArray PTR
DECLARE FUNCTION g_byte_array_free(BYVAL AS GByteArray PTR, BYVAL AS gboolean) AS guint8 PTR
DECLARE FUNCTION g_byte_array_free_to_bytes(BYVAL AS GByteArray PTR) AS GBytes PTR
DECLARE FUNCTION g_byte_array_ref(BYVAL AS GByteArray PTR) AS GByteArray PTR
DECLARE SUB g_byte_array_unref(BYVAL AS GByteArray PTR)
DECLARE FUNCTION g_byte_array_append(BYVAL AS GByteArray PTR, BYVAL AS CONST guint8 PTR, BYVAL AS guint) AS GByteArray PTR
DECLARE FUNCTION g_byte_array_prepend(BYVAL AS GByteArray PTR, BYVAL AS CONST guint8 PTR, BYVAL AS guint) AS GByteArray PTR
DECLARE FUNCTION g_byte_array_set_size(BYVAL AS GByteArray PTR, BYVAL AS guint) AS GByteArray PTR
DECLARE FUNCTION g_byte_array_remove_index(BYVAL AS GByteArray PTR, BYVAL AS guint) AS GByteArray PTR
DECLARE FUNCTION g_byte_array_remove_index_fast(BYVAL AS GByteArray PTR, BYVAL AS guint) AS GByteArray PTR
DECLARE FUNCTION g_byte_array_remove_range(BYVAL AS GByteArray PTR, BYVAL AS guint, BYVAL AS guint) AS GByteArray PTR
DECLARE SUB g_byte_array_sort(BYVAL AS GByteArray PTR, BYVAL AS GCompareFunc)
DECLARE SUB g_byte_array_sort_with_data(BYVAL AS GByteArray PTR, BYVAL AS GCompareDataFunc, BYVAL AS gpointer)

#ENDIF ' __G_ARRAY_H__

#IFNDEF __G_ASYNCQUEUE_H__
#DEFINE __G_ASYNCQUEUE_H__

#IFNDEF __G_THREAD_H__
#DEFINE __G_THREAD_H__

#IFNDEF __G_ATOMIC_H__
#DEFINE __G_ATOMIC_H__

DECLARE FUNCTION g_atomic_int_get_ ALIAS "g_atomic_int_get"(BYVAL AS gint PTR) AS gint
DECLARE SUB g_atomic_int_set_ ALIAS "g_atomic_int_set"(BYVAL AS gint PTR, BYVAL AS gint)
DECLARE SUB g_atomic_int_inc_ ALIAS "g_atomic_int_inc"(BYVAL AS gint PTR)
DECLARE FUNCTION g_atomic_int_dec_and_test_ ALIAS "g_atomic_int_dec_and_test"(BYVAL AS gint PTR) AS gboolean
DECLARE FUNCTION g_atomic_int_compare_and_exchange_ ALIAS "g_atomic_int_compare_and_exchange"(BYVAL AS gint PTR, BYVAL AS gint, BYVAL AS gint) AS gboolean
DECLARE FUNCTION g_atomic_int_add_ ALIAS "g_atomic_int_add"(BYVAL AS gint PTR, BYVAL AS gint) AS gint
DECLARE FUNCTION g_atomic_int_and_ ALIAS "g_atomic_int_and"(BYVAL AS guint PTR, BYVAL AS guint) AS guint
DECLARE FUNCTION g_atomic_int_or_ ALIAS "g_atomic_int_or"(BYVAL AS guint PTR, BYVAL AS guint) AS guint
DECLARE FUNCTION g_atomic_int_xor_ ALIAS "g_atomic_int_xor"(BYVAL AS guint PTR, BYVAL AS guint) AS guint
DECLARE FUNCTION g_atomic_pointer_get_ ALIAS "g_atomic_pointer_get"(BYVAL AS ANY PTR) AS gpointer
DECLARE SUB g_atomic_pointer_set_ ALIAS "g_atomic_pointer_set"(BYVAL AS ANY PTR, BYVAL AS gpointer)
DECLARE FUNCTION g_atomic_pointer_compare_and_exchange_ ALIAS "g_atomic_pointer_compare_and_exchange"(BYVAL AS ANY PTR, BYVAL AS gpointer, BYVAL AS gpointer) AS gboolean
DECLARE FUNCTION g_atomic_pointer_add_ ALIAS "g_atomic_pointer_add"(BYVAL AS ANY PTR, BYVAL AS gssize) AS gssize
DECLARE FUNCTION g_atomic_pointer_and_ ALIAS "g_atomic_pointer_and"(BYVAL AS ANY PTR, BYVAL AS gsize) AS gsize
DECLARE FUNCTION g_atomic_pointer_or_ ALIAS "g_atomic_pointer_or"(BYVAL AS ANY PTR, BYVAL AS gsize) AS gsize
DECLARE FUNCTION g_atomic_pointer_xor_ ALIAS "g_atomic_pointer_xor"(BYVAL AS ANY PTR, BYVAL AS gsize) AS gsize
DECLARE FUNCTION g_atomic_int_exchange_and_add(BYVAL AS gint PTR, BYVAL AS gint) AS gint

#DEFINE g_atomic_int_get(atomic) _
  (g_atomic_int_get_ (CAST(gint PTR, (atomic))))
#DEFINE g_atomic_int_set(atomic, newval) _
  (g_atomic_int_set_ (CAST(gint PTR, (atomic)), CAST(gint, (newval))))
#DEFINE g_atomic_int_compare_and_exchange(atomic, oldval, newval) _
  (g_atomic_int_compare_and_exchange_ (CAST(gint PTR, (atomic)), (oldval), (newval)))
#DEFINE g_atomic_int_add(atomic, val) _
  (g_atomic_int_add_ (CAST(gint PTR, (atomic)), (val)))
#DEFINE g_atomic_int_and(atomic, val) _
  (g_atomic_int_and_ (CAST(guint PTR, (atomic)), (val)))
#DEFINE g_atomic_int_or(atomic, val) _
  (g_atomic_int_or_ (CAST(guint PTR, (atomic)), (val)))
#DEFINE g_atomic_int_xor(atomic, val) _
  (g_atomic_int_xor_ (CAST(guint PTR, (atomic)), (val)))
#DEFINE g_atomic_int_inc(atomic) _
  (g_atomic_int_inc_ (CAST(gint PTR, (atomic))))
#DEFINE g_atomic_int_dec_and_test(atomic) _
  (g_atomic_int_dec_and_test_ (CAST(gint PTR, (atomic))))
#DEFINE g_atomic_pointer_get(atomic) _
  (g_atomic_pointer_get_ (atomic))
#DEFINE g_atomic_pointer_set(atomic, newval) _
  (g_atomic_pointer_set_ ((atomic), CAST(gpointer, (newval))))
#DEFINE g_atomic_pointer_compare_and_exchange(atomic, oldval, newval) _
  (g_atomic_pointer_compare_and_exchange_ ((atomic), CAST(gpointer, (oldval)), CAST(gpointer, (newval))))
#DEFINE g_atomic_pointer_add(atomic, val) _
  (g_atomic_pointer_add_ ((atomic), CAST(gssize, (val))))
#DEFINE g_atomic_pointer_and(atomic, val) _
  (g_atomic_pointer_and_ ((atomic), CAST(gsize, (val))))
#DEFINE g_atomic_pointer_or(atomic, val) _
  (g_atomic_pointer_or_ ((atomic), CAST(gsize, (val))))
#DEFINE g_atomic_pointer_xor(atomic, val) _
  (g_atomic_pointer_xor_ ((atomic), CAST(gsize, (val))))
#ENDIF ' DEFINED(G_ATOMI...

#IFNDEF __G_ERROR_H__
#DEFINE __G_ERROR_H__
#INCLUDE ONCE "crt/stdarg.bi"

#IFNDEF __G_QUARK_H__
#DEFINE __G_QUARK_H__

TYPE GQuark AS guint32

DECLARE FUNCTION g_quark_try_string(BYVAL AS CONST gchar PTR) AS GQuark
DECLARE FUNCTION g_quark_from_static_string(BYVAL AS CONST gchar PTR) AS GQuark
DECLARE FUNCTION g_quark_from_string(BYVAL AS CONST gchar PTR) AS GQuark
DECLARE FUNCTION g_quark_to_string(BYVAL AS GQuark) AS CONST gchar PTR
DECLARE FUNCTION g_intern_string(BYVAL AS CONST gchar PTR) AS CONST gchar PTR
DECLARE FUNCTION g_intern_static_string(BYVAL AS CONST gchar PTR) AS CONST gchar PTR

#ENDIF ' __G_QUARK_H__

TYPE GError AS _GError

TYPE _GError
  AS GQuark domain
  AS gint code
  AS gchar PTR message
END TYPE

DECLARE FUNCTION g_error_new(BYVAL AS GQuark, BYVAL AS gint, BYVAL AS CONST gchar PTR, ...) AS GError PTR
DECLARE FUNCTION g_error_new_literal(BYVAL AS GQuark, BYVAL AS gint, BYVAL AS CONST gchar PTR) AS GError PTR
DECLARE FUNCTION g_error_new_valist(BYVAL AS GQuark, BYVAL AS gint, BYVAL AS CONST gchar PTR, BYVAL AS va_list) AS GError PTR
DECLARE SUB g_error_free(BYVAL AS GError PTR)
DECLARE FUNCTION g_error_copy(BYVAL AS CONST GError PTR) AS GError PTR
DECLARE FUNCTION g_error_matches(BYVAL AS CONST GError PTR, BYVAL AS GQuark, BYVAL AS gint) AS gboolean
DECLARE SUB g_set_error(BYVAL AS GError PTR PTR, BYVAL AS GQuark, BYVAL AS gint, BYVAL AS CONST gchar PTR, ...)
DECLARE SUB g_set_error_literal(BYVAL AS GError PTR PTR, BYVAL AS GQuark, BYVAL AS gint, BYVAL AS CONST gchar PTR)
DECLARE SUB g_propagate_error(BYVAL AS GError PTR PTR, BYVAL AS GError PTR)
DECLARE SUB g_clear_error(BYVAL AS GError PTR PTR)
DECLARE SUB g_prefix_error(BYVAL AS GError PTR PTR, BYVAL AS CONST gchar PTR, ...)
DECLARE SUB g_propagate_prefixed_error(BYVAL AS GError PTR PTR, BYVAL AS GError PTR, BYVAL AS CONST gchar PTR, ...)

#ENDIF ' __G_ERROR_H__

#DEFINE G_THREAD_ERROR g_thread_error_quark ()

DECLARE FUNCTION g_thread_error_quark() AS GQuark

ENUM GThreadError
  G_THREAD_ERROR_AGAIN
END ENUM

TYPE GThreadFunc AS FUNCTION(BYVAL AS gpointer) AS gpointer
TYPE GThread AS _GThread
TYPE GMutex AS _GMutex
TYPE GRecMutex AS _GRecMutex
TYPE GRWLock AS _GRWLock
TYPE GCond AS _GCond
TYPE GPrivate AS _GPrivate
TYPE GOnce AS _GOnce

UNION _GMutex
  AS gpointer p
  AS guint i(1)
END UNION

TYPE _GRWLock
  AS gpointer p
  AS guint i(1)
END TYPE

TYPE _GCond
  AS gpointer p
  AS guint i(1)
END TYPE

TYPE _GRecMutex
  AS gpointer p
  AS guint i(1)
END TYPE

#DEFINE G_PRIVATE_INIT(notify) TYPE<GPrivate>( NULL, (notify), { NULL, NULL } )

TYPE _GPrivate
  AS gpointer p
  AS GDestroyNotify notify
  AS gpointer future(1)
END TYPE

ENUM GOnceStatus
  G_ONCE_STATUS_NOTCALLED
  G_ONCE_STATUS_PROGRESS
  G_ONCE_STATUS_READY
END ENUM

#DEFINE G_ONCE_INIT TYPE<GOnce>( G_ONCE_STATUS_NOTCALLED, NULL )

TYPE _GOnce
  AS GOnceStatus status
  AS gpointer retval
END TYPE

#DEFINE G_LOCK_NAME(name) g__ ## name ## _lock
#DEFINE G_LOCK_DEFINE_STATIC(name) static G_LOCK_DEFINE (name)
#DEFINE G_LOCK_DEFINE(name) GMutex G_LOCK_NAME (name)
#DEFINE G_LOCK_EXTERN(name) extern GMutex G_LOCK_NAME (name)

#IFDEF G_DEBUG_LOCKS

#DEFINE G_LOCK(name) _
  g_log (G_LOG_DOMAIN, G_LOG_LEVEL_DEBUG, !"file %s: line %d (%s): locking: %s ", __FILE__, __LINE__, G_STRFUNC, #name) : _
  g_static_mutex_lock (@G_LOCK_NAME (name))
#DEFINE G_UNLOCK(name) _
  g_log (G_LOG_DOMAIN, G_LOG_LEVEL_DEBUG, !"file %s: line %d (%s): unlocking: %s ", __FILE__, __LINE__, G_STRFUNC, #name) : _
  g_static_mutex_unlock (@G_LOCK_NAME (name))
#DEFINE G_TRYLOCK(name) _
  g_log (G_LOG_DOMAIN, G_LOG_LEVEL_DEBUG, !"file %s: line %d (%s): try locking: %s ", __FILE__, __LINE__, G_STRFUNC, #name) : _
  g_static_mutex_trylock (@G_LOCK_NAME (name))

#ELSE ' G_DEBUG_LOCKS

#DEFINE G_LOCK(name) g_static_mutex_lock (@G_LOCK_NAME (name))
#DEFINE G_UNLOCK(name) g_static_mutex_unlock (@G_LOCK_NAME (name))
#DEFINE G_TRYLOCK(name) g_static_mutex_trylock (@G_LOCK_NAME (name))

#ENDIF ' G_DEBUG_LOCKS

DECLARE FUNCTION g_thread_ref(BYVAL AS GThread PTR) AS GThread PTR
DECLARE SUB g_thread_unref(BYVAL AS GThread PTR)
DECLARE FUNCTION g_thread_new(BYVAL AS CONST gchar PTR, BYVAL AS GThreadFunc, BYVAL AS gpointer) AS GThread PTR
DECLARE FUNCTION g_thread_try_new(BYVAL AS CONST gchar PTR, BYVAL AS GThreadFunc, BYVAL AS gpointer, BYVAL AS GError PTR PTR) AS GThread PTR
DECLARE FUNCTION g_thread_self() AS GThread PTR
DECLARE SUB g_thread_exit(BYVAL AS gpointer)
DECLARE FUNCTION g_thread_join(BYVAL AS GThread PTR) AS gpointer
DECLARE SUB g_thread_yield()
DECLARE SUB g_mutex_init(BYVAL AS GMutex PTR)
DECLARE SUB g_mutex_clear(BYVAL AS GMutex PTR)
DECLARE SUB g_mutex_lock(BYVAL AS GMutex PTR)
DECLARE FUNCTION g_mutex_trylock(BYVAL AS GMutex PTR) AS gboolean
DECLARE SUB g_mutex_unlock(BYVAL AS GMutex PTR)
DECLARE SUB g_rw_lock_init(BYVAL AS GRWLock PTR)
DECLARE SUB g_rw_lock_clear(BYVAL AS GRWLock PTR)
DECLARE SUB g_rw_lock_writer_lock(BYVAL AS GRWLock PTR)
DECLARE FUNCTION g_rw_lock_writer_trylock(BYVAL AS GRWLock PTR) AS gboolean
DECLARE SUB g_rw_lock_writer_unlock(BYVAL AS GRWLock PTR)
DECLARE SUB g_rw_lock_reader_lock(BYVAL AS GRWLock PTR)
DECLARE FUNCTION g_rw_lock_reader_trylock(BYVAL AS GRWLock PTR) AS gboolean
DECLARE SUB g_rw_lock_reader_unlock(BYVAL AS GRWLock PTR)
DECLARE SUB g_rec_mutex_init(BYVAL AS GRecMutex PTR)
DECLARE SUB g_rec_mutex_clear(BYVAL AS GRecMutex PTR)
DECLARE SUB g_rec_mutex_lock(BYVAL AS GRecMutex PTR)
DECLARE FUNCTION g_rec_mutex_trylock(BYVAL AS GRecMutex PTR) AS gboolean
DECLARE SUB g_rec_mutex_unlock(BYVAL AS GRecMutex PTR)
DECLARE SUB g_cond_init(BYVAL AS GCond PTR)
DECLARE SUB g_cond_clear(BYVAL AS GCond PTR)
DECLARE SUB g_cond_wait(BYVAL AS GCond PTR, BYVAL AS GMutex PTR)
DECLARE SUB g_cond_signal(BYVAL AS GCond PTR)
DECLARE SUB g_cond_broadcast(BYVAL AS GCond PTR)
DECLARE FUNCTION g_cond_wait_until(BYVAL AS GCond PTR, BYVAL AS GMutex PTR, BYVAL AS gint64) AS gboolean
DECLARE FUNCTION g_private_get(BYVAL AS GPrivate PTR) AS gpointer
DECLARE SUB g_private_set(BYVAL AS GPrivate PTR, BYVAL AS gpointer)
DECLARE SUB g_private_replace(BYVAL AS GPrivate PTR, BYVAL AS gpointer)
DECLARE FUNCTION g_once_impl(BYVAL AS GOnce PTR, BYVAL AS GThreadFunc, BYVAL AS gpointer) AS gpointer
DECLARE FUNCTION g_once_init_enter(BYVAL AS ANY PTR) AS gboolean
DECLARE SUB g_once_init_leave_ ALIAS "g_once_init_leave"(BYVAL AS ANY PTR, BYVAL AS gsize)

#IFDEF G_ATOMIC_OP_MEMORY_BARRIER_NEEDED
#DEFINE g_once(once, func, arg) g_once_impl ((once), (func), (arg))
#ELSE ' G_ATOMIC_OP_MEMORY_BARRIER_NEEDED
#DEFINE g_once(once, func, arg) _
  IIF(((once)->status = G_ONCE_STATUS_READY) , _
   (once)->retval , _
   g_once_impl ((once), (func), (arg)))
#ENDIF ' G_ATOMIC_OP_MEMORY_BARRIER_NEEDED

#DEFINE g_once_init_leave(location, result) g_once_init_leave_((location), CAST(gsize, (result)))
#ENDIF ' __G_THREAD_H__

TYPE GAsyncQueue AS _GAsyncQueue

DECLARE FUNCTION g_async_queue_new() AS GAsyncQueue PTR
DECLARE FUNCTION g_async_queue_new_full(BYVAL AS GDestroyNotify) AS GAsyncQueue PTR
DECLARE SUB g_async_queue_lock(BYVAL AS GAsyncQueue PTR)
DECLARE SUB g_async_queue_unlock(BYVAL AS GAsyncQueue PTR)
DECLARE FUNCTION g_async_queue_ref(BYVAL AS GAsyncQueue PTR) AS GAsyncQueue PTR
DECLARE SUB g_async_queue_unref(BYVAL AS GAsyncQueue PTR)
DECLARE SUB g_async_queue_ref_unlocked(BYVAL AS GAsyncQueue PTR)
DECLARE SUB g_async_queue_unref_and_unlock(BYVAL AS GAsyncQueue PTR)
DECLARE SUB g_async_queue_push(BYVAL AS GAsyncQueue PTR, BYVAL AS gpointer)
DECLARE SUB g_async_queue_push_unlocked(BYVAL AS GAsyncQueue PTR, BYVAL AS gpointer)
DECLARE SUB g_async_queue_push_sorted(BYVAL AS GAsyncQueue PTR, BYVAL AS gpointer, BYVAL AS GCompareDataFunc, BYVAL AS gpointer)
DECLARE SUB g_async_queue_push_sorted_unlocked(BYVAL AS GAsyncQueue PTR, BYVAL AS gpointer, BYVAL AS GCompareDataFunc, BYVAL AS gpointer)
DECLARE FUNCTION g_async_queue_pop(BYVAL AS GAsyncQueue PTR) AS gpointer
DECLARE FUNCTION g_async_queue_pop_unlocked(BYVAL AS GAsyncQueue PTR) AS gpointer
DECLARE FUNCTION g_async_queue_try_pop(BYVAL AS GAsyncQueue PTR) AS gpointer
DECLARE FUNCTION g_async_queue_try_pop_unlocked(BYVAL AS GAsyncQueue PTR) AS gpointer
DECLARE FUNCTION g_async_queue_timed_pop(BYVAL AS GAsyncQueue PTR, BYVAL AS GTimeVal PTR) AS gpointer
DECLARE FUNCTION g_async_queue_timed_pop_unlocked(BYVAL AS GAsyncQueue PTR, BYVAL AS GTimeVal PTR) AS gpointer
DECLARE FUNCTION g_async_queue_length(BYVAL AS GAsyncQueue PTR) AS gint
DECLARE FUNCTION g_async_queue_length_unlocked(BYVAL AS GAsyncQueue PTR) AS gint
DECLARE SUB g_async_queue_sort(BYVAL AS GAsyncQueue PTR, BYVAL AS GCompareDataFunc, BYVAL AS gpointer)
DECLARE SUB g_async_queue_sort_unlocked(BYVAL AS GAsyncQueue PTR, BYVAL AS GCompareDataFunc, BYVAL AS gpointer)

#ENDIF ' __G_ASYNCQUEUE_H__

#IFNDEF __G_BACKTRACE_H__
#DEFINE __G_BACKTRACE_H__

DECLARE SUB g_on_error_query(BYVAL AS CONST gchar PTR)
DECLARE SUB g_on_error_stack_trace(BYVAL AS CONST gchar PTR)

#DEFINE G_BREAKPOINT() ASM int 3
#ENDIF ' __G_BACKTRACE_H__

#IFNDEF __G_BASE64_H__
#DEFINE __G_BASE64_H__

DECLARE FUNCTION g_base64_encode_step(BYVAL AS CONST guchar PTR, BYVAL AS gsize, BYVAL AS gboolean, BYVAL AS gchar PTR, BYVAL AS gint PTR, BYVAL AS gint PTR) AS gsize
DECLARE FUNCTION g_base64_encode_close(BYVAL AS gboolean, BYVAL AS gchar PTR, BYVAL AS gint PTR, BYVAL AS gint PTR) AS gsize
DECLARE FUNCTION g_base64_encode(BYVAL AS CONST guchar PTR, BYVAL AS gsize) AS gchar PTR
DECLARE FUNCTION g_base64_decode_step(BYVAL AS CONST gchar PTR, BYVAL AS gsize, BYVAL AS guchar PTR, BYVAL AS gint PTR, BYVAL AS guint PTR) AS gsize
DECLARE FUNCTION g_base64_decode(BYVAL AS CONST gchar PTR, BYVAL AS gsize PTR) AS guchar PTR
DECLARE FUNCTION g_base64_decode_inplace(BYVAL AS gchar PTR, BYVAL AS gsize PTR) AS guchar PTR

#ENDIF ' __G_BASE64_H__

#IFNDEF __G_BITLOCK_H__
#DEFINE __G_BITLOCK_H__

DECLARE SUB g_bit_lock(BYVAL AS gint PTR, BYVAL AS gint)
DECLARE FUNCTION g_bit_trylock(BYVAL AS gint PTR, BYVAL AS gint) AS gboolean
DECLARE SUB g_bit_unlock(BYVAL AS gint PTR, BYVAL AS gint)
DECLARE SUB g_pointer_bit_lock(BYVAL AS ANY PTR, BYVAL AS gint)
DECLARE FUNCTION g_pointer_bit_trylock(BYVAL AS ANY PTR, BYVAL AS gint) AS gboolean
DECLARE SUB g_pointer_bit_unlock(BYVAL AS ANY PTR, BYVAL AS gint)

#ENDIF ' __G_BITLOCK_H__

#IFNDEF __G_BOOKMARK_FILE_H__
#DEFINE __G_BOOKMARK_FILE_H__

#DEFINE G_BOOKMARK_FILE_ERROR (g_bookmark_file_error_quark ())

ENUM GBookmarkFileError
  G_BOOKMARK_FILE_ERROR_INVALID_URI
  G_BOOKMARK_FILE_ERROR_INVALID_VALUE
  G_BOOKMARK_FILE_ERROR_APP_NOT_REGISTERED
  G_BOOKMARK_FILE_ERROR_URI_NOT_FOUND
  G_BOOKMARK_FILE_ERROR_READ
  G_BOOKMARK_FILE_ERROR_UNKNOWN_ENCODING
  G_BOOKMARK_FILE_ERROR_WRITE
  G_BOOKMARK_FILE_ERROR_FILE_NOT_FOUND
END ENUM

DECLARE FUNCTION g_bookmark_file_error_quark() AS GQuark

TYPE GBookmarkFile AS _GBookmarkFile

DECLARE FUNCTION g_bookmark_file_new() AS GBookmarkFile PTR
DECLARE SUB g_bookmark_file_free(BYVAL AS GBookmarkFile PTR)
DECLARE FUNCTION g_bookmark_file_load_from_file(BYVAL AS GBookmarkFile PTR, BYVAL AS CONST gchar PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_bookmark_file_load_from_data(BYVAL AS GBookmarkFile PTR, BYVAL AS CONST gchar PTR, BYVAL AS gsize, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_bookmark_file_load_from_data_dirs(BYVAL AS GBookmarkFile PTR, BYVAL AS CONST gchar PTR, BYVAL AS gchar PTR PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_bookmark_file_to_data(BYVAL AS GBookmarkFile PTR, BYVAL AS gsize PTR, BYVAL AS GError PTR PTR) AS gchar PTR
DECLARE FUNCTION g_bookmark_file_to_file(BYVAL AS GBookmarkFile PTR, BYVAL AS CONST gchar PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE SUB g_bookmark_file_set_title(BYVAL AS GBookmarkFile PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION g_bookmark_file_get_title(BYVAL AS GBookmarkFile PTR, BYVAL AS CONST gchar PTR, BYVAL AS GError PTR PTR) AS gchar PTR
DECLARE SUB g_bookmark_file_set_description(BYVAL AS GBookmarkFile PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION g_bookmark_file_get_description(BYVAL AS GBookmarkFile PTR, BYVAL AS CONST gchar PTR, BYVAL AS GError PTR PTR) AS gchar PTR
DECLARE SUB g_bookmark_file_set_mime_type(BYVAL AS GBookmarkFile PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION g_bookmark_file_get_mime_type(BYVAL AS GBookmarkFile PTR, BYVAL AS CONST gchar PTR, BYVAL AS GError PTR PTR) AS gchar PTR
DECLARE SUB g_bookmark_file_set_groups(BYVAL AS GBookmarkFile PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR PTR, BYVAL AS gsize)
DECLARE SUB g_bookmark_file_add_group(BYVAL AS GBookmarkFile PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION g_bookmark_file_has_group(BYVAL AS GBookmarkFile PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_bookmark_file_get_groups(BYVAL AS GBookmarkFile PTR, BYVAL AS CONST gchar PTR, BYVAL AS gsize PTR, BYVAL AS GError PTR PTR) AS gchar PTR PTR
DECLARE SUB g_bookmark_file_add_application(BYVAL AS GBookmarkFile PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION g_bookmark_file_has_application(BYVAL AS GBookmarkFile PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_bookmark_file_get_applications(BYVAL AS GBookmarkFile PTR, BYVAL AS CONST gchar PTR, BYVAL AS gsize PTR, BYVAL AS GError PTR PTR) AS gchar PTR PTR
DECLARE FUNCTION g_bookmark_file_set_app_info(BYVAL AS GBookmarkFile PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint, BYVAL AS time_t, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_bookmark_file_get_app_info(BYVAL AS GBookmarkFile PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS gchar PTR PTR, BYVAL AS guint PTR, BYVAL AS time_t PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE SUB g_bookmark_file_set_is_private(BYVAL AS GBookmarkFile PTR, BYVAL AS CONST gchar PTR, BYVAL AS gboolean)
DECLARE FUNCTION g_bookmark_file_get_is_private(BYVAL AS GBookmarkFile PTR, BYVAL AS CONST gchar PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE SUB g_bookmark_file_set_icon(BYVAL AS GBookmarkFile PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION g_bookmark_file_get_icon(BYVAL AS GBookmarkFile PTR, BYVAL AS CONST gchar PTR, BYVAL AS gchar PTR PTR, BYVAL AS gchar PTR PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE SUB g_bookmark_file_set_added(BYVAL AS GBookmarkFile PTR, BYVAL AS CONST gchar PTR, BYVAL AS time_t)
DECLARE FUNCTION g_bookmark_file_get_added(BYVAL AS GBookmarkFile PTR, BYVAL AS CONST gchar PTR, BYVAL AS GError PTR PTR) AS time_t
DECLARE SUB g_bookmark_file_set_modified(BYVAL AS GBookmarkFile PTR, BYVAL AS CONST gchar PTR, BYVAL AS time_t)
DECLARE FUNCTION g_bookmark_file_get_modified(BYVAL AS GBookmarkFile PTR, BYVAL AS CONST gchar PTR, BYVAL AS GError PTR PTR) AS time_t
DECLARE SUB g_bookmark_file_set_visited(BYVAL AS GBookmarkFile PTR, BYVAL AS CONST gchar PTR, BYVAL AS time_t)
DECLARE FUNCTION g_bookmark_file_get_visited(BYVAL AS GBookmarkFile PTR, BYVAL AS CONST gchar PTR, BYVAL AS GError PTR PTR) AS time_t
DECLARE FUNCTION g_bookmark_file_has_item(BYVAL AS GBookmarkFile PTR, BYVAL AS CONST gchar PTR) AS gboolean
DECLARE FUNCTION g_bookmark_file_get_size(BYVAL AS GBookmarkFile PTR) AS gint
DECLARE FUNCTION g_bookmark_file_get_uris(BYVAL AS GBookmarkFile PTR, BYVAL AS gsize PTR) AS gchar PTR PTR
DECLARE FUNCTION g_bookmark_file_remove_group(BYVAL AS GBookmarkFile PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_bookmark_file_remove_application(BYVAL AS GBookmarkFile PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_bookmark_file_remove_item(BYVAL AS GBookmarkFile PTR, BYVAL AS CONST gchar PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_bookmark_file_move_item(BYVAL AS GBookmarkFile PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS GError PTR PTR) AS gboolean

#ENDIF ' __G_BOOKMARK_FILE_H__


#IFNDEF __G_BYTES_H__
#DEFINE __G_BYTES_H__

DECLARE FUNCTION g_bytes_new(BYVAL AS gconstpointer, BYVAL AS gsize) AS GBytes PTR
DECLARE FUNCTION g_bytes_new_take(BYVAL AS gpointer, BYVAL AS gsize) AS GBytes PTR
DECLARE FUNCTION g_bytes_new_static(BYVAL AS gconstpointer, BYVAL AS gsize) AS GBytes PTR
DECLARE FUNCTION g_bytes_new_with_free_func(BYVAL AS gconstpointer, BYVAL AS gsize, BYVAL AS GDestroyNotify, BYVAL AS gpointer) AS GBytes PTR
DECLARE FUNCTION g_bytes_new_from_bytes(BYVAL AS GBytes PTR, BYVAL AS gsize, BYVAL AS gsize) AS GBytes PTR
DECLARE FUNCTION g_bytes_get_data(BYVAL AS GBytes PTR) AS gconstpointer
DECLARE FUNCTION g_bytes_get_size(BYVAL AS GBytes PTR) AS gsize
DECLARE FUNCTION g_bytes_ref(BYVAL AS GBytes PTR) AS GBytes PTR
DECLARE SUB g_bytes_unref(BYVAL AS GBytes PTR)
DECLARE FUNCTION g_bytes_unref_to_data(BYVAL AS GBytes PTR, BYVAL AS gsize PTR) AS gpointer
DECLARE FUNCTION g_bytes_unref_to_array(BYVAL AS GBytes PTR) AS GByteArray PTR
DECLARE FUNCTION g_bytes_hash(BYVAL AS gconstpointer) AS guint
DECLARE FUNCTION g_bytes_equal(BYVAL AS gconstpointer, BYVAL AS gconstpointer) AS gboolean
DECLARE FUNCTION g_bytes_compare(BYVAL AS gconstpointer, BYVAL AS gconstpointer) AS gint

#ENDIF ' __G_BYTES_H__


#IFNDEF __G_CHARSET_H__
#DEFINE __G_CHARSET_H__

DECLARE FUNCTION g_get_charset(BYVAL AS CONST ZSTRING PTR PTR) AS gboolean
DECLARE FUNCTION g_get_codeset() AS gchar PTR
DECLARE FUNCTION g_get_language_names() AS CONST gchar CONST PTR PTR
DECLARE FUNCTION g_get_locale_variants(BYVAL AS CONST gchar PTR) AS gchar PTR PTR

#ENDIF ' __G_CHARSET_H__


#IFNDEF __G_CHECKSUM_H__
#DEFINE __G_CHECKSUM_H__

ENUM GChecksumType
  G_CHECKSUM_MD5
  G_CHECKSUM_SHA1
  G_CHECKSUM_SHA256
END ENUM

TYPE GChecksum AS _GChecksum

DECLARE FUNCTION g_checksum_type_get_length(BYVAL AS GChecksumType) AS gssize
DECLARE FUNCTION g_checksum_new(BYVAL AS GChecksumType) AS GChecksum PTR
DECLARE SUB g_checksum_reset(BYVAL AS GChecksum PTR)
DECLARE FUNCTION g_checksum_copy(BYVAL AS CONST GChecksum PTR) AS GChecksum PTR
DECLARE SUB g_checksum_free(BYVAL AS GChecksum PTR)
DECLARE SUB g_checksum_update(BYVAL AS GChecksum PTR, BYVAL AS CONST guchar PTR, BYVAL AS gssize)
DECLARE FUNCTION g_checksum_get_string(BYVAL AS GChecksum PTR) AS CONST gchar PTR
DECLARE SUB g_checksum_get_digest(BYVAL AS GChecksum PTR, BYVAL AS guint8 PTR, BYVAL AS gsize PTR)
DECLARE FUNCTION g_compute_checksum_for_data(BYVAL AS GChecksumType, BYVAL AS CONST guchar PTR, BYVAL AS gsize) AS gchar PTR
DECLARE FUNCTION g_compute_checksum_for_string(BYVAL AS GChecksumType, BYVAL AS CONST gchar PTR, BYVAL AS gssize) AS gchar PTR

#ENDIF ' __G_CHECKSUM_H__


#IFNDEF __G_CONVERT_H__
#DEFINE __G_CONVERT_H__

ENUM GConvertError
  G_CONVERT_ERROR_NO_CONVERSION
  G_CONVERT_ERROR_ILLEGAL_SEQUENCE
  G_CONVERT_ERROR_FAILED
  G_CONVERT_ERROR_PARTIAL_INPUT
  G_CONVERT_ERROR_BAD_URI
  G_CONVERT_ERROR_NOT_ABSOLUTE_PATH
END ENUM

#DEFINE G_CONVERT_ERROR g_convert_error_quark()

DECLARE FUNCTION g_convert_error_quark() AS GQuark

TYPE GIConv AS _GIConv PTR

DECLARE FUNCTION g_iconv_open(BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR) AS GIConv
DECLARE FUNCTION g_iconv(BYVAL AS GIConv, BYVAL AS gchar PTR PTR, BYVAL AS gsize PTR, BYVAL AS gchar PTR PTR, BYVAL AS gsize PTR) AS gsize
DECLARE FUNCTION g_iconv_close(BYVAL AS GIConv) AS gint
DECLARE FUNCTION g_convert(BYVAL AS CONST gchar PTR, BYVAL AS gssize, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS gsize PTR, BYVAL AS gsize PTR, BYVAL AS GError PTR PTR) AS gchar PTR
DECLARE FUNCTION g_convert_with_iconv(BYVAL AS CONST gchar PTR, BYVAL AS gssize, BYVAL AS GIConv, BYVAL AS gsize PTR, BYVAL AS gsize PTR, BYVAL AS GError PTR PTR) AS gchar PTR
DECLARE FUNCTION g_convert_with_fallback(BYVAL AS CONST gchar PTR, BYVAL AS gssize, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS gsize PTR, BYVAL AS gsize PTR, BYVAL AS GError PTR PTR) AS gchar PTR
DECLARE FUNCTION g_locale_to_utf8(BYVAL AS CONST gchar PTR, BYVAL AS gssize, BYVAL AS gsize PTR, BYVAL AS gsize PTR, BYVAL AS GError PTR PTR) AS gchar PTR
DECLARE FUNCTION g_locale_from_utf8(BYVAL AS CONST gchar PTR, BYVAL AS gssize, BYVAL AS gsize PTR, BYVAL AS gsize PTR, BYVAL AS GError PTR PTR) AS gchar PTR

#IFNDEF __GTK_DOC_IGNORE__
#IFDEF G_OS_WIN32
#DEFINE g_filename_to_utf8 g_filename_to_utf8_utf8
#DEFINE g_filename_from_utf8 g_filename_from_utf8_utf8
#DEFINE g_filename_from_uri g_filename_from_uri_utf8
#DEFINE g_filename_to_uri g_filename_to_uri_utf8
#ENDIF ' G_OS_WIN32
#ENDIF ' __GTK_DOC_IGNORE__

DECLARE FUNCTION g_filename_to_utf8(BYVAL AS CONST gchar PTR, BYVAL AS gssize, BYVAL AS gsize PTR, BYVAL AS gsize PTR, BYVAL AS GError PTR PTR) AS gchar PTR
DECLARE FUNCTION g_filename_from_utf8(BYVAL AS CONST gchar PTR, BYVAL AS gssize, BYVAL AS gsize PTR, BYVAL AS gsize PTR, BYVAL AS GError PTR PTR) AS gchar PTR
DECLARE FUNCTION g_filename_from_uri(BYVAL AS CONST gchar PTR, BYVAL AS gchar PTR PTR, BYVAL AS GError PTR PTR) AS gchar PTR
DECLARE FUNCTION g_filename_to_uri(BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS GError PTR PTR) AS gchar PTR
DECLARE FUNCTION g_filename_display_name(BYVAL AS CONST gchar PTR) AS gchar PTR
DECLARE FUNCTION g_get_filename_charsets(BYVAL AS CONST gchar PTR PTR PTR) AS gboolean
DECLARE FUNCTION g_filename_display_basename(BYVAL AS CONST gchar PTR) AS gchar PTR
DECLARE FUNCTION g_uri_list_extract_uris(BYVAL AS CONST gchar PTR) AS gchar PTR PTR

#ENDIF ' __G_CONVERT_H__

#IFNDEF __G_DATASET_H__
#DEFINE __G_DATASET_H__

TYPE GData AS _GData
TYPE GDataForeachFunc AS SUB(BYVAL AS GQuark, BYVAL AS gpointer, BYVAL AS gpointer)

DECLARE SUB g_datalist_init(BYVAL AS GData PTR PTR)
DECLARE SUB g_datalist_clear(BYVAL AS GData PTR PTR)
DECLARE FUNCTION g_datalist_id_get_data(BYVAL AS GData PTR PTR, BYVAL AS GQuark) AS gpointer
DECLARE SUB g_datalist_id_set_data_full(BYVAL AS GData PTR PTR, BYVAL AS GQuark, BYVAL AS gpointer, BYVAL AS GDestroyNotify)
DECLARE FUNCTION g_datalist_id_remove_no_notify(BYVAL AS GData PTR PTR, BYVAL AS GQuark) AS gpointer
DECLARE SUB g_datalist_foreach(BYVAL AS GData PTR PTR, BYVAL AS GDataForeachFunc, BYVAL AS gpointer)

#DEFINE G_DATALIST_FLAGS_MASK &h3

DECLARE SUB g_datalist_set_flags(BYVAL AS GData PTR PTR, BYVAL AS guint)
DECLARE SUB g_datalist_unset_flags(BYVAL AS GData PTR PTR, BYVAL AS guint)
DECLARE FUNCTION g_datalist_get_flags(BYVAL AS GData PTR PTR) AS guint

#DEFINE g_datalist_id_set_data(dl, q, d) _
     g_datalist_id_set_data_full ((dl), (q), (d), NULL)
#DEFINE g_datalist_id_remove_data(dl, q) _
     g_datalist_id_set_data ((dl), (q), NULL)
#DEFINE g_datalist_set_data_full(dl, k, d, f) _
     g_datalist_id_set_data_full ((dl), g_quark_from_string (k), (d), (f))
#DEFINE g_datalist_remove_no_notify(dl, k) _
     g_datalist_id_remove_no_notify ((dl), g_quark_try_string (k))
#DEFINE g_datalist_set_data(dl, k, d) _
     g_datalist_set_data_full ((dl), (k), (d), NULL)
#DEFINE g_datalist_remove_data(dl, k) _
     g_datalist_id_set_data ((dl), g_quark_try_string (k), NULL)

DECLARE SUB g_dataset_destroy(BYVAL AS gconstpointer)
DECLARE FUNCTION g_dataset_id_get_data(BYVAL AS gconstpointer, BYVAL AS GQuark) AS gpointer
DECLARE FUNCTION g_datalist_get_data(BYVAL AS GData PTR PTR, BYVAL AS CONST gchar PTR) AS gpointer
DECLARE SUB g_dataset_id_set_data_full(BYVAL AS gconstpointer, BYVAL AS GQuark, BYVAL AS gpointer, BYVAL AS GDestroyNotify)
DECLARE FUNCTION g_dataset_id_remove_no_notify(BYVAL AS gconstpointer, BYVAL AS GQuark) AS gpointer
DECLARE SUB g_dataset_foreach(BYVAL AS gconstpointer, BYVAL AS GDataForeachFunc, BYVAL AS gpointer)

#DEFINE g_dataset_id_set_data(l, k, d) _
     g_dataset_id_set_data_full ((l), (k), (d), NULL)
#DEFINE g_dataset_id_remove_data(l, k) _
     g_dataset_id_set_data ((l), (k), NULL)
#DEFINE g_dataset_get_data(l, k) _
     (g_dataset_id_get_data ((l), g_quark_try_string (k)))
#DEFINE g_dataset_set_data_full(l, k, d, f) _
     g_dataset_id_set_data_full ((l), g_quark_from_string (k), (d), (f))
#DEFINE g_dataset_remove_no_notify(l, k) _
     g_dataset_id_remove_no_notify ((l), g_quark_try_string (k))
#DEFINE g_dataset_set_data(l, k, d) _
     g_dataset_set_data_full ((l), (k), (d), NULL)
#DEFINE g_dataset_remove_data(l, k) _
     g_dataset_id_set_data ((l), g_quark_try_string (k), NULL)
#ENDIF ' __G_DATASET_H__

#IFNDEF __G_DATE_H__
#DEFINE __G_DATE_H__

TYPE GTime AS gint32
TYPE GDateYear AS guint16
TYPE GDateDay AS guint8
TYPE GDate AS _GDate

ENUM GDateDMY_
  G_DATE_DAY_ = 0
  G_DATE_MONTH_ = 1
  G_DATE_YEAR_ = 2
END ENUM

ENUM GDateWeekday
  G_DATE_BAD_WEEKDAY = 0
  G_DATE_MONDAY = 1
  G_DATE_TUESDAY = 2
  G_DATE_WEDNESDAY = 3
  G_DATE_THURSDAY = 4
  G_DATE_FRIDAY = 5
  G_DATE_SATURDAY = 6
  G_DATE_SUNDAY = 7
END ENUM

ENUM GDateMonth
  G_DATE_BAD_MONTH = 0
  G_DATE_JANUARY = 1
  G_DATE_FEBRUARY = 2
  G_DATE_MARCH = 3
  G_DATE_APRIL = 4
  G_DATE_MAY = 5
  G_DATE_JUNE = 6
  G_DATE_JULY = 7
  G_DATE_AUGUST = 8
  G_DATE_SEPTEMBER = 9
  G_DATE_OCTOBER = 10
  G_DATE_NOVEMBER = 11
  G_DATE_DECEMBER = 12
END ENUM

#DEFINE G_DATE_BAD_JULIAN 0U
#DEFINE G_DATE_BAD_DAY 0U
#DEFINE G_DATE_BAD_YEAR 0U

TYPE _GDate
  AS guint julian_days : 32
  AS guint julian : 1
  AS guint dmy : 1
  AS guint day : 6
  AS guint month : 4
  AS guint year : 16
END TYPE

DECLARE FUNCTION g_date_new() AS GDate PTR
DECLARE FUNCTION g_date_new_dmy(BYVAL AS GDateDay, BYVAL AS GDateMonth, BYVAL AS GDateYear) AS GDate PTR
DECLARE FUNCTION g_date_new_julian(BYVAL AS guint32) AS GDate PTR
DECLARE SUB g_date_free(BYVAL AS GDate PTR)
DECLARE FUNCTION g_date_valid(BYVAL AS CONST GDate PTR) AS gboolean
DECLARE FUNCTION g_date_valid_day(BYVAL AS GDateDay) AS gboolean
DECLARE FUNCTION g_date_valid_month(BYVAL AS GDateMonth) AS gboolean
DECLARE FUNCTION g_date_valid_year(BYVAL AS GDateYear) AS gboolean
DECLARE FUNCTION g_date_valid_weekday(BYVAL AS GDateWeekday) AS gboolean
DECLARE FUNCTION g_date_valid_julian(BYVAL AS guint32) AS gboolean
DECLARE FUNCTION g_date_valid_dmy(BYVAL AS GDateDay, BYVAL AS GDateMonth, BYVAL AS GDateYear) AS gboolean
DECLARE FUNCTION g_date_get_weekday(BYVAL AS CONST GDate PTR) AS GDateWeekday
DECLARE FUNCTION g_date_get_month(BYVAL AS CONST GDate PTR) AS GDateMonth
DECLARE FUNCTION g_date_get_year(BYVAL AS CONST GDate PTR) AS GDateYear
DECLARE FUNCTION g_date_get_day(BYVAL AS CONST GDate PTR) AS GDateDay
DECLARE FUNCTION g_date_get_julian(BYVAL AS CONST GDate PTR) AS guint32
DECLARE FUNCTION g_date_get_day_of_year(BYVAL AS CONST GDate PTR) AS guint
DECLARE FUNCTION g_date_get_monday_week_of_year(BYVAL AS CONST GDate PTR) AS guint
DECLARE FUNCTION g_date_get_sunday_week_of_year(BYVAL AS CONST GDate PTR) AS guint
DECLARE FUNCTION g_date_get_iso8601_week_of_year(BYVAL AS CONST GDate PTR) AS guint
DECLARE SUB g_date_clear(BYVAL AS GDate PTR, BYVAL AS guint)
DECLARE SUB g_date_set_parse(BYVAL AS GDate PTR, BYVAL AS CONST gchar PTR)
DECLARE SUB g_date_set_time_t(BYVAL AS GDate PTR, BYVAL AS time_t)
DECLARE SUB g_date_set_time_val(BYVAL AS GDate PTR, BYVAL AS GTimeVal PTR)

#IFNDEF G_DISABLE_DEPRECATED

DECLARE SUB g_date_set_time(BYVAL AS GDate PTR, BYVAL AS GTime)

#ENDIF ' G_DISABLE_DEPRECATED

DECLARE SUB g_date_set_month(BYVAL AS GDate PTR, BYVAL AS GDateMonth)
DECLARE SUB g_date_set_day(BYVAL AS GDate PTR, BYVAL AS GDateDay)
DECLARE SUB g_date_set_year(BYVAL AS GDate PTR, BYVAL AS GDateYear)
DECLARE SUB g_date_set_dmy(BYVAL AS GDate PTR, BYVAL AS GDateDay, BYVAL AS GDateMonth, BYVAL AS GDateYear)
DECLARE SUB g_date_set_julian(BYVAL AS GDate PTR, BYVAL AS guint32)
DECLARE FUNCTION g_date_is_first_of_month(BYVAL AS CONST GDate PTR) AS gboolean
DECLARE FUNCTION g_date_is_last_of_month(BYVAL AS CONST GDate PTR) AS gboolean
DECLARE SUB g_date_add_days(BYVAL AS GDate PTR, BYVAL AS guint)
DECLARE SUB g_date_subtract_days(BYVAL AS GDate PTR, BYVAL AS guint)
DECLARE SUB g_date_add_months(BYVAL AS GDate PTR, BYVAL AS guint)
DECLARE SUB g_date_subtract_months(BYVAL AS GDate PTR, BYVAL AS guint)
DECLARE SUB g_date_add_years(BYVAL AS GDate PTR, BYVAL AS guint)
DECLARE SUB g_date_subtract_years(BYVAL AS GDate PTR, BYVAL AS guint)
DECLARE FUNCTION g_date_is_leap_year(BYVAL AS GDateYear) AS gboolean
DECLARE FUNCTION g_date_get_days_in_month(BYVAL AS GDateMonth, BYVAL AS GDateYear) AS guint8
DECLARE FUNCTION g_date_get_monday_weeks_in_year(BYVAL AS GDateYear) AS guint8
DECLARE FUNCTION g_date_get_sunday_weeks_in_year(BYVAL AS GDateYear) AS guint8
DECLARE FUNCTION g_date_days_between(BYVAL AS CONST GDate PTR, BYVAL AS CONST GDate PTR) AS gint
DECLARE FUNCTION g_date_compare(BYVAL AS CONST GDate PTR, BYVAL AS CONST GDate PTR) AS gint
DECLARE SUB g_date_to_struct_tm(BYVAL AS CONST GDate PTR, BYVAL AS tm PTR)
DECLARE SUB g_date_clamp(BYVAL AS GDate PTR, BYVAL AS CONST GDate PTR, BYVAL AS CONST GDate PTR)
DECLARE SUB g_date_order(BYVAL AS GDate PTR, BYVAL AS GDate PTR)
DECLARE FUNCTION g_date_strftime(BYVAL AS gchar PTR, BYVAL AS gsize, BYVAL AS CONST gchar PTR, BYVAL AS CONST GDate PTR) AS gsize

#IFNDEF G_DISABLE_DEPRECATED
#DEFINE g_date_weekday g_date_get_weekday
#DEFINE g_date_month g_date_get_month
#DEFINE g_date_year g_date_get_year
#DEFINE g_date_day g_date_get_day
#DEFINE g_date_julian g_date_get_julian
#DEFINE g_date_day_of_year g_date_get_day_of_year
#DEFINE g_date_monday_week_of_year g_date_get_monday_week_of_year
#DEFINE g_date_sunday_week_of_year g_date_get_sunday_week_of_year
#DEFINE g_date_days_in_month g_date_get_days_in_month
#DEFINE g_date_monday_weeks_in_year g_date_get_monday_weeks_in_year
#DEFINE g_date_sunday_weeks_in_year g_date_get_sunday_weeks_in_year
#ENDIF ' G_DISABLE_DEPRECATED
#ENDIF ' __G_DATE_H__

#IFNDEF __G_DATE_TIME_H__
#DEFINE __G_DATE_TIME_H__

#IFNDEF __G_TIME_ZONE_H__
#DEFINE __G_TIME_ZONE_H__

TYPE GTimeZone AS _GTimeZone

ENUM GTimeType
  G_TIME_TYPE_STANDARD
  G_TIME_TYPE_DAYLIGHT
  G_TIME_TYPE_UNIVERSAL
END ENUM

DECLARE FUNCTION g_time_zone_new(BYVAL AS CONST gchar PTR) AS GTimeZone PTR
DECLARE FUNCTION g_time_zone_new_utc() AS GTimeZone PTR
DECLARE FUNCTION g_time_zone_new_local() AS GTimeZone PTR
DECLARE FUNCTION g_time_zone_ref(BYVAL AS GTimeZone PTR) AS GTimeZone PTR
DECLARE SUB g_time_zone_unref(BYVAL AS GTimeZone PTR)
DECLARE FUNCTION g_time_zone_find_interval(BYVAL AS GTimeZone PTR, BYVAL AS GTimeType, BYVAL AS gint64) AS gint
DECLARE FUNCTION g_time_zone_adjust_time(BYVAL AS GTimeZone PTR, BYVAL AS GTimeType, BYVAL AS gint64 PTR) AS gint
DECLARE FUNCTION g_time_zone_get_abbreviation(BYVAL AS GTimeZone PTR, BYVAL AS gint) AS CONST gchar PTR
DECLARE FUNCTION g_time_zone_get_offset(BYVAL AS GTimeZone PTR, BYVAL AS gint) AS gint32
DECLARE FUNCTION g_time_zone_is_dst(BYVAL AS GTimeZone PTR, BYVAL AS gint) AS gboolean

#ENDIF ' __G_TIME_ZONE_H__

#DEFINE G_TIME_SPAN_DAY (G_GINT64_CONSTANT (86400000000))
#DEFINE G_TIME_SPAN_HOUR (G_GINT64_CONSTANT (3600000000))
#DEFINE G_TIME_SPAN_MINUTE (G_GINT64_CONSTANT (60000000))
#DEFINE G_TIME_SPAN_SECOND (G_GINT64_CONSTANT (1000000))
#DEFINE G_TIME_SPAN_MILLISECOND (G_GINT64_CONSTANT (1000))

TYPE GTimeSpan AS gint64
TYPE GDateTime AS _GDateTime

DECLARE SUB g_date_time_unref(BYVAL AS GDateTime PTR)
DECLARE FUNCTION g_date_time_ref(BYVAL AS GDateTime PTR) AS GDateTime PTR
DECLARE FUNCTION g_date_time_new_now(BYVAL AS GTimeZone PTR) AS GDateTime PTR
DECLARE FUNCTION g_date_time_new_now_local() AS GDateTime PTR
DECLARE FUNCTION g_date_time_new_now_utc() AS GDateTime PTR
DECLARE FUNCTION g_date_time_new_from_unix_local(BYVAL AS gint64) AS GDateTime PTR
DECLARE FUNCTION g_date_time_new_from_unix_utc(BYVAL AS gint64) AS GDateTime PTR
DECLARE FUNCTION g_date_time_new_from_timeval_local(BYVAL AS CONST GTimeVal PTR) AS GDateTime PTR
DECLARE FUNCTION g_date_time_new_from_timeval_utc(BYVAL AS CONST GTimeVal PTR) AS GDateTime PTR
DECLARE FUNCTION g_date_time_new(BYVAL AS GTimeZone PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gdouble) AS GDateTime PTR
DECLARE FUNCTION g_date_time_new_local(BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gdouble) AS GDateTime PTR
DECLARE FUNCTION g_date_time_new_utc(BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gdouble) AS GDateTime PTR
DECLARE FUNCTION g_date_time_add(BYVAL AS GDateTime PTR, BYVAL AS GTimeSpan) AS GDateTime PTR
DECLARE FUNCTION g_date_time_add_years(BYVAL AS GDateTime PTR, BYVAL AS gint) AS GDateTime PTR
DECLARE FUNCTION g_date_time_add_months(BYVAL AS GDateTime PTR, BYVAL AS gint) AS GDateTime PTR
DECLARE FUNCTION g_date_time_add_weeks(BYVAL AS GDateTime PTR, BYVAL AS gint) AS GDateTime PTR
DECLARE FUNCTION g_date_time_add_days(BYVAL AS GDateTime PTR, BYVAL AS gint) AS GDateTime PTR
DECLARE FUNCTION g_date_time_add_hours(BYVAL AS GDateTime PTR, BYVAL AS gint) AS GDateTime PTR
DECLARE FUNCTION g_date_time_add_minutes(BYVAL AS GDateTime PTR, BYVAL AS gint) AS GDateTime PTR
DECLARE FUNCTION g_date_time_add_seconds(BYVAL AS GDateTime PTR, BYVAL AS gdouble) AS GDateTime PTR
DECLARE FUNCTION g_date_time_add_full(BYVAL AS GDateTime PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gdouble) AS GDateTime PTR
DECLARE FUNCTION g_date_time_compare(BYVAL AS gconstpointer, BYVAL AS gconstpointer) AS gint
DECLARE FUNCTION g_date_time_difference(BYVAL AS GDateTime PTR, BYVAL AS GDateTime PTR) AS GTimeSpan
DECLARE FUNCTION g_date_time_hash(BYVAL AS gconstpointer) AS guint
DECLARE FUNCTION g_date_time_equal(BYVAL AS gconstpointer, BYVAL AS gconstpointer) AS gboolean
DECLARE SUB g_date_time_get_ymd(BYVAL AS GDateTime PTR, BYVAL AS gint PTR, BYVAL AS gint PTR, BYVAL AS gint PTR)
DECLARE FUNCTION g_date_time_get_year(BYVAL AS GDateTime PTR) AS gint
DECLARE FUNCTION g_date_time_get_month(BYVAL AS GDateTime PTR) AS gint
DECLARE FUNCTION g_date_time_get_day_of_month(BYVAL AS GDateTime PTR) AS gint
DECLARE FUNCTION g_date_time_get_week_numbering_year(BYVAL AS GDateTime PTR) AS gint
DECLARE FUNCTION g_date_time_get_week_of_year(BYVAL AS GDateTime PTR) AS gint
DECLARE FUNCTION g_date_time_get_day_of_week(BYVAL AS GDateTime PTR) AS gint
DECLARE FUNCTION g_date_time_get_day_of_year(BYVAL AS GDateTime PTR) AS gint
DECLARE FUNCTION g_date_time_get_hour(BYVAL AS GDateTime PTR) AS gint
DECLARE FUNCTION g_date_time_get_minute(BYVAL AS GDateTime PTR) AS gint
DECLARE FUNCTION g_date_time_get_second(BYVAL AS GDateTime PTR) AS gint
DECLARE FUNCTION g_date_time_get_microsecond(BYVAL AS GDateTime PTR) AS gint
DECLARE FUNCTION g_date_time_get_seconds(BYVAL AS GDateTime PTR) AS gdouble
DECLARE FUNCTION g_date_time_to_unix(BYVAL AS GDateTime PTR) AS gint64
DECLARE FUNCTION g_date_time_to_timeval(BYVAL AS GDateTime PTR, BYVAL AS GTimeVal PTR) AS gboolean
DECLARE FUNCTION g_date_time_get_utc_offset(BYVAL AS GDateTime PTR) AS GTimeSpan
DECLARE FUNCTION g_date_time_get_timezone_abbreviation(BYVAL AS GDateTime PTR) AS CONST gchar PTR
DECLARE FUNCTION g_date_time_is_daylight_savings(BYVAL AS GDateTime PTR) AS gboolean
DECLARE FUNCTION g_date_time_to_timezone(BYVAL AS GDateTime PTR, BYVAL AS GTimeZone PTR) AS GDateTime PTR
DECLARE FUNCTION g_date_time_to_local(BYVAL AS GDateTime PTR) AS GDateTime PTR
DECLARE FUNCTION g_date_time_to_utc(BYVAL AS GDateTime PTR) AS GDateTime PTR
DECLARE FUNCTION g_date_time_format(BYVAL AS GDateTime PTR, BYVAL AS CONST gchar PTR) AS gchar PTR

#ENDIF ' __G_DATE_TIME_H__

#IFNDEF __G_DIR_H__
#DEFINE __G_DIR_H__

TYPE GDir AS _GDir

#IFNDEF __GTK_DOC_IGNORE__
#IFDEF G_OS_WIN32
#DEFINE g_dir_open g_dir_open_utf8
#DEFINE g_dir_read_name g_dir_read_name_utf8
#ENDIF ' G_OS_WIN32
#ENDIF ' __GTK_DOC_IGNORE__

DECLARE FUNCTION g_dir_open(BYVAL AS CONST gchar PTR, BYVAL AS guint, BYVAL AS GError PTR PTR) AS GDir PTR
DECLARE FUNCTION g_dir_read_name(BYVAL AS GDir PTR) AS CONST gchar PTR
DECLARE SUB g_dir_rewind(BYVAL AS GDir PTR)
DECLARE SUB g_dir_close(BYVAL AS GDir PTR)

#ENDIF ' __G_DIR_H__

#IFNDEF __G_ENVIRON_H__
#DEFINE __G_ENVIRON_H__

#IFNDEF __GTK_DOC_IGNORE__
#IFDEF G_OS_WIN32
#DEFINE g_getenv g_getenv_utf8
#DEFINE g_setenv g_setenv_utf8
#DEFINE g_unsetenv g_unsetenv_utf8
#ENDIF ' G_OS_WIN32
#ENDIF ' __GTK_DOC_IGNORE__

DECLARE FUNCTION g_getenv(BYVAL AS CONST gchar PTR) AS CONST gchar PTR
DECLARE FUNCTION g_setenv(BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS gboolean) AS gboolean
DECLARE SUB g_unsetenv(BYVAL AS CONST gchar PTR)
DECLARE FUNCTION g_listenv() AS gchar PTR PTR
DECLARE FUNCTION g_get_environ() AS gchar PTR PTR
DECLARE FUNCTION g_environ_getenv(BYVAL AS gchar PTR PTR, BYVAL AS CONST gchar PTR) AS CONST gchar PTR
DECLARE FUNCTION g_environ_setenv(BYVAL AS gchar PTR PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS gboolean) AS gchar PTR PTR
DECLARE FUNCTION g_environ_unsetenv(BYVAL AS gchar PTR PTR, BYVAL AS CONST gchar PTR) AS gchar PTR PTR

#ENDIF ' __G_ENVIRON_H__

#IFNDEF __G_FILEUTILS_H__
#DEFINE __G_FILEUTILS_H__

#DEFINE G_FILE_ERROR g_file_error_quark ()

ENUM GFileError
  G_FILE_ERROR_EXIST
  G_FILE_ERROR_ISDIR
  G_FILE_ERROR_ACCES
  G_FILE_ERROR_NAMETOOLONG
  G_FILE_ERROR_NOENT
  G_FILE_ERROR_NOTDIR
  G_FILE_ERROR_NXIO
  G_FILE_ERROR_NODEV
  G_FILE_ERROR_ROFS
  G_FILE_ERROR_TXTBSY
  G_FILE_ERROR_FAULT
  G_FILE_ERROR_LOOP
  G_FILE_ERROR_NOSPC
  G_FILE_ERROR_NOMEM
  G_FILE_ERROR_MFILE
  G_FILE_ERROR_NFILE
  G_FILE_ERROR_BADF
  G_FILE_ERROR_INVAL
  G_FILE_ERROR_PIPE
  G_FILE_ERROR_AGAIN
  G_FILE_ERROR_INTR
  G_FILE_ERROR_IO
  G_FILE_ERROR_PERM
  G_FILE_ERROR_NOSYS
  G_FILE_ERROR_FAILED
END ENUM

ENUM GFileTest
  G_FILE_TEST_IS_REGULAR = 1 SHL 0
  G_FILE_TEST_IS_SYMLINK = 1 SHL 1
  G_FILE_TEST_IS_DIR = 1 SHL 2
  G_FILE_TEST_IS_EXECUTABLE = 1 SHL 3
  G_FILE_TEST_EXISTS = 1 SHL 4
END ENUM

DECLARE FUNCTION g_file_error_quark() AS GQuark
DECLARE FUNCTION g_file_error_from_errno(BYVAL AS gint) AS GFileError

#IFNDEF __GTK_DOC_IGNORE__
#IFDEF G_OS_WIN32
#DEFINE g_file_test g_file_test_utf8
#DEFINE g_file_get_contents g_file_get_contents_utf8
#DEFINE g_mkstemp g_mkstemp_utf8
#DEFINE g_file_open_tmp g_file_open_tmp_utf8
#ENDIF ' G_OS_WIN32
#ENDIF ' __GTK_DOC_IGNORE__

DECLARE FUNCTION g_file_test(BYVAL AS CONST gchar PTR, BYVAL AS GFileTest) AS gboolean
DECLARE FUNCTION g_file_get_contents(BYVAL AS CONST gchar PTR, BYVAL AS gchar PTR PTR, BYVAL AS gsize PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_file_set_contents(BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS gssize, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_file_read_link(BYVAL AS CONST gchar PTR, BYVAL AS GError PTR PTR) AS gchar PTR
DECLARE FUNCTION g_mkdtemp(BYVAL AS gchar PTR) AS gchar PTR
DECLARE FUNCTION g_mkdtemp_full(BYVAL AS gchar PTR, BYVAL AS gint) AS gchar PTR
DECLARE FUNCTION g_mkstemp(BYVAL AS gchar PTR) AS gint
DECLARE FUNCTION g_mkstemp_full(BYVAL AS gchar PTR, BYVAL AS gint, BYVAL AS gint) AS gint
DECLARE FUNCTION g_file_open_tmp(BYVAL AS CONST gchar PTR, BYVAL AS gchar PTR PTR, BYVAL AS GError PTR PTR) AS gint
DECLARE FUNCTION g_dir_make_tmp(BYVAL AS CONST gchar PTR, BYVAL AS GError PTR PTR) AS gchar PTR
DECLARE FUNCTION g_build_path(BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, ...) AS gchar PTR
DECLARE FUNCTION g_build_pathv(BYVAL AS CONST gchar PTR, BYVAL AS gchar PTR PTR) AS gchar PTR
DECLARE FUNCTION g_build_filename(BYVAL AS CONST gchar PTR, ...) AS gchar PTR
DECLARE FUNCTION g_build_filenamev(BYVAL AS gchar PTR PTR) AS gchar PTR
DECLARE FUNCTION g_mkdir_with_parents(BYVAL AS CONST gchar PTR, BYVAL AS gint) AS gint

#IFDEF G_OS_WIN32
#DEFINE G_DIR_SEPARATOR ASC(!"\\")
#DEFINE G_DIR_SEPARATOR_S !"\\"
#DEFINE G_IS_DIR_SEPARATOR(c) ((c) = G_DIR_SEPARATOR ORELSE (c) = ASC(!"/"))
#DEFINE G_SEARCHPATH_SEPARATOR ASC(!";")
#DEFINE G_SEARCHPATH_SEPARATOR_S !";"
#ELSE ' G_OS_WIN32
#DEFINE G_DIR_SEPARATOR ASC(!"/")
#DEFINE G_DIR_SEPARATOR_S !"/"
#DEFINE G_IS_DIR_SEPARATOR(c) ((c) = G_DIR_SEPARATOR)
#DEFINE G_SEARCHPATH_SEPARATOR ASC(!":")
#DEFINE G_SEARCHPATH_SEPARATOR_S !":"
#ENDIF ' G_OS_WIN32

DECLARE FUNCTION g_path_is_absolute(BYVAL AS CONST gchar PTR) AS gboolean
DECLARE FUNCTION g_path_skip_root(BYVAL AS CONST gchar PTR) AS CONST gchar PTR
DECLARE FUNCTION g_basename(BYVAL AS CONST gchar PTR) AS CONST gchar PTR

#IFNDEF G_DISABLE_DEPRECATED
#DEFINE g_dirname g_path_get_dirname
#ENDIF ' G_DISABLE_DEPRECATED

#IFNDEF __GTK_DOC_IGNORE__
#IFDEF G_OS_WIN32
#DEFINE g_get_current_dir g_get_current_dir_utf8
#ENDIF ' G_OS_WIN32
#ENDIF ' __GTK_DOC_IGNORE__

DECLARE FUNCTION g_get_current_dir() AS gchar PTR
DECLARE FUNCTION g_path_get_basename(BYVAL AS CONST gchar PTR) AS gchar PTR
DECLARE FUNCTION g_path_get_dirname(BYVAL AS CONST gchar PTR) AS gchar PTR

#ENDIF ' __G_FILEUTILS_H__

#IFNDEF __G_GETTEXT_H__
#DEFINE __G_GETTEXT_H__

DECLARE FUNCTION g_strip_context(BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR) AS CONST gchar PTR
DECLARE FUNCTION g_dgettext(BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR) AS CONST gchar PTR
DECLARE FUNCTION g_dcgettext(BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint) AS CONST gchar PTR
DECLARE FUNCTION g_dngettext(BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS gulong) AS CONST gchar PTR
DECLARE FUNCTION g_dpgettext(BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS gsize) AS CONST gchar PTR
DECLARE FUNCTION g_dpgettext2(BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR) AS CONST gchar PTR

#ENDIF ' __G_GETTEXT_H__

#IFNDEF __G_HASH_H__
#DEFINE __G_HASH_H__

#IFNDEF __G_LIST_H__
#DEFINE __G_LIST_H__

#IFNDEF __G_MEM_H__
#DEFINE __G_MEM_H__

TYPE GMemVTable AS _GMemVTable

#IF GLIB_SIZEOF_VOID_P > GLIB_SIZEOF_LONG
#DEFINE G_MEM_ALIGN GLIB_SIZEOF_VOID_P
#ELSE ' GLIB_SIZEOF_VOI...
#DEFINE G_MEM_ALIGN GLIB_SIZEOF_LONG
#ENDIF ' GLIB_SIZEOF_VOI...

DECLARE SUB g_free(BYVAL AS gpointer)
DECLARE FUNCTION g_malloc(BYVAL AS gsize) AS gpointer
DECLARE FUNCTION g_malloc0(BYVAL AS gsize) AS gpointer
DECLARE FUNCTION g_realloc(BYVAL AS gpointer, BYVAL AS gsize) AS gpointer
DECLARE FUNCTION g_try_malloc(BYVAL AS gsize) AS gpointer
DECLARE FUNCTION g_try_malloc0(BYVAL AS gsize) AS gpointer
DECLARE FUNCTION g_try_realloc(BYVAL AS gpointer, BYVAL AS gsize) AS gpointer
DECLARE FUNCTION g_malloc_n(BYVAL AS gsize, BYVAL AS gsize) AS gpointer
DECLARE FUNCTION g_malloc0_n(BYVAL AS gsize, BYVAL AS gsize) AS gpointer
DECLARE FUNCTION g_realloc_n(BYVAL AS gpointer, BYVAL AS gsize, BYVAL AS gsize) AS gpointer
DECLARE FUNCTION g_try_malloc_n(BYVAL AS gsize, BYVAL AS gsize) AS gpointer
DECLARE FUNCTION g_try_malloc0_n(BYVAL AS gsize, BYVAL AS gsize) AS gpointer
DECLARE FUNCTION g_try_realloc_n(BYVAL AS gpointer, BYVAL AS gsize, BYVAL AS gsize) AS gpointer

#DEFINE _G_NEW(struct_type, n_structs, func) _
        (CAST(struct_type PTR, g_##func##_n ((n_structs), SIZEOF (struct_type))))
#DEFINE _G_RENEW(struct_type, mem, n_structs, func) _
        (CAST(struct_type PTR, g_##func##_n (mem, (n_structs), SIZEOF (struct_type))))

#DEFINE g_new(struct_type, n_structs) _G_NEW (struct_type, n_structs, malloc)
#DEFINE g_new0(struct_type, n_structs) _G_NEW (struct_type, n_structs, malloc0)
#DEFINE g_renew(struct_type, mem, n_structs) _G_RENEW (struct_type, mem, n_structs, realloc)
#DEFINE g_try_new(struct_type, n_structs) _G_NEW (struct_type, n_structs, try_malloc)
#DEFINE g_try_new0(struct_type, n_structs) _G_NEW (struct_type, n_structs, try_malloc0)
#DEFINE g_try_renew(struct_type, mem, n_structs) _G_RENEW (struct_type, mem, n_structs, try_realloc)

TYPE _GMemVTable
  malloc AS FUNCTION(BYVAL AS gsize) AS gpointer
  realloc AS FUNCTION(BYVAL AS gpointer, BYVAL AS gsize) AS gpointer
  free AS SUB(BYVAL AS gpointer)
  calloc AS FUNCTION(BYVAL AS gsize, BYVAL AS gsize) AS gpointer
  try_malloc AS FUNCTION(BYVAL AS gsize) AS gpointer
  try_realloc AS FUNCTION(BYVAL AS gpointer, BYVAL AS gsize) AS gpointer
END TYPE

DECLARE SUB g_mem_set_vtable(BYVAL AS GMemVTable PTR)
DECLARE FUNCTION g_mem_is_system_malloc() AS gboolean

EXTERN AS gboolean g_mem_gc_friendly
EXTERN AS GMemVTable PTR glib_mem_profiler_table

DECLARE SUB g_mem_profile()

#ENDIF ' __G_MEM_H__

TYPE GList AS _GList

TYPE _GList
  AS gpointer data
  AS GList PTR next
  AS GList PTR prev
END TYPE

DECLARE FUNCTION g_list_alloc() AS GList PTR
DECLARE SUB g_list_free(BYVAL AS GList PTR)
DECLARE SUB g_list_free_1(BYVAL AS GList PTR)

#DEFINE g_list_free1 g_list_free_1

DECLARE SUB g_list_free_full(BYVAL AS GList PTR, BYVAL AS GDestroyNotify)
DECLARE FUNCTION g_list_append(BYVAL AS GList PTR, BYVAL AS gpointer) AS GList PTR
DECLARE FUNCTION g_list_prepend(BYVAL AS GList PTR, BYVAL AS gpointer) AS GList PTR
DECLARE FUNCTION g_list_insert(BYVAL AS GList PTR, BYVAL AS gpointer, BYVAL AS gint) AS GList PTR
DECLARE FUNCTION g_list_insert_sorted(BYVAL AS GList PTR, BYVAL AS gpointer, BYVAL AS GCompareFunc) AS GList PTR
DECLARE FUNCTION g_list_insert_sorted_with_data(BYVAL AS GList PTR, BYVAL AS gpointer, BYVAL AS GCompareDataFunc, BYVAL AS gpointer) AS GList PTR
DECLARE FUNCTION g_list_insert_before(BYVAL AS GList PTR, BYVAL AS GList PTR, BYVAL AS gpointer) AS GList PTR
DECLARE FUNCTION g_list_concat(BYVAL AS GList PTR, BYVAL AS GList PTR) AS GList PTR
DECLARE FUNCTION g_list_remove(BYVAL AS GList PTR, BYVAL AS gconstpointer) AS GList PTR
DECLARE FUNCTION g_list_remove_all(BYVAL AS GList PTR, BYVAL AS gconstpointer) AS GList PTR
DECLARE FUNCTION g_list_remove_link(BYVAL AS GList PTR, BYVAL AS GList PTR) AS GList PTR
DECLARE FUNCTION g_list_delete_link(BYVAL AS GList PTR, BYVAL AS GList PTR) AS GList PTR
DECLARE FUNCTION g_list_reverse(BYVAL AS GList PTR) AS GList PTR
DECLARE FUNCTION g_list_copy(BYVAL AS GList PTR) AS GList PTR
DECLARE FUNCTION g_list_nth(BYVAL AS GList PTR, BYVAL AS guint) AS GList PTR
DECLARE FUNCTION g_list_nth_prev(BYVAL AS GList PTR, BYVAL AS guint) AS GList PTR
DECLARE FUNCTION g_list_find(BYVAL AS GList PTR, BYVAL AS gconstpointer) AS GList PTR
DECLARE FUNCTION g_list_find_custom(BYVAL AS GList PTR, BYVAL AS gconstpointer, BYVAL AS GCompareFunc) AS GList PTR
DECLARE FUNCTION g_list_position(BYVAL AS GList PTR, BYVAL AS GList PTR) AS gint
DECLARE FUNCTION g_list_index(BYVAL AS GList PTR, BYVAL AS gconstpointer) AS gint
DECLARE FUNCTION g_list_last(BYVAL AS GList PTR) AS GList PTR
DECLARE FUNCTION g_list_first(BYVAL AS GList PTR) AS GList PTR
DECLARE FUNCTION g_list_length(BYVAL AS GList PTR) AS guint
DECLARE SUB g_list_foreach(BYVAL AS GList PTR, BYVAL AS GFunc, BYVAL AS gpointer)
DECLARE FUNCTION g_list_sort(BYVAL AS GList PTR, BYVAL AS GCompareFunc) AS GList PTR
DECLARE FUNCTION g_list_sort_with_data(BYVAL AS GList PTR, BYVAL AS GCompareDataFunc, BYVAL AS gpointer) AS GList PTR
DECLARE FUNCTION g_list_nth_data(BYVAL AS GList PTR, BYVAL AS guint) AS gpointer

#DEFINE g_list_previous(list) IIF((list) , ((CAST(GList PTR, (list)))->prev) , NULL)
#DEFINE g_list_next(list) IIF((list) , ((CAST(GList PTR, (list)))->next) , NULL)
#ENDIF ' __G_LIST_H__

TYPE GHashTable AS _GHashTable
TYPE GHRFunc AS FUNCTION(BYVAL AS gpointer, BYVAL AS gpointer, BYVAL AS gpointer) AS gboolean
TYPE GHashTableIter AS _GHashTableIter

TYPE _GHashTableIter
  AS gpointer dummy1
  AS gpointer dummy2
  AS gpointer dummy3
  AS INTEGER dummy4
  AS gboolean dummy5
  AS gpointer dummy6
END TYPE

DECLARE FUNCTION g_hash_table_new(BYVAL AS GHashFunc, BYVAL AS GEqualFunc) AS GHashTable PTR
DECLARE FUNCTION g_hash_table_new_full(BYVAL AS GHashFunc, BYVAL AS GEqualFunc, BYVAL AS GDestroyNotify, BYVAL AS GDestroyNotify) AS GHashTable PTR
DECLARE SUB g_hash_table_destroy(BYVAL AS GHashTable PTR)
DECLARE SUB g_hash_table_insert(BYVAL AS GHashTable PTR, BYVAL AS gpointer, BYVAL AS gpointer)
DECLARE SUB g_hash_table_replace(BYVAL AS GHashTable PTR, BYVAL AS gpointer, BYVAL AS gpointer)
DECLARE FUNCTION g_hash_table_remove(BYVAL AS GHashTable PTR, BYVAL AS gconstpointer) AS gboolean
DECLARE SUB g_hash_table_remove_all(BYVAL AS GHashTable PTR)
DECLARE FUNCTION g_hash_table_steal(BYVAL AS GHashTable PTR, BYVAL AS gconstpointer) AS gboolean
DECLARE SUB g_hash_table_steal_all(BYVAL AS GHashTable PTR)
DECLARE FUNCTION g_hash_table_lookup(BYVAL AS GHashTable PTR, BYVAL AS gconstpointer) AS gpointer
DECLARE FUNCTION g_hash_table_lookup_extended(BYVAL AS GHashTable PTR, BYVAL AS gconstpointer, BYVAL AS gpointer PTR, BYVAL AS gpointer PTR) AS gboolean
DECLARE SUB g_hash_table_foreach(BYVAL AS GHashTable PTR, BYVAL AS GHFunc, BYVAL AS gpointer)
DECLARE FUNCTION g_hash_table_find(BYVAL AS GHashTable PTR, BYVAL AS GHRFunc, BYVAL AS gpointer) AS gpointer
DECLARE FUNCTION g_hash_table_foreach_remove(BYVAL AS GHashTable PTR, BYVAL AS GHRFunc, BYVAL AS gpointer) AS guint
DECLARE FUNCTION g_hash_table_foreach_steal(BYVAL AS GHashTable PTR, BYVAL AS GHRFunc, BYVAL AS gpointer) AS guint
DECLARE FUNCTION g_hash_table_size(BYVAL AS GHashTable PTR) AS guint
DECLARE FUNCTION g_hash_table_get_keys(BYVAL AS GHashTable PTR) AS GList PTR
DECLARE FUNCTION g_hash_table_get_values(BYVAL AS GHashTable PTR) AS GList PTR
DECLARE SUB g_hash_table_iter_init(BYVAL AS GHashTableIter PTR, BYVAL AS GHashTable PTR)
DECLARE FUNCTION g_hash_table_iter_next(BYVAL AS GHashTableIter PTR, BYVAL AS gpointer PTR, BYVAL AS gpointer PTR) AS gboolean
DECLARE FUNCTION g_hash_table_iter_get_hash_table(BYVAL AS GHashTableIter PTR) AS GHashTable PTR
DECLARE SUB g_hash_table_iter_remove(BYVAL AS GHashTableIter PTR)
DECLARE SUB g_hash_table_iter_replace(BYVAL AS GHashTableIter PTR, BYVAL AS gpointer)
DECLARE SUB g_hash_table_iter_steal(BYVAL AS GHashTableIter PTR)
DECLARE FUNCTION g_hash_table_ref(BYVAL AS GHashTable PTR) AS GHashTable PTR
DECLARE SUB g_hash_table_unref(BYVAL AS GHashTable PTR)

#IFNDEF G_DISABLE_DEPRECATED
#DEFINE g_hash_table_freeze(hash_table) (CAST(ANY, 0))
#DEFINE g_hash_table_thaw(hash_table) (CAST(ANY, 0))
#ENDIF ' G_DISABLE_DEPRECATED

DECLARE FUNCTION g_str_equal(BYVAL AS gconstpointer, BYVAL AS gconstpointer) AS gboolean
DECLARE FUNCTION g_str_hash(BYVAL AS gconstpointer) AS guint
DECLARE FUNCTION g_int_equal(BYVAL AS gconstpointer, BYVAL AS gconstpointer) AS gboolean
DECLARE FUNCTION g_int_hash(BYVAL AS gconstpointer) AS guint
DECLARE FUNCTION g_int64_equal(BYVAL AS gconstpointer, BYVAL AS gconstpointer) AS gboolean
DECLARE FUNCTION g_int64_hash(BYVAL AS gconstpointer) AS guint
DECLARE FUNCTION g_double_equal(BYVAL AS gconstpointer, BYVAL AS gconstpointer) AS gboolean
DECLARE FUNCTION g_double_hash(BYVAL AS gconstpointer) AS guint
DECLARE FUNCTION g_direct_hash(BYVAL AS gconstpointer) AS guint
DECLARE FUNCTION g_direct_equal(BYVAL AS gconstpointer, BYVAL AS gconstpointer) AS gboolean

#ENDIF ' __G_HASH_H__

#IFNDEF __G_HMAC_H__
#DEFINE __G_HMAC_H__

TYPE GHmac AS _GHmac

DECLARE FUNCTION g_hmac_new(BYVAL AS GChecksumType, BYVAL AS CONST guchar PTR, BYVAL AS gsize) AS GHmac PTR
DECLARE FUNCTION g_hmac_copy(BYVAL AS CONST GHmac PTR) AS GHmac PTR
DECLARE FUNCTION g_hmac_ref(BYVAL AS GHmac PTR) AS GHmac PTR
DECLARE SUB g_hmac_unref(BYVAL AS GHmac PTR)
DECLARE SUB g_hmac_update(BYVAL AS GHmac PTR, BYVAL AS CONST guchar PTR, BYVAL AS gssize)
DECLARE FUNCTION g_hmac_get_string(BYVAL AS GHmac PTR) AS CONST gchar PTR
DECLARE SUB g_hmac_get_digest(BYVAL AS GHmac PTR, BYVAL AS guint8 PTR, BYVAL AS gsize PTR)
DECLARE FUNCTION g_compute_hmac_for_data(BYVAL AS GChecksumType, BYVAL AS CONST guchar PTR, BYVAL AS gsize, BYVAL AS CONST guchar PTR, BYVAL AS gsize) AS gchar PTR
DECLARE FUNCTION g_compute_hmac_for_string(BYVAL AS GChecksumType, BYVAL AS CONST guchar PTR, BYVAL AS gsize, BYVAL AS CONST gchar PTR, BYVAL AS gssize) AS gchar PTR

#ENDIF ' __G_HMAC_H__

#IFNDEF __G_HOOK_H__
#DEFINE __G_HOOK_H__

TYPE GHook AS _GHook
TYPE GHookList AS _GHookList
TYPE GHookCompareFunc AS FUNCTION(BYVAL AS GHook PTR, BYVAL AS GHook PTR) AS gint
TYPE GHookFindFunc AS FUNCTION(BYVAL AS GHook PTR, BYVAL AS gpointer) AS gboolean
TYPE GHookMarshaller AS SUB(BYVAL AS GHook PTR, BYVAL AS gpointer)
TYPE GHookCheckMarshaller AS FUNCTION(BYVAL AS GHook PTR, BYVAL AS gpointer) AS gboolean
TYPE GHookFunc AS SUB(BYVAL AS gpointer)
TYPE GHookCheckFunc AS FUNCTION(BYVAL AS gpointer) AS gboolean
TYPE GHookFinalizeFunc AS SUB(BYVAL AS GHookList PTR, BYVAL AS GHook PTR)

ENUM GHookFlagMask
  G_HOOK_FLAG_ACTIVE = 1 SHL 0
  G_HOOK_FLAG_IN_CALL = 1 SHL 1
  G_HOOK_FLAG_MASK = &h0F
END ENUM

#DEFINE G_HOOK_FLAG_USER_SHIFT (4)

TYPE _GHookList
  AS gulong seq_id
  AS guint hook_size : 16
  AS guint is_setup : 1
  AS GHook PTR hooks
  AS gpointer dummy3
  AS GHookFinalizeFunc finalize_hook
  AS gpointer dummy(1)
END TYPE

TYPE _GHook
  AS gpointer data
  AS GHook PTR next
  AS GHook PTR prev
  AS guint ref_count
  AS gulong hook_id
  AS guint flags
  AS gpointer func
  AS GDestroyNotify destroy
END TYPE

#DEFINE G_HOOK(hook) (CAST(GHook PTR, (hook)))
#DEFINE G_HOOK_FLAGS(hook) (G_HOOK (hook)->flags)
#DEFINE G_HOOK_ACTIVE(hook) ((G_HOOK_FLAGS (hook) AND _
       G_HOOK_FLAG_ACTIVE) <> 0)
#DEFINE G_HOOK_IN_CALL(hook) ((G_HOOK_FLAGS (hook) AND _
       G_HOOK_FLAG_IN_CALL) <> 0)
#DEFINE G_HOOK_IS_VALID(hook) (G_HOOK (hook)->hook_id <> 0 ANDALSO _
      (G_HOOK_FLAGS (hook) AND G_HOOK_FLAG_ACTIVE))
#DEFINE G_HOOK_IS_UNLINKED(hook) (G_HOOK (hook)->next = NULL ANDALSO _
      G_HOOK (hook)->prev = NULL ANDALSO _
      G_HOOK (hook)->hook_id = 0 ANDALSO _
      G_HOOK (hook)->ref_count = 0)

DECLARE SUB g_hook_list_init(BYVAL AS GHookList PTR, BYVAL AS guint)
DECLARE SUB g_hook_list_clear(BYVAL AS GHookList PTR)
DECLARE FUNCTION g_hook_alloc(BYVAL AS GHookList PTR) AS GHook PTR
DECLARE SUB g_hook_free(BYVAL AS GHookList PTR, BYVAL AS GHook PTR)
DECLARE FUNCTION g_hook_ref(BYVAL AS GHookList PTR, BYVAL AS GHook PTR) AS GHook PTR
DECLARE SUB g_hook_unref(BYVAL AS GHookList PTR, BYVAL AS GHook PTR)
DECLARE FUNCTION g_hook_destroy(BYVAL AS GHookList PTR, BYVAL AS gulong) AS gboolean
DECLARE SUB g_hook_destroy_link(BYVAL AS GHookList PTR, BYVAL AS GHook PTR)
DECLARE SUB g_hook_prepend(BYVAL AS GHookList PTR, BYVAL AS GHook PTR)
DECLARE SUB g_hook_insert_before(BYVAL AS GHookList PTR, BYVAL AS GHook PTR, BYVAL AS GHook PTR)
DECLARE SUB g_hook_insert_sorted(BYVAL AS GHookList PTR, BYVAL AS GHook PTR, BYVAL AS GHookCompareFunc)
DECLARE FUNCTION g_hook_get(BYVAL AS GHookList PTR, BYVAL AS gulong) AS GHook PTR
DECLARE FUNCTION g_hook_find(BYVAL AS GHookList PTR, BYVAL AS gboolean, BYVAL AS GHookFindFunc, BYVAL AS gpointer) AS GHook PTR
DECLARE FUNCTION g_hook_find_data(BYVAL AS GHookList PTR, BYVAL AS gboolean, BYVAL AS gpointer) AS GHook PTR
DECLARE FUNCTION g_hook_find_func(BYVAL AS GHookList PTR, BYVAL AS gboolean, BYVAL AS gpointer) AS GHook PTR
DECLARE FUNCTION g_hook_find_func_data(BYVAL AS GHookList PTR, BYVAL AS gboolean, BYVAL AS gpointer, BYVAL AS gpointer) AS GHook PTR
DECLARE FUNCTION g_hook_first_valid(BYVAL AS GHookList PTR, BYVAL AS gboolean) AS GHook PTR
DECLARE FUNCTION g_hook_next_valid(BYVAL AS GHookList PTR, BYVAL AS GHook PTR, BYVAL AS gboolean) AS GHook PTR
DECLARE FUNCTION g_hook_compare_ids(BYVAL AS GHook PTR, BYVAL AS GHook PTR) AS gint

#DEFINE g_hook_append( hook_list, hook ) _
     g_hook_insert_before ((hook_list), NULL, (hook))

DECLARE SUB g_hook_list_invoke(BYVAL AS GHookList PTR, BYVAL AS gboolean)
DECLARE SUB g_hook_list_invoke_check(BYVAL AS GHookList PTR, BYVAL AS gboolean)
DECLARE SUB g_hook_list_marshal(BYVAL AS GHookList PTR, BYVAL AS gboolean, BYVAL AS GHookMarshaller, BYVAL AS gpointer)
DECLARE SUB g_hook_list_marshal_check(BYVAL AS GHookList PTR, BYVAL AS gboolean, BYVAL AS GHookCheckMarshaller, BYVAL AS gpointer)

#ENDIF ' __G_HOOK_H__

#IFNDEF __G_HOST_UTILS_H__
#DEFINE __G_HOST_UTILS_H__

DECLARE FUNCTION g_hostname_is_non_ascii(BYVAL AS CONST gchar PTR) AS gboolean
DECLARE FUNCTION g_hostname_is_ascii_encoded(BYVAL AS CONST gchar PTR) AS gboolean
DECLARE FUNCTION g_hostname_is_ip_address(BYVAL AS CONST gchar PTR) AS gboolean
DECLARE FUNCTION g_hostname_to_ascii(BYVAL AS CONST gchar PTR) AS gchar PTR
DECLARE FUNCTION g_hostname_to_unicode(BYVAL AS CONST gchar PTR) AS gchar PTR

#ENDIF ' __G_HOST_UTILS_H__

#IFNDEF __G_IOCHANNEL_H__
#DEFINE __G_IOCHANNEL_H__

#IFNDEF __G_MAIN_H__
#DEFINE __G_MAIN_H__

#IFNDEF __G_POLL_H__
#DEFINE __G_POLL_H__

TYPE GPollFD AS _GPollFD
TYPE GPollFunc AS FUNCTION(BYVAL AS GPollFD PTR, BYVAL AS guint, BYVAL AS gint) AS gint

TYPE _GPollFD
#IF DEFINED (G_OS_WIN32) AND GLIB_SIZEOF_VOID_P = 8
  AS gint64 fd
#ELSE ' DEFINED (G_OS_W...
  AS gint fd
#ENDIF ' DEFINED (G_OS_W...
  AS gushort events
  AS gushort revents
END TYPE

#IFDEF G_OS_WIN32
#IF GLIB_SIZEOF_VOID_P = 8
#DEFINE G_POLLFD_FORMAT !"%#I64x"
#ELSE ' GLIB_SIZEOF_VOI...
#DEFINE G_POLLFD_FORMAT !"%#x"
#ENDIF ' GLIB_SIZEOF_VOI...
#ELSE ' G_OS_WIN32
#DEFINE G_POLLFD_FORMAT !"%d"
#ENDIF ' G_OS_WIN32

DECLARE FUNCTION g_poll(BYVAL AS GPollFD PTR, BYVAL AS guint, BYVAL AS gint) AS gint

#ENDIF ' __G_POLL_H__

#IFNDEF __G_SLIST_H__
#DEFINE __G_SLIST_H__

TYPE GSList AS _GSList

TYPE _GSList
  AS gpointer data
  AS GSList PTR next
END TYPE

DECLARE FUNCTION g_slist_alloc() AS GSList PTR
DECLARE SUB g_slist_free(BYVAL AS GSList PTR)
DECLARE SUB g_slist_free_1(BYVAL AS GSList PTR)

#DEFINE g_slist_free1 g_slist_free_1

DECLARE SUB g_slist_free_full(BYVAL AS GSList PTR, BYVAL AS GDestroyNotify)
DECLARE FUNCTION g_slist_append(BYVAL AS GSList PTR, BYVAL AS gpointer) AS GSList PTR
DECLARE FUNCTION g_slist_prepend(BYVAL AS GSList PTR, BYVAL AS gpointer) AS GSList PTR
DECLARE FUNCTION g_slist_insert(BYVAL AS GSList PTR, BYVAL AS gpointer, BYVAL AS gint) AS GSList PTR
DECLARE FUNCTION g_slist_insert_sorted(BYVAL AS GSList PTR, BYVAL AS gpointer, BYVAL AS GCompareFunc) AS GSList PTR
DECLARE FUNCTION g_slist_insert_sorted_with_data(BYVAL AS GSList PTR, BYVAL AS gpointer, BYVAL AS GCompareDataFunc, BYVAL AS gpointer) AS GSList PTR
DECLARE FUNCTION g_slist_insert_before(BYVAL AS GSList PTR, BYVAL AS GSList PTR, BYVAL AS gpointer) AS GSList PTR
DECLARE FUNCTION g_slist_concat(BYVAL AS GSList PTR, BYVAL AS GSList PTR) AS GSList PTR
DECLARE FUNCTION g_slist_remove(BYVAL AS GSList PTR, BYVAL AS gconstpointer) AS GSList PTR
DECLARE FUNCTION g_slist_remove_all(BYVAL AS GSList PTR, BYVAL AS gconstpointer) AS GSList PTR
DECLARE FUNCTION g_slist_remove_link(BYVAL AS GSList PTR, BYVAL AS GSList PTR) AS GSList PTR
DECLARE FUNCTION g_slist_delete_link(BYVAL AS GSList PTR, BYVAL AS GSList PTR) AS GSList PTR
DECLARE FUNCTION g_slist_reverse(BYVAL AS GSList PTR) AS GSList PTR
DECLARE FUNCTION g_slist_copy(BYVAL AS GSList PTR) AS GSList PTR
DECLARE FUNCTION g_slist_nth(BYVAL AS GSList PTR, BYVAL AS guint) AS GSList PTR
DECLARE FUNCTION g_slist_find(BYVAL AS GSList PTR, BYVAL AS gconstpointer) AS GSList PTR
DECLARE FUNCTION g_slist_find_custom(BYVAL AS GSList PTR, BYVAL AS gconstpointer, BYVAL AS GCompareFunc) AS GSList PTR
DECLARE FUNCTION g_slist_position(BYVAL AS GSList PTR, BYVAL AS GSList PTR) AS gint
DECLARE FUNCTION g_slist_index(BYVAL AS GSList PTR, BYVAL AS gconstpointer) AS gint
DECLARE FUNCTION g_slist_last(BYVAL AS GSList PTR) AS GSList PTR
DECLARE FUNCTION g_slist_length(BYVAL AS GSList PTR) AS guint
DECLARE SUB g_slist_foreach(BYVAL AS GSList PTR, BYVAL AS GFunc, BYVAL AS gpointer)
DECLARE FUNCTION g_slist_sort(BYVAL AS GSList PTR, BYVAL AS GCompareFunc) AS GSList PTR
DECLARE FUNCTION g_slist_sort_with_data(BYVAL AS GSList PTR, BYVAL AS GCompareDataFunc, BYVAL AS gpointer) AS GSList PTR
DECLARE FUNCTION g_slist_nth_data(BYVAL AS GSList PTR, BYVAL AS guint) AS gpointer

#DEFINE g_slist_next(slist) IIF((slist) , ((CAST(GSList PTR, (slist)))->next) , NULL)
#ENDIF ' __G_SLIST_H__

TYPE GMainContext AS _GMainContext
TYPE GMainLoop AS _GMainLoop
TYPE GSource AS _GSource
TYPE GSourcePrivate AS _GSourcePrivate
TYPE GSourceCallbackFuncs AS _GSourceCallbackFuncs
TYPE GSourceFuncs AS _GSourceFuncs
TYPE GSourceFunc AS FUNCTION(BYVAL AS gpointer) AS gboolean
TYPE GChildWatchFunc AS SUB(BYVAL AS GPid, BYVAL AS gint, BYVAL AS gpointer)

TYPE _GSource
  AS gpointer callback_data
  AS GSourceCallbackFuncs PTR callback_funcs
  AS GSourceFuncs PTR source_funcs
  AS guint ref_count
  AS GMainContext PTR context
  AS gint priority
  AS guint flags
  AS guint source_id
  AS GSList PTR poll_fds
  AS GSource PTR prev
  AS GSource PTR next
  AS ZSTRING PTR name
  AS GSourcePrivate PTR priv
END TYPE

TYPE _GSourceCallbackFuncs
  ref AS SUB(BYVAL AS gpointer)
  unref AS SUB(BYVAL AS gpointer)
  get_ AS SUB(BYVAL AS gpointer, BYVAL AS GSource PTR, BYVAL AS GSourceFunc, BYVAL AS gpointer PTR)
END TYPE

TYPE GSourceDummyMarshal AS SUB()

TYPE _GSourceFuncs
  prepare AS FUNCTION(BYVAL AS GSource PTR, BYVAL AS gint PTR) AS gboolean
  check AS FUNCTION(BYVAL AS GSource PTR) AS gboolean
  dispatch AS FUNCTION(BYVAL AS GSource PTR, BYVAL AS GSourceFunc, BYVAL AS gpointer) AS gboolean
  finalize AS SUB(BYVAL AS GSource PTR)
  AS GSourceFunc closure_callback
  AS GSourceDummyMarshal closure_marshal
END TYPE

#DEFINE G_PRIORITY_HIGH -100
#DEFINE G_PRIORITY_DEFAULT 0
#DEFINE G_PRIORITY_HIGH_IDLE 100
#DEFINE G_PRIORITY_DEFAULT_IDLE 200
#DEFINE G_PRIORITY_LOW 300
#DEFINE G_SOURCE_REMOVE FALSE
#DEFINE G_SOURCE_CONTINUE TRUE

DECLARE FUNCTION g_main_context_new() AS GMainContext PTR
DECLARE FUNCTION g_main_context_ref(BYVAL AS GMainContext PTR) AS GMainContext PTR
DECLARE SUB g_main_context_unref(BYVAL AS GMainContext PTR)
DECLARE FUNCTION g_main_context_default() AS GMainContext PTR
DECLARE FUNCTION g_main_context_iteration(BYVAL AS GMainContext PTR, BYVAL AS gboolean) AS gboolean
DECLARE FUNCTION g_main_context_pending(BYVAL AS GMainContext PTR) AS gboolean
DECLARE FUNCTION g_main_context_find_source_by_id(BYVAL AS GMainContext PTR, BYVAL AS guint) AS GSource PTR
DECLARE FUNCTION g_main_context_find_source_by_user_data(BYVAL AS GMainContext PTR, BYVAL AS gpointer) AS GSource PTR
DECLARE FUNCTION g_main_context_find_source_by_funcs_user_data(BYVAL AS GMainContext PTR, BYVAL AS GSourceFuncs PTR, BYVAL AS gpointer) AS GSource PTR
DECLARE SUB g_main_context_wakeup(BYVAL AS GMainContext PTR)
DECLARE FUNCTION g_main_context_acquire(BYVAL AS GMainContext PTR) AS gboolean
DECLARE SUB g_main_context_release(BYVAL AS GMainContext PTR)
DECLARE FUNCTION g_main_context_is_owner(BYVAL AS GMainContext PTR) AS gboolean
DECLARE FUNCTION g_main_context_wait(BYVAL AS GMainContext PTR, BYVAL AS GCond PTR, BYVAL AS GMutex PTR) AS gboolean
DECLARE FUNCTION g_main_context_prepare(BYVAL AS GMainContext PTR, BYVAL AS gint PTR) AS gboolean
DECLARE FUNCTION g_main_context_query(BYVAL AS GMainContext PTR, BYVAL AS gint, BYVAL AS gint PTR, BYVAL AS GPollFD PTR, BYVAL AS gint) AS gint
DECLARE FUNCTION g_main_context_check(BYVAL AS GMainContext PTR, BYVAL AS gint, BYVAL AS GPollFD PTR, BYVAL AS gint) AS gint
DECLARE SUB g_main_context_dispatch(BYVAL AS GMainContext PTR)
DECLARE SUB g_main_context_set_poll_func(BYVAL AS GMainContext PTR, BYVAL AS GPollFunc)
DECLARE FUNCTION g_main_context_get_poll_func(BYVAL AS GMainContext PTR) AS GPollFunc
DECLARE SUB g_main_context_add_poll(BYVAL AS GMainContext PTR, BYVAL AS GPollFD PTR, BYVAL AS gint)
DECLARE SUB g_main_context_remove_poll(BYVAL AS GMainContext PTR, BYVAL AS GPollFD PTR)
DECLARE FUNCTION g_main_depth() AS gint
DECLARE FUNCTION g_main_current_source() AS GSource PTR
DECLARE SUB g_main_context_push_thread_default(BYVAL AS GMainContext PTR)
DECLARE SUB g_main_context_pop_thread_default(BYVAL AS GMainContext PTR)
DECLARE FUNCTION g_main_context_get_thread_default() AS GMainContext PTR
DECLARE FUNCTION g_main_context_ref_thread_default() AS GMainContext PTR
DECLARE FUNCTION g_main_loop_new(BYVAL AS GMainContext PTR, BYVAL AS gboolean) AS GMainLoop PTR
DECLARE SUB g_main_loop_run(BYVAL AS GMainLoop PTR)
DECLARE SUB g_main_loop_quit(BYVAL AS GMainLoop PTR)
DECLARE FUNCTION g_main_loop_ref(BYVAL AS GMainLoop PTR) AS GMainLoop PTR
DECLARE SUB g_main_loop_unref(BYVAL AS GMainLoop PTR)
DECLARE FUNCTION g_main_loop_is_running(BYVAL AS GMainLoop PTR) AS gboolean
DECLARE FUNCTION g_main_loop_get_context(BYVAL AS GMainLoop PTR) AS GMainContext PTR
DECLARE FUNCTION g_source_new(BYVAL AS GSourceFuncs PTR, BYVAL AS guint) AS GSource PTR
DECLARE FUNCTION g_source_ref(BYVAL AS GSource PTR) AS GSource PTR
DECLARE SUB g_source_unref(BYVAL AS GSource PTR)
DECLARE FUNCTION g_source_attach(BYVAL AS GSource PTR, BYVAL AS GMainContext PTR) AS guint
DECLARE SUB g_source_destroy(BYVAL AS GSource PTR)
DECLARE SUB g_source_set_priority(BYVAL AS GSource PTR, BYVAL AS gint)
DECLARE FUNCTION g_source_get_priority(BYVAL AS GSource PTR) AS gint
DECLARE SUB g_source_set_can_recurse(BYVAL AS GSource PTR, BYVAL AS gboolean)
DECLARE FUNCTION g_source_get_can_recurse(BYVAL AS GSource PTR) AS gboolean
DECLARE FUNCTION g_source_get_id(BYVAL AS GSource PTR) AS guint
DECLARE FUNCTION g_source_get_context(BYVAL AS GSource PTR) AS GMainContext PTR
DECLARE SUB g_source_set_callback(BYVAL AS GSource PTR, BYVAL AS GSourceFunc, BYVAL AS gpointer, BYVAL AS GDestroyNotify)
DECLARE SUB g_source_set_funcs(BYVAL AS GSource PTR, BYVAL AS GSourceFuncs PTR)
DECLARE FUNCTION g_source_is_destroyed(BYVAL AS GSource PTR) AS gboolean
DECLARE SUB g_source_set_name(BYVAL AS GSource PTR, BYVAL AS CONST ZSTRING PTR)
DECLARE FUNCTION g_source_get_name(BYVAL AS GSource PTR) AS CONST ZSTRING PTR
DECLARE SUB g_source_set_name_by_id(BYVAL AS guint, BYVAL AS CONST ZSTRING PTR)
DECLARE SUB g_source_set_callback_indirect(BYVAL AS GSource PTR, BYVAL AS gpointer, BYVAL AS GSourceCallbackFuncs PTR)
DECLARE SUB g_source_add_poll(BYVAL AS GSource PTR, BYVAL AS GPollFD PTR)
DECLARE SUB g_source_remove_poll(BYVAL AS GSource PTR, BYVAL AS GPollFD PTR)
DECLARE SUB g_source_add_child_source(BYVAL AS GSource PTR, BYVAL AS GSource PTR)
DECLARE SUB g_source_remove_child_source(BYVAL AS GSource PTR, BYVAL AS GSource PTR)
DECLARE SUB g_source_get_current_time(BYVAL AS GSource PTR, BYVAL AS GTimeVal PTR)
DECLARE FUNCTION g_source_get_time(BYVAL AS GSource PTR) AS gint64
DECLARE FUNCTION g_idle_source_new() AS GSource PTR
DECLARE FUNCTION g_child_watch_source_new(BYVAL AS GPid) AS GSource PTR
DECLARE FUNCTION g_timeout_source_new(BYVAL AS guint) AS GSource PTR
DECLARE FUNCTION g_timeout_source_new_seconds(BYVAL AS guint) AS GSource PTR
DECLARE SUB g_get_current_time(BYVAL AS GTimeVal PTR)
DECLARE FUNCTION g_get_monotonic_time() AS gint64
DECLARE FUNCTION g_get_real_time() AS gint64
DECLARE FUNCTION g_source_remove_ ALIAS "g_source_remove"(BYVAL AS guint) AS gboolean
DECLARE FUNCTION g_source_remove_by_user_data(BYVAL AS gpointer) AS gboolean
DECLARE FUNCTION g_source_remove_by_funcs_user_data(BYVAL AS GSourceFuncs PTR, BYVAL AS gpointer) AS gboolean
DECLARE FUNCTION g_timeout_add_full(BYVAL AS gint, BYVAL AS guint, BYVAL AS GSourceFunc, BYVAL AS gpointer, BYVAL AS GDestroyNotify) AS guint
DECLARE FUNCTION g_timeout_add(BYVAL AS guint, BYVAL AS GSourceFunc, BYVAL AS gpointer) AS guint
DECLARE FUNCTION g_timeout_add_seconds_full(BYVAL AS gint, BYVAL AS guint, BYVAL AS GSourceFunc, BYVAL AS gpointer, BYVAL AS GDestroyNotify) AS guint
DECLARE FUNCTION g_timeout_add_seconds(BYVAL AS guint, BYVAL AS GSourceFunc, BYVAL AS gpointer) AS guint
DECLARE FUNCTION g_child_watch_add_full(BYVAL AS gint, BYVAL AS GPid, BYVAL AS GChildWatchFunc, BYVAL AS gpointer, BYVAL AS GDestroyNotify) AS guint
DECLARE FUNCTION g_child_watch_add(BYVAL AS GPid, BYVAL AS GChildWatchFunc, BYVAL AS gpointer) AS guint
DECLARE FUNCTION g_idle_add(BYVAL AS GSourceFunc, BYVAL AS gpointer) AS guint
DECLARE FUNCTION g_idle_add_full(BYVAL AS gint, BYVAL AS GSourceFunc, BYVAL AS gpointer, BYVAL AS GDestroyNotify) AS guint
DECLARE FUNCTION g_idle_remove_by_data(BYVAL AS gpointer) AS gboolean
DECLARE SUB g_main_context_invoke_full(BYVAL AS GMainContext PTR, BYVAL AS gint, BYVAL AS GSourceFunc, BYVAL AS gpointer, BYVAL AS GDestroyNotify)
DECLARE SUB g_main_context_invoke(BYVAL AS GMainContext PTR, BYVAL AS GSourceFunc, BYVAL AS gpointer)

EXTERN AS GSourceFuncs g_timeout_funcs
EXTERN AS GSourceFuncs g_child_watch_funcs
EXTERN AS GSourceFuncs g_idle_funcs

#ENDIF ' __G_MAIN_H__

#IFNDEF __G_STRING_H__
#DEFINE __G_STRING_H__

#IFNDEF __G_UNICODE_H__
#DEFINE __G_UNICODE_H__

TYPE gunichar AS guint32
TYPE gunichar2 AS guint16

ENUM GUnicodeType
  G_UNICODE_CONTROL
  G_UNICODE_FORMAT
  G_UNICODE_UNASSIGNED
  G_UNICODE_PRIVATE_USE
  G_UNICODE_SURROGATE
  G_UNICODE_LOWERCASE_LETTER
  G_UNICODE_MODIFIER_LETTER
  G_UNICODE_OTHER_LETTER
  G_UNICODE_TITLECASE_LETTER
  G_UNICODE_UPPERCASE_LETTER
  G_UNICODE_SPACING_MARK
  G_UNICODE_ENCLOSING_MARK
  G_UNICODE_NON_SPACING_MARK
  G_UNICODE_DECIMAL_NUMBER
  G_UNICODE_LETTER_NUMBER
  G_UNICODE_OTHER_NUMBER
  G_UNICODE_CONNECT_PUNCTUATION
  G_UNICODE_DASH_PUNCTUATION
  G_UNICODE_CLOSE_PUNCTUATION
  G_UNICODE_FINAL_PUNCTUATION
  G_UNICODE_INITIAL_PUNCTUATION
  G_UNICODE_OTHER_PUNCTUATION
  G_UNICODE_OPEN_PUNCTUATION
  G_UNICODE_CURRENCY_SYMBOL
  G_UNICODE_MODIFIER_SYMBOL
  G_UNICODE_MATH_SYMBOL
  G_UNICODE_OTHER_SYMBOL
  G_UNICODE_LINE_SEPARATOR
  G_UNICODE_PARAGRAPH_SEPARATOR
  G_UNICODE_SPACE_SEPARATOR
END ENUM

#IFNDEF G_DISABLE_DEPRECATED
#DEFINE G_UNICODE_COMBINING_MARK G_UNICODE_SPACING_MARK
#ENDIF ' G_DISABLE_DEPRECATED

ENUM GUnicodeBreakType
  G_UNICODE_BREAK_MANDATORY
  G_UNICODE_BREAK_CARRIAGE_RETURN
  G_UNICODE_BREAK_LINE_FEED
  G_UNICODE_BREAK_COMBINING_MARK
  G_UNICODE_BREAK_SURROGATE
  G_UNICODE_BREAK_ZERO_WIDTH_SPACE
  G_UNICODE_BREAK_INSEPARABLE
  G_UNICODE_BREAK_NON_BREAKING_GLUE
  G_UNICODE_BREAK_CONTINGENT
  G_UNICODE_BREAK_SPACE
  G_UNICODE_BREAK_AFTER
  G_UNICODE_BREAK_BEFORE
  G_UNICODE_BREAK_BEFORE_AND_AFTER
  G_UNICODE_BREAK_HYPHEN
  G_UNICODE_BREAK_NON_STARTER
  G_UNICODE_BREAK_OPEN_PUNCTUATION
  G_UNICODE_BREAK_CLOSE_PUNCTUATION
  G_UNICODE_BREAK_QUOTATION
  G_UNICODE_BREAK_EXCLAMATION
  G_UNICODE_BREAK_IDEOGRAPHIC
  G_UNICODE_BREAK_NUMERIC
  G_UNICODE_BREAK_INFIX_SEPARATOR
  G_UNICODE_BREAK_SYMBOL
  G_UNICODE_BREAK_ALPHABETIC
  G_UNICODE_BREAK_PREFIX
  G_UNICODE_BREAK_POSTFIX
  G_UNICODE_BREAK_COMPLEX_CONTEXT
  G_UNICODE_BREAK_AMBIGUOUS
  G_UNICODE_BREAK_UNKNOWN
  G_UNICODE_BREAK_NEXT_LINE
  G_UNICODE_BREAK_WORD_JOINER
  G_UNICODE_BREAK_HANGUL_L_JAMO
  G_UNICODE_BREAK_HANGUL_V_JAMO
  G_UNICODE_BREAK_HANGUL_T_JAMO
  G_UNICODE_BREAK_HANGUL_LV_SYLLABLE
  G_UNICODE_BREAK_HANGUL_LVT_SYLLABLE
  G_UNICODE_BREAK_CLOSE_PARANTHESIS
END ENUM

ENUM GUnicodeScript
  G_UNICODE_SCRIPT_INVALID_CODE = -1
  G_UNICODE_SCRIPT_COMMON = 0
  G_UNICODE_SCRIPT_INHERITED
  G_UNICODE_SCRIPT_ARABIC
  G_UNICODE_SCRIPT_ARMENIAN
  G_UNICODE_SCRIPT_BENGALI
  G_UNICODE_SCRIPT_BOPOMOFO
  G_UNICODE_SCRIPT_CHEROKEE
  G_UNICODE_SCRIPT_COPTIC
  G_UNICODE_SCRIPT_CYRILLIC
  G_UNICODE_SCRIPT_DESERET
  G_UNICODE_SCRIPT_DEVANAGARI
  G_UNICODE_SCRIPT_ETHIOPIC
  G_UNICODE_SCRIPT_GEORGIAN
  G_UNICODE_SCRIPT_GOTHIC
  G_UNICODE_SCRIPT_GREEK
  G_UNICODE_SCRIPT_GUJARATI
  G_UNICODE_SCRIPT_GURMUKHI
  G_UNICODE_SCRIPT_HAN
  G_UNICODE_SCRIPT_HANGUL
  G_UNICODE_SCRIPT_HEBREW
  G_UNICODE_SCRIPT_HIRAGANA
  G_UNICODE_SCRIPT_KANNADA
  G_UNICODE_SCRIPT_KATAKANA
  G_UNICODE_SCRIPT_KHMER
  G_UNICODE_SCRIPT_LAO
  G_UNICODE_SCRIPT_LATIN
  G_UNICODE_SCRIPT_MALAYALAM
  G_UNICODE_SCRIPT_MONGOLIAN
  G_UNICODE_SCRIPT_MYANMAR
  G_UNICODE_SCRIPT_OGHAM
  G_UNICODE_SCRIPT_OLD_ITALIC
  G_UNICODE_SCRIPT_ORIYA
  G_UNICODE_SCRIPT_RUNIC
  G_UNICODE_SCRIPT_SINHALA
  G_UNICODE_SCRIPT_SYRIAC
  G_UNICODE_SCRIPT_TAMIL
  G_UNICODE_SCRIPT_TELUGU
  G_UNICODE_SCRIPT_THAANA
  G_UNICODE_SCRIPT_THAI
  G_UNICODE_SCRIPT_TIBETAN
  G_UNICODE_SCRIPT_CANADIAN_ABORIGINAL
  G_UNICODE_SCRIPT_YI
  G_UNICODE_SCRIPT_TAGALOG
  G_UNICODE_SCRIPT_HANUNOO
  G_UNICODE_SCRIPT_BUHID
  G_UNICODE_SCRIPT_TAGBANWA
  G_UNICODE_SCRIPT_BRAILLE
  G_UNICODE_SCRIPT_CYPRIOT
  G_UNICODE_SCRIPT_LIMBU
  G_UNICODE_SCRIPT_OSMANYA
  G_UNICODE_SCRIPT_SHAVIAN
  G_UNICODE_SCRIPT_LINEAR_B
  G_UNICODE_SCRIPT_TAI_LE
  G_UNICODE_SCRIPT_UGARITIC
  G_UNICODE_SCRIPT_NEW_TAI_LUE
  G_UNICODE_SCRIPT_BUGINESE
  G_UNICODE_SCRIPT_GLAGOLITIC
  G_UNICODE_SCRIPT_TIFINAGH
  G_UNICODE_SCRIPT_SYLOTI_NAGRI
  G_UNICODE_SCRIPT_OLD_PERSIAN
  G_UNICODE_SCRIPT_KHAROSHTHI
  G_UNICODE_SCRIPT_UNKNOWN
  G_UNICODE_SCRIPT_BALINESE
  G_UNICODE_SCRIPT_CUNEIFORM
  G_UNICODE_SCRIPT_PHOENICIAN
  G_UNICODE_SCRIPT_PHAGS_PA
  G_UNICODE_SCRIPT_NKO
  G_UNICODE_SCRIPT_KAYAH_LI
  G_UNICODE_SCRIPT_LEPCHA
  G_UNICODE_SCRIPT_REJANG
  G_UNICODE_SCRIPT_SUNDANESE
  G_UNICODE_SCRIPT_SAURASHTRA
  G_UNICODE_SCRIPT_CHAM
  G_UNICODE_SCRIPT_OL_CHIKI
  G_UNICODE_SCRIPT_VAI
  G_UNICODE_SCRIPT_CARIAN
  G_UNICODE_SCRIPT_LYCIAN
  G_UNICODE_SCRIPT_LYDIAN
  G_UNICODE_SCRIPT_AVESTAN
  G_UNICODE_SCRIPT_BAMUM
  G_UNICODE_SCRIPT_EGYPTIAN_HIEROGLYPHS
  G_UNICODE_SCRIPT_IMPERIAL_ARAMAIC
  G_UNICODE_SCRIPT_INSCRIPTIONAL_PAHLAVI
  G_UNICODE_SCRIPT_INSCRIPTIONAL_PARTHIAN
  G_UNICODE_SCRIPT_JAVANESE
  G_UNICODE_SCRIPT_KAITHI
  G_UNICODE_SCRIPT_LISU
  G_UNICODE_SCRIPT_MEETEI_MAYEK
  G_UNICODE_SCRIPT_OLD_SOUTH_ARABIAN
  G_UNICODE_SCRIPT_OLD_TURKIC
  G_UNICODE_SCRIPT_SAMARITAN
  G_UNICODE_SCRIPT_TAI_THAM
  G_UNICODE_SCRIPT_TAI_VIET
  G_UNICODE_SCRIPT_BATAK
  G_UNICODE_SCRIPT_BRAHMI
  G_UNICODE_SCRIPT_MANDAIC
END ENUM

DECLARE FUNCTION g_unicode_script_to_iso15924(BYVAL AS GUnicodeScript) AS guint32
DECLARE FUNCTION g_unicode_script_from_iso15924(BYVAL AS guint32) AS GUnicodeScript
DECLARE FUNCTION g_unichar_isalnum(BYVAL AS gunichar) AS gboolean
DECLARE FUNCTION g_unichar_isalpha(BYVAL AS gunichar) AS gboolean
DECLARE FUNCTION g_unichar_iscntrl(BYVAL AS gunichar) AS gboolean
DECLARE FUNCTION g_unichar_isdigit(BYVAL AS gunichar) AS gboolean
DECLARE FUNCTION g_unichar_isgraph(BYVAL AS gunichar) AS gboolean
DECLARE FUNCTION g_unichar_islower(BYVAL AS gunichar) AS gboolean
DECLARE FUNCTION g_unichar_isprint(BYVAL AS gunichar) AS gboolean
DECLARE FUNCTION g_unichar_ispunct(BYVAL AS gunichar) AS gboolean
DECLARE FUNCTION g_unichar_isspace(BYVAL AS gunichar) AS gboolean
DECLARE FUNCTION g_unichar_isupper(BYVAL AS gunichar) AS gboolean
DECLARE FUNCTION g_unichar_isxdigit(BYVAL AS gunichar) AS gboolean
DECLARE FUNCTION g_unichar_istitle(BYVAL AS gunichar) AS gboolean
DECLARE FUNCTION g_unichar_isdefined(BYVAL AS gunichar) AS gboolean
DECLARE FUNCTION g_unichar_iswide(BYVAL AS gunichar) AS gboolean
DECLARE FUNCTION g_unichar_iswide_cjk(BYVAL AS gunichar) AS gboolean
DECLARE FUNCTION g_unichar_iszerowidth(BYVAL AS gunichar) AS gboolean
DECLARE FUNCTION g_unichar_ismark(BYVAL AS gunichar) AS gboolean
DECLARE FUNCTION g_unichar_toupper(BYVAL AS gunichar) AS gunichar
DECLARE FUNCTION g_unichar_tolower(BYVAL AS gunichar) AS gunichar
DECLARE FUNCTION g_unichar_totitle(BYVAL AS gunichar) AS gunichar
DECLARE FUNCTION g_unichar_digit_value(BYVAL AS gunichar) AS gint
DECLARE FUNCTION g_unichar_xdigit_value(BYVAL AS gunichar) AS gint
DECLARE FUNCTION g_unichar_type(BYVAL AS gunichar) AS GUnicodeType
DECLARE FUNCTION g_unichar_break_type(BYVAL AS gunichar) AS GUnicodeBreakType
DECLARE FUNCTION g_unichar_combining_class(BYVAL AS gunichar) AS gint
DECLARE FUNCTION g_unichar_get_mirror_char(BYVAL AS gunichar, BYVAL AS gunichar PTR) AS gboolean
DECLARE FUNCTION g_unichar_get_script(BYVAL AS gunichar) AS GUnicodeScript
DECLARE FUNCTION g_unichar_validate(BYVAL AS gunichar) AS gboolean
DECLARE FUNCTION g_unichar_compose(BYVAL AS gunichar, BYVAL AS gunichar, BYVAL AS gunichar PTR) AS gboolean
DECLARE FUNCTION g_unichar_decompose(BYVAL AS gunichar, BYVAL AS gunichar PTR, BYVAL AS gunichar PTR) AS gboolean
DECLARE FUNCTION g_unichar_fully_decompose(BYVAL AS gunichar, BYVAL AS gboolean, BYVAL AS gunichar PTR, BYVAL AS gsize) AS gsize

#DEFINE G_UNICHAR_MAX_DECOMPOSITION_LENGTH 18

DECLARE SUB g_unicode_canonical_ordering(BYVAL AS gunichar PTR, BYVAL AS gsize)
DECLARE FUNCTION g_unicode_canonical_decomposition(BYVAL AS gunichar, BYVAL AS gsize PTR) AS gunichar PTR

EXTERN AS CONST gchar CONST PTR g_utf8_skip

#DEFINE g_utf8_next_char(p) CAST(ZSTRING PTR, (p) + g_utf8_skip[*CAST(CONST guchar PTR, (p))])

DECLARE FUNCTION g_utf8_get_char(BYVAL AS CONST gchar PTR) AS gunichar
DECLARE FUNCTION g_utf8_get_char_validated(BYVAL AS CONST gchar PTR, BYVAL AS gssize) AS gunichar
DECLARE FUNCTION g_utf8_offset_to_pointer(BYVAL AS CONST gchar PTR, BYVAL AS glong) AS gchar PTR
DECLARE FUNCTION g_utf8_pointer_to_offset(BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR) AS glong
DECLARE FUNCTION g_utf8_prev_char(BYVAL AS CONST gchar PTR) AS gchar PTR
DECLARE FUNCTION g_utf8_find_next_char(BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR) AS gchar PTR
DECLARE FUNCTION g_utf8_find_prev_char(BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR) AS gchar PTR
DECLARE FUNCTION g_utf8_strlen(BYVAL AS CONST gchar PTR, BYVAL AS gssize) AS glong
DECLARE FUNCTION g_utf8_substring(BYVAL AS CONST gchar PTR, BYVAL AS glong, BYVAL AS glong) AS gchar PTR
DECLARE FUNCTION g_utf8_strncpy(BYVAL AS gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS gsize) AS gchar PTR
DECLARE FUNCTION g_utf8_strchr(BYVAL AS CONST gchar PTR, BYVAL AS gssize, BYVAL AS gunichar) AS gchar PTR
DECLARE FUNCTION g_utf8_strrchr(BYVAL AS CONST gchar PTR, BYVAL AS gssize, BYVAL AS gunichar) AS gchar PTR
DECLARE FUNCTION g_utf8_strreverse(BYVAL AS CONST gchar PTR, BYVAL AS gssize) AS gchar PTR
DECLARE FUNCTION g_utf8_to_utf16(BYVAL AS CONST gchar PTR, BYVAL AS glong, BYVAL AS glong PTR, BYVAL AS glong PTR, BYVAL AS GError PTR PTR) AS gunichar2 PTR
DECLARE FUNCTION g_utf8_to_ucs4(BYVAL AS CONST gchar PTR, BYVAL AS glong, BYVAL AS glong PTR, BYVAL AS glong PTR, BYVAL AS GError PTR PTR) AS gunichar PTR
DECLARE FUNCTION g_utf8_to_ucs4_fast(BYVAL AS CONST gchar PTR, BYVAL AS glong, BYVAL AS glong PTR) AS gunichar PTR
DECLARE FUNCTION g_utf16_to_ucs4(BYVAL AS CONST gunichar2 PTR, BYVAL AS glong, BYVAL AS glong PTR, BYVAL AS glong PTR, BYVAL AS GError PTR PTR) AS gunichar PTR
DECLARE FUNCTION g_utf16_to_utf8(BYVAL AS CONST gunichar2 PTR, BYVAL AS glong, BYVAL AS glong PTR, BYVAL AS glong PTR, BYVAL AS GError PTR PTR) AS gchar PTR
DECLARE FUNCTION g_ucs4_to_utf16(BYVAL AS CONST gunichar PTR, BYVAL AS glong, BYVAL AS glong PTR, BYVAL AS glong PTR, BYVAL AS GError PTR PTR) AS gunichar2 PTR
DECLARE FUNCTION g_ucs4_to_utf8(BYVAL AS CONST gunichar PTR, BYVAL AS glong, BYVAL AS glong PTR, BYVAL AS glong PTR, BYVAL AS GError PTR PTR) AS gchar PTR
DECLARE FUNCTION g_unichar_to_utf8(BYVAL AS gunichar, BYVAL AS gchar PTR) AS gint
DECLARE FUNCTION g_utf8_validate(BYVAL AS CONST gchar PTR, BYVAL AS gssize, BYVAL AS CONST gchar PTR PTR) AS gboolean
DECLARE FUNCTION g_utf8_strup(BYVAL AS CONST gchar PTR, BYVAL AS gssize) AS gchar PTR
DECLARE FUNCTION g_utf8_strdown(BYVAL AS CONST gchar PTR, BYVAL AS gssize) AS gchar PTR
DECLARE FUNCTION g_utf8_casefold(BYVAL AS CONST gchar PTR, BYVAL AS gssize) AS gchar PTR

ENUM GNormalizeMode
  G_NORMALIZE_DEFAULT
  G_NORMALIZE_NFD = G_NORMALIZE_DEFAULT
  G_NORMALIZE_DEFAULT_COMPOSE
  G_NORMALIZE_NFC = G_NORMALIZE_DEFAULT_COMPOSE
  G_NORMALIZE_ALL
  G_NORMALIZE_NFKD = G_NORMALIZE_ALL
  G_NORMALIZE_ALL_COMPOSE
  G_NORMALIZE_NFKC = G_NORMALIZE_ALL_COMPOSE
END ENUM

DECLARE FUNCTION g_utf8_normalize(BYVAL AS CONST gchar PTR, BYVAL AS gssize, BYVAL AS GNormalizeMode) AS gchar PTR
DECLARE FUNCTION g_utf8_collate(BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR) AS gint
DECLARE FUNCTION g_utf8_collate_key(BYVAL AS CONST gchar PTR, BYVAL AS gssize) AS gchar PTR
DECLARE FUNCTION g_utf8_collate_key_for_filename(BYVAL AS CONST gchar PTR, BYVAL AS gssize) AS gchar PTR
DECLARE FUNCTION _g_utf8_make_valid(BYVAL AS CONST gchar PTR) AS gchar PTR

#ENDIF ' __G_UNICODE_H__

#IFNDEF __G_UTILS_H__
#DEFINE __G_UTILS_H__

#IF NOT DEFINED (G_VA_COPY)
#IF DEFINED (__GNUC__) AND DEFINED (__PPC__) AND (DEFINED (_CALL_SYSV) OR DEFINED (_WIN32))
#DEFINE G_VA_COPY(ap1, ap2) (*(ap1) = *(ap2))
#ELSEIF DEFINED (G_VA_COPY_AS_ARRAY)
#DEFINE G_VA_COPY(ap1, ap2) g_memmove ((ap1), (ap2), SIZEOF (va_list))
#ELSE ' DEFINED (__GNUC...
#DEFINE G_VA_COPY(ap1, ap2) ((ap1) = (ap2))
#ENDIF ' DEFINED (__GNUC...
#ENDIF ' NOT DEFINED (G_...

#IF DEFINED (G_HAVE_INLINE) AND DEFINED (__GNUC__) AND DEFINED (__STRICT_ANSI__)
#UNDEF inline
#DEFINE inline __inline__
#ELSEIF NOT DEFINED (G_HAVE_INLINE)
#UNDEF inline
#IF DEFINED (G_HAVE___INLINE__)
#DEFINE inline __inline__
#ELSEIF DEFINED (G_HAVE___INLINE)
#DEFINE inline __inline
#ELSE ' DEFINED (G_HAVE...
#DEFINE inline
#ENDIF ' DEFINED (G_HAVE...
#ENDIF ' DEFINED (G_HAVE...

#IFDEF G_IMPLEMENT_INLINES
#DEFINE G_INLINE_FUNC
#UNDEF G_CAN_INLINE
#ELSEIF DEFINED (__GNUC__)
#DEFINE G_INLINE_FUNC static __inline __attribute__ ((unused))
#ELSEIF DEFINED (G_CAN_INLINE)
#DEFINE G_INLINE_FUNC static inline
#ELSE ' G_IMPLEMENT_INLINES
#DEFINE G_INLINE_FUNC
#ENDIF ' G_IMPLEMENT_INLINES

#IFNDEF __GTK_DOC_IGNORE__
#IFDEF G_OS_WIN32
#DEFINE g_get_user_name g_get_user_name_utf8
#DEFINE g_get_real_name g_get_real_name_utf8
#DEFINE g_get_home_dir g_get_home_dir_utf8
#DEFINE g_get_tmp_dir g_get_tmp_dir_utf8
#ENDIF ' G_OS_WIN32
#ENDIF ' __GTK_DOC_IGNORE__

DECLARE FUNCTION g_get_user_name() AS CONST gchar PTR
DECLARE FUNCTION g_get_real_name() AS CONST gchar PTR
DECLARE FUNCTION g_get_home_dir() AS CONST gchar PTR
DECLARE FUNCTION g_get_tmp_dir() AS CONST gchar PTR
DECLARE FUNCTION g_get_host_name() AS CONST gchar PTR
DECLARE FUNCTION g_get_prgname() AS gchar PTR
DECLARE SUB g_set_prgname(BYVAL AS CONST gchar PTR)
DECLARE FUNCTION g_get_application_name() AS CONST gchar PTR
DECLARE SUB g_set_application_name(BYVAL AS CONST gchar PTR)
DECLARE SUB g_reload_user_special_dirs_cache()
DECLARE FUNCTION g_get_user_data_dir() AS CONST gchar PTR
DECLARE FUNCTION g_get_user_config_dir() AS CONST gchar PTR
DECLARE FUNCTION g_get_user_cache_dir() AS CONST gchar PTR
DECLARE FUNCTION g_get_system_data_dirs() AS CONST gchar CONST PTR PTR

#IFDEF G_OS_WIN32

DECLARE FUNCTION g_win32_get_system_data_dirs_for_module(BYVAL AS SUB()) AS CONST gchar CONST PTR PTR

#ENDIF ' G_OS_WIN32

#IF DEFINED (G_OS_WIN32) AND DEFINED (G_CAN_INLINE) AND NOT DEFINED (__cplusplus)
#DEFINE g_get_system_data_dirs _g_win32_get_system_data_dirs
#ENDIF ' DEFINED (G_OS_W...

DECLARE FUNCTION g_get_system_config_dirs() AS CONST gchar CONST PTR PTR
DECLARE FUNCTION g_get_user_runtime_dir() AS CONST gchar PTR

ENUM GUserDirectory
  G_USER_DIRECTORY_DESKTOP
  G_USER_DIRECTORY_DOCUMENTS
  G_USER_DIRECTORY_DOWNLOAD
  G_USER_DIRECTORY_MUSIC
  G_USER_DIRECTORY_PICTURES
  G_USER_DIRECTORY_PUBLIC_SHARE
  G_USER_DIRECTORY_TEMPLATES
  G_USER_DIRECTORY_VIDEOS
  G_USER_N_DIRECTORIES
END ENUM

DECLARE FUNCTION g_get_user_special_dir(BYVAL AS GUserDirectory) AS CONST gchar PTR

TYPE GDebugKey AS _GDebugKey

TYPE _GDebugKey
  AS CONST gchar PTR key
  AS guint value
END TYPE

DECLARE FUNCTION g_parse_debug_string(BYVAL AS CONST gchar PTR, BYVAL AS CONST GDebugKey PTR, BYVAL AS guint) AS guint
DECLARE FUNCTION g_snprintf(BYVAL AS gchar PTR, BYVAL AS gulong, BYVAL AS gchar CONST PTR, ...) AS gint
DECLARE FUNCTION g_vsnprintf(BYVAL AS gchar PTR, BYVAL AS gulong, BYVAL AS gchar CONST PTR, BYVAL AS va_list) AS gint
DECLARE SUB g_nullify_pointer(BYVAL AS gpointer PTR)

ENUM GFormatSizeFlags
  G_FORMAT_SIZE_DEFAULT = 0
  G_FORMAT_SIZE_LONG_FORMAT = 1 SHL 0
  G_FORMAT_SIZE_IEC_UNITS = 1 SHL 1
END ENUM

DECLARE FUNCTION g_format_size_full(BYVAL AS guint64, BYVAL AS GFormatSizeFlags) AS gchar PTR
DECLARE FUNCTION g_format_size(BYVAL AS guint64) AS gchar PTR
DECLARE FUNCTION g_format_size_for_display(BYVAL AS goffset) AS gchar PTR

#IFNDEF G_DISABLE_DEPRECATED

TYPE GVoidFunc AS SUB()

#IFNDEF ATEXIT
#DEFINE ATEXIT(proc) g_ATEXIT(proc)
#ELSE ' ATEXIT
#DEFINE G_NATIVE_ATEXIT
#ENDIF ' ATEXIT

DECLARE SUB g_atexit_ ALIAS "g_atexit"(BYVAL AS GVoidFunc)

'früher (2.28): ???
'#IFDEF G_OS_WIN32
'#IFNDEF ATEXIT
'#INCLUDE ONCE "crt/stdlib.bi"
'#DEFINE G_NATIVE_ATEXIT
'#ENDIF ' ATEXIT
'#DEFINE g_atexit(func) atexit(func)
'#ELSE
'DECLARE SUB g_atexit(BYVAL AS GVoidFunc)
'#ENDIF ' G_OS_WIN32

#IFDEF G_OS_WIN32
#UNDEF g_atexit
#DEFINE g_atexit(func) atexit(func)
#ENDIF ' G_OS_WIN32
#ENDIF ' G_DISABLE_DEPRECATED

#IFNDEF __GTK_DOC_IGNORE__
#IFDEF G_OS_WIN32
#DEFINE g_find_program_in_path g_find_program_in_path_utf8
#ENDIF ' G_OS_WIN32
#ENDIF ' __GTK_DOC_IGNORE__

DECLARE FUNCTION g_find_program_in_path(BYVAL AS CONST gchar PTR) AS gchar PTR
DECLARE FUNCTION g_bit_nth_lsf(BYVAL AS gulong, BYVAL AS gint) AS gint
DECLARE FUNCTION g_bit_nth_msf(BYVAL AS gulong, BYVAL AS gint) AS gint
DECLARE FUNCTION g_bit_storage(BYVAL AS gulong) AS guint

#IFNDEF G_DISABLE_DEPRECATED
#IFNDEF G_PLATFORM_WIN32
#DEFINE G_WIN32_DLLMAIN_FOR_DLL_NAME(static, dll_name)
#ELSE ' G_PLATFORM_WIN32
#MACRO G_WIN32_DLLMAIN_FOR_DLL_NAME(static, dll_name)
 STATIC SHARED AS ZSTRING PTR dll_name
 FUNCTION DllMain STDCALL ALIAS "DllMain" (BYVAL hinstDLL AS HINSTANCE, BYVAL fdwReason AS DWORD, BYVAL lpvReserved AS LPVOID) AS BOOL ' WINAPI
   DIM AS wchar_t wcbfr(999)
   SELECT CASE fdwReason
   CASE DLL_PROCESS_ATTACH
     GetModuleFileNameW (CAST(HMODULE, hinstDLL), wcbfr, G_N_ELEMENTS (wcbfr))
     VAR tem = g_utf16_to_utf8 (wcbfr, -1, NULL, NULL, NULL)
     dll_name = g_path_get_basename (tem)
     g_free (tem)
   END SELECT : RETURN TRUE
 END FUNCTION
#ENDMACRO

#ENDIF ' G_PLATFORM_WIN32
#ENDIF ' G_DISABLE_DEPRECATED
#ENDIF ' __G_UTILS_H__

TYPE GString AS _GString

TYPE _GString
  AS gchar PTR str
  AS gsize len
  AS gsize allocated_len
END TYPE

DECLARE FUNCTION g_string_new(BYVAL AS CONST gchar PTR) AS GString PTR
DECLARE FUNCTION g_string_new_len(BYVAL AS CONST gchar PTR, BYVAL AS gssize) AS GString PTR
DECLARE FUNCTION g_string_sized_new(BYVAL AS gsize) AS GString PTR
DECLARE FUNCTION g_string_free(BYVAL AS GString PTR, BYVAL AS gboolean) AS gchar PTR
DECLARE FUNCTION g_string_equal(BYVAL AS CONST GString PTR, BYVAL AS CONST GString PTR) AS gboolean
DECLARE FUNCTION g_string_hash(BYVAL AS CONST GString PTR) AS guint
DECLARE FUNCTION g_string_assign(BYVAL AS GString PTR, BYVAL AS CONST gchar PTR) AS GString PTR
DECLARE FUNCTION g_string_truncate(BYVAL AS GString PTR, BYVAL AS gsize) AS GString PTR
DECLARE FUNCTION g_string_set_size(BYVAL AS GString PTR, BYVAL AS gsize) AS GString PTR
DECLARE FUNCTION g_string_insert_len(BYVAL AS GString PTR, BYVAL AS gssize, BYVAL AS CONST gchar PTR, BYVAL AS gssize) AS GString PTR
DECLARE FUNCTION g_string_append(BYVAL AS GString PTR, BYVAL AS CONST gchar PTR) AS GString PTR
DECLARE FUNCTION g_string_append_len(BYVAL AS GString PTR, BYVAL AS CONST gchar PTR, BYVAL AS gssize) AS GString PTR
DECLARE FUNCTION g_string_append_c(BYVAL AS GString PTR, BYVAL AS UBYTE) AS GString PTR
DECLARE FUNCTION g_string_append_unichar(BYVAL AS GString PTR, BYVAL AS gunichar) AS GString PTR
DECLARE FUNCTION g_string_prepend(BYVAL AS GString PTR, BYVAL AS CONST gchar PTR) AS GString PTR
DECLARE FUNCTION g_string_prepend_c(BYVAL AS GString PTR, BYVAL AS UBYTE) AS GString PTR
DECLARE FUNCTION g_string_prepend_unichar(BYVAL AS GString PTR, BYVAL AS gunichar) AS GString PTR
DECLARE FUNCTION g_string_prepend_len(BYVAL AS GString PTR, BYVAL AS CONST gchar PTR, BYVAL AS gssize) AS GString PTR
DECLARE FUNCTION g_string_insert(BYVAL AS GString PTR, BYVAL AS gssize, BYVAL AS CONST gchar PTR) AS GString PTR
DECLARE FUNCTION g_string_insert_c(BYVAL AS GString PTR, BYVAL AS gssize, BYVAL AS UBYTE) AS GString PTR
DECLARE FUNCTION g_string_insert_unichar(BYVAL AS GString PTR, BYVAL AS gssize, BYVAL AS gunichar) AS GString PTR
DECLARE FUNCTION g_string_overwrite(BYVAL AS GString PTR, BYVAL AS gsize, BYVAL AS CONST gchar PTR) AS GString PTR
DECLARE FUNCTION g_string_overwrite_len(BYVAL AS GString PTR, BYVAL AS gsize, BYVAL AS CONST gchar PTR, BYVAL AS gssize) AS GString PTR
DECLARE FUNCTION g_string_erase(BYVAL AS GString PTR, BYVAL AS gssize, BYVAL AS gssize) AS GString PTR
DECLARE FUNCTION g_string_ascii_down(BYVAL AS GString PTR) AS GString PTR
DECLARE FUNCTION g_string_ascii_up(BYVAL AS GString PTR) AS GString PTR
DECLARE SUB g_string_vprintf(BYVAL AS GString PTR, BYVAL AS CONST gchar PTR, BYVAL AS va_list)
DECLARE SUB g_string_printf(BYVAL AS GString PTR, BYVAL AS CONST gchar PTR, ...)
DECLARE SUB g_string_append_vprintf(BYVAL AS GString PTR, BYVAL AS CONST gchar PTR, BYVAL AS va_list)
DECLARE SUB g_string_append_printf(BYVAL AS GString PTR, BYVAL AS CONST gchar PTR, ...)
DECLARE FUNCTION g_string_append_uri_escaped(BYVAL AS GString PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS gboolean) AS GString PTR

#IFDEF G_CAN_INLINE
#DEFINE g_string_append_c(gstr,c) g_string_append_c_inline (gstr, c)
#ENDIF ' G_CAN_INLINE

DECLARE FUNCTION g_string_down(BYVAL AS GString PTR) AS GString PTR
DECLARE FUNCTION g_string_up(BYVAL AS GString PTR) AS GString PTR

#IFNDEF G_DISABLE_DEPRECATED
#DEFINE g_string_sprintf g_string_printf
#DEFINE g_string_sprintfa g_string_append_printf
#ENDIF ' G_DISABLE_DEPRECATED
#ENDIF ' __G_STRING_H__

TYPE GIOChannel AS _GIOChannel
TYPE GIOFuncs AS _GIOFuncs

ENUM GIOError
  G_IO_ERROR_NONE
  G_IO_ERROR_AGAIN
  G_IO_ERROR_INVAL
  G_IO_ERROR_UNKNOWN
END ENUM

#DEFINE G_IO_CHANNEL_ERROR g_io_channel_error_quark()

ENUM GIOChannelError
  G_IO_CHANNEL_ERROR_FBIG
  G_IO_CHANNEL_ERROR_INVAL
  G_IO_CHANNEL_ERROR_IO
  G_IO_CHANNEL_ERROR_ISDIR
  G_IO_CHANNEL_ERROR_NOSPC
  G_IO_CHANNEL_ERROR_NXIO
  G_IO_CHANNEL_ERROR_OVERFLOW
  G_IO_CHANNEL_ERROR_PIPE
  G_IO_CHANNEL_ERROR_FAILED
END ENUM

ENUM GIOStatus
  G_IO_STATUS_ERROR
  G_IO_STATUS_NORMAL
  G_IO_STATUS_EOF
  G_IO_STATUS_AGAIN
END ENUM

ENUM GSeekType
  G_SEEK_CUR
  G_SEEK_SET
  G_SEEK_END
END ENUM

ENUM GIOCondition
  G_IO_INGLIB_SYSDEF_POLLIN
  G_IO_OUTGLIB_SYSDEF_POLLOUT
  G_IO_PRIGLIB_SYSDEF_POLLPRI
  G_IO_ERRGLIB_SYSDEF_POLLERR
  G_IO_HUPGLIB_SYSDEF_POLLHUP
  G_IO_NVALGLIB_SYSDEF_POLLNVAL
END ENUM

ENUM GIOFlags
  G_IO_FLAG_APPEND = 1 SHL 0
  G_IO_FLAG_NONBLOCK = 1 SHL 1
  G_IO_FLAG_IS_READABLE = 1 SHL 2
  G_IO_FLAG_IS_WRITABLE = 1 SHL 3
  G_IO_FLAG_IS_SEEKABLE = 1 SHL 4
  G_IO_FLAG_MASK = (1 SHL 5) - 1
  G_IO_FLAG_GET_MASK = G_IO_FLAG_MASK
  G_IO_FLAG_SET_MASK = G_IO_FLAG_APPEND OR G_IO_FLAG_NONBLOCK
END ENUM

#DEFINE G_IO_FLAG_IS_WRITEABLE (G_IO_FLAG_IS_WRITABLE)

TYPE _GIOChannel
  AS gint ref_count
  AS GIOFuncs PTR funcs
  AS gchar PTR encoding
  AS GIConv read_cd
  AS GIConv write_cd
  AS gchar PTR line_term
  AS guint line_term_len
  AS gsize buf_size
  AS GString PTR read_buf
  AS GString PTR encoded_read_buf
  AS GString PTR write_buf
  AS gchar partial_write_buf(5)
  AS guint use_buffer : 1
  AS guint do_encode : 1
  AS guint close_on_unref : 1
  AS guint is_readable : 1
  AS guint is_writeable : 1
  AS guint is_seekable : 1
  AS gpointer reserved1
  AS gpointer reserved2
END TYPE

TYPE GIOFunc AS FUNCTION(BYVAL AS GIOChannel PTR, BYVAL AS GIOCondition, BYVAL AS gpointer) AS gboolean

TYPE _GIOFuncs
  io_read AS FUNCTION(BYVAL AS GIOChannel PTR, BYVAL AS gchar PTR, BYVAL AS gsize, BYVAL AS gsize PTR, BYVAL AS GError PTR PTR) AS GIOStatus
  io_write AS FUNCTION(BYVAL AS GIOChannel PTR, BYVAL AS CONST gchar PTR, BYVAL AS gsize, BYVAL AS gsize PTR, BYVAL AS GError PTR PTR) AS GIOStatus
  io_seek AS FUNCTION(BYVAL AS GIOChannel PTR, BYVAL AS gint64, BYVAL AS GSeekType, BYVAL AS GError PTR PTR) AS GIOStatus
  io_close AS FUNCTION(BYVAL AS GIOChannel PTR, BYVAL AS GError PTR PTR) AS GIOStatus
  io_create_watch AS FUNCTION(BYVAL AS GIOChannel PTR, BYVAL AS GIOCondition) AS GSource PTR
  io_free AS SUB(BYVAL AS GIOChannel PTR)
  io_set_flags AS FUNCTION(BYVAL AS GIOChannel PTR, BYVAL AS GIOFlags, BYVAL AS GError PTR PTR) AS GIOStatus
  io_get_flags AS FUNCTION(BYVAL AS GIOChannel PTR) AS GIOFlags
END TYPE

DECLARE SUB g_io_channel_init(BYVAL AS GIOChannel PTR)
DECLARE FUNCTION g_io_channel_ref(BYVAL AS GIOChannel PTR) AS GIOChannel PTR
DECLARE SUB g_io_channel_unref(BYVAL AS GIOChannel PTR)
DECLARE FUNCTION g_io_channel_read(BYVAL AS GIOChannel PTR, BYVAL AS gchar PTR, BYVAL AS gsize, BYVAL AS gsize PTR) AS GIOError
DECLARE FUNCTION g_io_channel_write(BYVAL AS GIOChannel PTR, BYVAL AS CONST gchar PTR, BYVAL AS gsize, BYVAL AS gsize PTR) AS GIOError
DECLARE FUNCTION g_io_channel_seek(BYVAL AS GIOChannel PTR, BYVAL AS gint64, BYVAL AS GSeekType) AS GIOError
DECLARE SUB g_io_channel_close(BYVAL AS GIOChannel PTR)
DECLARE FUNCTION g_io_channel_shutdown(BYVAL AS GIOChannel PTR, BYVAL AS gboolean, BYVAL AS GError PTR PTR) AS GIOStatus
DECLARE FUNCTION g_io_add_watch_full(BYVAL AS GIOChannel PTR, BYVAL AS gint, BYVAL AS GIOCondition, BYVAL AS GIOFunc, BYVAL AS gpointer, BYVAL AS GDestroyNotify) AS guint
DECLARE FUNCTION g_io_create_watch(BYVAL AS GIOChannel PTR, BYVAL AS GIOCondition) AS GSource PTR
DECLARE FUNCTION g_io_add_watch(BYVAL AS GIOChannel PTR, BYVAL AS GIOCondition, BYVAL AS GIOFunc, BYVAL AS gpointer) AS guint
DECLARE SUB g_io_channel_set_buffer_size(BYVAL AS GIOChannel PTR, BYVAL AS gsize)
DECLARE FUNCTION g_io_channel_get_buffer_size(BYVAL AS GIOChannel PTR) AS gsize
DECLARE FUNCTION g_io_channel_get_buffer_condition(BYVAL AS GIOChannel PTR) AS GIOCondition
DECLARE FUNCTION g_io_channel_set_flags(BYVAL AS GIOChannel PTR, BYVAL AS GIOFlags, BYVAL AS GError PTR PTR) AS GIOStatus
DECLARE FUNCTION g_io_channel_get_flags(BYVAL AS GIOChannel PTR) AS GIOFlags
DECLARE SUB g_io_channel_set_line_term(BYVAL AS GIOChannel PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint)
DECLARE FUNCTION g_io_channel_get_line_term(BYVAL AS GIOChannel PTR, BYVAL AS gint PTR) AS CONST gchar PTR
DECLARE SUB g_io_channel_set_buffered(BYVAL AS GIOChannel PTR, BYVAL AS gboolean)
DECLARE FUNCTION g_io_channel_get_buffered(BYVAL AS GIOChannel PTR) AS gboolean
DECLARE FUNCTION g_io_channel_set_encoding(BYVAL AS GIOChannel PTR, BYVAL AS CONST gchar PTR, BYVAL AS GError PTR PTR) AS GIOStatus
DECLARE FUNCTION g_io_channel_get_encoding(BYVAL AS GIOChannel PTR) AS CONST gchar PTR
DECLARE SUB g_io_channel_set_close_on_unref(BYVAL AS GIOChannel PTR, BYVAL AS gboolean)
DECLARE FUNCTION g_io_channel_get_close_on_unref(BYVAL AS GIOChannel PTR) AS gboolean
DECLARE FUNCTION g_io_channel_flush(BYVAL AS GIOChannel PTR, BYVAL AS GError PTR PTR) AS GIOStatus
DECLARE FUNCTION g_io_channel_read_line(BYVAL AS GIOChannel PTR, BYVAL AS gchar PTR PTR, BYVAL AS gsize PTR, BYVAL AS gsize PTR, BYVAL AS GError PTR PTR) AS GIOStatus
DECLARE FUNCTION g_io_channel_read_line_string(BYVAL AS GIOChannel PTR, BYVAL AS GString PTR, BYVAL AS gsize PTR, BYVAL AS GError PTR PTR) AS GIOStatus
DECLARE FUNCTION g_io_channel_read_to_end(BYVAL AS GIOChannel PTR, BYVAL AS gchar PTR PTR, BYVAL AS gsize PTR, BYVAL AS GError PTR PTR) AS GIOStatus
DECLARE FUNCTION g_io_channel_read_chars(BYVAL AS GIOChannel PTR, BYVAL AS gchar PTR, BYVAL AS gsize, BYVAL AS gsize PTR, BYVAL AS GError PTR PTR) AS GIOStatus
DECLARE FUNCTION g_io_channel_read_unichar(BYVAL AS GIOChannel PTR, BYVAL AS gunichar PTR, BYVAL AS GError PTR PTR) AS GIOStatus
DECLARE FUNCTION g_io_channel_write_chars(BYVAL AS GIOChannel PTR, BYVAL AS CONST gchar PTR, BYVAL AS gssize, BYVAL AS gsize PTR, BYVAL AS GError PTR PTR) AS GIOStatus
DECLARE FUNCTION g_io_channel_write_unichar(BYVAL AS GIOChannel PTR, BYVAL AS gunichar, BYVAL AS GError PTR PTR) AS GIOStatus
DECLARE FUNCTION g_io_channel_seek_position(BYVAL AS GIOChannel PTR, BYVAL AS gint64, BYVAL AS GSeekType, BYVAL AS GError PTR PTR) AS GIOStatus

#IFDEF G_OS_WIN32
#DEFINE g_io_channel_new_file g_io_channel_new_file_utf8
#ENDIF ' G_OS_WIN32

DECLARE FUNCTION g_io_channel_new_file(BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS GError PTR PTR) AS GIOChannel PTR
DECLARE FUNCTION g_io_channel_error_quark() AS GQuark
DECLARE FUNCTION g_io_channel_error_from_errno(BYVAL AS gint) AS GIOChannelError
DECLARE FUNCTION g_io_channel_unix_new(BYVAL AS INTEGER) AS GIOChannel PTR
DECLARE FUNCTION g_io_channel_unix_get_fd(BYVAL AS GIOChannel PTR) AS gint

EXTERN AS GSourceFuncs g_io_watch_funcs

#IFDEF G_OS_WIN32
#DEFINE G_WIN32_MSG_HANDLE 19981206

DECLARE SUB g_io_channel_win32_make_pollfd(BYVAL AS GIOChannel PTR, BYVAL AS GIOCondition, BYVAL AS GPollFD PTR)
DECLARE FUNCTION g_io_channel_win32_poll(BYVAL AS GPollFD PTR, BYVAL AS gint, BYVAL AS gint) AS gint

#IF GLIB_SIZEOF_VOID_P = 8

DECLARE FUNCTION g_io_channel_win32_new_messages(BYVAL AS gsize) AS GIOChannel PTR

#ELSE ' GLIB_SIZEOF_VOI...

DECLARE FUNCTION g_io_channel_win32_new_messages(BYVAL AS guint) AS GIOChannel PTR

#ENDIF ' GLIB_SIZEOF_VOI...

DECLARE FUNCTION g_io_channel_win32_new_fd(BYVAL AS gint) AS GIOChannel PTR
DECLARE FUNCTION g_io_channel_win32_get_fd(BYVAL AS GIOChannel PTR) AS gint
DECLARE FUNCTION g_io_channel_win32_new_socket(BYVAL AS gint) AS GIOChannel PTR

#ENDIF ' G_OS_WIN32
#ENDIF ' __G_IOCHANNEL_H__

#IFNDEF __G_KEY_FILE_H__
#DEFINE __G_KEY_FILE_H__

ENUM GKeyFileError
  G_KEY_FILE_ERROR_UNKNOWN_ENCODING
  G_KEY_FILE_ERROR_PARSE
  G_KEY_FILE_ERROR_NOT_FOUND
  G_KEY_FILE_ERROR_KEY_NOT_FOUND
  G_KEY_FILE_ERROR_GROUP_NOT_FOUND
  G_KEY_FILE_ERROR_INVALID_VALUE
END ENUM

#DEFINE G_KEY_FILE_ERROR g_key_file_error_quark()

DECLARE FUNCTION g_key_file_error_quark() AS GQuark

TYPE GKeyFile AS _GKeyFile

ENUM GKeyFileFlags
  G_KEY_FILE_NONE = 0
  G_KEY_FILE_KEEP_COMMENTS = 1 SHL 0
  G_KEY_FILE_KEEP_TRANSLATIONS = 1 SHL 1
END ENUM

DECLARE FUNCTION g_key_file_new() AS GKeyFile PTR
DECLARE FUNCTION g_key_file_ref(BYVAL AS GKeyFile PTR) AS GKeyFile PTR
DECLARE SUB g_key_file_unref(BYVAL AS GKeyFile PTR)
DECLARE SUB g_key_file_free(BYVAL AS GKeyFile PTR)
DECLARE SUB g_key_file_set_list_separator(BYVAL AS GKeyFile PTR, BYVAL AS UBYTE)
DECLARE FUNCTION g_key_file_load_from_file(BYVAL AS GKeyFile PTR, BYVAL AS CONST gchar PTR, BYVAL AS GKeyFileFlags, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_key_file_load_from_data(BYVAL AS GKeyFile PTR, BYVAL AS CONST gchar PTR, BYVAL AS gsize, BYVAL AS GKeyFileFlags, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_key_file_load_from_dirs(BYVAL AS GKeyFile PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR PTR, BYVAL AS gchar PTR PTR, BYVAL AS GKeyFileFlags, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_key_file_load_from_data_dirs(BYVAL AS GKeyFile PTR, BYVAL AS CONST gchar PTR, BYVAL AS gchar PTR PTR, BYVAL AS GKeyFileFlags, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_key_file_to_data(BYVAL AS GKeyFile PTR, BYVAL AS gsize PTR, BYVAL AS GError PTR PTR) AS gchar PTR
DECLARE FUNCTION g_key_file_get_start_group(BYVAL AS GKeyFile PTR) AS gchar PTR
DECLARE FUNCTION g_key_file_get_groups(BYVAL AS GKeyFile PTR, BYVAL AS gsize PTR) AS gchar PTR PTR
DECLARE FUNCTION g_key_file_get_keys(BYVAL AS GKeyFile PTR, BYVAL AS CONST gchar PTR, BYVAL AS gsize PTR, BYVAL AS GError PTR PTR) AS gchar PTR PTR
DECLARE FUNCTION g_key_file_has_group(BYVAL AS GKeyFile PTR, BYVAL AS CONST gchar PTR) AS gboolean
DECLARE FUNCTION g_key_file_has_key(BYVAL AS GKeyFile PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_key_file_get_value(BYVAL AS GKeyFile PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS GError PTR PTR) AS gchar PTR
DECLARE SUB g_key_file_set_value(BYVAL AS GKeyFile PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION g_key_file_get_string(BYVAL AS GKeyFile PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS GError PTR PTR) AS gchar PTR
DECLARE SUB g_key_file_set_string(BYVAL AS GKeyFile PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION g_key_file_get_locale_string(BYVAL AS GKeyFile PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS GError PTR PTR) AS gchar PTR
DECLARE SUB g_key_file_set_locale_string(BYVAL AS GKeyFile PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION g_key_file_get_boolean(BYVAL AS GKeyFile PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE SUB g_key_file_set_boolean(BYVAL AS GKeyFile PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS gboolean)
DECLARE FUNCTION g_key_file_get_integer(BYVAL AS GKeyFile PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS GError PTR PTR) AS gint
DECLARE SUB g_key_file_set_integer(BYVAL AS GKeyFile PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint)
DECLARE FUNCTION g_key_file_get_int64(BYVAL AS GKeyFile PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS GError PTR PTR) AS gint64
DECLARE SUB g_key_file_set_int64(BYVAL AS GKeyFile PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint64)
DECLARE FUNCTION g_key_file_get_uint64(BYVAL AS GKeyFile PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS GError PTR PTR) AS guint64
DECLARE SUB g_key_file_set_uint64(BYVAL AS GKeyFile PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS guint64)
DECLARE FUNCTION g_key_file_get_double(BYVAL AS GKeyFile PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS GError PTR PTR) AS gdouble
DECLARE SUB g_key_file_set_double(BYVAL AS GKeyFile PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS gdouble)
DECLARE FUNCTION g_key_file_get_string_list(BYVAL AS GKeyFile PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS gsize PTR, BYVAL AS GError PTR PTR) AS gchar PTR PTR
DECLARE SUB g_key_file_set_string_list(BYVAL AS GKeyFile PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar CONST PTR PTR, BYVAL AS gsize)
DECLARE FUNCTION g_key_file_get_locale_string_list(BYVAL AS GKeyFile PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS gsize PTR, BYVAL AS GError PTR PTR) AS gchar PTR PTR
DECLARE SUB g_key_file_set_locale_string_list(BYVAL AS GKeyFile PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar CONST PTR PTR, BYVAL AS gsize)
DECLARE FUNCTION g_key_file_get_boolean_list(BYVAL AS GKeyFile PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS gsize PTR, BYVAL AS GError PTR PTR) AS gboolean PTR
DECLARE SUB g_key_file_set_boolean_list(BYVAL AS GKeyFile PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS gboolean PTR, BYVAL AS gsize)
DECLARE FUNCTION g_key_file_get_integer_list(BYVAL AS GKeyFile PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS gsize PTR, BYVAL AS GError PTR PTR) AS gint PTR
DECLARE SUB g_key_file_set_double_list(BYVAL AS GKeyFile PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS gdouble PTR, BYVAL AS gsize)
DECLARE FUNCTION g_key_file_get_double_list(BYVAL AS GKeyFile PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS gsize PTR, BYVAL AS GError PTR PTR) AS gdouble PTR
DECLARE SUB g_key_file_set_integer_list(BYVAL AS GKeyFile PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint PTR, BYVAL AS gsize)
DECLARE FUNCTION g_key_file_set_comment(BYVAL AS GKeyFile PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_key_file_get_comment(BYVAL AS GKeyFile PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS GError PTR PTR) AS gchar PTR
DECLARE FUNCTION g_key_file_remove_comment(BYVAL AS GKeyFile PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_key_file_remove_key(BYVAL AS GKeyFile PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_key_file_remove_group(BYVAL AS GKeyFile PTR, BYVAL AS CONST gchar PTR, BYVAL AS GError PTR PTR) AS gboolean

#DEFINE G_KEY_FILE_DESKTOP_GROUP !"Desktop Entry"
#DEFINE G_KEY_FILE_DESKTOP_KEY_TYPE !"Type"
#DEFINE G_KEY_FILE_DESKTOP_KEY_VERSION !"Version"
#DEFINE G_KEY_FILE_DESKTOP_KEY_NAME !"Name"
#DEFINE G_KEY_FILE_DESKTOP_KEY_GENERIC_NAME !"GenericName"
#DEFINE G_KEY_FILE_DESKTOP_KEY_NO_DISPLAY !"NoDisplay"
#DEFINE G_KEY_FILE_DESKTOP_KEY_COMMENT !"Comment"
#DEFINE G_KEY_FILE_DESKTOP_KEY_ICON !"Icon"
#DEFINE G_KEY_FILE_DESKTOP_KEY_HIDDEN !"Hidden"
#DEFINE G_KEY_FILE_DESKTOP_KEY_ONLY_SHOW_IN !"OnlyShowIn"
#DEFINE G_KEY_FILE_DESKTOP_KEY_NOT_SHOW_IN !"NotShowIn"
#DEFINE G_KEY_FILE_DESKTOP_KEY_TRY_EXEC !"TryExec"
#DEFINE G_KEY_FILE_DESKTOP_KEY_EXEC !"Exec"
#DEFINE G_KEY_FILE_DESKTOP_KEY_PATH !"Path"
#DEFINE G_KEY_FILE_DESKTOP_KEY_TERMINAL !"Terminal"
#DEFINE G_KEY_FILE_DESKTOP_KEY_MIME_TYPE !"MimeType"
#DEFINE G_KEY_FILE_DESKTOP_KEY_CATEGORIES !"Categories"
#DEFINE G_KEY_FILE_DESKTOP_KEY_STARTUP_NOTIFY !"StartupNotify"
#DEFINE G_KEY_FILE_DESKTOP_KEY_STARTUP_WM_CLASS !"StartupWMClass"
#DEFINE G_KEY_FILE_DESKTOP_KEY_URL !"URL"
#DEFINE G_KEY_FILE_DESKTOP_TYPE_APPLICATION !"Application"
#DEFINE G_KEY_FILE_DESKTOP_TYPE_LINK !"Link"
#DEFINE G_KEY_FILE_DESKTOP_TYPE_DIRECTORY !"Directory"
#ENDIF ' __G_KEY_FILE_H__

#IFNDEF __G_MAPPED_FILE_H__
#DEFINE __G_MAPPED_FILE_H__

TYPE GMappedFile AS _GMappedFile

DECLARE FUNCTION g_mapped_file_new(BYVAL AS CONST gchar PTR, BYVAL AS gboolean, BYVAL AS GError PTR PTR) AS GMappedFile PTR
DECLARE FUNCTION g_mapped_file_new_from_fd(BYVAL AS gint, BYVAL AS gboolean, BYVAL AS GError PTR PTR) AS GMappedFile PTR
DECLARE FUNCTION g_mapped_file_get_length(BYVAL AS GMappedFile PTR) AS gsize
DECLARE FUNCTION g_mapped_file_get_contents(BYVAL AS GMappedFile PTR) AS gchar PTR
DECLARE FUNCTION g_mapped_file_ref(BYVAL AS GMappedFile PTR) AS GMappedFile PTR
DECLARE SUB g_mapped_file_unref(BYVAL AS GMappedFile PTR)
DECLARE SUB g_mapped_file_free(BYVAL AS GMappedFile PTR)

#ENDIF ' __G_MAPPED_FILE_H__

#IFNDEF __G_MARKUP_H__
#DEFINE __G_MARKUP_H__

ENUM GMarkupError
  G_MARKUP_ERROR_BAD_UTF8
  G_MARKUP_ERROR_EMPTY
  G_MARKUP_ERROR_PARSE
  G_MARKUP_ERROR_UNKNOWN_ELEMENT
  G_MARKUP_ERROR_UNKNOWN_ATTRIBUTE
  G_MARKUP_ERROR_INVALID_CONTENT
  G_MARKUP_ERROR_MISSING_ATTRIBUTE
END ENUM

#DEFINE G_MARKUP_ERROR g_markup_error_quark ()

DECLARE FUNCTION g_markup_error_quark() AS GQuark

ENUM GMarkupParseFlags
  G_MARKUP_DO_NOT_USE_THIS_UNSUPPORTED_FLAG = 1 SHL 0
  G_MARKUP_TREAT_CDATA_AS_TEXT = 1 SHL 1
  G_MARKUP_PREFIX_ERROR_POSITION = 1 SHL 2
END ENUM

TYPE GMarkupParseContext AS _GMarkupParseContext
TYPE GMarkupParser AS _GMarkupParser

TYPE _GMarkupParser
  start_element AS SUB(BYVAL AS GMarkupParseContext PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR PTR, BYVAL AS CONST gchar PTR PTR, BYVAL AS gpointer, BYVAL AS GError PTR PTR)
  end_element AS SUB(BYVAL AS GMarkupParseContext PTR, BYVAL AS CONST gchar PTR, BYVAL AS gpointer, BYVAL AS GError PTR PTR)
  text AS SUB(BYVAL AS GMarkupParseContext PTR, BYVAL AS CONST gchar PTR, BYVAL AS gsize, BYVAL AS gpointer, BYVAL AS GError PTR PTR)
  passthrough AS SUB(BYVAL AS GMarkupParseContext PTR, BYVAL AS CONST gchar PTR, BYVAL AS gsize, BYVAL AS gpointer, BYVAL AS GError PTR PTR)
  error_ AS SUB(BYVAL AS GMarkupParseContext PTR, BYVAL AS GError PTR, BYVAL AS gpointer)
END TYPE

DECLARE FUNCTION g_markup_parse_context_new(BYVAL AS CONST GMarkupParser PTR, BYVAL AS GMarkupParseFlags, BYVAL AS gpointer, BYVAL AS GDestroyNotify) AS GMarkupParseContext PTR
DECLARE SUB g_markup_parse_context_free(BYVAL AS GMarkupParseContext PTR)
DECLARE FUNCTION g_markup_parse_context_parse(BYVAL AS GMarkupParseContext PTR, BYVAL AS CONST gchar PTR, BYVAL AS gssize, BYVAL AS GError PTR PTR) AS gboolean
DECLARE SUB g_markup_parse_context_push(BYVAL AS GMarkupParseContext PTR, BYVAL AS CONST GMarkupParser PTR, BYVAL AS gpointer)
DECLARE FUNCTION g_markup_parse_context_pop(BYVAL AS GMarkupParseContext PTR) AS gpointer
DECLARE FUNCTION g_markup_parse_context_end_parse(BYVAL AS GMarkupParseContext PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_markup_parse_context_get_element(BYVAL AS GMarkupParseContext PTR) AS CONST gchar PTR
DECLARE FUNCTION g_markup_parse_context_get_element_stack(BYVAL AS GMarkupParseContext PTR) AS CONST GSList PTR
DECLARE SUB g_markup_parse_context_get_position(BYVAL AS GMarkupParseContext PTR, BYVAL AS gint PTR, BYVAL AS gint PTR)
DECLARE FUNCTION g_markup_parse_context_get_user_data(BYVAL AS GMarkupParseContext PTR) AS gpointer
DECLARE FUNCTION g_markup_escape_text(BYVAL AS CONST gchar PTR, BYVAL AS gssize) AS gchar PTR
DECLARE FUNCTION g_markup_printf_escaped(BYVAL AS CONST ZSTRING PTR, ...) AS gchar PTR
DECLARE FUNCTION g_markup_vprintf_escaped(BYVAL AS CONST ZSTRING PTR, BYVAL AS va_list) AS gchar PTR

ENUM GMarkupCollectType
  G_MARKUP_COLLECT_INVALID
  G_MARKUP_COLLECT_STRING
  G_MARKUP_COLLECT_STRDUP
  G_MARKUP_COLLECT_BOOLEAN
  G_MARKUP_COLLECT_TRISTATE
  G_MARKUP_COLLECT_OPTIONAL = (1 SHL 16)
END ENUM

DECLARE FUNCTION g_markup_collect_attributes(BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR PTR, BYVAL AS CONST gchar PTR PTR, BYVAL AS GError PTR PTR, BYVAL AS GMarkupCollectType, BYVAL AS CONST gchar PTR, ...) AS gboolean

#ENDIF ' __G_MARKUP_H__

#IFNDEF __G_MESSAGES_H__
#DEFINE __G_MESSAGES_H__

DECLARE FUNCTION g_printf_string_upper_bound(BYVAL AS CONST gchar PTR, BYVAL AS va_list) AS gsize

#DEFINE G_LOG_LEVEL_USER_SHIFT (8)

ENUM GLogLevelFlags
  G_LOG_FLAG_RECURSION = 1 SHL 0
  G_LOG_FLAG_FATAL = 1 SHL 1
  G_LOG_LEVEL_ERROR = 1 SHL 2
  G_LOG_LEVEL_CRITICAL = 1 SHL 3
  G_LOG_LEVEL_WARNING = 1 SHL 4
  G_LOG_LEVEL_MESSAGE = 1 SHL 5
  G_LOG_LEVEL_INFO = 1 SHL 6
  G_LOG_LEVEL_DEBUG = 1 SHL 7
  G_LOG_LEVEL_MASK = NOT (G_LOG_FLAG_RECURSION OR G_LOG_FLAG_FATAL)
END ENUM

#DEFINE G_LOG_FATAL_MASK (G_LOG_FLAG_RECURSION OR G_LOG_LEVEL_ERROR)

TYPE GLogFunc AS SUB(BYVAL AS CONST gchar PTR, BYVAL AS GLogLevelFlags, BYVAL AS CONST gchar PTR, BYVAL AS gpointer)

DECLARE FUNCTION g_log_set_handler(BYVAL AS CONST gchar PTR, BYVAL AS GLogLevelFlags, BYVAL AS GLogFunc, BYVAL AS gpointer) AS guint
DECLARE SUB g_log_remove_handler(BYVAL AS CONST gchar PTR, BYVAL AS guint)
DECLARE SUB g_log_default_handler(BYVAL AS CONST gchar PTR, BYVAL AS GLogLevelFlags, BYVAL AS CONST gchar PTR, BYVAL AS gpointer)
DECLARE FUNCTION g_log_set_default_handler(BYVAL AS GLogFunc, BYVAL AS gpointer) AS GLogFunc
DECLARE SUB g_log(BYVAL AS CONST gchar PTR, BYVAL AS GLogLevelFlags, BYVAL AS CONST gchar PTR, ...)
DECLARE SUB g_logv(BYVAL AS CONST gchar PTR, BYVAL AS GLogLevelFlags, BYVAL AS CONST gchar PTR, BYVAL AS va_list)
DECLARE FUNCTION g_log_set_fatal_mask(BYVAL AS CONST gchar PTR, BYVAL AS GLogLevelFlags) AS GLogLevelFlags
DECLARE FUNCTION g_log_set_always_fatal(BYVAL AS GLogLevelFlags) AS GLogLevelFlags
DECLARE SUB _g_log_fallback_handler(BYVAL AS CONST gchar PTR, BYVAL AS GLogLevelFlags, BYVAL AS CONST gchar PTR, BYVAL AS gpointer)
DECLARE SUB g_return_if_fail_warning(BYVAL AS CONST ZSTRING PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS CONST ZSTRING PTR)
DECLARE SUB g_warn_message(BYVAL AS CONST ZSTRING PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS INTEGER, BYVAL AS CONST ZSTRING PTR, BYVAL AS CONST ZSTRING PTR)
DECLARE SUB g_assert_warning(BYVAL AS CONST ZSTRING PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS CONST INTEGER, BYVAL AS CONST ZSTRING PTR, BYVAL AS CONST ZSTRING PTR)

#IFNDEF G_LOG_DOMAIN
#DEFINE G_LOG_DOMAIN (CAST(gchar PTR, 0))
#ENDIF ' G_LOG_DOMAIN

#IFNDEF G_HAVE_GNUC_VARARGS

#DEFINE g_error(format) #ERROR g_error NOT defined (update fbc)
#DEFINE g_message(format)  #ERROR g_message NOT defined (update fbc)
#DEFINE g_critical(format)  #ERROR g_critical NOT defined (update fbc)
#DEFINE g_warning(format)  #ERROR g_warning NOT defined (update fbc)
#DEFINE g_debug(format)  #ERROR g_debug NOT defined (update fbc)

#ELSE ' G_HAVE_GNUC_VARARGS

#DEFINE g_error(__VA_ARGS__...) g_log (G_LOG_DOMAIN, G_LOG_LEVEL_ERROR, __VA_ARGS__)
#DEFINE g_message(__VA_ARGS__...) g_log (G_LOG_DOMAIN, G_LOG_LEVEL_MESSAGE, __VA_ARGS__)
#DEFINE g_critical(__VA_ARGS__...) g_log(G_LOG_DOMAIN, G_LOG_LEVEL_CRITICAL, __VA_ARGS__)
#DEFINE g_warning(__VA_ARGS__...) g_log(G_LOG_DOMAIN, G_LOG_LEVEL_WARNING, __VA_ARGS__)
#DEFINE g_debug(__VA_ARGS__...) g_log(G_LOG_DOMAIN, G_LOG_LEVEL_DEBUG, __VA_ARGS__)

#ENDIF ' G_HAVE_GNUC_VARARGS

TYPE GPrintFunc AS SUB(BYVAL AS CONST gchar PTR)

DECLARE SUB g_print(BYVAL AS CONST gchar PTR, ...)
DECLARE FUNCTION g_set_print_handler(BYVAL AS GPrintFunc) AS GPrintFunc
DECLARE SUB g_printerr(BYVAL AS CONST gchar PTR, ...)
DECLARE FUNCTION g_set_printerr_handler(BYVAL AS GPrintFunc) AS GPrintFunc

#DEFINE g_warn_if_reached() g_warn_message (G_LOG_DOMAIN, __FILE__, __LINE__, G_STRFUNC, NULL)
#DEFINE g_warn_if_fail(expr) IF NOT (expr) THEN g_warn_message (G_LOG_DOMAIN, __FILE__, __LINE__, G_STRFUNC, #expr)

#IFDEF G_DISABLE_CHECKS

#DEFINE g_return_if_fail(expr)
#DEFINE g_return_val_if_fail(expr,val)
#DEFINE g_return_if_reached()
#DEFINE g_return_val_if_reached(val)

#ELSE ' G_DISABLE_CHECKS

#DEFINE g_return_if_fail(expr) IF 0 = (expr) THEN g_log(G_LOG_DOMAIN, G_LOG_LEVEL_CRITICAL, _
          "file %s: line %d (%s): assertion `%s' failed", __FILE__, __LINE__, __FUNCTION__, #expr) : EXIT SUB
#DEFINE g_return_val_if_fail(expr,val) IF 0 = (expr) THEN g_log(G_LOG_DOMAIN, G_LOG_LEVEL_CRITICAL, _
          "file %s: line %d (%s): assertion `%s' failed", __FILE__, __LINE__, __FUNCTION__, #expr) : RETURN val
#DEFINE g_return_if_reached() g_log(G_LOG_DOMAIN, G_LOG_LEVEL_CRITICAL, _
          "file %s: line %d (%s): should not be reached", __FILE__, __LINE__, __FUNCTION__) : EXIT SUB
#DEFINE g_return_val_if_reached(val) g_log(G_LOG_DOMAIN, G_LOG_LEVEL_CRITICAL, _
          "file %s: line %d (%s): should not be reached", __FILE__, __LINE__, __FUNCTION__) : RETURN val

#ENDIF ' G_DISABLE_CHECKS
#ENDIF ' __G_MESSAGES_H__

#IFNDEF __G_NODE_H__
#DEFINE __G_NODE_H__

TYPE GNode AS _GNode

ENUM GTraverseFlags
  G_TRAVERSE_LEAVES = 1 SHL 0
  G_TRAVERSE_NON_LEAVES = 1 SHL 1
  G_TRAVERSE_ALL = G_TRAVERSE_LEAVES OR G_TRAVERSE_NON_LEAVES
  G_TRAVERSE_MASK = &h03
  G_TRAVERSE_LEAFS = G_TRAVERSE_LEAVES
  G_TRAVERSE_NON_LEAFS = G_TRAVERSE_NON_LEAVES
END ENUM

ENUM GTraverseType
  G_IN_ORDER
  G_PRE_ORDER
  G_POST_ORDER
  G_LEVEL_ORDER
END ENUM

TYPE GNodeTraverseFunc AS FUNCTION(BYVAL AS GNode PTR, BYVAL AS gpointer) AS gboolean
TYPE GNodeForeachFunc AS SUB(BYVAL AS GNode PTR, BYVAL AS gpointer)
TYPE GCopyFunc AS FUNCTION(BYVAL AS gconstpointer, BYVAL AS gpointer) AS gpointer

TYPE _GNode
  AS gpointer data
  AS GNode PTR next
  AS GNode PTR prev
  AS GNode PTR parent
  AS GNode PTR children
END TYPE

#DEFINE G_NODE_IS_ROOT(node) ((CAST(GNode PTR, (node)))->parent = NULL ANDALSO _
     (CAST(GNode PTR, (node)))->prev = NULL ANDALSO _
     (CAST(GNode PTR, (node)))->next = NULL)
#DEFINE G_NODE_IS_LEAF(node) ((CAST(GNode PTR, (node)))->children = NULL)

DECLARE FUNCTION g_node_new(BYVAL AS gpointer) AS GNode PTR
DECLARE SUB g_node_destroy(BYVAL AS GNode PTR)
DECLARE SUB g_node_unlink(BYVAL AS GNode PTR)
DECLARE FUNCTION g_node_copy_deep(BYVAL AS GNode PTR, BYVAL AS GCopyFunc, BYVAL AS gpointer) AS GNode PTR
DECLARE FUNCTION g_node_copy(BYVAL AS GNode PTR) AS GNode PTR
DECLARE FUNCTION g_node_insert(BYVAL AS GNode PTR, BYVAL AS gint, BYVAL AS GNode PTR) AS GNode PTR
DECLARE FUNCTION g_node_insert_before(BYVAL AS GNode PTR, BYVAL AS GNode PTR, BYVAL AS GNode PTR) AS GNode PTR
DECLARE FUNCTION g_node_insert_after(BYVAL AS GNode PTR, BYVAL AS GNode PTR, BYVAL AS GNode PTR) AS GNode PTR
DECLARE FUNCTION g_node_prepend(BYVAL AS GNode PTR, BYVAL AS GNode PTR) AS GNode PTR
DECLARE FUNCTION g_node_n_nodes(BYVAL AS GNode PTR, BYVAL AS GTraverseFlags) AS guint
DECLARE FUNCTION g_node_get_root(BYVAL AS GNode PTR) AS GNode PTR
DECLARE FUNCTION g_node_is_ancestor(BYVAL AS GNode PTR, BYVAL AS GNode PTR) AS gboolean
DECLARE FUNCTION g_node_depth(BYVAL AS GNode PTR) AS guint
DECLARE FUNCTION g_node_find(BYVAL AS GNode PTR, BYVAL AS GTraverseType, BYVAL AS GTraverseFlags, BYVAL AS gpointer) AS GNode PTR

#DEFINE g_node_append(parent, node) _
     g_node_insert_before ((parent), NULL, (node))
#DEFINE g_node_insert_data(parent, position, data) _
     g_node_insert ((parent), (position), g_node_new (data))
#DEFINE g_node_insert_data_before(parent, sibling, data) _
     g_node_insert_before ((parent), (sibling), g_node_new (data))
#DEFINE g_node_prepend_data(parent, data) _
     g_node_prepend ((parent), g_node_new (data))
#DEFINE g_node_append_data(parent, data) _
     g_node_insert_before ((parent), NULL, g_node_new (data))

DECLARE SUB g_node_traverse(BYVAL AS GNode PTR, BYVAL AS GTraverseType, BYVAL AS GTraverseFlags, BYVAL AS gint, BYVAL AS GNodeTraverseFunc, BYVAL AS gpointer)
DECLARE FUNCTION g_node_max_height(BYVAL AS GNode PTR) AS guint
DECLARE SUB g_node_children_foreach(BYVAL AS GNode PTR, BYVAL AS GTraverseFlags, BYVAL AS GNodeForeachFunc, BYVAL AS gpointer)
DECLARE SUB g_node_reverse_children(BYVAL AS GNode PTR)
DECLARE FUNCTION g_node_n_children(BYVAL AS GNode PTR) AS guint
DECLARE FUNCTION g_node_nth_child(BYVAL AS GNode PTR, BYVAL AS guint) AS GNode PTR
DECLARE FUNCTION g_node_last_child(BYVAL AS GNode PTR) AS GNode PTR
DECLARE FUNCTION g_node_find_child(BYVAL AS GNode PTR, BYVAL AS GTraverseFlags, BYVAL AS gpointer) AS GNode PTR
DECLARE FUNCTION g_node_child_position(BYVAL AS GNode PTR, BYVAL AS GNode PTR) AS gint
DECLARE FUNCTION g_node_child_index(BYVAL AS GNode PTR, BYVAL AS gpointer) AS gint
DECLARE FUNCTION g_node_first_sibling(BYVAL AS GNode PTR) AS GNode PTR
DECLARE FUNCTION g_node_last_sibling(BYVAL AS GNode PTR) AS GNode PTR

#DEFINE g_node_prev_sibling(node) IIF((node) , _
      (CAST(GNode PTR, (node)))->prev , NULL)
#DEFINE g_node_next_sibling(node) IIF((node) , _
      (CAST(GNode PTR, (node)))->next , NULL)
#DEFINE g_node_first_child(node) IIF((node) , _
      (CAST(GNode PTR, (node)))->children , NULL)
#ENDIF ' __G_NODE_H__

#IFNDEF __G_OPTION_H__
#DEFINE __G_OPTION_H__

TYPE GOptionContext AS _GOptionContext
TYPE GOptionGroup AS _GOptionGroup
TYPE GOptionEntry AS _GOptionEntry

ENUM GOptionFlags
  G_OPTION_FLAG_HIDDEN = 1 SHL 0
  G_OPTION_FLAG_IN_MAIN = 1 SHL 1
  G_OPTION_FLAG_REVERSE = 1 SHL 2
  G_OPTION_FLAG_NO_ARG = 1 SHL 3
  G_OPTION_FLAG_FILENAME = 1 SHL 4
  G_OPTION_FLAG_OPTIONAL_ARG = 1 SHL 5
  G_OPTION_FLAG_NOALIAS = 1 SHL 6
END ENUM

ENUM GOptionArg
  G_OPTION_ARG_NONE
  G_OPTION_ARG_STRING
  G_OPTION_ARG_INT
  G_OPTION_ARG_CALLBACK
  G_OPTION_ARG_FILENAME
  G_OPTION_ARG_STRING_ARRAY
  G_OPTION_ARG_FILENAME_ARRAY
  G_OPTION_ARG_DOUBLE
  G_OPTION_ARG_INT64
END ENUM

TYPE GOptionArgFunc AS FUNCTION(BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS gpointer, BYVAL AS GError PTR PTR) AS gboolean
TYPE GOptionParseFunc AS FUNCTION(BYVAL AS GOptionContext PTR, BYVAL AS GOptionGroup PTR, BYVAL AS gpointer, BYVAL AS GError PTR PTR) AS gboolean
TYPE GOptionErrorFunc AS SUB(BYVAL AS GOptionContext PTR, BYVAL AS GOptionGroup PTR, BYVAL AS gpointer, BYVAL AS GError PTR PTR)

#DEFINE G_OPTION_ERROR (g_option_error_quark ())

ENUM GOptionError
  G_OPTION_ERROR_UNKNOWN_OPTION
  G_OPTION_ERROR_BAD_VALUE
  G_OPTION_ERROR_FAILED
END ENUM

DECLARE FUNCTION g_option_error_quark() AS GQuark

TYPE _GOptionEntry
  AS CONST gchar PTR long_name
  AS gchar short_name
  AS gint flags
  AS GOptionArg arg
  AS gpointer arg_data
  AS CONST gchar PTR description
  AS CONST gchar PTR arg_description
END TYPE

#DEFINE G_OPTION_REMAINING !""

DECLARE FUNCTION g_option_context_new(BYVAL AS CONST gchar PTR) AS GOptionContext PTR
DECLARE SUB g_option_context_set_summary(BYVAL AS GOptionContext PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION g_option_context_get_summary(BYVAL AS GOptionContext PTR) AS CONST gchar PTR
DECLARE SUB g_option_context_set_description(BYVAL AS GOptionContext PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION g_option_context_get_description(BYVAL AS GOptionContext PTR) AS CONST gchar PTR
DECLARE SUB g_option_context_free(BYVAL AS GOptionContext PTR)
DECLARE SUB g_option_context_set_help_enabled(BYVAL AS GOptionContext PTR, BYVAL AS gboolean)
DECLARE FUNCTION g_option_context_get_help_enabled(BYVAL AS GOptionContext PTR) AS gboolean
DECLARE SUB g_option_context_set_ignore_unknown_options(BYVAL AS GOptionContext PTR, BYVAL AS gboolean)
DECLARE FUNCTION g_option_context_get_ignore_unknown_options(BYVAL AS GOptionContext PTR) AS gboolean
DECLARE SUB g_option_context_add_main_entries(BYVAL AS GOptionContext PTR, BYVAL AS CONST GOptionEntry PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION g_option_context_parse(BYVAL AS GOptionContext PTR, BYVAL AS gint PTR, BYVAL AS gchar PTR PTR PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE SUB g_option_context_set_translate_func(BYVAL AS GOptionContext PTR, BYVAL AS GTranslateFunc, BYVAL AS gpointer, BYVAL AS GDestroyNotify)
DECLARE SUB g_option_context_set_translation_domain(BYVAL AS GOptionContext PTR, BYVAL AS CONST gchar PTR)
DECLARE SUB g_option_context_add_group(BYVAL AS GOptionContext PTR, BYVAL AS GOptionGroup PTR)
DECLARE SUB g_option_context_set_main_group(BYVAL AS GOptionContext PTR, BYVAL AS GOptionGroup PTR)
DECLARE FUNCTION g_option_context_get_main_group(BYVAL AS GOptionContext PTR) AS GOptionGroup PTR
DECLARE FUNCTION g_option_context_get_help(BYVAL AS GOptionContext PTR, BYVAL AS gboolean, BYVAL AS GOptionGroup PTR) AS gchar PTR
DECLARE FUNCTION g_option_group_new(BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS gpointer, BYVAL AS GDestroyNotify) AS GOptionGroup PTR
DECLARE SUB g_option_group_set_parse_hooks(BYVAL AS GOptionGroup PTR, BYVAL AS GOptionParseFunc, BYVAL AS GOptionParseFunc)
DECLARE SUB g_option_group_set_error_hook(BYVAL AS GOptionGroup PTR, BYVAL AS GOptionErrorFunc)
DECLARE SUB g_option_group_free(BYVAL AS GOptionGroup PTR)
DECLARE SUB g_option_group_add_entries(BYVAL AS GOptionGroup PTR, BYVAL AS CONST GOptionEntry PTR)
DECLARE SUB g_option_group_set_translate_func(BYVAL AS GOptionGroup PTR, BYVAL AS GTranslateFunc, BYVAL AS gpointer, BYVAL AS GDestroyNotify)
DECLARE SUB g_option_group_set_translation_domain(BYVAL AS GOptionGroup PTR, BYVAL AS CONST gchar PTR)

#ENDIF ' __G_OPTION_H__

#IFNDEF __G_PATTERN_H__
#DEFINE __G_PATTERN_H__

TYPE GPatternSpec AS _GPatternSpec

DECLARE FUNCTION g_pattern_spec_new(BYVAL AS CONST gchar PTR) AS GPatternSpec PTR
DECLARE SUB g_pattern_spec_free(BYVAL AS GPatternSpec PTR)
DECLARE FUNCTION g_pattern_spec_equal(BYVAL AS GPatternSpec PTR, BYVAL AS GPatternSpec PTR) AS gboolean
DECLARE FUNCTION g_pattern_match(BYVAL AS GPatternSpec PTR, BYVAL AS guint, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR) AS gboolean
DECLARE FUNCTION g_pattern_match_string(BYVAL AS GPatternSpec PTR, BYVAL AS CONST gchar PTR) AS gboolean
DECLARE FUNCTION g_pattern_match_simple(BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR) AS gboolean

#ENDIF ' __G_PATTERN_H__

#IFNDEF __G_PRIMES_H__
#DEFINE __G_PRIMES_H__

DECLARE FUNCTION g_spaced_primes_closest(BYVAL AS guint) AS guint

#ENDIF ' __G_PRIMES_H__

#IFNDEF __G_QSORT_H__
#DEFINE __G_QSORT_H__

DECLARE SUB g_qsort_with_data(BYVAL AS gconstpointer, BYVAL AS gint, BYVAL AS gsize, BYVAL AS GCompareDataFunc, BYVAL AS gpointer)

#ENDIF ' __G_QSORT_H__

#IFNDEF __G_QUEUE_H__
#DEFINE __G_QUEUE_H__

TYPE GQueue AS _GQueue

TYPE _GQueue
  AS GList PTR head
  AS GList PTR tail
  AS guint length
END TYPE

#DEFINE G_QUEUE_INIT_ TYPE<GQueue>( NULL, NULL, 0 )

DECLARE FUNCTION g_queue_new() AS GQueue PTR
DECLARE SUB g_queue_free(BYVAL AS GQueue PTR)
DECLARE SUB g_queue_init(BYVAL AS GQueue PTR)
DECLARE SUB g_queue_clear(BYVAL AS GQueue PTR)
DECLARE FUNCTION g_queue_is_empty(BYVAL AS GQueue PTR) AS gboolean
DECLARE FUNCTION g_queue_get_length(BYVAL AS GQueue PTR) AS guint
DECLARE SUB g_queue_reverse(BYVAL AS GQueue PTR)
DECLARE FUNCTION g_queue_copy(BYVAL AS GQueue PTR) AS GQueue PTR
DECLARE SUB g_queue_foreach(BYVAL AS GQueue PTR, BYVAL AS GFunc, BYVAL AS gpointer)
DECLARE FUNCTION g_queue_find(BYVAL AS GQueue PTR, BYVAL AS gconstpointer) AS GList PTR
DECLARE FUNCTION g_queue_find_custom(BYVAL AS GQueue PTR, BYVAL AS gconstpointer, BYVAL AS GCompareFunc) AS GList PTR
DECLARE SUB g_queue_sort(BYVAL AS GQueue PTR, BYVAL AS GCompareDataFunc, BYVAL AS gpointer)
DECLARE SUB g_queue_push_head(BYVAL AS GQueue PTR, BYVAL AS gpointer)
DECLARE SUB g_queue_push_tail(BYVAL AS GQueue PTR, BYVAL AS gpointer)
DECLARE SUB g_queue_push_nth(BYVAL AS GQueue PTR, BYVAL AS gpointer, BYVAL AS gint)
DECLARE FUNCTION g_queue_pop_head(BYVAL AS GQueue PTR) AS gpointer
DECLARE FUNCTION g_queue_pop_tail(BYVAL AS GQueue PTR) AS gpointer
DECLARE FUNCTION g_queue_pop_nth(BYVAL AS GQueue PTR, BYVAL AS guint) AS gpointer
DECLARE FUNCTION g_queue_peek_head(BYVAL AS GQueue PTR) AS gpointer
DECLARE FUNCTION g_queue_peek_tail(BYVAL AS GQueue PTR) AS gpointer
DECLARE FUNCTION g_queue_peek_nth(BYVAL AS GQueue PTR, BYVAL AS guint) AS gpointer
DECLARE FUNCTION g_queue_index(BYVAL AS GQueue PTR, BYVAL AS gconstpointer) AS gint
DECLARE FUNCTION g_queue_remove(BYVAL AS GQueue PTR, BYVAL AS gconstpointer) AS gboolean
DECLARE FUNCTION g_queue_remove_all(BYVAL AS GQueue PTR, BYVAL AS gconstpointer) AS guint
DECLARE SUB g_queue_insert_before(BYVAL AS GQueue PTR, BYVAL AS GList PTR, BYVAL AS gpointer)
DECLARE SUB g_queue_insert_after(BYVAL AS GQueue PTR, BYVAL AS GList PTR, BYVAL AS gpointer)
DECLARE SUB g_queue_insert_sorted(BYVAL AS GQueue PTR, BYVAL AS gpointer, BYVAL AS GCompareDataFunc, BYVAL AS gpointer)
DECLARE SUB g_queue_push_head_link(BYVAL AS GQueue PTR, BYVAL AS GList PTR)
DECLARE SUB g_queue_push_tail_link(BYVAL AS GQueue PTR, BYVAL AS GList PTR)
DECLARE SUB g_queue_push_nth_link(BYVAL AS GQueue PTR, BYVAL AS gint, BYVAL AS GList PTR)
DECLARE FUNCTION g_queue_pop_head_link(BYVAL AS GQueue PTR) AS GList PTR
DECLARE FUNCTION g_queue_pop_tail_link(BYVAL AS GQueue PTR) AS GList PTR
DECLARE FUNCTION g_queue_pop_nth_link(BYVAL AS GQueue PTR, BYVAL AS guint) AS GList PTR
DECLARE FUNCTION g_queue_peek_head_link(BYVAL AS GQueue PTR) AS GList PTR
DECLARE FUNCTION g_queue_peek_tail_link(BYVAL AS GQueue PTR) AS GList PTR
DECLARE FUNCTION g_queue_peek_nth_link(BYVAL AS GQueue PTR, BYVAL AS guint) AS GList PTR
DECLARE FUNCTION g_queue_link_index(BYVAL AS GQueue PTR, BYVAL AS GList PTR) AS gint
DECLARE SUB g_queue_unlink(BYVAL AS GQueue PTR, BYVAL AS GList PTR)
DECLARE SUB g_queue_delete_link(BYVAL AS GQueue PTR, BYVAL AS GList PTR)

#ENDIF ' __G_QUEUE_H__

#IFNDEF __G_RAND_H__
#DEFINE __G_RAND_H__

TYPE GRand AS _GRand

DECLARE FUNCTION g_rand_new_with_seed(BYVAL AS guint32) AS GRand PTR
DECLARE FUNCTION g_rand_new_with_seed_array(BYVAL AS CONST guint32 PTR, BYVAL AS guint) AS GRand PTR
DECLARE FUNCTION g_rand_new() AS GRand PTR
DECLARE SUB g_rand_free(BYVAL AS GRand PTR)
DECLARE FUNCTION g_rand_copy(BYVAL AS GRand PTR) AS GRand PTR
DECLARE SUB g_rand_set_seed(BYVAL AS GRand PTR, BYVAL AS guint32)
DECLARE SUB g_rand_set_seed_array(BYVAL AS GRand PTR, BYVAL AS CONST guint32 PTR, BYVAL AS guint)

#DEFINE g_rand_boolean(rand_) ((g_rand_int (rand) AND (1 SHL 15)) <> 0)

DECLARE FUNCTION g_rand_int(BYVAL AS GRand PTR) AS guint32
DECLARE FUNCTION g_rand_int_range(BYVAL AS GRand PTR, BYVAL AS gint32, BYVAL AS gint32) AS gint32
DECLARE FUNCTION g_rand_double(BYVAL AS GRand PTR) AS gdouble
DECLARE FUNCTION g_rand_double_range(BYVAL AS GRand PTR, BYVAL AS gdouble, BYVAL AS gdouble) AS gdouble
DECLARE SUB g_random_set_seed(BYVAL AS guint32)

#DEFINE g_random_boolean() ((g_random_int () AND (1 SHL 15)) <> 0)

DECLARE FUNCTION g_random_int() AS guint32
DECLARE FUNCTION g_random_int_range(BYVAL AS gint32, BYVAL AS gint32) AS gint32
DECLARE FUNCTION g_random_double() AS gdouble
DECLARE FUNCTION g_random_double_range(BYVAL AS gdouble, BYVAL AS gdouble) AS gdouble

#ENDIF ' __G_RAND_H__


#IFNDEF __G_REGEX_H__
#DEFINE __G_REGEX_H__

ENUM GRegexError
  G_REGEX_ERROR_COMPILE
  G_REGEX_ERROR_OPTIMIZE
  G_REGEX_ERROR_REPLACE
  G_REGEX_ERROR_MATCH
  G_REGEX_ERROR_INTERNAL
  G_REGEX_ERROR_STRAY_BACKSLASH = 101
  G_REGEX_ERROR_MISSING_CONTROL_CHAR = 102
  G_REGEX_ERROR_UNRECOGNIZED_ESCAPE = 103
  G_REGEX_ERROR_QUANTIFIERS_OUT_OF_ORDER = 104
  G_REGEX_ERROR_QUANTIFIER_TOO_BIG = 105
  G_REGEX_ERROR_UNTERMINATED_CHARACTER_CLASS = 106
  G_REGEX_ERROR_INVALID_ESCAPE_IN_CHARACTER_CLASS = 107
  G_REGEX_ERROR_RANGE_OUT_OF_ORDER = 108
  G_REGEX_ERROR_NOTHING_TO_REPEAT = 109
  G_REGEX_ERROR_UNRECOGNIZED_CHARACTER = 112
  G_REGEX_ERROR_POSIX_NAMED_CLASS_OUTSIDE_CLASS = 113
  G_REGEX_ERROR_UNMATCHED_PARENTHESIS = 114
  G_REGEX_ERROR_INEXISTENT_SUBPATTERN_REFERENCE = 115
  G_REGEX_ERROR_UNTERMINATED_COMMENT = 118
  G_REGEX_ERROR_EXPRESSION_TOO_LARGE = 120
  G_REGEX_ERROR_MEMORY_ERROR = 121
  G_REGEX_ERROR_VARIABLE_LENGTH_LOOKBEHIND = 125
  G_REGEX_ERROR_MALFORMED_CONDITION = 126
  G_REGEX_ERROR_TOO_MANY_CONDITIONAL_BRANCHES = 127
  G_REGEX_ERROR_ASSERTION_EXPECTED = 128
  G_REGEX_ERROR_UNKNOWN_POSIX_CLASS_NAME = 130
  G_REGEX_ERROR_POSIX_COLLATING_ELEMENTS_NOT_SUPPORTED = 131
  G_REGEX_ERROR_HEX_CODE_TOO_LARGE = 134
  G_REGEX_ERROR_INVALID_CONDITION = 135
  G_REGEX_ERROR_SINGLE_BYTE_MATCH_IN_LOOKBEHIND = 136
  G_REGEX_ERROR_INFINITE_LOOP = 140
  G_REGEX_ERROR_MISSING_SUBPATTERN_NAME_TERMINATOR = 142
  G_REGEX_ERROR_DUPLICATE_SUBPATTERN_NAME = 143
  G_REGEX_ERROR_MALFORMED_PROPERTY = 146
  G_REGEX_ERROR_UNKNOWN_PROPERTY = 147
  G_REGEX_ERROR_SUBPATTERN_NAME_TOO_LONG = 148
  G_REGEX_ERROR_TOO_MANY_SUBPATTERNS = 149
  G_REGEX_ERROR_INVALID_OCTAL_VALUE = 151
  G_REGEX_ERROR_TOO_MANY_BRANCHES_IN_DEFINE = 154
  G_REGEX_ERROR_DEFINE_REPETION = 155
  G_REGEX_ERROR_INCONSISTENT_NEWLINE_OPTIONS = 156
  G_REGEX_ERROR_MISSING_BACK_REFERENCE = 157
END ENUM

#DEFINE G_REGEX_ERROR g_regex_error_quark ()

DECLARE FUNCTION g_regex_error_quark() AS GQuark

ENUM GRegexCompileFlags
  G_REGEX_CASELESS = 1 SHL 0
  G_REGEX_MULTILINE = 1 SHL 1
  G_REGEX_DOTALL = 1 SHL 2
  G_REGEX_EXTENDED = 1 SHL 3
  G_REGEX_ANCHORED = 1 SHL 4
  G_REGEX_DOLLAR_ENDONLY = 1 SHL 5
  G_REGEX_UNGREEDY = 1 SHL 9
  G_REGEX_RAW = 1 SHL 11
  G_REGEX_NO_AUTO_CAPTURE = 1 SHL 12
  G_REGEX_OPTIMIZE = 1 SHL 13
  G_REGEX_DUPNAMES = 1 SHL 19
  G_REGEX_NEWLINE_CR = 1 SHL 20
  G_REGEX_NEWLINE_LF = 1 SHL 21
  G_REGEX_NEWLINE_CRLF = G_REGEX_NEWLINE_CR OR G_REGEX_NEWLINE_LF
END ENUM

ENUM GRegexMatchFlags
  G_REGEX_MATCH_ANCHORED = 1 SHL 4
  G_REGEX_MATCH_NOTBOL = 1 SHL 7
  G_REGEX_MATCH_NOTEOL = 1 SHL 8
  G_REGEX_MATCH_NOTEMPTY = 1 SHL 10
  G_REGEX_MATCH_PARTIAL = 1 SHL 15
  G_REGEX_MATCH_NEWLINE_CR = 1 SHL 20
  G_REGEX_MATCH_NEWLINE_LF = 1 SHL 21
  G_REGEX_MATCH_NEWLINE_CRLF = G_REGEX_MATCH_NEWLINE_CR OR G_REGEX_MATCH_NEWLINE_LF
  G_REGEX_MATCH_NEWLINE_ANY = 1 SHL 22
END ENUM

TYPE GRegex AS _GRegex
TYPE GMatchInfo AS _GMatchInfo
TYPE GRegexEvalCallback AS FUNCTION(BYVAL AS CONST GMatchInfo PTR, BYVAL AS GString PTR, BYVAL AS gpointer) AS gboolean

DECLARE FUNCTION g_regex_new(BYVAL AS CONST gchar PTR, BYVAL AS GRegexCompileFlags, BYVAL AS GRegexMatchFlags, BYVAL AS GError PTR PTR) AS GRegex PTR
DECLARE FUNCTION g_regex_ref(BYVAL AS GRegex PTR) AS GRegex PTR
DECLARE SUB g_regex_unref(BYVAL AS GRegex PTR)
DECLARE FUNCTION g_regex_get_pattern(BYVAL AS CONST GRegex PTR) AS CONST gchar PTR
DECLARE FUNCTION g_regex_get_max_backref(BYVAL AS CONST GRegex PTR) AS gint
DECLARE FUNCTION g_regex_get_capture_count(BYVAL AS CONST GRegex PTR) AS gint
DECLARE FUNCTION g_regex_get_string_number(BYVAL AS CONST GRegex PTR, BYVAL AS CONST gchar PTR) AS gint
DECLARE FUNCTION g_regex_escape_string(BYVAL AS CONST gchar PTR, BYVAL AS gint) AS gchar PTR
DECLARE FUNCTION g_regex_escape_nul(BYVAL AS CONST gchar PTR, BYVAL AS gint) AS gchar PTR
DECLARE FUNCTION g_regex_get_compile_flags(BYVAL AS CONST GRegex PTR) AS GRegexCompileFlags
DECLARE FUNCTION g_regex_get_match_flags(BYVAL AS CONST GRegex PTR) AS GRegexMatchFlags
DECLARE FUNCTION g_regex_match_simple(BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS GRegexCompileFlags, BYVAL AS GRegexMatchFlags) AS gboolean
DECLARE FUNCTION g_regex_match(BYVAL AS CONST GRegex PTR, BYVAL AS CONST gchar PTR, BYVAL AS GRegexMatchFlags, BYVAL AS GMatchInfo PTR PTR) AS gboolean
DECLARE FUNCTION g_regex_match_full(BYVAL AS CONST GRegex PTR, BYVAL AS CONST gchar PTR, BYVAL AS gssize, BYVAL AS gint, BYVAL AS GRegexMatchFlags, BYVAL AS GMatchInfo PTR PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_regex_match_all(BYVAL AS CONST GRegex PTR, BYVAL AS CONST gchar PTR, BYVAL AS GRegexMatchFlags, BYVAL AS GMatchInfo PTR PTR) AS gboolean
DECLARE FUNCTION g_regex_match_all_full(BYVAL AS CONST GRegex PTR, BYVAL AS CONST gchar PTR, BYVAL AS gssize, BYVAL AS gint, BYVAL AS GRegexMatchFlags, BYVAL AS GMatchInfo PTR PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_regex_split_simple(BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS GRegexCompileFlags, BYVAL AS GRegexMatchFlags) AS gchar PTR PTR
DECLARE FUNCTION g_regex_split(BYVAL AS CONST GRegex PTR, BYVAL AS CONST gchar PTR, BYVAL AS GRegexMatchFlags) AS gchar PTR PTR
DECLARE FUNCTION g_regex_split_full(BYVAL AS CONST GRegex PTR, BYVAL AS CONST gchar PTR, BYVAL AS gssize, BYVAL AS gint, BYVAL AS GRegexMatchFlags, BYVAL AS gint, BYVAL AS GError PTR PTR) AS gchar PTR PTR
DECLARE FUNCTION g_regex_replace(BYVAL AS CONST GRegex PTR, BYVAL AS CONST gchar PTR, BYVAL AS gssize, BYVAL AS gint, BYVAL AS CONST gchar PTR, BYVAL AS GRegexMatchFlags, BYVAL AS GError PTR PTR) AS gchar PTR
DECLARE FUNCTION g_regex_replace_literal(BYVAL AS CONST GRegex PTR, BYVAL AS CONST gchar PTR, BYVAL AS gssize, BYVAL AS gint, BYVAL AS CONST gchar PTR, BYVAL AS GRegexMatchFlags, BYVAL AS GError PTR PTR) AS gchar PTR
DECLARE FUNCTION g_regex_replace_eval(BYVAL AS CONST GRegex PTR, BYVAL AS CONST gchar PTR, BYVAL AS gssize, BYVAL AS gint, BYVAL AS GRegexMatchFlags, BYVAL AS GRegexEvalCallback, BYVAL AS gpointer, BYVAL AS GError PTR PTR) AS gchar PTR
DECLARE FUNCTION g_regex_check_replacement(BYVAL AS CONST gchar PTR, BYVAL AS gboolean PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_match_info_get_regex(BYVAL AS CONST GMatchInfo PTR) AS GRegex PTR
DECLARE FUNCTION g_match_info_get_string(BYVAL AS CONST GMatchInfo PTR) AS CONST gchar PTR
DECLARE FUNCTION g_match_info_ref(BYVAL AS GMatchInfo PTR) AS GMatchInfo PTR
DECLARE SUB g_match_info_unref(BYVAL AS GMatchInfo PTR)
DECLARE SUB g_match_info_free(BYVAL AS GMatchInfo PTR)
DECLARE FUNCTION g_match_info_next(BYVAL AS GMatchInfo PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_match_info_matches(BYVAL AS CONST GMatchInfo PTR) AS gboolean
DECLARE FUNCTION g_match_info_get_match_count(BYVAL AS CONST GMatchInfo PTR) AS gint
DECLARE FUNCTION g_match_info_is_partial_match(BYVAL AS CONST GMatchInfo PTR) AS gboolean
DECLARE FUNCTION g_match_info_expand_references(BYVAL AS CONST GMatchInfo PTR, BYVAL AS CONST gchar PTR, BYVAL AS GError PTR PTR) AS gchar PTR
DECLARE FUNCTION g_match_info_fetch(BYVAL AS CONST GMatchInfo PTR, BYVAL AS gint) AS gchar PTR
DECLARE FUNCTION g_match_info_fetch_pos(BYVAL AS CONST GMatchInfo PTR, BYVAL AS gint, BYVAL AS gint PTR, BYVAL AS gint PTR) AS gboolean
DECLARE FUNCTION g_match_info_fetch_named(BYVAL AS CONST GMatchInfo PTR, BYVAL AS CONST gchar PTR) AS gchar PTR
DECLARE FUNCTION g_match_info_fetch_named_pos(BYVAL AS CONST GMatchInfo PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint PTR, BYVAL AS gint PTR) AS gboolean
DECLARE FUNCTION g_match_info_fetch_all(BYVAL AS CONST GMatchInfo PTR) AS gchar PTR PTR

#ENDIF ' __G_REGEX_H__

#IFNDEF __G_SCANNER_H__
#DEFINE __G_SCANNER_H__

TYPE GScanner AS _GScanner
TYPE GScannerConfig AS _GScannerConfig
TYPE GTokenValue AS _GTokenValue
TYPE GScannerMsgFunc AS SUB(BYVAL AS GScanner PTR, BYVAL AS gchar PTR, BYVAL AS gboolean)

#DEFINE G_CSET_A_2_Z_ !"ABCDEFGHIJKLMNOPQRSTUVWXYZ"
#DEFINE G_CSET_a_2_z !"abcdefghijklmnopqrstuvwxyz"
#DEFINE G_CSET_DIGITS !"0123456789"
#DEFINE G_CSET_LATINC !"\300\301\302\303\304\305\306"_
   !"\307\310\311\312\313\314\315\316\317\320"_
   !"\321\322\323\324\325\326"_
   !"\330\331\332\333\334\335\336"
#DEFINE G_CSET_LATINS !"\337\340\341\342\343\344\345\346"_
   !"\347\350\351\352\353\354\355\356\357\360"_
   !"\361\362\363\364\365\366"_
   !"\370\371\372\373\374\375\376\377"

ENUM GErrorType
  G_ERR_UNKNOWN
  G_ERR_UNEXP_EOF
  G_ERR_UNEXP_EOF_IN_STRING
  G_ERR_UNEXP_EOF_IN_COMMENT
  G_ERR_NON_DIGIT_IN_CONST
  G_ERR_DIGIT_RADIX
  G_ERR_FLOAT_RADIX
  G_ERR_FLOAT_MALFORMED
END ENUM

ENUM GTokenType
  G_TOKEN_EOF = 0
  G_TOKEN_LEFT_PAREN = ASC(!"(")
  G_TOKEN_RIGHT_PAREN = ASC(!")")
  G_TOKEN_LEFT_CURLY = ASC(!"{")
  G_TOKEN_RIGHT_CURLY = ASC(!"}")
  G_TOKEN_LEFT_BRACE = ASC(!"[")
  G_TOKEN_RIGHT_BRACE = ASC(!"]")
  G_TOKEN_EQUAL_SIGN = ASC(!"=")
  G_TOKEN_COMMA = ASC(!",")
  G_TOKEN_NONE = 256
  G_TOKEN_ERROR
  G_TOKEN_CHAR
  G_TOKEN_BINARY
  G_TOKEN_OCTAL
  G_TOKEN_INT
  G_TOKEN_HEX
  G_TOKEN_FLOAT
  G_TOKEN_STRING
  G_TOKEN_SYMBOL
  G_TOKEN_IDENTIFIER
  G_TOKEN_IDENTIFIER_NULL
  G_TOKEN_COMMENT_SINGLE
  G_TOKEN_COMMENT_MULTI
  G_TOKEN_LAST
END ENUM

UNION _GTokenValue
  AS gpointer v_symbol
  AS gchar PTR v_identifier
  AS gulong v_binary
  AS gulong v_octal
  AS gulong v_int
  AS guint64 v_int64
  AS gdouble v_float
  AS gulong v_hex
  AS gchar PTR v_string
  AS gchar PTR v_comment
  AS guchar v_char
  AS guint v_error
END UNION

TYPE _GScannerConfig
  AS gchar PTR cset_skip_characters
  AS gchar PTR cset_identifier_first
  AS gchar PTR cset_identifier_nth
  AS gchar PTR cpair_comment_single
  AS guint case_sensitive : 1
  AS guint skip_comment_multi : 1
  AS guint skip_comment_single : 1
  AS guint scan_comment_multi : 1
  AS guint scan_identifier : 1
  AS guint scan_identifier_1char : 1
  AS guint scan_identifier_NULL : 1
  AS guint scan_symbols : 1
  AS guint scan_binary : 1
  AS guint scan_octal : 1
  AS guint scan_float : 1
  AS guint scan_hex : 1
  AS guint scan_hex_dollar : 1
  AS guint scan_string_sq : 1
  AS guint scan_string_dq : 1
  AS guint numbers_2_int : 1
  AS guint int_2_float : 1
  AS guint identifier_2_string : 1
  AS guint char_2_token : 1
  AS guint symbol_2_token : 1
  AS guint scope_0_fallback : 1
  AS guint store_int64 : 1
  AS guint padding_dummy
END TYPE

TYPE _GScanner
  AS gpointer user_data
  AS guint max_parse_errors
  AS guint parse_errors
  AS CONST gchar PTR input_name
  AS GData PTR qdata
  AS GScannerConfig PTR config
  AS GTokenType token
  AS GTokenValue value
  AS guint line
  AS guint position
  AS GTokenType next_token
  AS GTokenValue next_value
  AS guint next_line
  AS guint next_position
  AS GHashTable PTR symbol_table
  AS gint input_fd
  AS CONST gchar PTR text
  AS CONST gchar PTR text_end
  AS gchar PTR buffer
  AS guint scope_id
  AS GScannerMsgFunc msg_handler
END TYPE

DECLARE FUNCTION g_scanner_new(BYVAL AS CONST GScannerConfig PTR) AS GScanner PTR
DECLARE SUB g_scanner_destroy(BYVAL AS GScanner PTR)
DECLARE SUB g_scanner_input_file(BYVAL AS GScanner PTR, BYVAL AS gint)
DECLARE SUB g_scanner_sync_file_offset(BYVAL AS GScanner PTR)
DECLARE SUB g_scanner_input_text(BYVAL AS GScanner PTR, BYVAL AS CONST gchar PTR, BYVAL AS guint)
DECLARE FUNCTION g_scanner_get_next_token(BYVAL AS GScanner PTR) AS GTokenType
DECLARE FUNCTION g_scanner_peek_next_token(BYVAL AS GScanner PTR) AS GTokenType
DECLARE FUNCTION g_scanner_cur_token(BYVAL AS GScanner PTR) AS GTokenType
DECLARE FUNCTION g_scanner_cur_value(BYVAL AS GScanner PTR) AS GTokenValue
DECLARE FUNCTION g_scanner_cur_line(BYVAL AS GScanner PTR) AS guint
DECLARE FUNCTION g_scanner_cur_position(BYVAL AS GScanner PTR) AS guint
DECLARE FUNCTION g_scanner_eof(BYVAL AS GScanner PTR) AS gboolean
DECLARE FUNCTION g_scanner_set_scope(BYVAL AS GScanner PTR, BYVAL AS guint) AS guint
DECLARE SUB g_scanner_scope_add_symbol(BYVAL AS GScanner PTR, BYVAL AS guint, BYVAL AS CONST gchar PTR, BYVAL AS gpointer)
DECLARE SUB g_scanner_scope_remove_symbol(BYVAL AS GScanner PTR, BYVAL AS guint, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION g_scanner_scope_lookup_symbol(BYVAL AS GScanner PTR, BYVAL AS guint, BYVAL AS CONST gchar PTR) AS gpointer
DECLARE SUB g_scanner_scope_foreach_symbol(BYVAL AS GScanner PTR, BYVAL AS guint, BYVAL AS GHFunc, BYVAL AS gpointer)
DECLARE FUNCTION g_scanner_lookup_symbol(BYVAL AS GScanner PTR, BYVAL AS CONST gchar PTR) AS gpointer
DECLARE SUB g_scanner_unexp_token(BYVAL AS GScanner PTR, BYVAL AS GTokenType, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint)
DECLARE SUB g_scanner_error(BYVAL AS GScanner PTR, BYVAL AS CONST gchar PTR, ...)
DECLARE SUB g_scanner_warn(BYVAL AS GScanner PTR, BYVAL AS CONST gchar PTR, ...)

#IFNDEF G_DISABLE_DEPRECATED

#DEFINE g_scanner_add_symbol( scanner, symbol, value ) g_scanner_scope_add_symbol ((scanner), 0, (symbol), (value))
#DEFINE g_scanner_remove_symbol( scanner, symbol ) g_scanner_scope_remove_symbol ((scanner), 0, (symbol))
#DEFINE g_scanner_foreach_symbol( scanner, func, data ) g_scanner_scope_foreach_symbol ((scanner), 0, (func), (data))
#DEFINE g_scanner_freeze_symbol_table(scanner) CAST(ANY, 0)
#DEFINE g_scanner_thaw_symbol_table(scanner) CAST(ANY, 0)

#ENDIF ' G_DISABLE_DEPRECATED
#ENDIF ' __G_SCANNER_H__

#IFNDEF __G_SEQUENCE_H__
#DEFINE __G_SEQUENCE_H__

TYPE GSequence AS _GSequence
TYPE GSequenceIter AS _GSequenceNode
TYPE GSequenceIterCompareFunc AS FUNCTION(BYVAL AS GSequenceIter PTR, BYVAL AS GSequenceIter PTR, BYVAL AS gpointer) AS gint

DECLARE FUNCTION g_sequence_new(BYVAL AS GDestroyNotify) AS GSequence PTR
DECLARE SUB g_sequence_free(BYVAL AS GSequence PTR)
DECLARE FUNCTION g_sequence_get_length(BYVAL AS GSequence PTR) AS gint
DECLARE SUB g_sequence_foreach(BYVAL AS GSequence PTR, BYVAL AS GFunc, BYVAL AS gpointer)
DECLARE SUB g_sequence_foreach_range(BYVAL AS GSequenceIter PTR, BYVAL AS GSequenceIter PTR, BYVAL AS GFunc, BYVAL AS gpointer)
DECLARE SUB g_sequence_sort(BYVAL AS GSequence PTR, BYVAL AS GCompareDataFunc, BYVAL AS gpointer)
DECLARE SUB g_sequence_sort_iter(BYVAL AS GSequence PTR, BYVAL AS GSequenceIterCompareFunc, BYVAL AS gpointer)
DECLARE FUNCTION g_sequence_get_begin_iter(BYVAL AS GSequence PTR) AS GSequenceIter PTR
DECLARE FUNCTION g_sequence_get_end_iter(BYVAL AS GSequence PTR) AS GSequenceIter PTR
DECLARE FUNCTION g_sequence_get_iter_at_pos(BYVAL AS GSequence PTR, BYVAL AS gint) AS GSequenceIter PTR
DECLARE FUNCTION g_sequence_append(BYVAL AS GSequence PTR, BYVAL AS gpointer) AS GSequenceIter PTR
DECLARE FUNCTION g_sequence_prepend(BYVAL AS GSequence PTR, BYVAL AS gpointer) AS GSequenceIter PTR
DECLARE FUNCTION g_sequence_insert_before(BYVAL AS GSequenceIter PTR, BYVAL AS gpointer) AS GSequenceIter PTR
DECLARE SUB g_sequence_move(BYVAL AS GSequenceIter PTR, BYVAL AS GSequenceIter PTR)
DECLARE SUB g_sequence_swap(BYVAL AS GSequenceIter PTR, BYVAL AS GSequenceIter PTR)
DECLARE FUNCTION g_sequence_insert_sorted(BYVAL AS GSequence PTR, BYVAL AS gpointer, BYVAL AS GCompareDataFunc, BYVAL AS gpointer) AS GSequenceIter PTR
DECLARE FUNCTION g_sequence_insert_sorted_iter(BYVAL AS GSequence PTR, BYVAL AS gpointer, BYVAL AS GSequenceIterCompareFunc, BYVAL AS gpointer) AS GSequenceIter PTR
DECLARE SUB g_sequence_sort_changed(BYVAL AS GSequenceIter PTR, BYVAL AS GCompareDataFunc, BYVAL AS gpointer)
DECLARE SUB g_sequence_sort_changed_iter(BYVAL AS GSequenceIter PTR, BYVAL AS GSequenceIterCompareFunc, BYVAL AS gpointer)
DECLARE SUB g_sequence_remove(BYVAL AS GSequenceIter PTR)
DECLARE SUB g_sequence_remove_range(BYVAL AS GSequenceIter PTR, BYVAL AS GSequenceIter PTR)
DECLARE SUB g_sequence_move_range(BYVAL AS GSequenceIter PTR, BYVAL AS GSequenceIter PTR, BYVAL AS GSequenceIter PTR)
DECLARE FUNCTION g_sequence_search(BYVAL AS GSequence PTR, BYVAL AS gpointer, BYVAL AS GCompareDataFunc, BYVAL AS gpointer) AS GSequenceIter PTR
DECLARE FUNCTION g_sequence_search_iter(BYVAL AS GSequence PTR, BYVAL AS gpointer, BYVAL AS GSequenceIterCompareFunc, BYVAL AS gpointer) AS GSequenceIter PTR
DECLARE FUNCTION g_sequence_lookup(BYVAL AS GSequence PTR, BYVAL AS gpointer, BYVAL AS GCompareDataFunc, BYVAL AS gpointer) AS GSequenceIter PTR
DECLARE FUNCTION g_sequence_lookup_iter(BYVAL AS GSequence PTR, BYVAL AS gpointer, BYVAL AS GSequenceIterCompareFunc, BYVAL AS gpointer) AS GSequenceIter PTR
DECLARE FUNCTION g_sequence_get(BYVAL AS GSequenceIter PTR) AS gpointer
DECLARE SUB g_sequence_set(BYVAL AS GSequenceIter PTR, BYVAL AS gpointer)
DECLARE FUNCTION g_sequence_iter_is_begin(BYVAL AS GSequenceIter PTR) AS gboolean
DECLARE FUNCTION g_sequence_iter_is_end(BYVAL AS GSequenceIter PTR) AS gboolean
DECLARE FUNCTION g_sequence_iter_next(BYVAL AS GSequenceIter PTR) AS GSequenceIter PTR
DECLARE FUNCTION g_sequence_iter_prev(BYVAL AS GSequenceIter PTR) AS GSequenceIter PTR
DECLARE FUNCTION g_sequence_iter_get_position(BYVAL AS GSequenceIter PTR) AS gint
DECLARE FUNCTION g_sequence_iter_move(BYVAL AS GSequenceIter PTR, BYVAL AS gint) AS GSequenceIter PTR
DECLARE FUNCTION g_sequence_iter_get_sequence(BYVAL AS GSequenceIter PTR) AS GSequence PTR
DECLARE FUNCTION g_sequence_iter_compare(BYVAL AS GSequenceIter PTR, BYVAL AS GSequenceIter PTR) AS gint
DECLARE FUNCTION g_sequence_range_get_midpoint(BYVAL AS GSequenceIter PTR, BYVAL AS GSequenceIter PTR) AS GSequenceIter PTR

#ENDIF ' __G_SEQUENCE_H__

#IFNDEF __G_SHELL_H__
#DEFINE __G_SHELL_H__

#DEFINE G_SHELL_ERROR g_shell_error_quark ()

ENUM GShellError
  G_SHELL_ERROR_BAD_QUOTING
  G_SHELL_ERROR_EMPTY_STRING
  G_SHELL_ERROR_FAILED
END ENUM

DECLARE FUNCTION g_shell_error_quark() AS GQuark
DECLARE FUNCTION g_shell_quote(BYVAL AS CONST gchar PTR) AS gchar PTR
DECLARE FUNCTION g_shell_unquote(BYVAL AS CONST gchar PTR, BYVAL AS GError PTR PTR) AS gchar PTR
DECLARE FUNCTION g_shell_parse_argv(BYVAL AS CONST gchar PTR, BYVAL AS gint PTR, BYVAL AS gchar PTR PTR PTR, BYVAL AS GError PTR PTR) AS gboolean

#ENDIF ' __G_SHELL_H__

#IFNDEF __G_SLICE_H__
#DEFINE __G_SLICE_H__

DECLARE FUNCTION g_slice_alloc(BYVAL AS gsize) AS gpointer
DECLARE FUNCTION g_slice_alloc0(BYVAL AS gsize) AS gpointer
DECLARE FUNCTION g_slice_copy(BYVAL AS gsize, BYVAL AS gconstpointer) AS gpointer
DECLARE SUB g_slice_free1(BYVAL AS gsize, BYVAL AS gpointer)
DECLARE SUB g_slice_free_chain_with_offset(BYVAL AS gsize, BYVAL AS gpointer, BYVAL AS gsize)

#DEFINE g_slice_new(type) (CAST(type PTR, g_slice_alloc (SIZEOF (type))))
#DEFINE g_slice_new0(type) (CAST(type PTR, g_slice_alloc0 (SIZEOF (type))))
#DEFINE g_slice_dup(type, mem) _
  IIF(1 , CAST(type PTR, g_slice_copy (SIZEOF (type), (mem))) _
     , (CAST(ANY, (CAST(type PTR, 0) = (mem))), CAST(type PTR, 0)))

#DEFINE g_slice_free(type, mem) g_slice_free1 (SIZEOF (type), (mem))
#DEFINE g_slice_free_chain(type, mem_chain, next) g_slice_free_chain_with_offset (SIZEOF (type), (mem_chain), G_STRUCT_OFFSET (type, next))

ENUM GSliceConfig
  G_SLICE_CONFIG_ALWAYS_MALLOC = 1
  G_SLICE_CONFIG_BYPASS_MAGAZINES
  G_SLICE_CONFIG_WORKING_SET_MSECS
  G_SLICE_CONFIG_COLOR_INCREMENT
  G_SLICE_CONFIG_CHUNK_SIZES
  G_SLICE_CONFIG_CONTENTION_COUNTER
END ENUM

DECLARE SUB g_slice_set_config(BYVAL AS GSliceConfig, BYVAL AS gint64)
DECLARE FUNCTION g_slice_get_config(BYVAL AS GSliceConfig) AS gint64
DECLARE FUNCTION g_slice_get_config_state(BYVAL AS GSliceConfig, BYVAL AS gint64, BYVAL AS guint PTR) AS gint64 PTR

#ENDIF ' __G_SLICE_H__

#IFNDEF __G_SPAWN_H__
#DEFINE __G_SPAWN_H__

#DEFINE G_SPAWN_ERROR g_spawn_error_quark ()

ENUM GSpawnError
  G_SPAWN_ERROR_FORK
  G_SPAWN_ERROR_READ
  G_SPAWN_ERROR_CHDIR
  G_SPAWN_ERROR_ACCES
  G_SPAWN_ERROR_PERM
  G_SPAWN_ERROR_2BIG
  G_SPAWN_ERROR_NOEXEC
  G_SPAWN_ERROR_NAMETOOLONG
  G_SPAWN_ERROR_NOENT
  G_SPAWN_ERROR_NOMEM
  G_SPAWN_ERROR_NOTDIR
  G_SPAWN_ERROR_LOOP
  G_SPAWN_ERROR_TXTBUSY
  G_SPAWN_ERROR_IO
  G_SPAWN_ERROR_NFILE
  G_SPAWN_ERROR_MFILE
  G_SPAWN_ERROR_INVAL
  G_SPAWN_ERROR_ISDIR
  G_SPAWN_ERROR_LIBBAD
  G_SPAWN_ERROR_FAILED
END ENUM

TYPE GSpawnChildSetupFunc AS SUB(BYVAL AS gpointer)

ENUM GSpawnFlags
  G_SPAWN_LEAVE_DESCRIPTORS_OPEN = 1 SHL 0
  G_SPAWN_DO_NOT_REAP_CHILD = 1 SHL 1
  G_SPAWN_SEARCH_PATH = 1 SHL 2
  G_SPAWN_STDOUT_TO_DEV_NULL = 1 SHL 3
  G_SPAWN_STDERR_TO_DEV_NULL = 1 SHL 4
  G_SPAWN_CHILD_INHERITS_STDIN = 1 SHL 5
  G_SPAWN_FILE_AND_ARGV_ZERO = 1 SHL 6
END ENUM

DECLARE FUNCTION g_spawn_error_quark() AS GQuark

#IFNDEF __GTK_DOC_IGNORE__
#IFDEF G_OS_WIN32
#DEFINE g_spawn_async g_spawn_async_utf8
#DEFINE g_spawn_async_with_pipes g_spawn_async_with_pipes_utf8
#DEFINE g_spawn_sync g_spawn_sync_utf8
#DEFINE g_spawn_command_line_sync g_spawn_command_line_sync_utf8
#DEFINE g_spawn_command_line_async g_spawn_command_line_async_utf8
#ENDIF ' G_OS_WIN32
#ENDIF ' __GTK_DOC_IGNORE__

DECLARE FUNCTION g_spawn_async(BYVAL AS CONST gchar PTR, BYVAL AS gchar PTR PTR, BYVAL AS gchar PTR PTR, BYVAL AS GSpawnFlags, BYVAL AS GSpawnChildSetupFunc, BYVAL AS gpointer, BYVAL AS GPid PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_spawn_async_with_pipes(BYVAL AS CONST gchar PTR, BYVAL AS gchar PTR PTR, BYVAL AS gchar PTR PTR, BYVAL AS GSpawnFlags, BYVAL AS GSpawnChildSetupFunc, BYVAL AS gpointer, BYVAL AS GPid PTR, BYVAL AS gint PTR, BYVAL AS gint PTR, BYVAL AS gint PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_spawn_sync(BYVAL AS CONST gchar PTR, BYVAL AS gchar PTR PTR, BYVAL AS gchar PTR PTR, BYVAL AS GSpawnFlags, BYVAL AS GSpawnChildSetupFunc, BYVAL AS gpointer, BYVAL AS gchar PTR PTR, BYVAL AS gchar PTR PTR, BYVAL AS gint PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_spawn_command_line_sync(BYVAL AS CONST gchar PTR, BYVAL AS gchar PTR PTR, BYVAL AS gchar PTR PTR, BYVAL AS gint PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_spawn_command_line_async(BYVAL AS CONST gchar PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE SUB g_spawn_close_pid(BYVAL AS GPid)

#ENDIF ' __G_SPAWN_H__

#IFNDEF __G_STRFUNCS_H__
#DEFINE __G_STRFUNCS_H__

ENUM GAsciiType
  G_ASCII_ALNUM = 1 SHL 0
  G_ASCII_ALPHA = 1 SHL 1
  G_ASCII_CNTRL = 1 SHL 2
  G_ASCII_DIGIT = 1 SHL 3
  G_ASCII_GRAPH = 1 SHL 4
  G_ASCII_LOWER = 1 SHL 5
  G_ASCII_PRINT = 1 SHL 6
  G_ASCII_PUNCT = 1 SHL 7
  G_ASCII_SPACE = 1 SHL 8
  G_ASCII_UPPER = 1 SHL 9
  G_ASCII_XDIGIT = 1 SHL 10
END ENUM

EXTERN AS CONST guint16 CONST PTR g_ascii_table

#DEFINE g_ascii_isalnum(c) _
  ((g_ascii_table[CAST(guchar, (c))] AND G_ASCII_ALNUM) <> 0)
#DEFINE g_ascii_isalpha(c) _
  ((g_ascii_table[CAST(guchar, (c))] AND G_ASCII_ALPHA) <> 0)
#DEFINE g_ascii_iscntrl(c) _
  ((g_ascii_table[CAST(guchar, (c))] AND G_ASCII_CNTRL) <> 0)
#DEFINE g_ascii_isdigit(c) _
  ((g_ascii_table[CAST(guchar, (c))] AND G_ASCII_DIGIT) <> 0)
#DEFINE g_ascii_isgraph(c) _
  ((g_ascii_table[CAST(guchar, (c))] AND G_ASCII_GRAPH) <> 0)
#DEFINE g_ascii_islower(c) _
  ((g_ascii_table[CAST(guchar, (c))] AND G_ASCII_LOWER) <> 0)
#DEFINE g_ascii_isprint(c) _
  ((g_ascii_table[CAST(guchar, (c))] AND G_ASCII_PRINT) <> 0)
#DEFINE g_ascii_ispunct(c) _
  ((g_ascii_table[CAST(guchar, (c))] AND G_ASCII_PUNCT) <> 0)
#DEFINE g_ascii_isspace(c) _
  ((g_ascii_table[CAST(guchar, (c))] AND G_ASCII_SPACE) <> 0)
#DEFINE g_ascii_isupper(c) _
  ((g_ascii_table[CAST(guchar, (c))] AND G_ASCII_UPPER) <> 0)
#DEFINE g_ascii_isxdigit(c) _
  ((g_ascii_table[CAST(guchar, (c))] AND G_ASCII_XDIGIT) <> 0)

DECLARE FUNCTION g_ascii_tolower(BYVAL AS UBYTE) AS UBYTE
DECLARE FUNCTION g_ascii_toupper(BYVAL AS UBYTE) AS UBYTE
DECLARE FUNCTION g_ascii_digit_value(BYVAL AS UBYTE) AS gint
DECLARE FUNCTION g_ascii_xdigit_value(BYVAL AS UBYTE) AS gint

#DEFINE G_STR_DELIMITERS !"_-|> <."

DECLARE FUNCTION g_strdelimit(BYVAL AS gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS UBYTE) AS gchar PTR
DECLARE FUNCTION g_strcanon(BYVAL AS gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS UBYTE) AS gchar PTR
DECLARE FUNCTION g_strerror(BYVAL AS gint) AS CONST gchar PTR
DECLARE FUNCTION g_strsignal(BYVAL AS gint) AS CONST gchar PTR
DECLARE FUNCTION g_strreverse(BYVAL AS gchar PTR) AS gchar PTR
DECLARE FUNCTION g_strlcpy(BYVAL AS gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS gsize) AS gsize
DECLARE FUNCTION g_strlcat(BYVAL AS gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS gsize) AS gsize
DECLARE FUNCTION g_strstr_len(BYVAL AS CONST gchar PTR, BYVAL AS gssize, BYVAL AS CONST gchar PTR) AS gchar PTR
DECLARE FUNCTION g_strrstr(BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR) AS gchar PTR
DECLARE FUNCTION g_strrstr_len(BYVAL AS CONST gchar PTR, BYVAL AS gssize, BYVAL AS CONST gchar PTR) AS gchar PTR
DECLARE FUNCTION g_str_has_suffix(BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR) AS gboolean
DECLARE FUNCTION g_str_has_prefix(BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR) AS gboolean
DECLARE FUNCTION g_strtod(BYVAL AS CONST gchar PTR, BYVAL AS gchar PTR PTR) AS gdouble
DECLARE FUNCTION g_ascii_strtod(BYVAL AS CONST gchar PTR, BYVAL AS gchar PTR PTR) AS gdouble
DECLARE FUNCTION g_ascii_strtoull(BYVAL AS CONST gchar PTR, BYVAL AS gchar PTR PTR, BYVAL AS guint) AS guint64
DECLARE FUNCTION g_ascii_strtoll(BYVAL AS CONST gchar PTR, BYVAL AS gchar PTR PTR, BYVAL AS guint) AS gint64

#DEFINE G_ASCII_DTOSTR_BUF_SIZE (29 + 10)

DECLARE FUNCTION g_ascii_dtostr(BYVAL AS gchar PTR, BYVAL AS gint, BYVAL AS gdouble) AS gchar PTR
DECLARE FUNCTION g_ascii_formatd(BYVAL AS gchar PTR, BYVAL AS gint, BYVAL AS CONST gchar PTR, BYVAL AS gdouble) AS gchar PTR
DECLARE FUNCTION g_strchug(BYVAL AS gchar PTR) AS gchar PTR
DECLARE FUNCTION g_strchomp(BYVAL AS gchar PTR) AS gchar PTR

#DEFINE g_strstrip( string ) g_strchomp (g_strchug (string))

DECLARE FUNCTION g_ascii_strcasecmp(BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR) AS gint
DECLARE FUNCTION g_ascii_strncasecmp(BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS gsize) AS gint
DECLARE FUNCTION g_ascii_strdown(BYVAL AS CONST gchar PTR, BYVAL AS gssize) AS gchar PTR
DECLARE FUNCTION g_ascii_strup(BYVAL AS CONST gchar PTR, BYVAL AS gssize) AS gchar PTR
DECLARE FUNCTION g_strcasecmp(BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR) AS gint
DECLARE FUNCTION g_strncasecmp(BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS guint) AS gint
DECLARE FUNCTION g_strdown(BYVAL AS gchar PTR) AS gchar PTR
DECLARE FUNCTION g_strup(BYVAL AS gchar PTR) AS gchar PTR
DECLARE FUNCTION g_strdup(BYVAL AS CONST gchar PTR) AS gchar PTR
DECLARE FUNCTION g_strdup_printf(BYVAL AS CONST gchar PTR, ...) AS gchar PTR
DECLARE FUNCTION g_strdup_vprintf(BYVAL AS CONST gchar PTR, BYVAL AS va_list) AS gchar PTR
DECLARE FUNCTION g_strndup(BYVAL AS CONST gchar PTR, BYVAL AS gsize) AS gchar PTR
DECLARE FUNCTION g_strnfill(BYVAL AS gsize, BYVAL AS UBYTE) AS gchar PTR
DECLARE FUNCTION g_strconcat(BYVAL AS CONST gchar PTR, ...) AS gchar PTR
DECLARE FUNCTION g_strjoin(BYVAL AS CONST gchar PTR, ...) AS gchar PTR
DECLARE FUNCTION g_strcompress(BYVAL AS CONST gchar PTR) AS gchar PTR
DECLARE FUNCTION g_strescape(BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR) AS gchar PTR
DECLARE FUNCTION g_memdup(BYVAL AS gconstpointer, BYVAL AS guint) AS gpointer
DECLARE FUNCTION g_strsplit(BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint) AS gchar PTR PTR
DECLARE FUNCTION g_strsplit_set(BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint) AS gchar PTR PTR
DECLARE FUNCTION g_strjoinv(BYVAL AS CONST gchar PTR, BYVAL AS gchar PTR PTR) AS gchar PTR
DECLARE SUB g_strfreev(BYVAL AS gchar PTR PTR)
DECLARE FUNCTION g_strdupv(BYVAL AS gchar PTR PTR) AS gchar PTR PTR
DECLARE FUNCTION g_strv_length(BYVAL AS gchar PTR PTR) AS guint
DECLARE FUNCTION g_stpcpy(BYVAL AS gchar PTR, BYVAL AS CONST ZSTRING PTR) AS gchar PTR

#ENDIF ' __G_STRFUNCS_H__

#IFNDEF __G_STRINGCHUNK_H__
#DEFINE __G_STRINGCHUNK_H__

TYPE GStringChunk AS _GStringChunk

DECLARE FUNCTION g_string_chunk_new(BYVAL AS gsize) AS GStringChunk PTR
DECLARE SUB g_string_chunk_free(BYVAL AS GStringChunk PTR)
DECLARE SUB g_string_chunk_clear(BYVAL AS GStringChunk PTR)
DECLARE FUNCTION g_string_chunk_insert(BYVAL AS GStringChunk PTR, BYVAL AS CONST gchar PTR) AS gchar PTR
DECLARE FUNCTION g_string_chunk_insert_len(BYVAL AS GStringChunk PTR, BYVAL AS CONST gchar PTR, BYVAL AS gssize) AS gchar PTR
DECLARE FUNCTION g_string_chunk_insert_const(BYVAL AS GStringChunk PTR, BYVAL AS CONST gchar PTR) AS gchar PTR

#ENDIF ' __G_STRINGCHUNK_H__

#IFNDEF __G_TEST_UTILS_H__
#DEFINE __G_TEST_UTILS_H__

TYPE GTestCase AS GTestCase_
TYPE GTestSuite AS GTestSuite_
TYPE GTestFunc AS SUB()
TYPE GTestDataFunc AS SUB(BYVAL AS gconstpointer)
TYPE GTestFixtureFunc AS SUB(BYVAL AS gpointer, BYVAL AS gconstpointer)

#DEFINE g_assert_cmpstr(s1, cmp, s2) _
           IF 0 = (s1 cmp s2) THEN _
                  g_assertion_message_cmpstr(G_LOG_DOMAIN, __FILE__, __LINE__, G_STRFUNC, _
                                             #s1 " " #cmp " " #s2, s1, #cmp, s2)
#DEFINE g_assert_cmpint(n1, cmp, n2) _
           IF 0 = (CLNGINT(n1) cmp CLNGINT(n2)) THEN _
                  g_assertion_message (G_LOG_DOMAIN, __FILE__, __LINE__, G_STRFUNC, _
                    g_strdup_printf ("assertion failed (%s): (%" G_GINT64_FORMAT " %s %" G_GINT64_FORMAT ")", _
                                     #n1 " " #cmp " " #n2, CLNGINT(n1), #cmp, CLNGINT(n2)))
#DEFINE g_assert_cmpuint(n1, cmp, n2) _
           IF 0 = (CULNGINT(n1) cmp CULNGINT(n2)) THEN _
                  g_assertion_message (G_LOG_DOMAIN, __FILE__, __LINE__, G_STRFUNC, _
                    g_strdup_printf ("assertion failed (%s): (%" G_GUINT64_FORMAT " %s %" G_GUINT64_FORMAT ")", _
                                     #n1 " " #cmp " " #n2, CULNGINT(n1), #cmp, CULNGINT(n2)))
#DEFINE g_assert_cmphex(n1, cmp, n2) _
          IF 0 = (n1 cmp n2) THEN _
                  g_assertion_message (G_LOG_DOMAIN, __FILE__, __LINE__, G_STRFUNC, _
                    g_strdup_printf ("assertion failed (%s): (0x%08" G_GINT64_MODIFIER "x %s 0x%08" G_GINT64_MODIFIER "x)", _
                                     #n1 " " #cmp " " #n2, CAST(guint64, n1), #cmp, CAST(guint64, n2)))
#DEFINE g_assert_cmpfloat(n1,cmp,n2) _
          IF 0 = (n1 cmp n2) THEN _
                  g_assertion_message (G_LOG_DOMAIN, __FILE__, __LINE__, G_STRFUNC, _
                    g_strdup_printf ("assertion failed (%s): (%.9g %s %.9g)", _
                                     #n1 " " #cmp " " #n2, CDBL(n1), #cmp, CDBL(n2)))
#DEFINE g_assert_no_error(err) IF (err) THEN _
          g_assertion_message_error (G_LOG_DOMAIN, __FILE__, __LINE__, G_STRFUNC, #err, err, 0, 0)
#DEFINE g_assert_error(err, dom, c) IF (0 = err ORELSE (err)->domain <> dom ORELSE (err)->code <> c) THEN _
          g_assertion_message_error (G_LOG_DOMAIN, __FILE__, __LINE__, G_STRFUNC, #err, err, dom, c)

#IFDEF G_DISABLE_ASSERT

#DEFINE g_assert_not_reached()
#DEFINE g_assert(expr)

#ELSE ' G_DISABLE_ASSERT

#DEFINE g_assert_not_reached() g_assertion_message (G_LOG_DOMAIN, __FILE__, __LINE__, G_STRFUNC, NULL)
#DEFINE g_assert(expr) IF NOT (expr) THEN g_assertion_message_expr (G_LOG_DOMAIN, __FILE__, __LINE__, G_STRFUNC, #expr)

#ENDIF ' G_DISABLE_ASSERT

DECLARE FUNCTION g_strcmp0(BYVAL AS CONST ZSTRING PTR, BYVAL AS CONST ZSTRING PTR) AS INTEGER
DECLARE SUB g_test_minimized_result(BYVAL AS DOUBLE, BYVAL AS CONST ZSTRING PTR, ...)
DECLARE SUB g_test_maximized_result(BYVAL AS DOUBLE, BYVAL AS CONST ZSTRING PTR, ...)
DECLARE SUB g_test_init(BYVAL AS INTEGER PTR, BYVAL AS ZSTRING PTR PTR PTR, ...)

#DEFINE g_test_quick() (g_test_config_vars->test_quick)
#DEFINE g_test_slow() ( 0 = g_test_config_vars->test_quick)
#DEFINE g_test_thorough() ( 0 = g_test_config_vars->test_quick)
#DEFINE g_test_perf() (g_test_config_vars->test_perf)
#DEFINE g_test_verbose() (g_test_config_vars->test_verbose)
#DEFINE g_test_quiet() (g_test_config_vars->test_quiet)

DECLARE FUNCTION g_test_run() AS INTEGER
DECLARE SUB g_test_add_func(BYVAL AS CONST ZSTRING PTR, BYVAL AS GTestFunc)
DECLARE SUB g_test_add_data_func(BYVAL AS CONST ZSTRING PTR, BYVAL AS gconstpointer, BYVAL AS GTestDataFunc)
DECLARE SUB g_test_fail()

#MACRO g_test_add(testpath, Fixture, tdata, fsetup, ftest, fteardown)
 DIM add_vtable AS SUB CDECL(BYVAL AS CONST ZSTRING PTR, _
                             BYVAL AS gsize, _
                             BYVAL AS gconstpointer, _
                             BYVAL AS SUB CDECL(BYVAL AS Fixture PTR, BYVAL AS gconstpointer), _
                             BYVAL AS SUB CDECL(BYVAL AS Fixture PTR, BYVAL AS gconstpointer), _
                             BYVAL AS SUB CDECL(BYVAL AS Fixture PTR, BYVAL AS gconstpointer)) _
     = CAST(SUB CDECL(BYVAL AS CONST ZSTRING PTR, _
                      BYVAL AS gsize, _
                      BYVAL AS gconstpointer, _
                      BYVAL AS SUB CDECL(BYVAL AS Fixture PTR, BYVAL AS gconstpointer), _
                      BYVAL AS SUB CDECL(BYVAL AS Fixture PTR, BYVAL AS gconstpointer), _
                      BYVAL AS SUB CDECL(BYVAL AS Fixture PTR, BYVAL AS gconstpointer)), _
            g_test_add_vtable) ' Thanks, dkl!
 add_vtable (testpath, SIZEOF (Fixture), tdata, fsetup, ftest, fteardown)
#ENDMACRO

DECLARE SUB g_test_message(BYVAL AS CONST ZSTRING PTR, ...)
DECLARE SUB g_test_bug_base(BYVAL AS CONST ZSTRING PTR)
DECLARE SUB g_test_bug(BYVAL AS CONST ZSTRING PTR)
DECLARE SUB g_test_timer_start()
DECLARE FUNCTION g_test_timer_elapsed() AS DOUBLE
DECLARE FUNCTION g_test_timer_last() AS DOUBLE
DECLARE SUB g_test_queue_free(BYVAL AS gpointer)
DECLARE SUB g_test_queue_destroy(BYVAL AS GDestroyNotify, BYVAL AS gpointer)

#DEFINE g_test_queue_unref(gobject) g_test_queue_destroy (g_object_unref, gobject)

ENUM GTestTrapFlags
  G_TEST_TRAP_SILENCE_STDOUT = 1 SHL 7
  G_TEST_TRAP_SILENCE_STDERR = 1 SHL 8
  G_TEST_TRAP_INHERIT_STDIN = 1 SHL 9
END ENUM

DECLARE FUNCTION g_test_trap_fork(BYVAL AS guint64, BYVAL AS GTestTrapFlags) AS gboolean
DECLARE FUNCTION g_test_trap_has_passed() AS gboolean
DECLARE FUNCTION g_test_trap_reached_timeout() AS gboolean

#DEFINE g_test_trap_assert_passed() g_test_trap_assertions (G_LOG_DOMAIN, __FILE__, __LINE__, G_STRFUNC, 0, 0)
#DEFINE g_test_trap_assert_failed() g_test_trap_assertions (G_LOG_DOMAIN, __FILE__, __LINE__, G_STRFUNC, 1, 0)
#DEFINE g_test_trap_assert_stdout(soutpattern) g_test_trap_assertions (G_LOG_DOMAIN, __FILE__, __LINE__, G_STRFUNC, 2, soutpattern)
#DEFINE g_test_trap_assert_stdout_unmatched(soutpattern) g_test_trap_assertions (G_LOG_DOMAIN, __FILE__, __LINE__, G_STRFUNC, 3, soutpattern)
#DEFINE g_test_trap_assert_stderr(serrpattern) g_test_trap_assertions (G_LOG_DOMAIN, __FILE__, __LINE__, G_STRFUNC, 4, serrpattern)
#DEFINE g_test_trap_assert_stderr_unmatched(serrpattern) g_test_trap_assertions (G_LOG_DOMAIN, __FILE__, __LINE__, G_STRFUNC, 5, serrpattern)
#DEFINE g_test_rand_bit() (0 <> (g_test_rand_int() AND (1 SHL 15)))

DECLARE FUNCTION g_test_rand_int() AS gint32
DECLARE FUNCTION g_test_rand_int_range(BYVAL AS gint32, BYVAL AS gint32) AS gint32
DECLARE FUNCTION g_test_rand_double() AS DOUBLE
DECLARE FUNCTION g_test_rand_double_range(BYVAL AS DOUBLE, BYVAL AS DOUBLE) AS DOUBLE
DECLARE FUNCTION g_test_create_case(BYVAL AS CONST ZSTRING PTR, BYVAL AS gsize, BYVAL AS gconstpointer, BYVAL AS GTestFixtureFunc, BYVAL AS GTestFixtureFunc, BYVAL AS GTestFixtureFunc) AS GTestCase PTR
DECLARE FUNCTION g_test_create_suite(BYVAL AS CONST ZSTRING PTR) AS GTestSuite PTR
DECLARE FUNCTION g_test_get_root() AS GTestSuite PTR
DECLARE SUB g_test_suite_add(BYVAL AS GTestSuite PTR, BYVAL AS GTestCase PTR)
DECLARE SUB g_test_suite_add_suite(BYVAL AS GTestSuite PTR, BYVAL AS GTestSuite PTR)
DECLARE FUNCTION g_test_run_suite(BYVAL AS GTestSuite PTR) AS INTEGER
DECLARE SUB g_test_trap_assertions(BYVAL AS CONST ZSTRING PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS INTEGER, BYVAL AS CONST ZSTRING PTR, BYVAL AS guint64, BYVAL AS CONST ZSTRING PTR)
DECLARE SUB g_assertion_message(BYVAL AS CONST ZSTRING PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS INTEGER, BYVAL AS CONST ZSTRING PTR, BYVAL AS CONST ZSTRING PTR)
DECLARE SUB g_assertion_message_expr(BYVAL AS CONST ZSTRING PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS INTEGER, BYVAL AS CONST ZSTRING PTR, BYVAL AS CONST ZSTRING PTR)
DECLARE SUB g_assertion_message_cmpstr(BYVAL AS CONST ZSTRING PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS INTEGER, BYVAL AS CONST ZSTRING PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS CONST ZSTRING PTR)
DECLARE SUB g_assertion_message_cmpnum(BYVAL AS CONST ZSTRING PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS INTEGER, BYVAL AS CONST ZSTRING PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS DOUBLE, BYVAL AS CONST ZSTRING PTR, BYVAL AS DOUBLE, BYVAL AS UBYTE)
DECLARE SUB g_assertion_message_error(BYVAL AS CONST ZSTRING PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS INTEGER, BYVAL AS CONST ZSTRING PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS CONST GError PTR, BYVAL AS GQuark, BYVAL AS INTEGER)
DECLARE SUB g_test_add_vtable(BYVAL AS CONST ZSTRING PTR, BYVAL AS gsize, BYVAL AS gconstpointer, BYVAL AS GTestFixtureFunc, BYVAL AS GTestFixtureFunc, BYVAL AS GTestFixtureFunc)

TYPE GTestConfig
  AS gboolean test_initialized
  AS gboolean test_quick
  AS gboolean test_perf
  AS gboolean test_verbose
  AS gboolean test_quiet
END TYPE

EXTERN AS CONST GTestConfig CONST PTR g_test_config_vars

ENUM GTestLogType
  G_TEST_LOG_NONE
  G_TEST_LOG_ERROR
  G_TEST_LOG_START_BINARY
  G_TEST_LOG_LIST_CASE
  G_TEST_LOG_SKIP_CASE
  G_TEST_LOG_START_CASE
  G_TEST_LOG_STOP_CASE
  G_TEST_LOG_MIN_RESULT
  G_TEST_LOG_MAX_RESULT
  G_TEST_LOG_MESSAGE
END ENUM

TYPE GTestLogMsg
  AS GTestLogType log_type
  AS guint n_strings
  AS gchar PTR PTR strings
  AS guint n_nums
  AS DOUBLE PTR nums
END TYPE

TYPE GTestLogBuffer
  AS GString PTR data
  AS GSList PTR msgs
END TYPE

DECLARE FUNCTION g_test_log_type_name(BYVAL AS GTestLogType) AS CONST ZSTRING PTR
DECLARE FUNCTION g_test_log_buffer_new() AS GTestLogBuffer PTR
DECLARE SUB g_test_log_buffer_free(BYVAL AS GTestLogBuffer PTR)
DECLARE SUB g_test_log_buffer_push(BYVAL AS GTestLogBuffer PTR, BYVAL AS guint, BYVAL AS CONST guint8 PTR)
DECLARE FUNCTION g_test_log_buffer_pop(BYVAL AS GTestLogBuffer PTR) AS GTestLogMsg PTR
DECLARE SUB g_test_log_msg_free(BYVAL AS GTestLogMsg PTR)

TYPE GTestLogFatalFunc AS FUNCTION(BYVAL AS CONST gchar PTR, BYVAL AS GLogLevelFlags, BYVAL AS CONST gchar PTR, BYVAL AS gpointer) AS gboolean

DECLARE SUB g_test_log_set_fatal_handler(BYVAL AS GTestLogFatalFunc, BYVAL AS gpointer)

#ENDIF ' __G_TEST_UTILS_H__

#IFNDEF __G_THREADPOOL_H__
#DEFINE __G_THREADPOOL_H__

TYPE GThreadPool AS _GThreadPool

TYPE _GThreadPool
  AS GFunc func
  AS gpointer user_data
  AS gboolean exclusive
END TYPE

DECLARE FUNCTION g_thread_pool_new(BYVAL AS GFunc, BYVAL AS gpointer, BYVAL AS gint, BYVAL AS gboolean, BYVAL AS GError PTR PTR) AS GThreadPool PTR
DECLARE SUB g_thread_pool_free(BYVAL AS GThreadPool PTR, BYVAL AS gboolean, BYVAL AS gboolean)
DECLARE FUNCTION g_thread_pool_push(BYVAL AS GThreadPool PTR, BYVAL AS gpointer, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_thread_pool_unprocessed(BYVAL AS GThreadPool PTR) AS guint
DECLARE SUB g_thread_pool_set_sort_function(BYVAL AS GThreadPool PTR, BYVAL AS GCompareDataFunc, BYVAL AS gpointer)
DECLARE FUNCTION g_thread_pool_set_max_threads(BYVAL AS GThreadPool PTR, BYVAL AS gint, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_thread_pool_get_max_threads(BYVAL AS GThreadPool PTR) AS gint
DECLARE FUNCTION g_thread_pool_get_num_threads(BYVAL AS GThreadPool PTR) AS guint
DECLARE SUB g_thread_pool_set_max_unused_threads(BYVAL AS gint)
DECLARE FUNCTION g_thread_pool_get_max_unused_threads() AS gint
DECLARE FUNCTION g_thread_pool_get_num_unused_threads() AS guint
DECLARE SUB g_thread_pool_stop_unused_threads()
DECLARE SUB g_thread_pool_set_max_idle_time(BYVAL AS guint)
DECLARE FUNCTION g_thread_pool_get_max_idle_time() AS guint

#ENDIF ' __G_THREADPOOL_H__

#IFNDEF __G_TIMER_H__
#DEFINE __G_TIMER_H__

TYPE GTimer AS _GTimer

#DEFINE G_USEC_PER_SEC 1000000

DECLARE FUNCTION g_timer_new() AS GTimer PTR
DECLARE SUB g_timer_destroy(BYVAL AS GTimer PTR)
DECLARE SUB g_timer_start(BYVAL AS GTimer PTR)
DECLARE SUB g_timer_stop(BYVAL AS GTimer PTR)
DECLARE SUB g_timer_reset(BYVAL AS GTimer PTR)
DECLARE SUB g_timer_continue(BYVAL AS GTimer PTR)
DECLARE FUNCTION g_timer_elapsed(BYVAL AS GTimer PTR, BYVAL AS gulong PTR) AS gdouble
DECLARE SUB g_usleep(BYVAL AS gulong)
DECLARE SUB g_time_val_add(BYVAL AS GTimeVal PTR, BYVAL AS glong)
DECLARE FUNCTION g_time_val_from_iso8601(BYVAL AS CONST gchar PTR, BYVAL AS GTimeVal PTR) AS gboolean
DECLARE FUNCTION g_time_val_to_iso8601(BYVAL AS GTimeVal PTR) AS gchar PTR

#ENDIF ' __G_TIMER_H__

#IFNDEF __G_TRASH_STACK_H__
#DEFINE __G_TRASH_STACK_H__

TYPE GTrashStack AS _GTrashStack

TYPE _GTrashStack
  AS GTrashStack PTR next
END TYPE

DECLARE SUB g_trash_stack_push(BYVAL AS GTrashStack PTR PTR, BYVAL AS gpointer)
DECLARE FUNCTION g_trash_stack_pop(BYVAL AS GTrashStack PTR PTR) AS gpointer
DECLARE FUNCTION g_trash_stack_peek(BYVAL AS GTrashStack PTR PTR) AS gpointer
DECLARE FUNCTION g_trash_stack_height(BYVAL AS GTrashStack PTR PTR) AS guint

#ENDIF ' __G_TRASH_STACK_H__

#IFNDEF __G_TREE_H__
#DEFINE __G_TREE_H__

TYPE GTree AS _GTree
TYPE GTraverseFunc AS FUNCTION(BYVAL AS gpointer, BYVAL AS gpointer, BYVAL AS gpointer) AS gboolean

DECLARE FUNCTION g_tree_new(BYVAL AS GCompareFunc) AS GTree PTR
DECLARE FUNCTION g_tree_new_with_data(BYVAL AS GCompareDataFunc, BYVAL AS gpointer) AS GTree PTR
DECLARE FUNCTION g_tree_new_full(BYVAL AS GCompareDataFunc, BYVAL AS gpointer, BYVAL AS GDestroyNotify, BYVAL AS GDestroyNotify) AS GTree PTR
DECLARE FUNCTION g_tree_ref(BYVAL AS GTree PTR) AS GTree PTR
DECLARE SUB g_tree_unref(BYVAL AS GTree PTR)
DECLARE SUB g_tree_destroy(BYVAL AS GTree PTR)
DECLARE SUB g_tree_insert(BYVAL AS GTree PTR, BYVAL AS gpointer, BYVAL AS gpointer)
DECLARE SUB g_tree_replace(BYVAL AS GTree PTR, BYVAL AS gpointer, BYVAL AS gpointer)
DECLARE FUNCTION g_tree_remove(BYVAL AS GTree PTR, BYVAL AS gconstpointer) AS gboolean
DECLARE FUNCTION g_tree_steal(BYVAL AS GTree PTR, BYVAL AS gconstpointer) AS gboolean
DECLARE FUNCTION g_tree_lookup(BYVAL AS GTree PTR, BYVAL AS gconstpointer) AS gpointer
DECLARE FUNCTION g_tree_lookup_extended(BYVAL AS GTree PTR, BYVAL AS gconstpointer, BYVAL AS gpointer PTR, BYVAL AS gpointer PTR) AS gboolean
DECLARE SUB g_tree_foreach(BYVAL AS GTree PTR, BYVAL AS GTraverseFunc, BYVAL AS gpointer)
DECLARE SUB g_tree_traverse(BYVAL AS GTree PTR, BYVAL AS GTraverseFunc, BYVAL AS GTraverseType, BYVAL AS gpointer)
DECLARE FUNCTION g_tree_search(BYVAL AS GTree PTR, BYVAL AS GCompareFunc, BYVAL AS gconstpointer) AS gpointer
DECLARE FUNCTION g_tree_height(BYVAL AS GTree PTR) AS gint
DECLARE FUNCTION g_tree_nnodes(BYVAL AS GTree PTR) AS gint

#ENDIF ' __G_TREE_H__

#IFNDEF __G_URI_FUNCS_H__
#DEFINE __G_URI_FUNCS_H__

#DEFINE G_URI_RESERVED_CHARS_GENERIC_DELIMITERS !":/?#[]@"
#DEFINE G_URI_RESERVED_CHARS_SUBCOMPONENT_DELIMITERS !"!$&'()*+,;="
#DEFINE G_URI_RESERVED_CHARS_ALLOWED_IN_PATH_ELEMENT G_URI_RESERVED_CHARS_SUBCOMPONENT_DELIMITERS !":@"
#DEFINE G_URI_RESERVED_CHARS_ALLOWED_IN_PATH G_URI_RESERVED_CHARS_ALLOWED_IN_PATH_ELEMENT !"/"
#DEFINE G_URI_RESERVED_CHARS_ALLOWED_IN_USERINFO G_URI_RESERVED_CHARS_SUBCOMPONENT_DELIMITERS !":"

DECLARE FUNCTION g_uri_unescape_string(BYVAL AS CONST ZSTRING PTR, BYVAL AS CONST ZSTRING PTR) AS ZSTRING PTR
DECLARE FUNCTION g_uri_unescape_segment(BYVAL AS CONST ZSTRING PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS CONST ZSTRING PTR) AS ZSTRING PTR
DECLARE FUNCTION g_uri_parse_scheme(BYVAL AS CONST ZSTRING PTR) AS ZSTRING PTR
DECLARE FUNCTION g_uri_escape_string(BYVAL AS CONST ZSTRING PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS gboolean) AS ZSTRING PTR

#ENDIF ' __G_URI_FUNCS_H__

#IFNDEF __G_VARIANT_TYPE_H__
#DEFINE __G_VARIANT_TYPE_H__

TYPE GVariantType AS _GVariantType

#DEFINE G_VARIANT_TYPE_BOOLEAN (CAST(CONST GVariantType PTR, @!"b"))
#DEFINE G_VARIANT_TYPE_BYTE (CAST(CONST GVariantType PTR, @!"y"))
#DEFINE G_VARIANT_TYPE_INT16 (CAST(CONST GVariantType PTR, @!"n"))
#DEFINE G_VARIANT_TYPE_UINT16 (CAST(CONST GVariantType PTR, @!"q"))
#DEFINE G_VARIANT_TYPE_INT32 (CAST(CONST GVariantType PTR, @!"i"))
#DEFINE G_VARIANT_TYPE_UINT32 (CAST(CONST GVariantType PTR, @!"u"))
#DEFINE G_VARIANT_TYPE_INT64 (CAST(CONST GVariantType PTR, @!"x"))
#DEFINE G_VARIANT_TYPE_UINT64 (CAST(CONST GVariantType PTR, @!"t"))
#DEFINE G_VARIANT_TYPE_DOUBLE (CAST(CONST GVariantType PTR, @!"d"))
#DEFINE G_VARIANT_TYPE_STRING (CAST(CONST GVariantType PTR, @!"s"))
#DEFINE G_VARIANT_TYPE_OBJECT_PATH (CAST(CONST GVariantType PTR, @!"o"))
#DEFINE G_VARIANT_TYPE_SIGNATURE (CAST(CONST GVariantType PTR, @!"g"))
#DEFINE G_VARIANT_TYPE_VARIANT (CAST(CONST GVariantType PTR, @!"v"))
#DEFINE G_VARIANT_TYPE_HANDLE (CAST(CONST GVariantType PTR, @!"h"))
#DEFINE G_VARIANT_TYPE_UNIT (CAST(CONST GVariantType PTR, @!"()"))
#DEFINE G_VARIANT_TYPE_ANY (CAST(CONST GVariantType PTR, @!"*"))
#DEFINE G_VARIANT_TYPE_BASIC (CAST(CONST GVariantType PTR, @!"?"))
#DEFINE G_VARIANT_TYPE_MAYBE (CAST(CONST GVariantType PTR, @!"m*"))
#DEFINE G_VARIANT_TYPE_ARRAY (CAST(CONST GVariantType PTR, @!"a*"))
#DEFINE G_VARIANT_TYPE_TUPLE (CAST(CONST GVariantType PTR, @!"r"))
#DEFINE G_VARIANT_TYPE_DICT_ENTRY (CAST(CONST GVariantType PTR, @!"{?*}"))
#DEFINE G_VARIANT_TYPE_DICTIONARY (CAST(CONST GVariantType PTR, @!"a{?*}"))
#DEFINE G_VARIANT_TYPE_STRING_ARRAY (CAST(CONST GVariantType PTR, @!"as"))
#DEFINE G_VARIANT_TYPE_OBJECT_PATH_ARRAY (CAST(CONST GVariantType PTR, @!"ao"))
#DEFINE G_VARIANT_TYPE_BYTESTRING (CAST(CONST GVariantType PTR, @!"ay"))
#DEFINE G_VARIANT_TYPE_BYTESTRING_ARRAY (CAST(CONST GVariantType PTR, @!"aay"))
#DEFINE G_VARIANT_TYPE_VARDICT (CAST(CONST GVariantType PTR, @!"a{sv}"))

#IFNDEF G_DISABLE_CHECKS
#DEFINE G_VARIANT_TYPE(type_string) (g_variant_type_checked_ ((type_string)))
#ELSE ' G_DISABLE_CHECKS
#DEFINE G_VARIANT_TYPE(type_string) (CAST(CONST GVariantType PTR, (type_string)))
#ENDIF ' G_DISABLE_CHECKS

DECLARE FUNCTION g_variant_type_string_is_valid(BYVAL AS CONST gchar PTR) AS gboolean
DECLARE FUNCTION g_variant_type_string_scan(BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR PTR) AS gboolean
DECLARE SUB g_variant_type_free(BYVAL AS GVariantType PTR)
DECLARE FUNCTION g_variant_type_copy(BYVAL AS CONST GVariantType PTR) AS GVariantType PTR
DECLARE FUNCTION g_variant_type_new(BYVAL AS CONST gchar PTR) AS GVariantType PTR
DECLARE FUNCTION g_variant_type_get_string_length(BYVAL AS CONST GVariantType PTR) AS gsize
DECLARE FUNCTION g_variant_type_peek_string(BYVAL AS CONST GVariantType PTR) AS CONST gchar PTR
DECLARE FUNCTION g_variant_type_dup_string(BYVAL AS CONST GVariantType PTR) AS gchar PTR
DECLARE FUNCTION g_variant_type_is_definite(BYVAL AS CONST GVariantType PTR) AS gboolean
DECLARE FUNCTION g_variant_type_is_container(BYVAL AS CONST GVariantType PTR) AS gboolean
DECLARE FUNCTION g_variant_type_is_basic(BYVAL AS CONST GVariantType PTR) AS gboolean
DECLARE FUNCTION g_variant_type_is_maybe(BYVAL AS CONST GVariantType PTR) AS gboolean
DECLARE FUNCTION g_variant_type_is_array(BYVAL AS CONST GVariantType PTR) AS gboolean
DECLARE FUNCTION g_variant_type_is_tuple(BYVAL AS CONST GVariantType PTR) AS gboolean
DECLARE FUNCTION g_variant_type_is_dict_entry(BYVAL AS CONST GVariantType PTR) AS gboolean
DECLARE FUNCTION g_variant_type_is_variant(BYVAL AS CONST GVariantType PTR) AS gboolean
DECLARE FUNCTION g_variant_type_hash(BYVAL AS gconstpointer) AS guint
DECLARE FUNCTION g_variant_type_equal(BYVAL AS gconstpointer, BYVAL AS gconstpointer) AS gboolean
DECLARE FUNCTION g_variant_type_is_subtype_of(BYVAL AS CONST GVariantType PTR, BYVAL AS CONST GVariantType PTR) AS gboolean
DECLARE FUNCTION g_variant_type_element(BYVAL AS CONST GVariantType PTR) AS CONST GVariantType PTR
DECLARE FUNCTION g_variant_type_first(BYVAL AS CONST GVariantType PTR) AS CONST GVariantType PTR
DECLARE FUNCTION g_variant_type_next(BYVAL AS CONST GVariantType PTR) AS CONST GVariantType PTR
DECLARE FUNCTION g_variant_type_n_items(BYVAL AS CONST GVariantType PTR) AS gsize
DECLARE FUNCTION g_variant_type_key(BYVAL AS CONST GVariantType PTR) AS CONST GVariantType PTR
DECLARE FUNCTION g_variant_type_value(BYVAL AS CONST GVariantType PTR) AS CONST GVariantType PTR
DECLARE FUNCTION g_variant_type_new_array(BYVAL AS CONST GVariantType PTR) AS GVariantType PTR
DECLARE FUNCTION g_variant_type_new_maybe(BYVAL AS CONST GVariantType PTR) AS GVariantType PTR
DECLARE FUNCTION g_variant_type_new_tuple(BYVAL AS CONST GVariantType CONST PTR PTR, BYVAL AS gint) AS GVariantType PTR
DECLARE FUNCTION g_variant_type_new_dict_entry(BYVAL AS CONST GVariantType PTR, BYVAL AS CONST GVariantType PTR) AS GVariantType PTR
DECLARE FUNCTION g_variant_type_checked_(BYVAL AS CONST gchar PTR) AS CONST GVariantType PTR

#ENDIF ' __G_VARIANT_TYPE_H__

#IFNDEF __G_VARIANT_H__
#DEFINE __G_VARIANT_H__

TYPE GVariant AS _GVariant

ENUM GVariantClass
  G_VARIANT_CLASS_BOOLEAN = ASC(!"b")
  G_VARIANT_CLASS_BYTE = ASC(!"y")
  G_VARIANT_CLASS_INT16 = ASC(!"n")
  G_VARIANT_CLASS_UINT16 = ASC(!"q")
  G_VARIANT_CLASS_INT32 = ASC(!"i")
  G_VARIANT_CLASS_UINT32 = ASC(!"u")
  G_VARIANT_CLASS_INT64 = ASC(!"x")
  G_VARIANT_CLASS_UINT64 = ASC(!"t")
  G_VARIANT_CLASS_HANDLE = ASC(!"h")
  G_VARIANT_CLASS_DOUBLE = ASC(!"d")
  G_VARIANT_CLASS_STRING = ASC(!"s")
  G_VARIANT_CLASS_OBJECT_PATH = ASC(!"o")
  G_VARIANT_CLASS_SIGNATURE = ASC(!"g")
  G_VARIANT_CLASS_VARIANT = ASC(!"v")
  G_VARIANT_CLASS_MAYBE = ASC(!"m")
  G_VARIANT_CLASS_ARRAY = ASC(!"a")
  G_VARIANT_CLASS_TUPLE = ASC(!"(")
  G_VARIANT_CLASS_DICT_ENTRY = ASC(!"{")
END ENUM

DECLARE SUB g_variant_unref(BYVAL AS GVariant PTR)
DECLARE FUNCTION g_variant_ref(BYVAL AS GVariant PTR) AS GVariant PTR
DECLARE FUNCTION g_variant_ref_sink(BYVAL AS GVariant PTR) AS GVariant PTR
DECLARE FUNCTION g_variant_is_floating(BYVAL AS GVariant PTR) AS gboolean
DECLARE FUNCTION g_variant_take_ref(BYVAL AS GVariant PTR) AS GVariant PTR
DECLARE FUNCTION g_variant_get_type(BYVAL AS GVariant PTR) AS CONST GVariantType PTR
DECLARE FUNCTION g_variant_get_type_string(BYVAL AS GVariant PTR) AS CONST gchar PTR
DECLARE FUNCTION g_variant_is_of_type(BYVAL AS GVariant PTR, BYVAL AS CONST GVariantType PTR) AS gboolean
DECLARE FUNCTION g_variant_is_container(BYVAL AS GVariant PTR) AS gboolean
DECLARE FUNCTION g_variant_classify(BYVAL AS GVariant PTR) AS GVariantClass
DECLARE FUNCTION g_variant_new_boolean(BYVAL AS gboolean) AS GVariant PTR
DECLARE FUNCTION g_variant_new_byte(BYVAL AS guchar) AS GVariant PTR
DECLARE FUNCTION g_variant_new_int16(BYVAL AS gint16) AS GVariant PTR
DECLARE FUNCTION g_variant_new_uint16(BYVAL AS guint16) AS GVariant PTR
DECLARE FUNCTION g_variant_new_int32(BYVAL AS gint32) AS GVariant PTR
DECLARE FUNCTION g_variant_new_uint32(BYVAL AS guint32) AS GVariant PTR
DECLARE FUNCTION g_variant_new_int64(BYVAL AS gint64) AS GVariant PTR
DECLARE FUNCTION g_variant_new_uint64(BYVAL AS guint64) AS GVariant PTR
DECLARE FUNCTION g_variant_new_handle(BYVAL AS gint32) AS GVariant PTR
DECLARE FUNCTION g_variant_new_double(BYVAL AS gdouble) AS GVariant PTR
DECLARE FUNCTION g_variant_new_string(BYVAL AS CONST gchar PTR) AS GVariant PTR
DECLARE FUNCTION g_variant_new_object_path(BYVAL AS CONST gchar PTR) AS GVariant PTR
DECLARE FUNCTION g_variant_is_object_path(BYVAL AS CONST gchar PTR) AS gboolean
DECLARE FUNCTION g_variant_new_signature(BYVAL AS CONST gchar PTR) AS GVariant PTR
DECLARE FUNCTION g_variant_is_signature(BYVAL AS CONST gchar PTR) AS gboolean
DECLARE FUNCTION g_variant_new_variant(BYVAL AS GVariant PTR) AS GVariant PTR
DECLARE FUNCTION g_variant_new_strv(BYVAL AS CONST gchar CONST PTR PTR, BYVAL AS gssize) AS GVariant PTR
DECLARE FUNCTION g_variant_new_objv(BYVAL AS CONST gchar CONST PTR PTR, BYVAL AS gssize) AS GVariant PTR
DECLARE FUNCTION g_variant_new_bytestring(BYVAL AS CONST gchar PTR) AS GVariant PTR
DECLARE FUNCTION g_variant_new_bytestring_array(BYVAL AS CONST gchar CONST PTR PTR, BYVAL AS gssize) AS GVariant PTR
DECLARE FUNCTION g_variant_new_fixed_array(BYVAL AS CONST GVariantType PTR, BYVAL AS gconstpointer, BYVAL AS gsize, BYVAL AS gsize) AS GVariant PTR
DECLARE FUNCTION g_variant_get_boolean(BYVAL AS GVariant PTR) AS gboolean
DECLARE FUNCTION g_variant_get_byte(BYVAL AS GVariant PTR) AS guchar
DECLARE FUNCTION g_variant_get_int16(BYVAL AS GVariant PTR) AS gint16
DECLARE FUNCTION g_variant_get_uint16(BYVAL AS GVariant PTR) AS guint16
DECLARE FUNCTION g_variant_get_int32(BYVAL AS GVariant PTR) AS gint32
DECLARE FUNCTION g_variant_get_uint32(BYVAL AS GVariant PTR) AS guint32
DECLARE FUNCTION g_variant_get_int64(BYVAL AS GVariant PTR) AS gint64
DECLARE FUNCTION g_variant_get_uint64(BYVAL AS GVariant PTR) AS guint64
DECLARE FUNCTION g_variant_get_handle(BYVAL AS GVariant PTR) AS gint32
DECLARE FUNCTION g_variant_get_double(BYVAL AS GVariant PTR) AS gdouble
DECLARE FUNCTION g_variant_get_variant(BYVAL AS GVariant PTR) AS GVariant PTR
DECLARE FUNCTION g_variant_get_string(BYVAL AS GVariant PTR, BYVAL AS gsize PTR) AS CONST gchar PTR
DECLARE FUNCTION g_variant_dup_string(BYVAL AS GVariant PTR, BYVAL AS gsize PTR) AS gchar PTR
DECLARE FUNCTION g_variant_get_strv(BYVAL AS GVariant PTR, BYVAL AS gsize PTR) AS CONST gchar PTR PTR
DECLARE FUNCTION g_variant_dup_strv(BYVAL AS GVariant PTR, BYVAL AS gsize PTR) AS gchar PTR PTR
DECLARE FUNCTION g_variant_get_objv(BYVAL AS GVariant PTR, BYVAL AS gsize PTR) AS CONST gchar PTR PTR
DECLARE FUNCTION g_variant_dup_objv(BYVAL AS GVariant PTR, BYVAL AS gsize PTR) AS gchar PTR PTR
DECLARE FUNCTION g_variant_get_bytestring(BYVAL AS GVariant PTR) AS CONST gchar PTR
DECLARE FUNCTION g_variant_dup_bytestring(BYVAL AS GVariant PTR, BYVAL AS gsize PTR) AS gchar PTR
DECLARE FUNCTION g_variant_get_bytestring_array(BYVAL AS GVariant PTR, BYVAL AS gsize PTR) AS CONST gchar PTR PTR
DECLARE FUNCTION g_variant_dup_bytestring_array(BYVAL AS GVariant PTR, BYVAL AS gsize PTR) AS gchar PTR PTR
DECLARE FUNCTION g_variant_new_maybe(BYVAL AS CONST GVariantType PTR, BYVAL AS GVariant PTR) AS GVariant PTR
DECLARE FUNCTION g_variant_new_array(BYVAL AS CONST GVariantType PTR, BYVAL AS GVariant CONST PTR PTR, BYVAL AS gsize) AS GVariant PTR
DECLARE FUNCTION g_variant_new_tuple(BYVAL AS GVariant CONST PTR PTR, BYVAL AS gsize) AS GVariant PTR
DECLARE FUNCTION g_variant_new_dict_entry(BYVAL AS GVariant PTR, BYVAL AS GVariant PTR) AS GVariant PTR
DECLARE FUNCTION g_variant_get_maybe(BYVAL AS GVariant PTR) AS GVariant PTR
DECLARE FUNCTION g_variant_n_children(BYVAL AS GVariant PTR) AS gsize
DECLARE SUB g_variant_get_child(BYVAL AS GVariant PTR, BYVAL AS gsize, BYVAL AS CONST gchar PTR, ...)
DECLARE FUNCTION g_variant_get_child_value(BYVAL AS GVariant PTR, BYVAL AS gsize) AS GVariant PTR
DECLARE FUNCTION g_variant_lookup(BYVAL AS GVariant PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, ...) AS gboolean
DECLARE FUNCTION g_variant_lookup_value(BYVAL AS GVariant PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST GVariantType PTR) AS GVariant PTR
DECLARE FUNCTION g_variant_get_fixed_array(BYVAL AS GVariant PTR, BYVAL AS gsize PTR, BYVAL AS gsize) AS gconstpointer
DECLARE FUNCTION g_variant_get_size(BYVAL AS GVariant PTR) AS gsize
DECLARE FUNCTION g_variant_get_data(BYVAL AS GVariant PTR) AS gconstpointer
DECLARE SUB g_variant_store(BYVAL AS GVariant PTR, BYVAL AS gpointer)
DECLARE FUNCTION g_variant_print(BYVAL AS GVariant PTR, BYVAL AS gboolean) AS gchar PTR
DECLARE FUNCTION g_variant_print_string(BYVAL AS GVariant PTR, BYVAL AS GString PTR, BYVAL AS gboolean) AS GString PTR
DECLARE FUNCTION g_variant_hash(BYVAL AS gconstpointer) AS guint
DECLARE FUNCTION g_variant_equal(BYVAL AS gconstpointer, BYVAL AS gconstpointer) AS gboolean
DECLARE FUNCTION g_variant_get_normal_form(BYVAL AS GVariant PTR) AS GVariant PTR
DECLARE FUNCTION g_variant_is_normal_form(BYVAL AS GVariant PTR) AS gboolean
DECLARE FUNCTION g_variant_byteswap(BYVAL AS GVariant PTR) AS GVariant PTR
DECLARE FUNCTION g_variant_new_from_data(BYVAL AS CONST GVariantType PTR, BYVAL AS gconstpointer, BYVAL AS gsize, BYVAL AS gboolean, BYVAL AS GDestroyNotify, BYVAL AS gpointer) AS GVariant PTR

TYPE GVariantIter AS _GVariantIter

TYPE _GVariantIter
  AS gsize x(15)
END TYPE

DECLARE FUNCTION g_variant_iter_new(BYVAL AS GVariant PTR) AS GVariantIter PTR
DECLARE FUNCTION g_variant_iter_init(BYVAL AS GVariantIter PTR, BYVAL AS GVariant PTR) AS gsize
DECLARE FUNCTION g_variant_iter_copy(BYVAL AS GVariantIter PTR) AS GVariantIter PTR
DECLARE FUNCTION g_variant_iter_n_children(BYVAL AS GVariantIter PTR) AS gsize
DECLARE SUB g_variant_iter_free(BYVAL AS GVariantIter PTR)
DECLARE FUNCTION g_variant_iter_next_value(BYVAL AS GVariantIter PTR) AS GVariant PTR
DECLARE FUNCTION g_variant_iter_next(BYVAL AS GVariantIter PTR, BYVAL AS CONST gchar PTR, ...) AS gboolean
DECLARE FUNCTION g_variant_iter_loop(BYVAL AS GVariantIter PTR, BYVAL AS CONST gchar PTR, ...) AS gboolean

TYPE GVariantBuilder AS _GVariantBuilder

TYPE _GVariantBuilder
  AS gsize x(15)
END TYPE

ENUM GVariantParseError
  G_VARIANT_PARSE_ERROR_FAILED
  G_VARIANT_PARSE_ERROR_BASIC_TYPE_EXPECTED
  G_VARIANT_PARSE_ERROR_CANNOT_INFER_TYPE
  G_VARIANT_PARSE_ERROR_DEFINITE_TYPE_EXPECTED
  G_VARIANT_PARSE_ERROR_INPUT_NOT_AT_END
  G_VARIANT_PARSE_ERROR_INVALID_CHARACTER
  G_VARIANT_PARSE_ERROR_INVALID_FORMAT_STRING
  G_VARIANT_PARSE_ERROR_INVALID_OBJECT_PATH
  G_VARIANT_PARSE_ERROR_INVALID_SIGNATURE
  G_VARIANT_PARSE_ERROR_INVALID_TYPE_STRING
  G_VARIANT_PARSE_ERROR_NO_COMMON_TYPE
  G_VARIANT_PARSE_ERROR_NUMBER_OUT_OF_RANGE
  G_VARIANT_PARSE_ERROR_NUMBER_TOO_BIG
  G_VARIANT_PARSE_ERROR_TYPE_ERROR
  G_VARIANT_PARSE_ERROR_UNEXPECTED_TOKEN
  G_VARIANT_PARSE_ERROR_UNKNOWN_KEYWORD
  G_VARIANT_PARSE_ERROR_UNTERMINATED_STRING_CONSTANT
  G_VARIANT_PARSE_ERROR_VALUE_EXPECTED
END ENUM

#DEFINE G_VARIANT_PARSE_ERROR (g_variant_parser_get_error_quark ())

DECLARE FUNCTION g_variant_parser_get_error_quark() AS GQuark
DECLARE FUNCTION g_variant_builder_new(BYVAL AS CONST GVariantType PTR) AS GVariantBuilder PTR
DECLARE SUB g_variant_builder_unref(BYVAL AS GVariantBuilder PTR)
DECLARE FUNCTION g_variant_builder_ref(BYVAL AS GVariantBuilder PTR) AS GVariantBuilder PTR
DECLARE SUB g_variant_builder_init(BYVAL AS GVariantBuilder PTR, BYVAL AS CONST GVariantType PTR)
DECLARE FUNCTION g_variant_builder_end(BYVAL AS GVariantBuilder PTR) AS GVariant PTR
DECLARE SUB g_variant_builder_clear(BYVAL AS GVariantBuilder PTR)
DECLARE SUB g_variant_builder_open(BYVAL AS GVariantBuilder PTR, BYVAL AS CONST GVariantType PTR)
DECLARE SUB g_variant_builder_close(BYVAL AS GVariantBuilder PTR)
DECLARE SUB g_variant_builder_add_value(BYVAL AS GVariantBuilder PTR, BYVAL AS GVariant PTR)
DECLARE SUB g_variant_builder_add(BYVAL AS GVariantBuilder PTR, BYVAL AS CONST gchar PTR, ...)
DECLARE SUB g_variant_builder_add_parsed(BYVAL AS GVariantBuilder PTR, BYVAL AS CONST gchar PTR, ...)
DECLARE FUNCTION g_variant_new(BYVAL AS CONST gchar PTR, ...) AS GVariant PTR
DECLARE SUB g_variant_get(BYVAL AS GVariant PTR, BYVAL AS CONST gchar PTR, ...)
DECLARE FUNCTION g_variant_new_va(BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR PTR, BYVAL AS va_list PTR) AS GVariant PTR
DECLARE SUB g_variant_get_va(BYVAL AS GVariant PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR PTR, BYVAL AS va_list PTR)
DECLARE FUNCTION g_variant_parse(BYVAL AS CONST GVariantType PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR PTR, BYVAL AS GError PTR PTR) AS GVariant PTR
DECLARE FUNCTION g_variant_new_parsed(BYVAL AS CONST gchar PTR, ...) AS GVariant PTR
DECLARE FUNCTION g_variant_new_parsed_va(BYVAL AS CONST gchar PTR, BYVAL AS va_list PTR) AS GVariant PTR
DECLARE FUNCTION g_variant_compare(BYVAL AS gconstpointer, BYVAL AS gconstpointer) AS gint

#ENDIF ' __G_VARIANT_H__

#IFNDEF __G_VERSION_H__
#DEFINE __G_VERSION_H__

EXTERN AS CONST guint glib_major_version_ ALIAS "glib_major_version"
EXTERN AS CONST guint glib_minor_version_ ALIAS "glib_minor_version"
EXTERN AS CONST guint glib_micro_version_ ALIAS "glib_micro_version"
EXTERN AS CONST guint glib_interface_age
EXTERN AS CONST guint glib_binary_age

DECLARE FUNCTION glib_check_version_ ALIAS "glib_check_version"(BYVAL AS guint, BYVAL AS guint, BYVAL AS guint) AS CONST gchar PTR

#DEFINE GLIB_CHECK_VERSION(major,minor,micro) _
    (GLIB_MAJOR_VERSION > (major) ORELSE _
     (GLIB_MAJOR_VERSION = (major) ANDALSO GLIB_MINOR_VERSION > (minor)) ORELSE _
     (GLIB_MAJOR_VERSION = (major) ANDALSO GLIB_MINOR_VERSION = (minor) ANDALSO _
      GLIB_MICRO_VERSION > = (micro)))
#ENDIF ' __G_VERSION_H__

#IFDEF G_PLATFORM_WIN32

#IFNDEF __G_WIN32_H__
#DEFINE __G_WIN32_H__

#IFDEF G_PLATFORM_WIN32
#IFNDEF MAXPATHLEN
#DEFINE MAXPATHLEN 1024
#ENDIF ' MAXPATHLEN

#IFDEF G_OS_WIN32

DECLARE FUNCTION g_win32_ftruncate(BYVAL AS gint, BYVAL AS guint) AS gint

#ENDIF ' G_OS_WIN32

DECLARE FUNCTION g_win32_getlocale() AS gchar PTR
DECLARE FUNCTION g_win32_error_message(BYVAL AS gint) AS gchar PTR

#IFNDEF G_DISABLE_DEPRECATED
#IFNDEF __GTK_DOC_IGNORE__
#IFDEF _WIN64
#DEFINE g_win32_get_package_installation_directory g_win32_get_package_installation_directory_utf8
#DEFINE g_win32_get_package_installation_subdirectory g_win32_get_package_installation_subdirectory_utf8
#ENDIF ' _WIN64
#ENDIF ' __GTK_DOC_IGNORE__

DECLARE FUNCTION g_win32_get_package_installation_directory(BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR) AS gchar PTR
DECLARE FUNCTION g_win32_get_package_installation_subdirectory(BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR) AS gchar PTR

#ENDIF ' G_DISABLE_DEPRECATED

DECLARE FUNCTION g_win32_get_package_installation_directory_of_module(BYVAL AS gpointer) AS gchar PTR
DECLARE FUNCTION g_win32_get_windows_version() AS guint
DECLARE FUNCTION g_win32_locale_filename_from_utf8(BYVAL AS CONST gchar PTR) AS gchar PTR

#DEFINE G_WIN32_IS_NT_BASED() TRUE
#DEFINE G_WIN32_HAVE_WIDECHAR_API() TRUE
#ENDIF ' G_PLATFORM_WIN32
#ENDIF ' __G_WIN32_H__

#ENDIF ' G_PLATFORM_WIN32
#IFNDEF __G_ALLOCATOR_H__
#DEFINE __G_ALLOCATOR_H__

TYPE GAllocator AS _GAllocator
TYPE GMemChunk AS _GMemChunk

#DEFINE G_ALLOC_ONLY 1
#DEFINE G_ALLOC_AND_FREE 2
#DEFINE G_ALLOCATOR_LIST 1
#DEFINE G_ALLOCATOR_SLIST 2
#DEFINE G_ALLOCATOR_NODE 3
#DEFINE g_chunk_new(type, chunk) (CAST(type PTR, g_mem_chunk_alloc (chunk)))
#DEFINE g_chunk_new0(type, chunk) (CAST(type PTR, g_mem_chunk_alloc0 (chunk)))
#DEFINE g_chunk_free(mem, mem_chunk) (g_mem_chunk_free (mem_chunk, mem))
#DEFINE g_mem_chunk_create(type, x, y) (g_mem_chunk_new (NULL, SIZEOF (type), 0, 0))

DECLARE FUNCTION g_mem_chunk_new(BYVAL AS CONST gchar PTR, BYVAL AS gint, BYVAL AS gsize, BYVAL AS gint) AS GMemChunk PTR
DECLARE SUB g_mem_chunk_destroy(BYVAL AS GMemChunk PTR)
DECLARE FUNCTION g_mem_chunk_alloc(BYVAL AS GMemChunk PTR) AS gpointer
DECLARE FUNCTION g_mem_chunk_alloc0(BYVAL AS GMemChunk PTR) AS gpointer
DECLARE SUB g_mem_chunk_free(BYVAL AS GMemChunk PTR, BYVAL AS gpointer)
DECLARE SUB g_mem_chunk_clean(BYVAL AS GMemChunk PTR)
DECLARE SUB g_mem_chunk_reset(BYVAL AS GMemChunk PTR)
DECLARE SUB g_mem_chunk_print(BYVAL AS GMemChunk PTR)
DECLARE SUB g_mem_chunk_info()
DECLARE SUB g_blow_chunks()
DECLARE FUNCTION g_allocator_new(BYVAL AS CONST gchar PTR, BYVAL AS guint) AS GAllocator PTR
DECLARE SUB g_allocator_free(BYVAL AS GAllocator PTR)
DECLARE SUB g_list_push_allocator(BYVAL AS GAllocator PTR)
DECLARE SUB g_list_pop_allocator()
DECLARE SUB g_slist_push_allocator(BYVAL AS GAllocator PTR)
DECLARE SUB g_slist_pop_allocator()
DECLARE SUB g_node_push_allocator(BYVAL AS GAllocator PTR)
DECLARE SUB g_node_pop_allocator()

#ENDIF ' __G_ALLOCATOR_H__

#IFNDEF __G_CACHE_H__
#DEFINE __G_CACHE_H__

TYPE GCache AS _GCache
TYPE GCacheNewFunc AS FUNCTION(BYVAL AS gpointer) AS gpointer
TYPE GCacheDupFunc AS FUNCTION(BYVAL AS gpointer) AS gpointer
TYPE GCacheDestroyFunc AS SUB(BYVAL AS gpointer)

DECLARE FUNCTION g_cache_new(BYVAL AS GCacheNewFunc, BYVAL AS GCacheDestroyFunc, BYVAL AS GCacheDupFunc, BYVAL AS GCacheDestroyFunc, BYVAL AS GHashFunc, BYVAL AS GHashFunc, BYVAL AS GEqualFunc) AS GCache PTR
DECLARE SUB g_cache_destroy(BYVAL AS GCache PTR)
DECLARE FUNCTION g_cache_insert(BYVAL AS GCache PTR, BYVAL AS gpointer) AS gpointer
DECLARE SUB g_cache_remove(BYVAL AS GCache PTR, BYVAL AS gconstpointer)
DECLARE SUB g_cache_key_foreach(BYVAL AS GCache PTR, BYVAL AS GHFunc, BYVAL AS gpointer)
DECLARE SUB g_cache_value_foreach(BYVAL AS GCache PTR, BYVAL AS GHFunc, BYVAL AS gpointer)

#ENDIF ' __G_CACHE_H__

#IFNDEF __G_COMPLETION_H__
#DEFINE __G_COMPLETION_H__

TYPE GCompletion AS _GCompletion
TYPE GCompletionFunc AS FUNCTION(BYVAL AS gpointer) AS gchar PTR
TYPE GCompletionStrncmpFunc AS FUNCTION(BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS gsize) AS gint

TYPE _GCompletion
  AS GList PTR items
  AS GCompletionFunc func
  AS gchar PTR prefix
  AS GList PTR cache
  AS GCompletionStrncmpFunc strncmp_func
END TYPE

DECLARE FUNCTION g_completion_new(BYVAL AS GCompletionFunc) AS GCompletion PTR
DECLARE SUB g_completion_add_items(BYVAL AS GCompletion PTR, BYVAL AS GList PTR)
DECLARE SUB g_completion_remove_items(BYVAL AS GCompletion PTR, BYVAL AS GList PTR)
DECLARE SUB g_completion_clear_items(BYVAL AS GCompletion PTR)
DECLARE FUNCTION g_completion_complete(BYVAL AS GCompletion PTR, BYVAL AS CONST gchar PTR, BYVAL AS gchar PTR PTR) AS GList PTR
DECLARE FUNCTION g_completion_complete_utf8(BYVAL AS GCompletion PTR, BYVAL AS CONST gchar PTR, BYVAL AS gchar PTR PTR) AS GList PTR
DECLARE SUB g_completion_set_compare(BYVAL AS GCompletion PTR, BYVAL AS GCompletionStrncmpFunc)
DECLARE SUB g_completion_free(BYVAL AS GCompletion PTR)

#ENDIF ' __G_COMPLETION_H__

#IFNDEF __G_DEPRECATED_MAIN_H__
#DEFINE __G_DEPRECATED_MAIN_H__

#DEFINE g_main_new(is_running) g_main_loop_new (NULL, is_running)
#DEFINE g_main_run(loop) g_main_loop_run(loop)
#DEFINE g_main_quit(loop) g_main_loop_quit(loop)
#DEFINE g_main_destroy(loop) g_main_loop_unref(loop)
#DEFINE g_main_is_running(loop) g_main_loop_is_running(loop)
#DEFINE g_main_iteration(may_block) g_main_context_iteration (NULL, may_block)
#DEFINE g_main_pending() g_main_context_pending (NULL)
#DEFINE g_main_set_poll_func(func) g_main_context_set_poll_func (NULL, func)
#ENDIF ' __G_DEPRECATED_MAIN_H__

#IFNDEF __G_REL_H__
#DEFINE __G_REL_H__

TYPE GRelation AS _GRelation
TYPE GTuples AS _GTuples

TYPE _GTuples
  AS guint len
END TYPE

DECLARE FUNCTION g_relation_new(BYVAL AS gint) AS GRelation PTR
DECLARE SUB g_relation_destroy(BYVAL AS GRelation PTR)
DECLARE SUB g_relation_index(BYVAL AS GRelation PTR, BYVAL AS gint, BYVAL AS GHashFunc, BYVAL AS GEqualFunc)
DECLARE SUB g_relation_insert(BYVAL AS GRelation PTR, ...)
DECLARE FUNCTION g_relation_delete(BYVAL AS GRelation PTR, BYVAL AS gconstpointer, BYVAL AS gint) AS gint
DECLARE FUNCTION g_relation_select(BYVAL AS GRelation PTR, BYVAL AS gconstpointer, BYVAL AS gint) AS GTuples PTR
DECLARE FUNCTION g_relation_count(BYVAL AS GRelation PTR, BYVAL AS gconstpointer, BYVAL AS gint) AS gint
DECLARE FUNCTION g_relation_exists(BYVAL AS GRelation PTR, ...) AS gboolean
DECLARE SUB g_relation_print(BYVAL AS GRelation PTR)
DECLARE SUB g_tuples_destroy(BYVAL AS GTuples PTR)
DECLARE FUNCTION g_tuples_index(BYVAL AS GTuples PTR, BYVAL AS gint, BYVAL AS gint) AS gpointer

#ENDIF ' __G_REL_H__

#IFNDEF __G_DEPRECATED_THREAD_H__
#DEFINE __G_DEPRECATED_THREAD_H__

ENUM GThreadPriority
  G_THREAD_PRIORITY_LOW
  G_THREAD_PRIORITY_NORMAL
  G_THREAD_PRIORITY_HIGH
  G_THREAD_PRIORITY_URGENT
END ENUM

TYPE _GThread
  AS GThreadFunc func
  AS gpointer data
  AS gboolean joinable
  AS GThreadPriority priority
END TYPE

TYPE GThreadFunctions AS _GThreadFunctions

TYPE _GThreadFunctions
  mutex_new AS FUNCTION() AS GMutex PTR
  mutex_lock AS SUB(BYVAL AS GMutex PTR)
  mutex_trylock AS FUNCTION(BYVAL AS GMutex PTR) AS gboolean
  mutex_unlock AS SUB(BYVAL AS GMutex PTR)
  mutex_free AS SUB(BYVAL AS GMutex PTR)
  cond_new AS FUNCTION() AS GCond PTR
  cond_signal AS SUB(BYVAL AS GCond PTR)
  cond_broadcast AS SUB(BYVAL AS GCond PTR)
  cond_wait AS SUB(BYVAL AS GCond PTR, BYVAL AS GMutex PTR)
  cond_timed_wait AS FUNCTION(BYVAL AS GCond PTR, BYVAL AS GMutex PTR, BYVAL AS GTimeVal PTR) AS gboolean
  cond_free AS SUB(BYVAL AS GCond PTR)
  private_new AS FUNCTION(BYVAL AS GDestroyNotify) AS GPrivate PTR
  private_get AS FUNCTION(BYVAL AS GPrivate PTR) AS gpointer
  private_set AS SUB(BYVAL AS GPrivate PTR, BYVAL AS gpointer)
  thread_create AS SUB(BYVAL AS GThreadFunc, BYVAL AS gpointer, BYVAL AS gulong, BYVAL AS gboolean, BYVAL AS gboolean, BYVAL AS GThreadPriority, BYVAL AS gpointer, BYVAL AS GError PTR PTR)
  thread_yield AS SUB()
  thread_join AS SUB(BYVAL AS gpointer)
  thread_exit AS SUB()
  thread_set_priority AS SUB(BYVAL AS gpointer, BYVAL AS GThreadPriority)
  thread_self AS SUB(BYVAL AS gpointer)
  thread_equal AS FUNCTION(BYVAL AS gpointer, BYVAL AS gpointer) AS gboolean
END TYPE

EXTERN AS GThreadFunctions g_thread_functions_for_glib_use
EXTERN AS gboolean g_thread_use_default_impl
EXTERN g_thread_gettime AS FUNCTION() AS guint64

DECLARE FUNCTION g_thread_create(BYVAL AS GThreadFunc, BYVAL AS gpointer, BYVAL AS gboolean, BYVAL AS GError PTR PTR) AS GThread PTR
DECLARE FUNCTION g_thread_create_full(BYVAL AS GThreadFunc, BYVAL AS gpointer, BYVAL AS gulong, BYVAL AS gboolean, BYVAL AS gboolean, BYVAL AS GThreadPriority, BYVAL AS GError PTR PTR) AS GThread PTR
DECLARE SUB g_thread_set_priority(BYVAL AS GThread PTR, BYVAL AS GThreadPriority)
DECLARE SUB g_thread_foreach(BYVAL AS GFunc, BYVAL AS gpointer)

#IFNDEF G_OS_WIN32

#INCLUDE ONCE "crt/bits/pthreadtypes.bi"

#ENDIF ' G_OS_WIN32

#DEFINE g_static_mutex_get_mutex g_static_mutex_get_mutex_impl
#DEFINE G_STATIC_MUTEX_INIT_ TYPE<GStaticMutex>( NULL )

TYPE GStaticMutex
  AS GMutex PTR mutex
#IFNDEF G_OS_WIN32
  AS pthread_mutex_t unused
#ENDIF ' G_OS_WIN32
END TYPE

#DEFINE g_static_mutex_lock(mutex) _
    g_mutex_lock (g_static_mutex_get_mutex (mutex))
#DEFINE g_static_mutex_trylock(mutex) _
    g_mutex_trylock (g_static_mutex_get_mutex (mutex))
#DEFINE g_static_mutex_unlock(mutex) _
    g_mutex_unlock (g_static_mutex_get_mutex (mutex))

DECLARE SUB g_static_mutex_init(BYVAL AS GStaticMutex PTR)
DECLARE SUB g_static_mutex_free(BYVAL AS GStaticMutex PTR)
DECLARE FUNCTION g_static_mutex_get_mutex_impl(BYVAL AS GStaticMutex PTR) AS GMutex PTR

TYPE GStaticRecMutex AS _GStaticRecMutex

UNION _GStaticRecMutex__
#IFDEF G_OS_WIN32
  AS ANY PTR owner
#ELSE ' G_OS_WIN32
  AS pthread_t owner
#ENDIF ' G_OS_WIN32
  AS gdouble dummy
END UNION

TYPE _GStaticRecMutex
  AS GStaticMutex mutex
  AS guint depth
  AS _GStaticRecMutex__ unknown
END TYPE

#DEFINE G_STATIC_REC_MUTEX_INIT_ TYPE<GStaticRecMutex>( G_STATIC_MUTEX_INIT_ )

DECLARE SUB g_static_rec_mutex_init(BYVAL AS GStaticRecMutex PTR)
DECLARE SUB g_static_rec_mutex_lock(BYVAL AS GStaticRecMutex PTR)
DECLARE FUNCTION g_static_rec_mutex_trylock(BYVAL AS GStaticRecMutex PTR) AS gboolean
DECLARE SUB g_static_rec_mutex_unlock(BYVAL AS GStaticRecMutex PTR)
DECLARE SUB g_static_rec_mutex_lock_full(BYVAL AS GStaticRecMutex PTR, BYVAL AS guint)
DECLARE FUNCTION g_static_rec_mutex_unlock_full(BYVAL AS GStaticRecMutex PTR) AS guint
DECLARE SUB g_static_rec_mutex_free(BYVAL AS GStaticRecMutex PTR)

TYPE GStaticRWLock AS _GStaticRWLock

TYPE _GStaticRWLock
  AS GStaticMutex mutex
  AS GCond PTR read_cond
  AS GCond PTR write_cond
  AS guint read_counter
  AS gboolean have_writer
  AS guint want_to_read
  AS guint want_to_write
END TYPE

#DEFINE G_STATIC_RW_LOCK_INIT_ TYPE<GStaticRWLock>( G_STATIC_MUTEX_INIT_, NULL, NULL, 0, FALSE, 0, 0 )

DECLARE SUB g_static_rw_lock_init(BYVAL AS GStaticRWLock PTR)
DECLARE SUB g_static_rw_lock_reader_lock(BYVAL AS GStaticRWLock PTR)
DECLARE FUNCTION g_static_rw_lock_reader_trylock(BYVAL AS GStaticRWLock PTR) AS gboolean
DECLARE SUB g_static_rw_lock_reader_unlock(BYVAL AS GStaticRWLock PTR)
DECLARE SUB g_static_rw_lock_writer_lock(BYVAL AS GStaticRWLock PTR)
DECLARE FUNCTION g_static_rw_lock_writer_trylock(BYVAL AS GStaticRWLock PTR) AS gboolean
DECLARE SUB g_static_rw_lock_writer_unlock(BYVAL AS GStaticRWLock PTR)
DECLARE SUB g_static_rw_lock_free(BYVAL AS GStaticRWLock PTR)
DECLARE FUNCTION g_private_new(BYVAL AS GDestroyNotify) AS GPrivate PTR

TYPE GStaticPrivate AS _GStaticPrivate

TYPE _GStaticPrivate
  AS guint index
END TYPE

#DEFINE G_STATIC_PRIVATE_INIT_ TYPE<GStaticPrivate>( 0 )

DECLARE SUB g_static_private_init(BYVAL AS GStaticPrivate PTR)
DECLARE FUNCTION g_static_private_get(BYVAL AS GStaticPrivate PTR) AS gpointer
DECLARE SUB g_static_private_set(BYVAL AS GStaticPrivate PTR, BYVAL AS gpointer, BYVAL AS GDestroyNotify)
DECLARE SUB g_static_private_free(BYVAL AS GStaticPrivate PTR)
DECLARE FUNCTION g_once_init_enter_impl(BYVAL AS gsize PTR) AS gboolean
DECLARE SUB g_thread_init(BYVAL AS gpointer)
DECLARE SUB g_thread_init_with_errorcheck_mutexes(BYVAL AS gpointer)
DECLARE FUNCTION g_thread_get_initialized() AS gboolean

EXTERN AS gboolean g_threads_got_initialized

#DEFINE g_thread_supported() (1)

DECLARE FUNCTION g_mutex_new() AS GMutex PTR
DECLARE SUB g_mutex_free(BYVAL AS GMutex PTR)
DECLARE FUNCTION g_cond_new() AS GCond PTR
DECLARE SUB g_cond_free(BYVAL AS GCond PTR)
DECLARE FUNCTION g_cond_timed_wait(BYVAL AS GCond PTR, BYVAL AS GMutex PTR, BYVAL AS GTimeVal PTR) AS gboolean

#ENDIF ' __G_DEPRECATED_THREAD_H__

#UNDEF __GLIB_H_INSIDE__
#ENDIF ' __G_LIB_H__

END EXTERN

#IFDEF __FB_WIN32__
#PRAGMA pop(msbitfields)
#ENDIF
