''
''
'' gsourceclosure -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsourceclosure_bi__
#define __gsourceclosure_bi__

#include once "gtk/gobject/gclosure.bi"

declare sub g_source_set_closure cdecl alias "g_source_set_closure" (byval source as GSource ptr, byval closure as GClosure ptr)
declare function g_io_channel_get_type cdecl alias "g_io_channel_get_type" () as GType
declare function g_io_condition_get_type cdecl alias "g_io_condition_get_type" () as GType

#endif
