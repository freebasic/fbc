''
''
'' gtkhscrollbar -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkhscrollbar_bi__
#define __gtkhscrollbar_bi__

#include once "gtk/gdk.bi"
#include once "gtk/gtk/gtkscrollbar.bi"

type GtkHScrollbar as _GtkHScrollbar
type GtkHScrollbarClass as _GtkHScrollbarClass

type _GtkHScrollbar
	scrollbar as GtkScrollbar
end type

type _GtkHScrollbarClass
	parent_class as GtkScrollbarClass
end type

declare function gtk_hscrollbar_get_type cdecl alias "gtk_hscrollbar_get_type" () as GType
declare function gtk_hscrollbar_new cdecl alias "gtk_hscrollbar_new" (byval adjustment as GtkAdjustment ptr) as GtkWidget ptr

#endif
