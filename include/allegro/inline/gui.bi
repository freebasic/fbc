''
''
'' allegro\gui -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __allegro_inline_gui_bi__
#define __allegro_inline_gui_bi__

#include once "allegro/gui.bi"

declare function object_message cdecl alias "object_message" (byval d as DIALOG ptr, byval msg as integer, byval c as integer) as integer

#endif
