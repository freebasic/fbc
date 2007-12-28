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
#include once "gtkscrollbar.bi"

#define GTK_TYPE_HSCROLLBAR (gtk_hscrollbar_get_type ())
#define GTK_HSCROLLBAR(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_HSCROLLBAR, GtkHScrollbar))
#define GTK_HSCROLLBAR_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_HSCROLLBAR, GtkHScrollbarClass))
#define GTK_IS_HSCROLLBAR(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_HSCROLLBAR))
#define GTK_IS_HSCROLLBAR_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_HSCROLLBAR))
#define GTK_HSCROLLBAR_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_HSCROLLBAR, GtkHScrollbarClass))

type GtkHScrollbar as _GtkHScrollbar
type GtkHScrollbarClass as _GtkHScrollbarClass

type _GtkHScrollbar
	scrollbar as GtkScrollbar
end type

type _GtkHScrollbarClass
	parent_class as GtkScrollbarClass
end type

declare function gtk_hscrollbar_get_type () as GType
declare function gtk_hscrollbar_new (byval adjustment as GtkAdjustment ptr) as GtkWidget ptr

#endif
