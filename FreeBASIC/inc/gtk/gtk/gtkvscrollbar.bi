''
''
'' gtkvscrollbar -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkvscrollbar_bi__
#define __gtkvscrollbar_bi__

#include once "gtk/gdk.bi"
#include once "gtk/gtk/gtkscrollbar.bi"

type GtkVScrollbar as _GtkVScrollbar
type GtkVScrollbarClass as _GtkVScrollbarClass

type _GtkVScrollbar
	scrollbar as GtkScrollbar
end type

type _GtkVScrollbarClass
	parent_class as GtkScrollbarClass
end type

declare function gtk_vscrollbar_get_type cdecl alias "gtk_vscrollbar_get_type" () as GType
declare function gtk_vscrollbar_new cdecl alias "gtk_vscrollbar_new" (byval adjustment as GtkAdjustment ptr) as GtkWidget ptr

#endif
