''
''
'' gquark -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gquark_bi__
#define __gquark_bi__

#include once "gtk/glib/gtypes.bi"

type GQuark as guint32

declare function g_quark_try_string cdecl alias "g_quark_try_string" (byval string as gchar ptr) as GQuark
declare function g_quark_from_static_string cdecl alias "g_quark_from_static_string" (byval string as gchar ptr) as GQuark
declare function g_quark_from_string cdecl alias "g_quark_from_string" (byval string as gchar ptr) as GQuark
declare function g_quark_to_string cdecl alias "g_quark_to_string" (byval quark as GQuark) as gchar ptr

#endif
