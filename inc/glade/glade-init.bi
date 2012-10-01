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

#include once "glib.bi"

declare sub glade_init ()
declare sub glade_require (byval library as zstring ptr)
declare sub glade_provide (byval library as zstring ptr)

#define glade_gnome_init  glade_init
#define glade_bonobo_init glade_init

#endif
