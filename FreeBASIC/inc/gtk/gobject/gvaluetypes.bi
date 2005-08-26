''
''
'' gvaluetypes -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gvaluetypes_bi__
#define __gvaluetypes_bi__

#include once "gtk/gobject/gvalue.bi"

declare sub g_value_set_char cdecl alias "g_value_set_char" (byval value as GValue ptr, byval v_char as gchar)
declare function g_value_get_char cdecl alias "g_value_get_char" (byval value as GValue ptr) as gchar
declare sub g_value_set_uchar cdecl alias "g_value_set_uchar" (byval value as GValue ptr, byval v_uchar as guchar)
declare function g_value_get_uchar cdecl alias "g_value_get_uchar" (byval value as GValue ptr) as guchar
declare sub g_value_set_boolean cdecl alias "g_value_set_boolean" (byval value as GValue ptr, byval v_boolean as gboolean)
declare function g_value_get_boolean cdecl alias "g_value_get_boolean" (byval value as GValue ptr) as gboolean
declare sub g_value_set_int cdecl alias "g_value_set_int" (byval value as GValue ptr, byval v_int as gint)
declare function g_value_get_int cdecl alias "g_value_get_int" (byval value as GValue ptr) as gint
declare sub g_value_set_uint cdecl alias "g_value_set_uint" (byval value as GValue ptr, byval v_uint as guint)
declare function g_value_get_uint cdecl alias "g_value_get_uint" (byval value as GValue ptr) as guint
declare sub g_value_set_long cdecl alias "g_value_set_long" (byval value as GValue ptr, byval v_long as glong)
declare function g_value_get_long cdecl alias "g_value_get_long" (byval value as GValue ptr) as glong
declare sub g_value_set_ulong cdecl alias "g_value_set_ulong" (byval value as GValue ptr, byval v_ulong as gulong)
declare function g_value_get_ulong cdecl alias "g_value_get_ulong" (byval value as GValue ptr) as gulong
declare sub g_value_set_int64 cdecl alias "g_value_set_int64" (byval value as GValue ptr, byval v_int64 as gint64)
declare function g_value_get_int64 cdecl alias "g_value_get_int64" (byval value as GValue ptr) as gint64
declare sub g_value_set_uint64 cdecl alias "g_value_set_uint64" (byval value as GValue ptr, byval v_uint64 as guint64)
declare function g_value_get_uint64 cdecl alias "g_value_get_uint64" (byval value as GValue ptr) as guint64
declare sub g_value_set_float cdecl alias "g_value_set_float" (byval value as GValue ptr, byval v_float as gfloat)
declare function g_value_get_float cdecl alias "g_value_get_float" (byval value as GValue ptr) as gfloat
declare sub g_value_set_double cdecl alias "g_value_set_double" (byval value as GValue ptr, byval v_double as gdouble)
declare function g_value_get_double cdecl alias "g_value_get_double" (byval value as GValue ptr) as gdouble
declare sub g_value_set_string cdecl alias "g_value_set_string" (byval value as GValue ptr, byval v_string as zstring ptr)
declare sub g_value_set_static_string cdecl alias "g_value_set_static_string" (byval value as GValue ptr, byval v_string as zstring ptr)
declare function g_value_get_string cdecl alias "g_value_get_string" (byval value as GValue ptr) as zstring ptr
declare function g_value_dup_string cdecl alias "g_value_dup_string" (byval value as GValue ptr) as zstring ptr
declare sub g_value_set_pointer cdecl alias "g_value_set_pointer" (byval value as GValue ptr, byval v_pointer as gpointer)
declare function g_value_get_pointer cdecl alias "g_value_get_pointer" (byval value as GValue ptr) as gpointer
declare function g_pointer_type_register_static cdecl alias "g_pointer_type_register_static" (byval name as zstring ptr) as GType
declare function g_strdup_value_contents cdecl alias "g_strdup_value_contents" (byval value as GValue ptr) as zstring ptr
declare sub g_value_take_string cdecl alias "g_value_take_string" (byval value as GValue ptr, byval v_string as zstring ptr)
declare sub g_value_set_string_take_ownership cdecl alias "g_value_set_string_take_ownership" (byval value as GValue ptr, byval v_string as zstring ptr)

type gchararray as zstring ptr

#endif
