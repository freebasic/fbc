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
#include once "gtkrange.bi"

#define GTK_TYPE_SCROLLBAR (gtk_scrollbar_get_type ())
#define GTK_SCROLLBAR(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_SCROLLBAR, GtkScrollbar))
#define GTK_SCROLLBAR_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_SCROLLBAR, GtkScrollbarClass))
#define GTK_IS_SCROLLBAR(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_SCROLLBAR))
#define GTK_IS_SCROLLBAR_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_SCROLLBAR))
#define GTK_SCROLLBAR_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_SCROLLBAR, GtkScrollbarClass))

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

declare function gtk_scrollbar_get_type () as GType

#endif
