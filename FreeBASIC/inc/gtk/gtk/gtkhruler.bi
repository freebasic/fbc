''
''
'' gtkhruler -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkhruler_bi__
#define __gtkhruler_bi__

#include once "gtk/gdk.bi"
#include once "gtk/gtk/gtkruler.bi"

type GtkHRuler as _GtkHRuler
type GtkHRulerClass as _GtkHRulerClass

type _GtkHRuler
	ruler as GtkRuler
end type

type _GtkHRulerClass
	parent_class as GtkRulerClass
end type

declare function gtk_hruler_get_type cdecl alias "gtk_hruler_get_type" () as GType
declare function gtk_hruler_new cdecl alias "gtk_hruler_new" () as GtkWidget ptr

#endif
