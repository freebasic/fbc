''
''
'' gtkscrollbar -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkscrollbar_bi__
#define __gtkscrollbar_bi__

#include once "gtk/gdk.bi"
#include once "gtk/gtk/gtkrange.bi"

type GtkScrollbar as _GtkScrollbar
type GtkScrollbarClass as _GtkScrollbarClass

type _GtkScrollbar
	range as GtkRange
end type

type _GtkScrollbarClass
	parent_class as GtkRangeClass
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

declare function gtk_scrollbar_get_type cdecl alias "gtk_scrollbar_get_type" () as GType

#endif
