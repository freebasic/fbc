''
''
'' gtkvruler -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkvruler_bi__
#define __gtkvruler_bi__

#include once "gtk/gdk.bi"
#include once "gtk/gtk/gtkruler.bi"

type GtkVRuler as _GtkVRuler
type GtkVRulerClass as _GtkVRulerClass

type _GtkVRuler
	ruler as GtkRuler
end type

type _GtkVRulerClass
	parent_class as GtkRulerClass
end type

declare function gtk_vruler_get_type cdecl alias "gtk_vruler_get_type" () as GType
declare function gtk_vruler_new cdecl alias "gtk_vruler_new" () as GtkWidget ptr

#endif
