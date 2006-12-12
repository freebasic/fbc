''
''
'' gboxed -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gboxed_bi__
#define __gboxed_bi__

#include once "gtype.bi"

#define G_TYPE_IS_BOXED(type_) G_TYPE_FUNDAMENTAL(type_) = G_TYPE_BOXED
#define G_VALUE_HOLDS_BOXED(value) G_TYPE_CHECK_VALUE_TYPE(value, G_TYPE_BOXED)

type GBoxedCopyFunc as function cdecl(byval as gpointer) as gpointer
type GBoxedFreeFunc as sub cdecl(byval as gpointer)

declare function g_boxed_copy (byval boxed_type as GType, byval src_boxed as gconstpointer) as gpointer
declare sub g_boxed_free (byval boxed_type as GType, byval boxed as gpointer)
declare sub g_value_set_boxed (byval value as GValue ptr, byval v_boxed as gconstpointer)
declare sub g_value_set_static_boxed (byval value as GValue ptr, byval v_boxed as gconstpointer)
declare function g_value_get_boxed (byval value as GValue ptr) as gpointer
declare function g_value_dup_boxed (byval value as GValue ptr) as gpointer
declare function g_boxed_type_register_static (byval name as zstring ptr, byval boxed_copy as GBoxedCopyFunc, byval boxed_free as GBoxedFreeFunc) as GType
declare sub g_value_take_boxed (byval value as GValue ptr, byval v_boxed as gconstpointer)
declare sub g_value_set_boxed_take_ownership (byval value as GValue ptr, byval v_boxed as gconstpointer)
declare function g_closure_get_type () as GType
declare function g_value_get_type () as GType
declare function g_value_array_get_type () as GType
declare function g_strv_get_type () as GType
declare function g_gstring_get_type () as GType

type GStrv as zstring ptr ptr

#endif
