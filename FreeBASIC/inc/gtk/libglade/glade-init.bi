''
''
'' glade-init -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __glade_init_bi__
#define __glade_init_bi__

#include once "gtk/glib.bi"

declare sub glade_init cdecl alias "glade_init" ()
declare sub glade_require cdecl alias "glade_require" (byval library as string)
declare sub glade_provide cdecl alias "glade_provide" (byval library as string)

#endif
