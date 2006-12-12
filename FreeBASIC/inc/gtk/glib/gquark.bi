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

#include once "gtypes.bi"

type GQuark as guint32

declare function g_quark_try_string (byval string as zstring ptr) as GQuark
declare function g_quark_from_static_string (byval string as zstring ptr) as GQuark
declare function g_quark_from_string (byval string as zstring ptr) as GQuark
declare function g_quark_to_string (byval quark as GQuark) as zstring ptr

#endif
